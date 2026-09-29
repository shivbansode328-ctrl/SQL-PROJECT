
CREATE DATABASE FoodDeliveryProject;
USE FoodDeliveryProject;

-- 1. Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    JoinDate DATE
);

INSERT INTO Customers VALUES
(1, 'Amit Sharma', '9876543210', 'amit@example.com', '2024-01-12'),
(2, 'Neha Verma', '8765432109', 'neha@example.com', '2024-02-18'),
(3, 'Rohit Mehta', '7654321098', 'rohit@example.com', '2024-03-22'),
(4, 'Pooja Singh', '6543210987', 'pooja@example.com', '2024-04-15');

SELECT * FROM Customers;

-- 2. Restaurants
CREATE TABLE Restaurants (
    RestaurantID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    Rating FLOAT
);

INSERT INTO Restaurants VALUES
(1, 'Spicy Hub', 'Mumbai', 4.5),
(2, 'Burger Town', 'Pune', 4.2),
(3, 'Pizza Palace', 'Delhi', 3.9),
(4, 'Healthy Bites', 'Bangalore', 4.7);

SELECT * FROM Restaurants;

-- 3. DeliveryPartners
CREATE TABLE DeliveryPartners (
    PartnerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    VehicleType VARCHAR(50),
    Rating FLOAT
);

INSERT INTO DeliveryPartners VALUES
(1, 'Ravi Kumar', '9123456789', 'Bike', 4.6),
(2, 'Suresh Patil', '9234567890', 'Scooter', 4.1),
(3, 'Anil Yadav', '9345678901', 'Bike', 3.8),
(4, 'Kiran Joshi', '9456789012', 'Scooter', 4.9);

SELECT * FROM DeliveryPartners;

-- 4. Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    PartnerID INT,
    OrderTime DATETIME,
    DeliveryTime DATETIME,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID),
    FOREIGN KEY (PartnerID) REFERENCES DeliveryPartners(PartnerID)
);

INSERT INTO Orders VALUES
(1, 1, 1, 1, '2025-01-10 12:00:00', '2025-01-10 12:40:00', 550.00, 'Delivered'),
(2, 2, 2, 2, '2025-01-11 13:00:00', '2025-01-11 13:50:00', 320.00, 'Delivered'),
(3, 3, 3, 3, '2025-01-12 18:00:00', NULL, 700.00, 'Cancelled'),
(4, 4, 4, 4, '2025-01-13 20:00:00', '2025-01-13 20:30:00', 450.00, 'Delivered');

SELECT * FROM Orders;

-- 5. OrderReviews
CREATE TABLE OrderReviews (
    ReviewID INT PRIMARY KEY,
    OrderID INT,
    CustomerRating FLOAT,
    ReviewText VARCHAR(255),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderReviews VALUES
(1, 1, 4.8, 'Excellent food and quick delivery'),
(2, 2, 4.2, 'Tasty burger and good service'),
(3, 3, 2.5, 'Order cancelled very late'),
(4, 4, 5.0, 'Healthy and fresh food');

SELECT * FROM OrderReviews;
