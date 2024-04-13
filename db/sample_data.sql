-- Correct INSERT for Members, assuming UserID is SERIAL and auto-generated
INSERT INTO Members (Username, Email, Name, JoinDate, Weight_kg, Height_cm) VALUES
('user1', 'user1@example.com', 'User One', '2021-09-01', 70, 175),
('user2', 'user2@example.com', 'User Two', '2021-08-01', 80, 180),
('user3', 'user3@example.com', 'User Three', '2021-07-01', 65, 160),
('user4', 'user4@example.com', 'User Four', '2021-06-01', 75, 165),
('user5', 'user5@example.com', 'User Five', '2021-05-01', 68, 170),
('user6', 'user6@example.com', 'User Six', '2021-04-01', 82, 178),
('user7', 'user7@example.com', 'User Seven', '2021-03-01', 90, 185),
('user8', 'user8@example.com', 'User Eight', '2021-02-01', 64, 160),
('user9', 'user9@example.com', 'User Nine', '2021-01-01', 76, 172),
('user10', 'user10@example.com', 'User Ten', '2020-12-01', 85, 180),
('user11', 'user11@example.com', 'User Eleven', '2020-11-01', 60, 158),
('user12', 'user12@example.com', 'User Twelve', '2020-10-01', 92, 190),
('user13', 'user13@example.com', 'User Thirteen', '2020-09-01', 78, 175),
('user14', 'user14@example.com', 'User Fourteen', '2020-08-01', 84, 177),
('user15', 'user15@example.com', 'User Fifteen', '2020-07-01', 70, 169),
('user16', 'user16@example.com', 'User Sixteen', '2020-06-01', 88, 183),
('user17', 'user17@example.com', 'User Seventeen', '2020-05-01', 73, 165),
('user18', 'user18@example.com', 'User Eighteen', '2020-04-01', 66, 162),
('user19', 'user19@example.com', 'User Nineteen', '2020-03-01', 95, 188),
('user20', 'user20@example.com', 'User Twenty', '2020-02-01', 63, 159),
('user21', 'user21@example.com', 'User Twenty-One', '2020-01-01', 79, 174),
('user22', 'user22@example.com', 'User Twenty-Two', '2019-12-01', 82, 176),
('user23', 'user23@example.com', 'User Twenty-Three', '2019-11-01', 58, 154),
('user24', 'user24@example.com', 'User Twenty-Four', '2019-10-01', 91, 187),
('user25', 'user25@example.com', 'User Twenty-Five', '2019-09-01', 77, 173),
('user26', 'user26@example.com', 'User Twenty-Six', '2019-08-01', 81, 179),
('user27', 'user27@example.com', 'User Twenty-Seven', '2019-07-01', 67, 163),
('user28', 'user28@example.com', 'User Twenty-Eight', '2019-06-01', 89, 184),
('user29', 'user29@example.com', 'User Twenty-Nine', '2019-05-01', 74, 166),
('user30', 'user30@example.com', 'User Thirty', '2019-04-01', 65, 161),
('user31', 'user31@example.com', 'User Thirty-One', '2019-03-01', 94, 189),
('user32', 'user32@example.com', 'User Thirty-Two', '2019-02-01', 62, 157),
('user33', 'user33@example.com', 'User Thirty-Three', '2019-01-01', 80, 175),
('user34', 'user34@example.com', 'User Thirty-Four', '2018-12-01', 83, 178),
('user35', 'user35@example.com', 'User Thirty-Five', '2018-11-01', 59, 155),
('user36', 'user36@example.com', 'User Thirty-Six', '2018-10-01', 93, 191),
('user37', 'user37@example.com', 'User Thirty-Seven', '2018-09-01', 75, 169),
('user38', 'user38@example.com', 'User Thirty-Eight', '2018-08-01', 85, 182),
('user39', 'user39@example.com', 'User Thirty-Nine', '2018-07-01', 71, 167),
('user40', 'user40@example.com', 'User Forty', '2018-06-01', 87, 181),
('user41', 'user41@example.com', 'User Forty-One', '2018-05-01', 69, 164),
('user42', 'user42@example.com', 'User Forty-Two', '2018-04-01', 96, 192),
('user43', 'user43@example.com', 'User Forty-Three', '2018-03-01', 64, 160),
('user44', 'user44@example.com', 'User Forty-Four', '2018-02-01', 78, 174),
('user45', 'user45@example.com', 'User Forty-Five', '2018-01-01', 84, 180),
('user46', 'user46@example.com', 'User Forty-Six', '2017-12-01', 57, 153),
('user47', 'user47@example.com', 'User Forty-Seven', '2017-11-01', 90, 186),
('user48', 'user48@example.com', 'User Forty-Eight', '2017-10-01', 76, 172),
('user49', 'user49@example.com', 'User Forty-Nine', '2017-09-01', 86, 183),
('user50', 'user50@example.com', 'User Fifty', '2017-08-01', 68, 168);


