from fastapi import FastAPI, HTTPException, Path, Query, Body
from typing import Optional
import psycopg2
import sys
import os

sys.path.append(os.path.abspath("../"))
from sql import connect_to_db

app = FastAPI()


# Member Functions
@app.get("/members")
async def members():
    conn = connect_to_db()
    members = {}
    err = ""
    if conn is not None:
        try:
            cur = conn.cursor()
            cur.execute(
                """
                SELECT * FROM Members;
                """
            )
            members = [
                dict((cur.description[i][0], value) for i, value in enumerate(row))
                for row in cur.fetchall()
            ]
        except psycopg2.Error as e:
            err = e
            print(f"An error occurred: {e}")
        finally:
            if cur is not None:
                cur.close()
            if conn is not None:
                conn.close()
    else:
        err = "Connection to the database is not established."
    if err:
        return {"error": str(err)}
    elif members:
        return {
            "members": members,
        }
    else:
        return {}


@app.post("/register/")
async def user_registration(user_details: dict):
    conn = connect_to_db()
    user_id = 0
    err = ""
    if conn is not None:
        try:
            with conn.cursor() as cur:
                if user_details and (
                    user_details.get("username", None)
                    and user_details.get("email", None)
                    and user_details.get("name", None)
                    and user_details.get("weight_kg", None)
                    and user_details.get("height_cm", None)
                ):
                    cur.execute(
                        "INSERT INTO Members (username, email, name, joindate, weight_kg, height_cm) VALUES (%s, %s, %s, CURRENT_DATE, %s, %s) RETURNING userid;",
                        (
                            user_details["username"],
                            user_details["email"],
                            user_details["name"],
                            user_details["weight_kg"],
                            user_details["height_cm"],
                        ),
                    )
                    user_id = cur.fetchone()[0]
                    conn.commit()
                else:
                    err = "Request Error: Invalid Data"
        except psycopg2.Error as e:
            err = e
        finally:
            if cur is not None:
                cur.close()
            if conn is not None:
                conn.close()
    else:
        err = "Connection to the database is not established."
    if err:
        return {"error": str(err)}
    elif user_id:
        return {
            "message": "User registration successful",
            "user_id": user_id,
        }
    else:
        return {}


@app.put("/profile/{user_id}/")
async def update_profile(user_id: int, update_data: dict):
    conn = connect_to_db()
    updated_user = {}
    err = ""
    if conn is not None:
        try:
            with conn.cursor() as cur:
                # Create a list of update operations and ensure the data is present
                updates = []
                update_values = []
                if update_data.get("username"):
                    updates.append("username = %s")
                    update_values.append(update_data["username"])
                if update_data.get("email"):
                    updates.append("email = %s")
                    update_values.append(update_data["email"])
                if update_data.get("name"):
                    updates.append("name = %s")
                    update_values.append(update_data["name"])
                if update_data.get("weight_kg"):
                    updates.append("weight_kg = %s")
                    update_values.append(update_data["weight_kg"])
                if update_data.get("height_cm"):
                    updates.append("height_cm = %s")
                    update_values.append(update_data["height_cm"])

                # Only attempt update if there are fields to update
                if updates:
                    update_query = (
                        "UPDATE Members SET "
                        + ", ".join(updates)
                        + " WHERE userid = %s RETURNING *;"
                    )
                    update_values.append(user_id)
                    cur.execute(update_query, tuple(update_values))
                    updated_user = cur.fetchone()
                    if updated_user:
                        conn.commit()
                    else:
                        err = "No user found with the specified ID"
                else:
                    err = "No valid fields provided for update"
        except psycopg2.Error as e:
            err = str(e)
        finally:
            if cur is not None:
                cur.close()
            if conn is not None:
                conn.close()
    else:
        err = "Connection to the database is not established."

    if err:
        return {"error": err}
    elif updated_user:
        return {"user": updated_user}
    else:
        return {}


