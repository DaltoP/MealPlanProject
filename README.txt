README.txt
1. Description of the Data
This database is designed for a Meal Planning Application. It contains the following types of data:

Customers: Information about customers, including their names, email addresses, preferred diets, and zip codes.

Meals: Details about various meals, including meal names, categories (e.g., breakfast, lunch), preparation times, difficulty levels, and calorie counts.

Ingredients: Details about ingredients used in the meals, categorized into types (e.g., protein, carbs) and allergen information.

Meal-Ingredients: A junction table connecting meals to their respective ingredients.

Nutrition Data: Comprehensive nutrition details for each meal, such as caloric value, fat content, vitamins, and minerals.

Grocery Stores: Information about grocery stores, including locations, contact information, and zip codes.

Store Inventory: A list of ingredients available in each grocery store, along with their prices and stock levels.

Feedback: Customer feedback on meals, including ratings and comments.

Source of Data
The data was generated using a combination of tools:

Mockaroo and Kaggle: Used to generate fake data for customers(Mockaroo) and meals(Kaggle)
Manual Input: Some data, such as ingredients and feedback, were manually added. Also Coming up with grocery stores I knew.
LLM: Using ChatGPT for the ratings and feedback and some customers


2. How to Execute the Files
Step 1: Setup the Database
Open MySQL Workbench or any MySQL interface.
Execute the SQL schema script (my_queries.sql) to create and populate the database:
Ensure the database is named mealplandb.
Insert at least 200 rows of data across the tables.

Step 2: Run the Python Front-End
Ensure you have Python installed with the mysql-connector-python library:
Install the library with the command: pip install mysql-connector-python
Save the front-end.py script to your local machine.
Execute the script:
Use the command: python3 front-end.py or python front-end.py.
Enter your MySQL root password when prompted.
Follow the menu options to execute queries:
For example, select 1 to query customers who prefer the Keto diet.

3. Expected Grade and Justification
I expect to receive a grade of A (100%) for the following reasons:

The database schema follows all the project guidelines with appropriate normalization.
Data is properly populated across all tables, exceeding the 200-row requirement.
All required queries are implemented:
Level 1: Four read-only queries, including SELECT, JOIN, subqueries, and aggregate functions.
Level 2: Four modification queries, including INSERT, DELETE, and queries demonstrating ON UPDATE and ON DELETE constraints.
The Python script successfully connects to the database and executes all queries with user interaction.
The project adheres to best practices, including modular code, comments, and user-friendly outputs.
4. Challenges Faced
Database Design:

Normalizing data and deciding which columns to include in each table required significant effort.
Determining the appropriate foreign key constraints, especially in junction tables.
Populating Data:

Generating realistic data that aligns with the schema required the use of Mockaroo and manual adjustments.
Ensuring foreign key relationships were maintained during data insertion.
Python and MySQL Integration:

Encountered initial errors with the mysql-connector-python library installation.
Debugging query errors, such as handling user input.

Error Handling

