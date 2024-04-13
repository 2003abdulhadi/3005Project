from fastapi import FastAPI, HTTPException, Path, Query, Body
from typing import Optional
import psycopg2
import json
import sys
import os

sys.path.append(os.path.abspath("../"))
from db import connect_to_db

app = FastAPI()


# --------------------
# Member Functions
# --------------------
@app.get("/members")
async def members():
    conn = connect_to_db()
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
            print(members)
        except psycopg2.Error as e:
            print(f"An error occurred: {e}")
        finally:
            if cur is not None:
                cur.close()
            if conn is not None:
                conn.close()
    else:
        print("Connection to the database is not established.")
    return {}


@app.post("/register/")
async def user_registration(user_details: dict):
    conn = connect_to_db()
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
                    return {
                        "message": "User registration successful",
                        "user_id": user_id,
                    }
        except psycopg2.Error as e:
            return {"error": str(e)}
        finally:
            if cur is not None:
                cur.close()
            if conn is not None:
                conn.close()
    else:
        print("Connection to the database is not established.")
    return {}


@app.put("/profile/{user_id}/")
async def update_profile(user_id: int, update_data: dict):
    """Update user profile information."""
    return {
        "message": "Profile updated successfully",
        "user_id": user_id,
        "updates": update_data,
    }


@app.get("/dashboard/{user_id}/")
async def display_dashboard(user_id: int):
    """Display user's exercise routines, achievements, and health statistics."""
    return {"message": "Dashboard data", "user_id": user_id}


@app.post("/schedule/")
async def manage_schedule(schedule_details: dict):
    """Schedule personal training sessions or classes."""
    return {"message": "Schedule updated", "schedule_details": schedule_details}


# --------------------
# Trainer Functions
# --------------------


@app.post("/trainer/schedule/")
async def set_trainer_availability(trainer_id: int, availability_data: dict):
    """Set trainer availability times."""
    return {
        "message": "Trainer availability set",
        "trainer_id": trainer_id,
        "availability": availability_data,
    }


@app.get("/trainer/{trainer_id}/members/")
async def view_member_profile(
    trainer_id: int, member_name: Optional[str] = Query(None)
):
    """View profiles of members by name."""
    return {
        "message": "Member profile data",
        "trainer_id": trainer_id,
        "member_name": member_name,
    }


# --------------------
# Administrative Staff Functions
# --------------------


@app.post("/room/booking/")
async def manage_room_booking(booking_details: dict):
    """Manage room bookings."""
    return {"message": "Room booked successfully", "booking_details": booking_details}


@app.put("/equipment/{equipment_id}/maintenance/")
async def monitor_equipment_maintenance(equipment_id: int, maintenance_status: dict):
    """Monitor and update equipment maintenance status."""
    return {
        "message": "Equipment maintenance updated",
        "equipment_id": equipment_id,
        "status": maintenance_status,
    }


@app.put("/class/schedule/")
async def update_class_schedule(schedule_details: dict):
    """Update class schedules."""
    return {"message": "Class schedule updated", "schedule_details": schedule_details}


@app.post("/billing/")
async def process_billing(payment_details: dict):
    """Process billing and payments."""
    return {"message": "Payment processed", "payment_details": payment_details}


# --------------------
# Run the App
# --------------------
if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8000)