-- Insert Goals for each member, assuming 2-5 goals per member
-- Note: UserID must be valid INT referencing a Member's UserID
INSERT INTO Goals (UserID, StartDate, EndDate, GoalType, GoalAmount, Completed) VALUES
(1, '2021-09-02', '2021-12-01', 'Lose weight', 5, FALSE),
(1, '2021-09-02', '2022-01-01', 'Gain weight', 3, TRUE),
(2, '2021-08-02', '2021-11-01', 'Timed', 30, FALSE),
(2, '2021-08-02', '2022-02-01', 'Frequency', 20, TRUE),
(3, '2021-07-02', '2021-10-01', 'Lose weight', 4, FALSE),
(3, '2021-07-02', '2022-03-01', 'Gain weight', 6, TRUE),
(4, '2021-06-02', '2021-09-01', 'Timed', 15, FALSE),
(4, '2021-06-02', '2022-04-01', 'Frequency', 25, TRUE),
(5, '2021-05-02', '2021-08-01', 'Lose weight', 7, FALSE),
(5, '2021-05-02', '2022-05-01', 'Gain weight', 2, TRUE),
(6, '2021-04-02', '2021-07-01', 'Timed', 45, FALSE),
(6, '2021-04-02', '2022-06-01', 'Frequency', 15, TRUE),
(7, '2021-03-02', '2021-06-01', 'Lose weight', 8, FALSE),
(7, '2021-03-02', '2022-07-01', 'Gain weight', 1, TRUE),
(8, '2021-02-02', '2021-05-01', 'Timed', 25, FALSE),
(8, '2021-02-02', '2022-08-01', 'Frequency', 30, TRUE),
(9, '2021-01-02', '2021-04-01', 'Lose weight', 9, FALSE),
(9, '2021-01-02', '2022-09-01', 'Gain weight', 5, TRUE),
(10, '2020-12-02', '2021-03-01', 'Timed', 20, FALSE),
(10, '2020-12-02', '2022-10-01', 'Frequency', 22, TRUE);
-- More goals, randomize the values and assign to members

-- Insert Trainers, choosing 10 members to be trainers
-- Note: TrainerID must be a valid Member's UserID
INSERT INTO Trainers (TrainerID, CertifiedDate) VALUES
(1, '2021-08-20'),
(2, '2021-07-15'),
(3, '2021-06-10'),
(4, '2021-05-05'),
(5, '2021-04-30'),
(6, '2021-03-25'),
(7, '2021-02-20'),
(8, '2021-01-15'),
(9, '2020-12-10'),
(10, '2020-11-05');
-- More trainers up to 10
INSERT INTO TrainingSessions (TrainerID, MemberID, StartTime, EndTime) VALUES
(1, 11, '2023-04-15 08:00:00', '2023-04-15 09:00:00'),
(1, 12, '2023-04-15 09:30:00', '2023-04-15 10:30:00'),
(2, 13, '2023-04-15 08:00:00', '2023-04-15 09:00:00'),
(2, 14, '2023-04-15 10:00:00', '2023-04-15 11:00:00'),
(3, 15, '2023-04-15 08:00:00', '2023-04-15 09:00:00'),
(3, 16, '2023-04-15 09:30:00', '2023-04-15 10:30:00'),
(4, 17, '2023-04-16 08:00:00', '2023-04-16 09:00:00'),
(4, 18, '2023-04-16 10:00:00', '2023-04-16 11:00:00'),
(5, 19, '2023-04-16 08:00:00', '2023-04-16 09:00:00'),
(5, 20, '2023-04-16 09:30:00', '2023-04-16 10:30:00'),
(6, 21, '2023-04-16 08:00:00', '2023-04-16 09:00:00'),
(6, 22, '2023-04-16 10:00:00', '2023-04-16 11:00:00'),
(7, 23, '2023-04-17 08:00:00', '2023-04-17 09:00:00'),
(7, 24, '2023-04-17 09:30:00', '2023-04-17 10:30:00'),
(8, 25, '2023-04-17 08:00:00', '2023-04-17 09:00:00'),
(8, 26, '2023-04-17 10:00:00', '2023-04-17 11:00:00'),
(9, 27, '2023-04-18 08:00:00', '2023-04-18 09:00:00'),
(9, 28, '2023-04-18 09:30:00', '2023-04-18 10:30:00'),
(10, 29, '2023-04-18 08:00:00', '2023-04-18 09:00:00'),
(10, 30, '2023-04-18 10:00:00', '2023-04-18 11:00:00');

