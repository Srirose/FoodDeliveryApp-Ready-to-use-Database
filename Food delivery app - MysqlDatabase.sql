CREATE DATABASE FoodOrderingApp;
USE FoodOrderingApp;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    phone VARCHAR(15),
    rating DECIMAL(2,1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(8,2) NOT NULL,
    restaurant_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
        ON DELETE CASCADE
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    restaurant_id INT,
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Preparing', 'Out for Delivery', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);


CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT DEFAULT 1,
    price_each DECIMAL(8,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);
-- Data inserting time
INSERT INTO Users (name, email, password, phone, address) VALUES
('Anand Kumar', 'anand@example.com', 'pass123', '9876543210', 'Chennai, Tamil Nadu'),
('Priya Rani', 'priya@example.com', 'securepass', '9876543211', 'Coimbatore, Tamil Nadu'),
('Rahul Dev', 'rahul@example.com', 'rahul123', '9876543212', 'Madurai, Tamil Nadu'),
('Sneha Jain', 'sneha@example.com', 'snehapwd', '9876543213', 'Tirunelveli, Tamil Nadu'),
('Arun Mehta', 'arun@example.com', 'arunpass', '9876543214', 'Salem, Tamil Nadu');
Select * from Users;
INSERT INTO Restaurants (name, address, phone, rating) VALUES
('Spice Villa', 'Anna Nagar, Chennai', '0441234567', 4.5),
('Taste of Punjab', 'RS Puram, Coimbatore', '0422234567', 4.2),
('Chettinad Express', 'KK Nagar, Madurai', '0452234567', 4.6),
('South Delight', 'Palayamkottai, Tirunelveli', '0462234567', 4.3),
('Tandoori Treat', 'Fairlands, Salem', '0427234567', 4.1);
Select * from Restaurants;
INSERT INTO Items (name, description, price, restaurant_id) VALUES
('Paneer Butter Masala', 'Cottage cheese in butter tomato gravy', 180.00, 1),
('Veg Biryani', 'Flavored basmati rice with vegetables', 150.00, 2),
('Chicken Chettinad', 'Spicy Chettinad style chicken curry', 220.00, 3),
('Masala Dosa', 'Crispy dosa with potato masala', 90.00, 4),
('Tandoori Chicken', 'Grilled chicken with spices', 250.00, 5),
('Gobi Manchurian', 'Fried cauliflower in Indo-Chinese style', 130.00, 1),
('Rajma Chawal', 'Kidney beans curry with rice', 140.00, 2),
('Fish Curry', 'Tangy and spicy fish curry', 200.00, 3),
('Idli Vada Combo', 'Soft idli and crispy vada with sambar', 70.00, 4),
('Butter Naan', 'Tandoori naan with butter', 50.00, 5);
select * from Items;
INSERT INTO Orders (user_id, restaurant_id, status, total_amount) VALUES
(1, 1, 'Delivered', 310.00),
(2, 2, 'Out for Delivery', 290.00),
(3, 3, 'Preparing', 420.00),
(4, 4, 'Pending', 160.00),
(5, 5, 'Delivered', 300.00);
select * from Orders;

INSERT INTO Order_Items (order_id, item_id, quantity, price_each) VALUES
(1, 1, 1, 180.00),   -- Paneer Butter Masala
(1, 6, 1, 130.00),   -- Gobi Manchurian

(2, 2, 1, 150.00),   -- Veg Biryani
(2, 7, 1, 140.00),   -- Rajma Chawal

(3, 3, 1, 220.00),   -- Chicken Chettinad
(3, 8, 1, 200.00),   -- Fish Curry

(4, 4, 1, 90.00),    -- Masala Dosa
(4, 9, 1, 70.00),    -- Idli Vada Combo

(5, 5, 1, 250.00),   -- Tandoori Chicken
(5, 10, 1, 50.00);   -- Butter Naan
Select * from Order_Items;
-- Used to select the restaurant based on rating
SELECT name AS Restaurant_Name, rating 
FROM Restaurants
ORDER BY rating DESC;
-- Used to show the join statement
SELECT 
    Items.name AS Item_Name, 
    Items.price, 
    Restaurants.name AS Restaurant_Name 
FROM Items
JOIN Restaurants ON Items.restaurant_id = Restaurants.restaurant_id;

SELECT * FROM Orders
WHERE status = 'Cancelled';

SELECT * FROM Orders
WHERE order_time >= NOW() - INTERVAL 3 DAY;

-- Thank you!!!

