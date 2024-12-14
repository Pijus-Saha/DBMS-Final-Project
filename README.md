# DBMS-Final-Project
# You can import the sweetify.sql file to phpmyadmin for run the full project.
CREATE DATABASE Sweetify;
USE Sweetify;


CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    phone_number VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE,
    description TEXT
);


CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    stock_quantity INT,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);


CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_price DECIMAL(10, 2),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);


CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


CREATE TABLE Cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


CREATE TABLE Wishlist (
    wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2),
    method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery'),
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);


CREATE TABLE Shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipping_address TEXT,
    shipping_date TIMESTAMP NULL,
    delivery_date TIMESTAMP NULL,
    tracking_number VARCHAR(100),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);


CREATE TABLE Admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password_hash VARCHAR(255),
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE Discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    discount_code VARCHAR(50) UNIQUE,
    description TEXT,
    discount_percentage DECIMAL(5, 2),
    valid_from DATE,
    valid_to DATE
);


CREATE TABLE ProductDiscounts (
    product_discount_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    discount_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id) ON DELETE CASCADE
);


CREATE TABLE ActivityLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);


CREATE TABLE Notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);


CREATE TABLE Subscriptions (
    subscription_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    subscription_type ENUM('Free', 'Basic', 'Premium'),
    start_date DATE,
    end_date DATE,
    status ENUM('Active', 'Expired', 'Cancelled'),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);


CREATE TABLE SupportTickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    subject VARCHAR(255),
    message TEXT,
    status ENUM('Open', 'In Progress', 'Resolved', 'Closed') DEFAULT 'Open',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);


