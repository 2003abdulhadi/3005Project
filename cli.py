import requests

def main():
    api_base_url = "http://localhost:8000"  # Adjust if your API is hosted differently

    while True:
        print("\nChoose an option:")
        print("1. List all members")
        print("2. Register a new member")
        print("3. Update member profile")
        print("4. Display member dashboard")
        print("5. Get member schedule")
        print("6. Register for a training session")
        print("7. Register for a class")
        print("0. Exit")
        choice = input("Enter your choice: ")

        if choice == '1':
            response = requests.get(f"{api_base_url}/members")
            print_response(response)
        elif choice == '2':
            user_details = get_user_details()
            response = requests.post(f"{api_base_url}/register/", json=user_details)
            print_response(response)
        elif choice == '3':
            user_id = input("Enter user ID: ")
            update_data = get_user_details()
            response = requests.put(f"{api_base_url}/profile/{user_id}", json=update_data)
            print_response(response)
        elif choice == '4':
            user_id = input("Enter user ID: ")
            response = requests.get(f"{api_base_url}/dashboard/{user_id}")
            print_response(response)
        elif choice == '5':
            member_id = input("Enter member ID: ")
            response = requests.get(f"{api_base_url}/members/{member_id}/schedule")
            print_response(response)
        elif choice == '6':
            session_details = get_session_details()
            response = requests.post(f"{api_base_url}/register/training-session", json=session_details)
            print_response(response)
        elif choice == '7':
            session_details = get_class_details()
            response = requests.post(f"{api_base_url}/register/class", json=session_details)
            print_response(response)
        elif choice == '0':
            break
        else:
            print("Invalid option, please try again.")

def get_user_details():
    print("Enter user details:")
    username = input("Username: ")
    email = input("Email: ")
    name = input("Name: ")
    weight_kg = input("Weight (kg): ")
    height_cm = input("Height (cm): ")
    return {
        "username": username,
        "email": email,
        "name": name,
        "weight_kg": weight_kg,
        "height_cm": height_cm
    }

def get_session_details():
    print("Enter session details:")
    trainer_id = input("Trainer ID: ")
    member_id = input("Member ID: ")
    start_time = input("Start time (YYYY-MM-DD HH:MM:SS): ")
    end_time = input("End time (YYYY-MM-DD HH:MM:SS): ")
    return {
        "trainer_id": trainer_id,
        "member_id": member_id,
        "start_time": start_time,
        "end_time": end_time
    }

def get_class_details():
    print("Enter class registration details:")
    class_id = input("Class ID: ")
    member_id = input("Member ID: ")
    return {
        "class_id": class_id,
        "member_id": member_id
    }

def print_response(response):
    if response.status_code == 200:
        print("\nSuccess:")
        data = response.json()
        for key, value in data.items():
            print(f"{key.capitalize()}: {value}")
    else:
        print("\nFailed:")
        print("Status Code:", response.status_code)
        print(response.text)

if __name__ == "__main__":
    main()