@app.get("/dashboard/{user_id}/")
async def display_dashboard(user_id: int):
    """Display user's exercise routines, achievements, and health statistics."""
    conn = connect_to_db()
    dashboard_data = {}
    err = ""
    if conn is not None:
        try:
            with conn.cursor() as cur:
                # Query for health statistics
                cur.execute(
                    "SELECT weight_kg, height_cm FROM Members WHERE userid = %s;",
                    (user_id,),
                )
                health_stats = cur.fetchone()
                if health_stats:
                    dashboard_data["health_statistics"] = {
                        "weight_kg": health_stats[0],
                        "height_cm": health_stats[1],
                    }

                # Query for completed goals (achievements)
                cur.execute(
                    "SELECT goalid, goaltype, goalamount, completeddate FROM Goals WHERE userid = %s AND completed = TRUE;",
                    (user_id,),
                )
                achievements = cur.fetchall()
                dashboard_data["achievements"] = [
                    {
                        "goal_id": row[0],
                        "goal_type": row[1],
                        "goal_amount": row[2],
                        "completed_date": row[3],
                    }
                    for row in achievements
                ]

                # Query for exercise routines based on subscribed plans
                cur.execute(
                    """
                    SELECT p.planid, p.description 
                    FROM Plans p
                    INNER JOIN Subscriptions s ON p.planid = s.subscriptiontypeid
                    WHERE s.userid = %s AND s.subscriptiontype = 'Plan';
                    """,
                    (user_id,),
                )
                plans = cur.fetchall()
                dashboard_data["exercise_routines"] = [
                    {"plan_id": row[0], "description": row[1]} for row in plans
                ]

        except psycopg2.Error as e:
            err = e
            return {"error": str(e)}
        finally:
            cur.close()
            conn.close()
    else:
        err = "Connection to the database is not established."

    if err:
        return {"error": err}
    elif dashboard_data:
        return {"dashboard": dashboard_data}
    else:
        return {}


@app.get("/members/{member_id}/schedule/")
async def get_member_schedule(member_id: int):
    conn = connect_to_db()
    schedule_data = []
    err = ""
    if conn is not None:
        try:
            with conn.cursor() as cur:
                # Query to fetch all the member's booked sessions from training sessions and classes
                cur.execute(
                    """
                    SELECT 'Training Session' AS session_type, StartTime AS session_start, EndTime AS session_end
                    FROM TrainingSessions
                    WHERE MemberID = %s
                    UNION ALL
                    SELECT 'Class' AS session_type, StartTime AS session_start, EndTime AS session_end
                    FROM Classes
                    INNER JOIN Subscriptions ON Classes.ClassID = Subscriptions.SubscriptionTypeID
                    WHERE Subscriptions.UserID = %s AND Subscriptions.SubscriptionType = 'Class';
                    """,
                    (member_id, member_id),
                )
                sessions = cur.fetchall()
                schedule_data = [
                    {"session_type": row[0], "start_time": row[1], "end_time": row[2]}
                    for row in sessions
                ]
        except psycopg2.Error as e:
            err = str(e)
        finally:
            cur.close()
            conn.close()
    else:
        err = "Connection to the database is not established."

    if err:
        return {"error": err}
    elif schedule_data:
        return {"schedule": schedule_data}
    else:
        return {}


@app.post("/register/training-session/")
async def register_training_session(session_details: dict):
    # Retrieve parameters safely using get
    trainer_id = session_details.get("trainer_id")
    member_id = session_details.get("member_id")
    start_time = session_details.get("start_time")
    end_time = session_details.get("end_time")

    # Check if all required parameters are provided
    if not all([trainer_id, member_id, start_time, end_time]):
        raise HTTPException(
            status_code=400, detail="Missing required parameters for registration."
        )

    conn = connect_to_db()
    result = {}
    err = ""
    if conn is not None:
        try:
            with conn.cursor() as cur:
                # Check for trainer and member availability
                cur.execute(
                    """
                    SELECT COUNT(*) FROM TrainingSessions
                    WHERE (TrainerID = %s OR MemberID = %s) AND 
                          NOT (%s >= EndTime OR %s <= StartTime);
                    """,
                    (trainer_id, member_id, end_time, start_time),
                )
                if cur.fetchone()[0] > 0:
                    err = "Schedule conflict detected."
                else:
                    # Insert new training session and return details
                    cur.execute(
                        """
                        INSERT INTO TrainingSessions (TrainerID, MemberID, StartTime, EndTime) 
                        VALUES (%s, %s, %s, %s) RETURNING SessionID, TrainerID, MemberID, StartTime, EndTime;
                        """,
                        (trainer_id, member_id, start_time, end_time),
                    )
                    session_info = cur.fetchone()
                    conn.commit()
                    result = {
                        "SessionID": session_info[0],
                        "TrainerID": session_info[1],
                        "MemberID": session_info[2],
                        "StartTime": session_info[3],
                        "EndTime": session_info[4],
                    }
        except psycopg2.Error as e:
            err = str(e)
        finally:
            cur.close()
            conn.close()
    else:
        err = "Connection to the database is not established."

    if err:
        return {"error": err}
    elif result:
        return {
            "message": "Training session registered successfully",
            "session_details": result,
        }
    else:
        return {}