INSERT INTO Exercises (Activity) VALUES
('Treadmill Running'),
('Stationary Bike'),
('Elliptical Trainer'),
('Rowing Machine'),
('Stair Climber'),
('Bench Press'),
('Deadlift'),
('Squat'),
('Leg Press'),
('Lat Pull Down'),
('Shoulder Press'),
('Barbell Curl'),
('Tricep Extension'),
('Chest Fly'),
('Leg Curl'),
('Leg Extension'),
('Calf Raise'),
('Pull Up'),
('Push Up'),
('Plank'),
('Lunge'),
('Burpees'),
('Sit-ups'),
('Kettlebell Swing'),
('Box Jump'),
('Battle Ropes'),
('Medicine Ball Slam'),
('Yoga Stretch'),
('Pilates Routine'),
('Core Crunch');

INSERT INTO Workouts (Description, Frequency) VALUES
('Cardio Blast - High intensity cardio for fat loss', 3),
('Strength Training - Full body workout', 4),
('HIIT Session - Quick, intense bursts', 5),
('Lower Body Strength - Focus on legs and glutes', 2),
('Upper Body Strength - Build muscle in arms, chest, and back', 2),
('Core Strengthening - Abdominal and lower back exercises', 3),
('Endurance Training - Long duration, low intensity', 3),
('Flexibility Workout - Yoga and stretching routines', 4),
('Functional Training - Exercises to improve daily activities', 3),
('Bootcamp - Combination of strength and cardio', 4);

INSERT INTO WorkoutExercises (WorkoutID, ExerciseID, Sets, Reps) VALUES
-- Cardio Blast - High intensity cardio for fat loss
(1, 1, 1, 20),  -- Treadmill Running, 20 minutes
(1, 2, 1, 30),  -- Stationary Bike, 30 minutes
(1, 3, 1, 15),  -- Elliptical Trainer, 15 minutes

-- Strength Training - Full body workout
(2, 6, 4, 8),   -- Bench Press, 4 sets of 8 reps
(2, 7, 3, 6),   -- Deadlift, 3 sets of 6 reps
(2, 8, 3, 10),  -- Squat, 3 sets of 10 reps
(2, 10, 3, 12), -- Lat Pull Down, 3 sets of 12 reps

-- HIIT Session - Quick, intense bursts
(3, 24, 4, 30), -- Kettlebell Swing, 4 sets of 30 reps
(3, 22, 4, 15), -- Burpees, 4 sets of 15 reps
(3, 21, 4, 20), -- Lunge, 4 sets of 20 reps

-- Lower Body Strength - Focus on legs and glutes
(4, 8, 4, 10),  -- Squat, 4 sets of 10 reps
(4, 9, 4, 12),  -- Leg Press, 4 sets of 12 reps
(4, 16, 4, 15), -- Leg Extension, 4 sets of 15 reps

-- Upper Body Strength - Build muscle in arms, chest, and back
(5, 6, 4, 8),   -- Bench Press, 4 sets of 8 reps
(5, 11, 4, 10), -- Shoulder Press, 4 sets of 10 reps
(5, 12, 3, 12), -- Barbell Curl, 3 sets of 12 reps

-- Core Strengthening - Abdominal and lower back exercises
(6, 23, 4, 25), -- Sit-ups, 4 sets of 25 reps
(6, 20, 3, 60), -- Plank, 3 sets of 60 seconds
(6, 19, 3, 15), -- Push Up, 3 sets of 15 reps