CREATE TABLE Vendors (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE VendorProducts (
    vendor_product_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_id INT,
    product_id INT,
    stock_quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


CREATE VIEW ActiveUsers AS
SELECT user_id, first_name, last_name, email, created_at
FROM Users
WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

CREATE VIEW TopSellingProducts AS
SELECT p.product_id, p.product_name, SUM(od.quantity) AS total_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC;

CREATE VIEW RecentOrders AS
SELECT o.order_id, u.first_name, u.last_name, o.total_price, o.order_date
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
ORDER BY o.order_date DESC
LIMIT 10;

CREATE VIEW ProductStockStatus AS
SELECT p.product_id, p.product_name, i.quantity AS stock_quantity
FROM Products p
JOIN Inventory i ON p.product_id = i.product_id;

CREATE VIEW PendingSupportTickets AS
SELECT st.ticket_id, u.first_name, u.last_name, st.subject, st.created_at
FROM SupportTickets st
JOIN Users u ON st.user_id = u.user_id
WHERE st.status = 'Open';


DELIMITER //
CREATE TRIGGER UpdateInventoryAfterOrder
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END //

CREATE TRIGGER LogUserActions
AFTER INSERT ON ActivityLogs
FOR EACH ROW
BEGIN
    INSERT INTO Notifications (user_id, message, created_at)
    VALUES (NEW.user_id, CONCAT('Action logged: ', NEW.action), NOW());
END //

CREATE TRIGGER UpdateOrderStatus
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    IF NEW.status = 'Delivered' THEN
        INSERT INTO Notifications (user_id, message, created_at)
        VALUES (NEW.user_id, 'Your order has been delivered.', NOW());
    END IF;
END //


DELIMITER //


CREATE TRIGGER ValidateStockBeforeOrder
BEFORE INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;
    SELECT quantity INTO available_stock FROM Inventory WHERE product_id = NEW.product_id;
    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for this product.';
    END IF;
END //


CREATE TRIGGER SetShippingDate
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    IF NEW.status = 'Shipped' THEN
        UPDATE Shipping
        SET shipping_date = NOW()
        WHERE order_id = NEW.order_id;
    END IF;
END //


CREATE TRIGGER LogUserRegistration
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    INSERT INTO ActivityLogs (user_id, action, timestamp)
    VALUES (NEW.user_id, 'User registered.', NOW());
END //


CREATE TRIGGER UpdateVendorStock
AFTER UPDATE ON Inventory
FOR EACH ROW
BEGIN
    UPDATE VendorProducts
    SET stock_quantity = NEW.quantity
    WHERE product_id = NEW.product_id;
END //


CREATE TRIGGER CalculateOrderTotal
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE order_total DECIMAL(10, 2);
    SELECT SUM(quantity * price) INTO order_total
    FROM OrderDetails
    WHERE order_id = NEW.order_id;
    UPDATE Orders
    SET total_price = order_total
    WHERE order_id = NEW.order_id;
END //

DELIMITER ;


INSERT INTO Users (first_name, last_name, email, password_hash, phone_number, address) VALUES
('Rahim', 'Ahmed', 'rahim.ahmed@example.com', 'hashed_pw1', '01711111111', 'Dhaka'),
('Karim', 'Hossain', 'karim.hossain@example.com', 'hashed_pw2', '01722222222', 'Chattogram'),
('Sumon', 'Islam', 'sumon.islam@example.com', 'hashed_pw3', '01733333333', 'Sylhet'),
('Rita', 'Sultana', 'rita.sultana@example.com', 'hashed_pw4', '01744444444', 'Rajshahi'),
('Mita', 'Akter', 'mita.akter@example.com', 'hashed_pw5', '01755555555', 'Khulna'),
('Jalal', 'Uddin', 'jalal.uddin@example.com', 'hashed_pw6', '01766666666', 'Barishal'),
('Tina', 'Begum', 'tina.begum@example.com', 'hashed_pw7', '01777777777', 'Rangpur'),
('Mamun', 'Chowdhury', 'mamun.chowdhury@example.com', 'hashed_pw8', '01788888888', 'Mymensingh'),
('Nadia', 'Shikder', 'nadia.shikder@example.com', 'hashed_pw9', '01799999999', 'Gazipur'),
('Rashed', 'Hasan', 'rashed.hasan@example.com', 'hashed_pw10', '01811111111', 'Cumilla'),
('Sadia', 'Pervin', 'sadia.pervin@example.com', 'hashed_pw11', '01822222222', 'Narayanganj'),
('Fahim', 'Rahman', 'fahim.rahman@example.com', 'hashed_pw12', '01833333333', 'Jashore'),
('Rumi', 'Jahan', 'rumi.jahan@example.com', 'hashed_pw13', '01844444444', 'Faridpur'),
('Imran', 'Sikder', 'imran.sikder@example.com', 'hashed_pw14', '01855555555', 'Noakhali'),
('Bithi', 'Khan', 'bithi.khan@example.com', 'hashed_pw15', '01866666666', 'Dinajpur');

INSERT INTO Categories (category_name, description) VALUES
('Traditional Sweets', 'Bangladeshi traditional sweets like roshogolla and sandesh'),
('Modern Sweets', 'Innovative sweets like chocolate-based items'),
('Milk-Based Sweets', 'Sweets made primarily from milk, such as kheer and chomchom'),
('Dry Sweets', 'Dry sweets like laddoo and barfi'),
('Syrup-Based Sweets', 'Syrupy sweets such as jilapi and roshmalai');

INSERT INTO Products (product_name, description, price, stock_quantity, category_id) VALUES
('Roshogolla', 'Soft round sweets made from chhena and syrup', 10.00, 500, 1),
('Sandesh', 'Sweet made from milk and sugar', 12.00, 400, 1),
('Chocolate Barfi', 'Chocolate-flavored barfi', 15.00, 200, 2),
('Chomchom', 'Caramel-coated cylindrical sweets', 20.00, 300, 3),
('Kheer', 'Sweet milk pudding', 25.00, 150, 3),
('Laddoo', 'Round sweet balls made from flour and sugar', 8.00, 600, 4),
('Jilapi', 'Crispy and syrupy spiral sweets', 5.00, 1000, 5),
('Roshmalai', 'Soft balls soaked in sweetened milk', 18.00, 250, 5),
('Barfi', 'Sweet confectionery made with condensed milk', 15.00, 350, 4),
('Kalo Jam', 'Syrup-coated sweet, darker than roshogolla', 12.00, 400, 1),
('Chocolate Sandesh', 'Sandesh with chocolate flavor', 18.00, 200, 2),
('Pera Sandesh', 'Dry milk-based sweet', 15.00, 300, 1),
('Malai Chop', 'Sweets soaked in creamy milk', 22.00, 150, 3),
('Dry Fruits Laddoo', 'Laddoo enriched with dry fruits', 20.00, 250, 4),
('Milk Cake', 'Sweetened condensed milk cake', 30.00, 100, 3);


INSERT INTO Orders (user_id, total_price, status) VALUES
(1, 100.00, 'Pending'),
(2, 250.00, 'Processing'),
(3, 180.00, 'Shipped'),
(4, 300.00, 'Delivered'),
(5, 150.00, 'Cancelled'),
(6, 220.00, 'Processing'),
(7, 180.00, 'Shipped'),
(8, 320.00, 'Pending'),
(9, 90.00, 'Delivered'),
(10, 200.00, 'Pending'),
(11, 120.00, 'Cancelled'),
(12, 400.00, 'Processing'),
(13, 340.00, 'Shipped'),
(14, 150.00, 'Pending'),
(15, 230.00, 'Delivered');

INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES
(1, 1, 10, 10.00),
(2, 3, 5, 15.00),
(3, 6, 20, 8.00),
(4, 9, 10, 15.00),
(5, 4, 5, 20.00),
(6, 7, 15, 5.00),
(7, 8, 10, 18.00),
(8, 2, 15, 12.00),
(9, 12, 10, 15.00),
(10, 10, 8, 12.00),
(11, 5, 6, 25.00),
(12, 13, 12, 22.00),
(13, 14, 10, 20.00),
(14, 11, 5, 18.00),
(15, 15, 8, 30.00);

INSERT INTO Cart (user_id, product_id, quantity) VALUES
(1, 3, 2),
(2, 6, 5),
(3, 1, 3),
(4, 2, 4),
(5, 5, 1),
(6, 7, 6),
(7, 4, 2),
(8, 9, 3),
(9, 10, 5),
(10, 8, 1),
(11, 12, 2),
(12, 15, 4),
(13, 14, 2),
(14, 13, 1),
(15, 11, 3);

INSERT INTO Wishlist (user_id, product_id) VALUES
(1, 1),
(2, 3),
(3, 5),
(4, 7),
(5, 9),
(6, 2),
(7, 4),
(8, 6),
(9, 8),
(10, 10),
(11, 12),
(12, 14),
(13, 15),
(14, 13),
(15, 11);

INSERT INTO Reviews (user_id, product_id, rating, comment) VALUES
(1, 1, 5, 'Delicious! Highly recommended.'),
(2, 3, 4, 'Good, but a bit overpriced.'),
(3, 5, 5, 'Best I’ve ever tasted!'),
(4, 7, 3, 'Average taste, not as expected.'),
(5, 9, 4, 'Loved the flavor!'),
(6, 2, 5, 'Perfect for any occasion.'),
(7, 4, 3, 'Too sweet for my liking.'),
(8, 6, 4, 'Nice texture and taste.'),
(9, 8, 5, 'A must-try dessert!'),
(10, 10, 3, 'Decent quality.'),
(11, 12, 4, 'Very satisfying.'),
(12, 14, 5, 'Excellent product!'),
(13, 15, 4, 'Good, but stock often runs out.'),
(14, 13, 5, 'Amazing flavor and texture.'),
(15, 11, 4, 'Quite good overall.');

INSERT INTO Inventory (product_id, quantity) VALUES
(1, 500),
(2, 400),
(3, 200),
(4, 300),
(5, 150),
(6, 600),
(7, 1000),
(8, 250),
(9, 350),
(10, 400),
(11, 200),
(12, 300),
(13, 150),
(14, 250),
(15, 100);

INSERT INTO Payments (order_id, payment_date, amount, method, status) VALUES
(1, '2024-12-01 10:00:00', 100.00, 'Credit Card', 'Completed'),
(2, '2024-12-02 11:30:00', 250.00, 'PayPal', 'Completed'),
(3, '2024-12-03 14:45:00', 180.00, 'Bank Transfer', 'Completed'),
(4, '2024-12-04 09:20:00', 300.00, 'Cash on Delivery', 'Pending'),
(5, '2024-12-05 16:10:00', 150.00, 'Credit Card', 'Failed'),
(6, '2024-12-06 12:25:00', 220.00, 'PayPal', 'Completed'),
(7, '2024-12-07 15:50:00', 180.00, 'Bank Transfer', 'Completed'),
(8, '2024-12-08 10:05:00', 320.00, 'Credit Card', 'Completed'),
(9, '2024-12-09 17:15:00', 90.00, 'Cash on Delivery', 'Pending'),
(10, '2024-12-10 13:30:00', 200.00, 'Credit Card', 'Completed');

INSERT INTO Shipping (order_id, shipping_address, shipping_date, delivery_date, tracking_number) VALUES
(1, 'Dhaka, Bangladesh', '2024-12-02', '2024-12-04', 'TRACK12345'),
(2, 'Chattogram, Bangladesh', '2024-12-03', '2024-12-06', 'TRACK12346'),
(3, 'Sylhet, Bangladesh', '2024-12-04', '2024-12-08', 'TRACK12347'),
(4, 'Rajshahi, Bangladesh', '2024-12-05', '2024-12-10', 'TRACK12348'),
(5, 'Khulna, Bangladesh', '2024-12-06', NULL, 'TRACK12349'),
(6, 'Barishal, Bangladesh', '2024-12-07', '2024-12-11', 'TRACK12350'),
(7, 'Rangpur, Bangladesh', '2024-12-08', '2024-12-12', 'TRACK12351'),
(8, 'Mymensingh, Bangladesh', '2024-12-09', NULL, 'TRACK12352'),
(9, 'Gazipur, Bangladesh', '2024-12-10', '2024-12-15', 'TRACK12353');

INSERT INTO Admins (username, password_hash, email) VALUES
('Rubayat', 'Uddin', 'rimon15-5973@diu.edu.bd'),
('Apon', 'Paul', 'paul15-5896@diu.edu.bd'),
('Masum', 'Billah', 'billah15-6002@diu.edu.bd'),
('Pijus', 'Saha', 'saha15-5809@diu.edu.bd');

INSERT INTO Discounts (discount_code, description, discount_percentage, valid_from, valid_to) VALUES
('NEWYEAR2025', 'New Year Offer', 10.00, '2024-12-31', '2025-01-07'),
('WINTERSALE', 'Winter Sale', 15.00, '2024-12-01', '2025-02-28'),
('FREESHIP', 'Free Shipping Discount', 5.00, '2024-11-15', '2024-12-31');

INSERT INTO ProductDiscounts (product_id, discount_id) VALUES
(1, 1),
(3, 2),
(7, 3),
(8, 1),
(9, 2);

INSERT INTO ActivityLogs (user_id, action, timestamp) VALUES
(1, 'Logged in', '2024-12-01 09:00:00'),
(2, 'Placed an order', '2024-12-01 09:15:00'),
(3, 'Updated profile', '2024-12-01 10:30:00'),
(4, 'Logged out', '2024-12-01 11:00:00'),
(5, 'Added to wishlist', '2024-12-01 11:15:00');

INSERT INTO Notifications (user_id, message, created_at, is_read) VALUES
(1, 'Your order has been processed', '2024-12-01 09:00:00', FALSE),
(2, 'New discount available!', '2024-12-01 10:00:00', TRUE),
(3, 'Your profile has been updated', '2024-12-01 10:30:00', FALSE),
(4, 'Welcome back!', '2024-12-01 11:00:00', TRUE),
(5, 'Item added to your wishlist', '2024-12-01 11:15:00', FALSE);

INSERT INTO SupportTickets (user_id, subject, message, status) VALUES
(1, 'Order Issue', 'I did not receive my order.', 'Open'),
(2, 'Discount Inquiry', 'How to use discount codes?', 'Resolved'),
(3, 'Shipping Delay', 'My delivery is delayed.', 'In Progress');

INSERT INTO Vendors (name, email, phone_number, address) VALUES
('Vendor1', 'vendor1@example.com', '01811111111', 'Dhaka, Bangladesh'),
('Vendor2', 'vendor2@example.com', '01822222222', 'Chattogram, Bangladesh'),
('Vendor3', 'vendor3@example.com', '01833333333', 'Sylhet, Bangladesh');

INSERT INTO VendorProducts (vendor_id, product_id, stock_quantity, price) VALUES
(1, 1, 300, 9.00),
(1, 2, 200, 11.00),
(2, 3, 150, 13.00),
(2, 4, 100, 18.00),
(3, 5, 80, 22.00);