@app.post("/register/class/")
async def register_class(session_details: dict):
    conn = connect_to_db()
    result = {}
    err = ""
    if conn is not None:
        try:
            with conn.cursor() as cur:
                # First, check if the class itself is valid and fetch the start and end times for the class
                cur.execute(
                    """
                    SELECT StartTime, EndTime FROM Classes
                    WHERE ClassID = %s;
                    """,
                    (session_details["class_id"],),
                )
                class_times = cur.fetchone()
                if not class_times:
                    err = "Class does not exist."
                else:
                    start_time, end_time = class_times

                    # Check for scheduling conflicts for both member and the class's trainer
                    cur.execute(
                        """
                        SELECT 1 FROM Sessions
                        WHERE UserID IN (
                            SELECT TrainerID FROM Classes WHERE ClassID = %s
                            UNION 
                            SELECT %s
                        ) AND (
                            (%s, %s) OVERLAPS (StartTime, EndTime)
                        );
                        """,
                        (
                            session_details["class_id"],
                            session_details["member_id"],
                            start_time,
                            end_time,
                        ),
                    )
                    conflict = cur.fetchone()
                    if conflict:
                        err = "Schedule conflict detected for either member or trainer."
                    else:
                        # Insert new class subscription and return details
                        cur.execute(
                            """
                            INSERT INTO Subscriptions (UserID, SubscriptionType, SubscriptionTypeID, SubscriptionDate)
                            VALUES (%s, 'Class', %s, CURRENT_DATE) RETURNING SubscriptionID, UserID, SubscriptionTypeID, SubscriptionDate;
                            """,
                            (session_details["member_id"], session_details["class_id"]),
                        )
                        subscription_info = cur.fetchone()
                        conn.commit()
                        result = {
                            "SubscriptionID": subscription_info[0],
                            "UserID": subscription_info[1],
                            "SubscriptionTypeID": subscription_info[2],
                            "SubscriptionDate": subscription_info[3],
                        }
        except psycopg2.Error as e:
            err = str(e)
        finally:
            cur.close()
            conn.close()
    else:
        err = "Connection to the database is not established."

    if err:
        return {"error": err}
    elif result:
        return {
            "message": "Class registered successfully",
            "subscription_details": result,
        }
    else:
        return {}


@app.post("/trainer/schedule/")
async def set_trainer_availability(availability_data: dict[str, str]):
    return {"message": "Not Implemented", "booking_details": availability_data}


@app.get("/trainer/{trainer_id}/members/")
async def view_member_profile(
    trainer_id: int, member_name: Optional[str] = Query(None)
):
    return {
        "message": "Member profile data",
        "trainer_id": trainer_id,
        "member_name": member_name,
    }


# Administrative Staff Functions
@app.post("/room/booking/")
async def manage_room_booking(booking_details: dict):
    return {"message": "Not Implemented", "booking_details": booking_details}


@app.put("/equipment/{equipment_id}/maintenance/")
async def monitor_equipment_maintenance(equipment_id: int, maintenance_status: dict):
    return {
        "message": "Not Implemented",
        "equipment_id": equipment_id,
        "status": maintenance_status,
    }


@app.put("/class/schedule/")
async def update_class_schedule(schedule_details: dict):
    return {"message": "Not Implemented", "schedule_details": schedule_details}


@app.post("/billing/")
async def process_billing(payment_details: dict):
    return {"message": "Not Implemented", "payment_details": payment_details}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8000)