-- Endurance Training - Long duration, low intensity
(7, 1, 1, 40),  -- Treadmill Running, 40 minutes
(7, 2, 1, 45),  -- Stationary Bike, 45 minutes
(7, 4, 1, 30),  -- Rowing Machine, 30 minutes

-- Flexibility Workout - Yoga and stretching routines
(8, 28, 5, 10), -- Yoga Stretch, 5 stretches for 10 minutes total
(8, 29, 5, 10), -- Pilates Routine, 5 routines for 10 minutes total

-- Functional Training - Exercises to improve daily activities
(9, 25, 4, 12), -- Box Jump, 4 sets of 12 reps
(9, 26, 3, 15), -- Battle Ropes, 3 sets of 15 reps
(9, 21, 4, 20), -- Lunge, 4 sets of 20 reps

-- Bootcamp - Combination of strength and cardio
(10, 6, 3, 10),  -- Bench Press, 3 sets of 10 reps
(10, 8, 3, 10),  -- Squat, 3 sets of 10 reps
(10, 22, 4, 15), -- Burpees, 4 sets of 15 reps
(10, 2, 1, 20);  -- Stationary Bike, 20 minutes

INSERT INTO Plans (Description) VALUES
('Complete Fitness Program - A combination of strength, cardio, and flexibility training'),
('Weight Loss Bootcamp - Intensive cardio with strength training for maximum fat burn'),
('Strength and Power Building - Focuses on increasing muscle mass and strength'),
('Endurance and Stamina Program - Enhances cardiovascular endurance and overall stamina'),
('Lower Body and Core Specialization - Targets leg, glute, and core strengthening'),
('Holistic Body Wellness - Incorporates yoga, Pilates, and light cardio for overall wellness');

INSERT INTO PlanWorkouts (PlanID, WorkoutID) VALUES
-- Complete Fitness Program
(1, 2),  -- Strength Training
(1, 1),  -- Cardio Blast
(1, 8),  -- Flexibility Workout

-- Weight Loss Bootcamp
(2, 1),  -- Cardio Blast
(2, 3),  -- HIIT Session
(2, 10), -- Bootcamp

-- Strength and Power Building
(3, 2),  -- Strength Training
(3, 4),  -- Lower Body Strength
(3, 5),  -- Upper Body Strength

-- Endurance and Stamina Program
(4, 1),  -- Cardio Blast
(4, 7),  -- Endurance Training
(4, 3),  -- HIIT Session

-- Lower Body and Core Specialization
(5, 4),  -- Lower Body Strength
(5, 6),  -- Core Strengthening
(5, 9),  -- Functional Training

-- Holistic Body Wellness
(6, 8),  -- Flexibility Workout
(6, 9),  -- Functional Training
(6, 3);  -- HIIT Session

-- Insert Subscriptions, assuming each trainer has 5-50 subscribers
-- Note: UserID and SubscriptionTypeID must be valid INTs
INSERT INTO Subscriptions (UserID, SubscriptionType, SubscriptionTypeID, SubscriptionDate) VALUES
(3, 'Trainer', 1, '2021-09-01'),
(4, 'Trainer', 1, '2021-09-02');
-- More subscriptions

-- Insert Plans, 2-8 per trainer
INSERT INTO Plans (Description) VALUES
('Plan Description 1');
-- More plans

INSERT INTO Routines (UserID, PlanID, Created, Frequency, Description) VALUES
(1, 1, '2022-01-01 08:00:00', '5 days', 'Comprehensive fitness program covering all aspects of training.'),
(2, 2, '2022-01-02 08:00:00', '4 days', 'Intensive program focusing on maximum fat burn and endurance.'),
(3, 3, '2022-01-03 08:00:00', '3 days', 'Strength building program targeting major muscle groups.'),
(4, 4, '2022-01-04 08:00:00', '5 days', 'Endurance and stamina enhancement for athletic performance.'),
(5, 5, '2022-01-05 08:00:00', '4 days', 'Specialized program for lower body and core strengthening.'),
(6, 6, '2022-01-06 08:00:00', '3 days', 'Wellness program with a gentle approach to fitness.'),
(7, 1, '2022-01-07 08:00:00', '4 days', 'Balanced fitness regimen with a focus on sustainable health.'),
(8, 2, '2022-01-08 08:00:00', '5 days', 'High-intensity interval training combined with strategic strength exercises.'),
(9, 3, '2022-01-09 08:00:00', '3 days', 'Power lifting and heavy strength training for advanced fitness levels.'),
(10, 4, '2022-01-10 08:00:00', '4 days', 'Long-duration workouts designed to increase cardio fitness and endurance.');


