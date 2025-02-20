import mysql.connector as mysql

# Connect to the database
def connect(password_str):
    db = mysql.connect(
        host="localhost",
        user="root",
        passwd=password_str,
        database="mealplandb"
    )
    return db

# Read-only queries
def query_keto_customers(db):
    """Retrieve all customers who prefer a Keto diet."""
    cursor = db.cursor()
    query = "SELECT FirstName, LastName, Email FROM Customers WHERE PreferredDiet = 'Keto';"
    cursor.execute(query)
    for record in cursor.fetchall():
        print(record)
    cursor.close()

def query_meal_ingredients(db):
    """Find ingredients for a specific meal."""
    cursor = db.cursor()
    meal_name = input("Enter the meal name: ")
    query = """
    SELECT m.Meal, i.Name AS Ingredient, i.Category
    FROM Meals m
    JOIN MealIngredients mi ON m.MealID = mi.MealID
    JOIN Ingredients i ON mi.IngredientID = i.IngredientID
    WHERE m.Meal = %s;
    """
    cursor.execute(query, (meal_name,))
    for record in cursor.fetchall():
        print(record)
    cursor.close()

# Modification queries
def add_customer(db):
    """Add a new customer to the database."""
    cursor = db.cursor()
    first_name = input("Enter first name: ")
    last_name = input("Enter last name: ")
    email = input("Enter email: ")
    diet = input("Enter preferred diet: ")
    zip_code = input("Enter zip code: ")
    query = "INSERT INTO Customers (FirstName, LastName, Email, PreferredDiet, ZipCode) VALUES (%s, %s, %s, %s, %s);"
    cursor.execute(query, (first_name, last_name, email, diet, zip_code))
    db.commit()
    print("Customer added successfully.")
    cursor.close()

def delete_feedback(db):
    """Delete a feedback record for a meal."""
    cursor = db.cursor()
    customer_id = input("Enter customer ID: ")
    meal_id = input("Enter meal ID: ")
    query = "DELETE FROM Feedback WHERE CustomerID = %s AND MealID = %s;"
    cursor.execute(query, (customer_id, meal_id))
    db.commit()
    print("Feedback deleted successfully.")
    cursor.close()

def query_high_calorie_meals(db):
    """Retrieve meals with calories higher than the average."""
    cursor = db.cursor()
    query = """
    SELECT Meal, Calories
    FROM Meals
    WHERE Calories > (SELECT AVG(Calories) FROM Meals);
    """
    cursor.execute(query)
    for record in cursor.fetchall():
        print(record)
    cursor.close()

def query_meal_ratings(db):
    """Calculate the average rating for each meal."""
    cursor = db.cursor()
    query = """
    SELECT m.Meal, AVG(f.Rating) AS AverageRating
    FROM Feedback f
    JOIN Meals m ON f.MealID = m.MealID
    GROUP BY m.Meal
    ORDER BY AverageRating DESC;
    """
    cursor.execute(query)
    for record in cursor.fetchall():
        print(record)
    cursor.close()

def update_store_zip_code(db):
    """Update the zip code of a grocery store."""
    cursor = db.cursor()
    store_id = input("Enter the Store ID to update: ")
    new_zip_code = input("Enter the new zip code: ")
    query = "UPDATE GroceryStores SET ZipCode = %s WHERE StoreID = %s;"
    cursor.execute(query, (new_zip_code, store_id))
    db.commit()
    print("Zip code updated successfully.")
    cursor.close()

def delete_meal_and_feedback(db):
    """Delete a meal and cascade delete its feedback records."""
    cursor = db.cursor()
    meal_id = input("Enter the Meal ID to delete: ")
    query = "DELETE FROM Meals WHERE MealID = %s;"
    cursor.execute(query, (meal_id,))
    db.commit()
    print("Meal and its related feedback deleted successfully.")
    cursor.close()


# Main function to run the script
def main():
    """Main menu to execute SQL queries."""
    password_str = input("Enter MySQL root password: ")
    db = connect(password_str)

    while True:
        print("\nChoose a query to execute:")
        print("1. Query Keto customers")
        print("2. Query meal ingredients")
        print("3. Query meals with above-average calories")
        print("4. Query average rating for meals")
        print("5. Add a customer")
        print("6. Delete feedback")
        print("7. Update grocery store zip code")
        print("8. Delete a meal and its feedback")
        print("9. Exit")

        choice = int(input("Enter your choice: "))

        if choice == 1:
            query_keto_customers(db)
        elif choice == 2:
            query_meal_ingredients(db)
        elif choice == 3:
            query_high_calorie_meals(db)
        elif choice == 4:
            query_meal_ratings(db)
        elif choice == 5:
            add_customer(db)
        elif choice == 6:
            delete_feedback(db)
        elif choice == 7:
            update_store_zip_code(db)
        elif choice == 8:
            delete_meal_and_feedback(db)
        elif choice == 9:
            print("Exiting...")
            break
        else:
            print("Invalid choice. Please try again.")

    db.close()


if __name__ == "__main__":
    main()
