-- Define ENUM types
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'goal_type') THEN
        CREATE TYPE goal_type AS ENUM ('Lose weight', 'Gain weight', 'Timed', 'Frequency');
    END IF;
END$$;
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'equipment_type') THEN
        CREATE TYPE equipment_type AS ENUM ('Weights', 'Machines', 'Platforms', 'Accessories');
    END IF;
END$$;
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'condition_type') THEN
        CREATE TYPE condition_type AS ENUM ('Good Condition', 'In Service', 'Needs Maintenance');
    END IF;
END$$;
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'subscription_type') THEN
        CREATE TYPE subscription_type AS ENUM('Plan', 'Class', 'Trainer');
    END IF;
END$$;
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'session_type') THEN
        CREATE TYPE session_type AS ENUM ('Training Session', 'Class');
    END IF;
END$$;

CREATE TABLE Members (
    UserID SERIAL PRIMARY KEY,
    Username VARCHAR(255) UNIQUE NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Name VARCHAR(255) NOT NULL,
    JoinDate DATE NOT NULL,
    Weight_kg INT NOT NULL,
    Height_cm INT NOT NULL
);

CREATE TABLE Goals (
    GoalID SERIAL PRIMARY KEY,
    UserID INT NOT NULL,
    StartDate TIMESTAMP NOT NULL,
    EndDate TIMESTAMP,
    GoalType goal_type NOT NULL,
    GoalAmount INT NOT NULL,
    Completed BOOLEAN NOT NULL DEFAULT FALSE,
    CompletedDate TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Members(UserID)
);

CREATE TABLE Subscriptions (
    SubscriptionID SERIAL PRIMARY KEY,
    UserID INT NOT NULL,
    SubscriptionType subscription_type NOT NULL,
    SubscriptionTypeID INT NOT NULL,
    SubscriptionDate TIMESTAMP NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Members(UserID)
);

CREATE TABLE Exercises (
    ExerciseID SERIAL PRIMARY KEY,
    Activity VARCHAR(255) NOT NULL
);

CREATE TABLE Workouts (
    WorkoutID SERIAL PRIMARY KEY,
    Description TEXT,
    Frequency INT NOT NULL
);

CREATE TABLE WorkoutExercises (
    WorkoutID INT NOT NULL,
    ExerciseID INT NOT NULL,
    Sets INT NOT NULL,
    Reps INT NOT NULL,
    FOREIGN KEY (WorkoutID) REFERENCES Workouts(WorkoutID),
    FOREIGN KEY (ExerciseID) REFERENCES Exercises(ExerciseID),
    PRIMARY KEY (WorkoutID, ExerciseID)
);

CREATE TABLE Plans (
    PlanID SERIAL PRIMARY KEY,
    Description TEXT,
    TrainerID INT,
    FOREIGN KEY (TrainerID) REFERENCES Trainers(TrainerID)
);


CREATE TABLE PlanWorkouts (
    PlanID INT NOT NULL,
    WorkoutID INT NOT NULL,
    FOREIGN KEY (PlanID) REFERENCES Plans(PlanID),
    FOREIGN KEY (WorkoutID) REFERENCES Workouts(WorkoutID),
    PRIMARY KEY (PlanID, WorkoutID)
);

CREATE TABLE Routines (
    RoutineID SERIAL PRIMARY KEY,
    UserID INT NOT NULL,
    PlanID INT NOT NULL,
    Created TIMESTAMP NOT NULL,
    Frequency VARCHAR(255),
    Description TEXT,
    FOREIGN KEY (UserID) REFERENCES Members(UserID),
    FOREIGN KEY (PlanID) REFERENCES Plans(PlanID)
);

CREATE TABLE Trainers (
    TrainerID INT PRIMARY KEY,
    CertifiedDate TIMESTAMP NOT NULL,
    FOREIGN KEY (TrainerID) REFERENCES Members(UserID)
);

CREATE TABLE TrainingSessions (
    SessionID SERIAL PRIMARY KEY,
    TrainerID INT NOT NULL,
    MemberID INT NOT NULL,
    StartTime TIMESTAMP NOT NULL,
    EndTime TIMESTAMP NOT NULL,
    FOREIGN KEY (TrainerID) REFERENCES Trainers(TrainerID),
    FOREIGN KEY (MemberID) REFERENCES Members(UserID)
);

CREATE TABLE Rooms (
    RoomID SERIAL PRIMARY KEY,
    RoomName VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE RoomBookings (
    BookingID SERIAL PRIMARY KEY,
    RoomID INT NOT NULL,
    StartTime TIMESTAMP NOT NULL,
    EndTime TIMESTAMP NOT NULL,
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);


CREATE TABLE Classes (
    ClassID SERIAL PRIMARY KEY,
    TrainerID INT NOT NULL,
    RoomID INT NOT NULL,
    StartTime TIMESTAMP NOT NULL,
    EndTime TIMESTAMP NOT NULL,
    FOREIGN KEY (TrainerID) REFERENCES Trainers(TrainerID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);


CREATE TABLE Sessions (
    SessionID SERIAL PRIMARY KEY,
    UserID INT NOT NULL,
    SessionType session_type NOT NULL,
    SessionTypeID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Members(UserID)
);

CREATE TABLE Equipment (
    EquipmentID SERIAL PRIMARY KEY,
    EquipmentType equipment_type NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL,
    Condition condition_type NOT NULL
);