INSERT INTO Rooms (RoomName) VALUES
('Aerobics Studio'),
('Spin Cycle Room'),
('Yoga Studio'),
('Pilates Room'),
('Free Weights Room'),
('Cardio Equipment Room'),
('CrossFit Box'),
('Dance Studio'),
('Martial Arts Dojo'),
('Functional Training Zone');


INSERT INTO Classes (TrainerID, RoomID, StartTime, EndTime, Frequency) VALUES
-- First set of classes
(1, 1, '08:00', '09:00', 'MWF'),  -- Trainer 1 in Room 1 (Morning Slot)
(2, 2, '08:00', '09:00', 'MWF'),  -- Trainer 2 in Room 2 (Morning Slot)
(3, 3, '08:00', '09:00', 'MWF'),  -- Trainer 3 in Room 3 (Morning Slot)
(4, 4, '08:00', '09:00', 'MWF'),  -- Trainer 4 in Room 4 (Morning Slot)

-- Second set of classes for each room to ensure no overlap with different timings or days
(1, 1, '10:00', '11:00', 'TuTh'),  -- Trainer 1 in Room 1 again, but different times (Late Morning Slot)
(2, 2, '10:00', '11:00', 'TuTh'),  -- Trainer 2 in Room 2 again, different times (Late Morning Slot)
(3, 3, '10:00', '11:00', 'TuTh'),  -- Trainer 3 in Room 3, different times (Late Morning Slot)
(4, 4, '10:00', '11:00', 'TuTh');  -- Trainer 4 in Room 4, different times (Late Morning Slot)

-- Room bookings for classes (Note: Assuming dates need to be dynamically set or are set as examples here)
INSERT INTO RoomBookings (RoomID, StartTime, EndTime) VALUES
-- Bookings for MWF classes from 8:00 AM to 9:00 AM
(1, '2023-04-15 08:00:00', '2023-04-15 09:00:00'),
(1, '2023-04-17 08:00:00', '2023-04-17 09:00:00'),
(1, '2023-04-19 08:00:00', '2023-04-19 09:00:00'),
(2, '2023-04-15 08:00:00', '2023-04-15 09:00:00'),
(2, '2023-04-17 08:00:00', '2023-04-17 09:00:00'),
(2, '2023-04-19 08:00:00', '2023-04-19 09:00:00'),
(3, '2023-04-15 08:00:00', '2023-04-15 09:00:00'),
(3, '2023-04-17 08:00:00', '2023-04-17 09:00:00'),
(3, '2023-04-19 08:00:00', '2023-04-19 09:00:00'),
(4, '2023-04-15 08:00:00', '2023-04-15 09:00:00'),
(4, '2023-04-17 08:00:00', '2023-04-17 09:00:00'),
(4, '2023-04-19 08:00:00', '2023-04-19 09:00:00'),

-- Bookings for TTh classes from 10:00 AM to 11:00 AM
(1, '2023-04-16 10:00:00', '2023-04-16 11:00:00'),
(1, '2023-04-18 10:00:00', '2023-04-18 11:00:00'),
(2, '2023-04-16 10:00:00', '2023-04-16 11:00:00'),
(2, '2023-04-18 10:00:00', '2023-04-18 11:00:00'),
(3, '2023-04-16 10:00:00', '2023-04-16 11:00:00'),
(3, '2023-04-18 10:00:00', '2023-04-18 11:00:00'),
(4, '2023-04-16 10:00:00', '2023-04-16 11:00:00'),
(4, '2023-04-18 10:00:00', '2023-04-18 11:00:00');


-- Insert Equipment, 20 pieces including weights, machines, etc.
INSERT INTO Equipment (EquipmentType, Name, Description, Condition) VALUES
('Weights', '10kg Dumbbell', '10 kg dumbbell pair', 'Good Condition'),
('Machines', 'Treadmill', 'High-speed treadmill', 'Needs Maintenance');
-- More equipment up to 20 pieces
