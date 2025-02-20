-- my_queries.sql

-- Query 1: Retrieve all customers who prefer a Keto diet.
-- (1) This query fetches customers whose preferred diet is 'Keto'.
-- (2) Works correctly.
-- (3) Returns rows with customer first name, last name, and email (e.g., ("John", "Doe", "john.doe@example.com")).
SELECT FirstName, LastName, Email
FROM Customers
WHERE PreferredDiet = 'Keto';

-- Query 2: Find ingredients for a specific meal.
-- (1) This query retrieves the ingredients for a specific meal, joined with their categories.
-- (2) Works correctly when a valid meal name is provided.
-- (3) Returns rows with meal name, ingredient name, and ingredient category (e.g., ("Pasta", "Tomato", "Vegetable")).
SELECT m.Meal, i.Name AS Ingredient, i.Category
FROM Meals m
JOIN MealIngredients mi ON m.MealID = mi.MealID
JOIN Ingredients i ON mi.IngredientID = i.IngredientID
WHERE m.Meal = 'Pasta'; -- Replace 'Pasta' with any meal name.

-- Query 3: Retrieve meals with above-average calories.
-- (1) This query retrieves all meals that have calories higher than the average calorie value of meals in the database.
-- (2) Works correctly.
-- (3) Returns rows with meal name and calorie count (e.g., ("Burger", 600)).
SELECT Meal, Calories
FROM Meals
WHERE Calories > (SELECT AVG(Calories) FROM Meals);

-- Query 4: Calculate the average rating for each meal.
-- (1) This query calculates the average rating for each meal based on feedback and sorts them in descending order of average rating.
-- (2) Works correctly.
-- (3) Returns rows with meal name and average rating (e.g., ("Pizza", 4.5)).
SELECT m.Meal, AVG(f.Rating) AS AverageRating
FROM Feedback f
JOIN Meals m ON f.MealID = m.MealID
GROUP BY m.Meal
ORDER BY AverageRating DESC;

-- Query 5: Add a new customer.
-- (1) This query inserts a new customer record into the database.
-- (2) Works correctly when all inputs are valid.
-- (3) Inserts a row into the Customers table (e.g., ("John", "Doe", "john.doe@example.com", "Keto", "12345")).
INSERT INTO Customers (FirstName, LastName, Email, PreferredDiet, ZipCode)
VALUES ('John', 'Doe', 'john.doe@example.com', 'Keto', '12345');

-- Query 6: Delete a feedback record for a meal.
-- (1) This query deletes a feedback record for a specific customer and meal combination.
-- (2) Works correctly when valid CustomerID and MealID are provided.
-- (3) Removes a row from the Feedback table where CustomerID = 1 and MealID = 2.
DELETE FROM Feedback
WHERE CustomerID = 1 AND MealID = 2;

-- Query 7: Update the zip code of a grocery store.
-- (1) This query updates the zip code of a grocery store based on its StoreID.
-- (2) Works correctly when a valid StoreID is provided.
-- (3) Updates the zip code in the GroceryStores table (e.g., StoreID 1's ZipCode is updated to "67890").
UPDATE GroceryStores
SET ZipCode = '67890'
WHERE StoreID = 1;

-- Query 8: Delete a meal and its feedback records (cascade delete).
-- (1) This query deletes a meal record and all related feedback records due to ON DELETE CASCADE.
-- (2) Works correctly when a valid MealID is provided.
-- (3) Removes a row from the Meals table and all related rows from the Feedback table (e.g., MealID = 3).
DELETE FROM Meals
WHERE MealID = 3;
