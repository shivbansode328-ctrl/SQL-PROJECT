
# Problem Solving with SQL Queries
# 1. Customer and Order Analysis

-- 1. Top Customers by Total Orders
SELECT c.Name, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Status = 'Delivered'
GROUP BY c.CustomerID
ORDER BY TotalOrders DESC
LIMIT 5;

-- 2. Customers with High Cancellation Rate
SELECT c.Name,
       COUNT(CASE WHEN o.Status = 'Cancelled' THEN 1 END) * 1.0 / COUNT(o.OrderID) AS CancellationRate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
HAVING CancellationRate > 0.3;

-- 3. Busiest Order Day
SELECT DAYNAME(OrderTime) AS DayOfWeek, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY DayOfWeek
ORDER BY TotalOrders DESC
LIMIT 1;

# 2. Delivery Partner Performance

-- 1. Delivery Partners Rated Below 4.0
SELECT d.Name, AVG(r.CustomerRating) AS AvgRating
FROM DeliveryPartners d
JOIN Orders o ON d.PartnerID = o.PartnerID
JOIN OrderReviews r ON o.OrderID = r.OrderID
GROUP BY d.PartnerID
HAVING AvgRating < 4.0;

-- 2. Top 5 Highest Value Orders
SELECT c.Name, o.TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY o.TotalAmount DESC
LIMIT 5;

-- 3. Delivery Partners with High Cancellation Rates
SELECT d.Name,
       COUNT(CASE WHEN o.Status = 'Cancelled' THEN 1 END) * 1.0 / COUNT(o.OrderID) AS CancellationRate
FROM DeliveryPartners d
JOIN Orders o ON d.PartnerID = o.PartnerID
GROUP BY d.PartnerID
HAVING CancellationRate > 0.3;

# 3. Revenue and Restaurant Metrics

-- 1. Monthly Revenue
SELECT MONTH(OrderTime) AS Month,
       SUM(TotalAmount) AS MonthlyRevenue
FROM Orders
WHERE Status = 'Delivered'
GROUP BY Month
ORDER BY Month;

-- 2. Top Restaurants by Revenue
SELECT r.Name,
       SUM(o.TotalAmount) AS Revenue
FROM Restaurants r
JOIN Orders o ON r.RestaurantID = o.RestaurantID
WHERE o.Status = 'Delivered'
GROUP BY r.RestaurantID
ORDER BY Revenue DESC;

-- 3. Average Delivery Time
SELECT AVG(TIMESTAMPDIFF(MINUTE, OrderTime, DeliveryTime)) AS AvgDeliveryMinutes
FROM Orders
WHERE Status = 'Delivered';

# 4. Review and Rating Analysis

-- 1. Restaurants with Best Ratings
SELECT r.Name, AVG(rv.CustomerRating) AS AvgRating
FROM Restaurants r
JOIN Orders o ON r.RestaurantID = o.RestaurantID
JOIN OrderReviews rv ON o.OrderID = rv.OrderID
GROUP BY r.RestaurantID
ORDER BY AvgRating DESC;

-- 2. Orders with Low Ratings
SELECT o.OrderID, rv.CustomerRating, rv.ReviewText
FROM Orders o
JOIN OrderReviews rv ON o.OrderID = rv.OrderID
WHERE rv.CustomerRating < 3.0;

-- 3. Total Orders by Status
SELECT Status, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY Status;
