-- Create Database
DROP SCHEMA IF EXISTS mealplandb;
CREATE SCHEMA mealplandb;
USE mealplandb;

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PreferredDiet ENUM('Vegan', 'Keto', 'Low-Carb', 'Vegetarian', 'Paleo', 'Mediterranean', 'None') NOT NULL,
    ZipCode VARCHAR(10) NOT NULL
);

-- Meals Table
CREATE TABLE Meals (
    MealID INT AUTO_INCREMENT PRIMARY KEY,
    Meal VARCHAR(100) NOT NULL,
    Category ENUM('Breakfast', 'Lunch', 'Dinner', 'Snacks', 'Dessert') NOT NULL,
    PrepTime INT NOT NULL,
    Difficulty ENUM('Easy', 'Medium', 'Hard') NOT NULL,
    Calories INT NOT NULL
);

-- Ingredients Table
CREATE TABLE Ingredients (
    IngredientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Category ENUM('Protein', 'Carb', 'Vegetable', 'Fruit', 'Dairy', 'Spice', 'Other') NOT NULL,
    IsAllergen BOOLEAN NOT NULL DEFAULT FALSE
);

-- MealIngredients Table (Junction Table for Many-to-Many Relationship)
CREATE TABLE MealIngredients (
    MealIngredientID INT AUTO_INCREMENT PRIMARY KEY,
    MealID INT NOT NULL,
    IngredientID INT NOT NULL,
    FOREIGN KEY (MealID) REFERENCES Meals(MealID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID)
);

-- Nutrition Data Table
CREATE TABLE NutritionData (
    NutritionID INT AUTO_INCREMENT PRIMARY KEY,
    IngredientID INT NOT NULL,
    MealID INT NOT NULL,
    CaloricValue INT NOT NULL,
    Fat DECIMAL(5, 2),
    SaturatedFats DECIMAL(5, 2),
    MonounsaturatedFats DECIMAL(5, 2),
    PolyunsaturatedFats DECIMAL(5, 2),
    Carbohydrates DECIMAL(5, 2),
    Sugars DECIMAL(5, 2),
    Protein DECIMAL(5, 2),
    DietaryFiber DECIMAL(5, 2),
    Cholesterol DECIMAL(5, 2),
    Sodium DECIMAL(5, 2),
    Water DECIMAL(10, 3),
    VitaminA DECIMAL(5, 2),
    VitaminB1 DECIMAL(5, 3),
    VitaminB11 DECIMAL(10, 3),
    VitaminB12 DECIMAL(10, 3),
    VitaminB2 DECIMAL(10, 3),
    VitaminB3 DECIMAL(10, 3),
    VitaminB5 DECIMAL(10, 3),
    VitaminB6 DECIMAL(10, 3),
    VitaminC DECIMAL(10, 3),
    VitaminD DECIMAL(10, 3),
    VitaminE DECIMAL(10, 3),
    VitaminK DECIMAL(10, 3),
    Calcium DECIMAL(5, 2),
    Copper DECIMAL(10, 3),
    Iron DECIMAL(10, 3),
    Magnesium DECIMAL(5, 2),
    Manganese DECIMAL(10, 3),
    Phosphorus DECIMAL(5, 2),
    Potassium DECIMAL(5, 2),
    Selenium DECIMAL(10, 3),
    Zinc DECIMAL(10, 3),
    NutritionDensity DECIMAL(10, 3),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID),
    FOREIGN KEY (MealID) REFERENCES Meals(MealID)
);


-- Grocery Stores Table
CREATE TABLE GroceryStores (
    StoreID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(200) NOT NULL,
    ContactInfo VARCHAR(100),
    ZipCode VARCHAR(10) NOT NULL
);

-- Store Inventory Table
CREATE TABLE StoreInventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    StoreID INT NOT NULL,
    IngredientID INT NOT NULL,
    PricePerUnit DECIMAL(10,2) NOT NULL,
    StockLevel INT NOT NULL,
    FOREIGN KEY (StoreID) REFERENCES GroceryStores(StoreID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID)
);

-- Feedback Table
CREATE TABLE Feedback (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    MealID INT NOT NULL,
    Rating ENUM('1', '2', '3', '4', '5') NOT NULL,
    Comments TEXT,
    FeedbackDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (MealID) REFERENCES Meals(MealID)
);

-- Create indexes to improve query performance
CREATE INDEX idx_customer_email ON Customers(Email);
CREATE INDEX idx_meal_category ON Meals(Category);
CREATE INDEX idx_ingredient_category ON Ingredients(Category);
CREATE INDEX idx_store_zipcode ON GroceryStores(ZipCode);
CREATE INDEX idx_feedback_date ON Feedback(FeedbackDate);