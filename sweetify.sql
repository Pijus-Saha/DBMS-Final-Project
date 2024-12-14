-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 12, 2024 at 07:49 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sweetify`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `activeusers`
-- (See below for the actual view)
--
CREATE TABLE `activeusers` (
`user_id` int(11)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`email` varchar(100)
,`created_at` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `activitylogs`
--

CREATE TABLE `activitylogs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activitylogs`
--

INSERT INTO `activitylogs` (`log_id`, `user_id`, `action`, `timestamp`) VALUES
(1, 1, 'User registered.', '2024-12-10 05:10:29'),
(2, 2, 'User registered.', '2024-12-10 05:10:29'),
(3, 3, 'User registered.', '2024-12-10 05:10:29'),
(4, 4, 'User registered.', '2024-12-10 05:10:29'),
(5, 5, 'User registered.', '2024-12-10 05:10:29'),
(6, 6, 'User registered.', '2024-12-10 05:10:29'),
(7, 7, 'User registered.', '2024-12-10 05:10:29'),
(8, 8, 'User registered.', '2024-12-10 05:10:29'),
(9, 9, 'User registered.', '2024-12-10 05:10:29'),
(10, 10, 'User registered.', '2024-12-10 05:10:29'),
(11, 11, 'User registered.', '2024-12-10 05:10:29'),
(12, 12, 'User registered.', '2024-12-10 05:10:29'),
(13, 13, 'User registered.', '2024-12-10 05:10:29'),
(14, 14, 'User registered.', '2024-12-10 05:10:29'),
(15, 15, 'User registered.', '2024-12-10 05:10:29'),
(16, 1, 'Logged in', '2024-12-01 03:00:00'),
(17, 2, 'Placed an order', '2024-12-01 03:15:00'),
(18, 3, 'Updated profile', '2024-12-01 04:30:00'),
(19, 4, 'Logged out', '2024-12-01 05:00:00'),
(20, 5, 'Added to wishlist', '2024-12-01 05:15:00');

--
-- Triggers `activitylogs`
--
DELIMITER $$
CREATE TRIGGER `LogUserActions` AFTER INSERT ON `activitylogs` FOR EACH ROW BEGIN
    INSERT INTO Notifications (user_id, message, created_at)
    VALUES (NEW.user_id, CONCAT('Action logged: ', NEW.action), NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `username`, `password_hash`, `email`, `created_at`) VALUES
(1, 'Rubayat', 'Uddin', 'rimon15-5973@diu.edu.bd', '2024-12-10 05:22:30'),
(2, 'Apon', 'Paul', 'paul15-5896@diu.edu.bd', '2024-12-10 05:22:30'),
(3, 'Masum', 'Billah', 'billah15-6002@diu.edu.bd', '2024-12-10 05:22:30'),
(4, 'Pijus', 'Saha', 'saha15-5809@diu.edu.bd', '2024-12-10 05:22:30');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `product_id`, `quantity`, `created_at`) VALUES
(1, 1, 3, 2, '2024-12-10 05:14:15'),
(2, 2, 6, 5, '2024-12-10 05:14:15'),
(3, 3, 1, 3, '2024-12-10 05:14:15'),
(4, 4, 2, 4, '2024-12-10 05:14:15'),
(5, 5, 5, 1, '2024-12-10 05:14:15'),
(6, 6, 7, 6, '2024-12-10 05:14:15'),
(7, 7, 4, 2, '2024-12-10 05:14:15'),
(8, 8, 9, 3, '2024-12-10 05:14:15'),
(9, 9, 10, 5, '2024-12-10 05:14:15'),
(10, 10, 8, 1, '2024-12-10 05:14:15'),
(11, 11, 12, 2, '2024-12-10 05:14:15'),
(12, 12, 15, 4, '2024-12-10 05:14:15'),
(13, 13, 14, 2, '2024-12-10 05:14:15'),
(14, 14, 13, 1, '2024-12-10 05:14:15'),
(15, 15, 11, 3, '2024-12-10 05:14:15');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Traditional Sweets', 'Bangladeshi traditional sweets like roshogolla and sandesh'),
(2, 'Modern Sweets', 'Innovative sweets like chocolate-based items'),
(3, 'Milk-Based Sweets', 'Sweets made primarily from milk, such as kheer and chomchom'),
(4, 'Dry Sweets', 'Dry sweets like laddoo and barfi'),
(5, 'Syrup-Based Sweets', 'Syrupy sweets such as jilapi and roshmalai');

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `discount_id` int(11) NOT NULL,
  `discount_code` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `discount_percentage` decimal(5,2) DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `discounts`
--

INSERT INTO `discounts` (`discount_id`, `discount_code`, `description`, `discount_percentage`, `valid_from`, `valid_to`) VALUES
(1, 'NEWYEAR2025', 'New Year Offer', 10.00, '2024-12-31', '2025-01-07'),
(2, 'WINTERSALE', 'Winter Sale', 15.00, '2024-12-01', '2025-02-28'),
(3, 'FREESHIP', 'Free Shipping Discount', 5.00, '2024-11-15', '2024-12-31');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `product_id`, `quantity`, `last_updated`) VALUES
(1, 1, 500, '2024-12-10 05:17:21'),
(2, 2, 400, '2024-12-10 05:17:21'),
(3, 3, 200, '2024-12-10 05:17:21'),
(4, 4, 300, '2024-12-10 05:17:21'),
(5, 5, 150, '2024-12-10 05:17:21'),
(6, 6, 600, '2024-12-10 05:17:21'),
(7, 7, 1000, '2024-12-10 05:17:21'),
(8, 8, 250, '2024-12-10 05:17:21'),
(9, 9, 350, '2024-12-10 05:17:21'),
(10, 10, 400, '2024-12-10 05:17:21'),
(11, 11, 200, '2024-12-10 05:17:21'),
(12, 12, 300, '2024-12-10 05:17:21'),
(13, 13, 150, '2024-12-10 05:17:21'),
(14, 14, 250, '2024-12-10 05:17:21'),
(15, 15, 100, '2024-12-10 05:17:21');

--
-- Triggers `inventory`
--
DELIMITER $$
CREATE TRIGGER `UpdateVendorStock` AFTER UPDATE ON `inventory` FOR EACH ROW BEGIN
    UPDATE VendorProducts
    SET stock_quantity = NEW.quantity
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `message`, `created_at`, `is_read`) VALUES
(1, 1, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(2, 2, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(3, 3, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(4, 4, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(5, 5, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(6, 6, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(7, 7, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(8, 8, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(9, 9, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(10, 10, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(11, 11, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(12, 12, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(13, 13, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(14, 14, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(15, 15, 'Action logged: User registered.', '2024-12-10 05:10:29', 0),
(16, 4, 'Your order has been delivered.', '2024-12-10 05:13:50', 0),
(17, 9, 'Your order has been delivered.', '2024-12-10 05:13:50', 0),
(18, 15, 'Your order has been delivered.', '2024-12-10 05:13:50', 0),
(19, 1, 'Action logged: Logged in', '2024-12-10 05:25:33', 0),
(20, 2, 'Action logged: Placed an order', '2024-12-10 05:25:33', 0),
(21, 3, 'Action logged: Updated profile', '2024-12-10 05:25:33', 0),
(22, 4, 'Action logged: Logged out', '2024-12-10 05:25:33', 0),
(23, 5, 'Action logged: Added to wishlist', '2024-12-10 05:25:33', 0),
(24, 1, 'Your order has been processed', '2024-12-01 03:00:00', 0),
(25, 2, 'New discount available!', '2024-12-01 04:00:00', 1),
(26, 3, 'Your profile has been updated', '2024-12-01 04:30:00', 0),
(27, 4, 'Welcome back!', '2024-12-01 05:00:00', 1),
(28, 5, 'Item added to your wishlist', '2024-12-01 05:15:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderdetails`
--

INSERT INTO `orderdetails` (`order_detail_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 1, 10, 10.00),
(2, 2, 3, 5, 15.00),
(3, 3, 6, 20, 8.00),
(4, 4, 9, 10, 15.00),
(5, 5, 4, 5, 20.00),
(6, 6, 7, 15, 5.00),
(7, 7, 8, 10, 18.00),
(8, 8, 2, 15, 12.00),
(9, 9, 12, 10, 15.00),
(10, 10, 10, 8, 12.00),
(11, 11, 5, 6, 25.00),
(12, 12, 13, 12, 22.00),
(13, 13, 14, 10, 20.00),
(14, 14, 11, 5, 18.00),
(15, 15, 15, 8, 30.00);

--
-- Triggers `orderdetails`
--
DELIMITER $$
CREATE TRIGGER `CalculateOrderTotal` AFTER INSERT ON `orderdetails` FOR EACH ROW BEGIN
    DECLARE order_total DECIMAL(10, 2);
    SELECT SUM(quantity * price) INTO order_total
    FROM OrderDetails
    WHERE order_id = NEW.order_id;
    UPDATE Orders
    SET total_price = order_total
    WHERE order_id = NEW.order_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UpdateInventoryAfterOrder` AFTER INSERT ON `orderdetails` FOR EACH ROW BEGIN
    UPDATE Inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `ValidateStockBeforeOrder` BEFORE INSERT ON `orderdetails` FOR EACH ROW BEGIN
    DECLARE available_stock INT;
    SELECT quantity INTO available_stock FROM Inventory WHERE product_id = NEW.product_id;
    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for this product.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Pending','Processing','Shipped','Delivered','Cancelled') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `total_price`, `order_date`, `status`) VALUES
(1, 1, 100.00, '2024-12-10 05:13:18', 'Pending'),
(2, 2, 75.00, '2024-12-10 05:13:18', 'Processing'),
(3, 3, 160.00, '2024-12-10 05:13:18', 'Shipped'),
(4, 4, 150.00, '2024-12-10 05:13:18', 'Delivered'),
(5, 5, 100.00, '2024-12-10 05:13:18', 'Cancelled'),
(6, 6, 75.00, '2024-12-10 05:13:18', 'Processing'),
(7, 7, 180.00, '2024-12-10 05:13:18', 'Shipped'),
(8, 8, 180.00, '2024-12-10 05:13:18', 'Pending'),
(9, 9, 150.00, '2024-12-10 05:13:18', 'Delivered'),
(10, 10, 96.00, '2024-12-10 05:13:18', 'Pending'),
(11, 11, 150.00, '2024-12-10 05:13:18', 'Cancelled'),
(12, 12, 264.00, '2024-12-10 05:13:18', 'Processing'),
(13, 13, 200.00, '2024-12-10 05:13:18', 'Shipped'),
(14, 14, 90.00, '2024-12-10 05:13:18', 'Pending'),
(15, 15, 240.00, '2024-12-10 05:13:18', 'Delivered');

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `SetShippingDate` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    IF NEW.status = 'Shipped' THEN
        UPDATE Shipping
        SET shipping_date = NOW()
        WHERE order_id = NEW.order_id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UpdateOrderStatus` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    IF NEW.status = 'Delivered' THEN
        INSERT INTO Notifications (user_id, message, created_at)
        VALUES (NEW.user_id, 'Your order has been delivered.', NOW());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `amount` decimal(10,2) DEFAULT NULL,
  `method` enum('Credit Card','PayPal','Bank Transfer','Cash on Delivery') DEFAULT NULL,
  `status` enum('Pending','Completed','Failed') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `order_id`, `payment_date`, `amount`, `method`, `status`) VALUES
(1, 1, '2024-12-01 04:00:00', 100.00, 'Credit Card', 'Completed'),
(2, 2, '2024-12-02 05:30:00', 250.00, 'PayPal', 'Completed'),
(3, 3, '2024-12-03 08:45:00', 180.00, 'Bank Transfer', 'Completed'),
(4, 4, '2024-12-04 03:20:00', 300.00, 'Cash on Delivery', 'Pending'),
(5, 5, '2024-12-05 10:10:00', 150.00, 'Credit Card', 'Failed'),
(6, 6, '2024-12-06 06:25:00', 220.00, 'PayPal', 'Completed'),
(7, 7, '2024-12-07 09:50:00', 180.00, 'Bank Transfer', 'Completed'),
(8, 8, '2024-12-08 04:05:00', 320.00, 'Credit Card', 'Completed'),
(9, 9, '2024-12-09 11:15:00', 90.00, 'Cash on Delivery', 'Pending'),
(10, 10, '2024-12-10 07:30:00', 200.00, 'Credit Card', 'Completed');

-- --------------------------------------------------------

--
-- Stand-in structure for view `pendingsupporttickets`
-- (See below for the actual view)
--
CREATE TABLE `pendingsupporttickets` (
`ticket_id` int(11)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`subject` varchar(255)
,`created_at` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `productdiscounts`
--

CREATE TABLE `productdiscounts` (
  `product_discount_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `productdiscounts`
--

INSERT INTO `productdiscounts` (`product_discount_id`, `product_id`, `discount_id`) VALUES
(1, 1, 1),
(2, 3, 2),
(3, 7, 3),
(4, 8, 1),
(5, 9, 2);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `stock_quantity`, `category_id`, `created_at`) VALUES
(1, 'Roshogolla', 'Soft round sweets made from chhena and syrup', 10.00, 500, 1, '2024-12-10 05:12:21'),
(2, 'Sandesh', 'Sweet made from milk and sugar', 12.00, 400, 1, '2024-12-10 05:12:21'),
(3, 'Chocolate Barfi', 'Chocolate-flavored barfi', 15.00, 200, 2, '2024-12-10 05:12:21'),
(4, 'Chomchom', 'Caramel-coated cylindrical sweets', 20.00, 300, 3, '2024-12-10 05:12:21'),
(5, 'Kheer', 'Sweet milk pudding', 25.00, 150, 3, '2024-12-10 05:12:21'),
(6, 'Laddoo', 'Round sweet balls made from flour and sugar', 8.00, 600, 4, '2024-12-10 05:12:21'),
(7, 'Jilapi', 'Crispy and syrupy spiral sweets', 5.00, 1000, 5, '2024-12-10 05:12:21'),
(8, 'Roshmalai', 'Soft balls soaked in sweetened milk', 18.00, 250, 5, '2024-12-10 05:12:21'),
(9, 'Barfi', 'Sweet confectionery made with condensed milk', 15.00, 350, 4, '2024-12-10 05:12:21'),
(10, 'Kalo Jam', 'Syrup-coated sweet, darker than roshogolla', 12.00, 400, 1, '2024-12-10 05:12:21'),
(11, 'Chocolate Sandesh', 'Sandesh with chocolate flavor', 18.00, 200, 2, '2024-12-10 05:12:21'),
(12, 'Pera Sandesh', 'Dry milk-based sweet', 15.00, 300, 1, '2024-12-10 05:12:21'),
(13, 'Malai Chop', 'Sweets soaked in creamy milk', 22.00, 150, 3, '2024-12-10 05:12:21'),
(14, 'Dry Fruits Laddoo', 'Laddoo enriched with dry fruits', 20.00, 250, 4, '2024-12-10 05:12:21'),
(15, 'Milk Cake', 'Sweetened condensed milk cake', 30.00, 100, 3, '2024-12-10 05:12:21');

-- --------------------------------------------------------

--
-- Stand-in structure for view `productstockstatus`
-- (See below for the actual view)
--
CREATE TABLE `productstockstatus` (
`product_id` int(11)
,`product_name` varchar(100)
,`stock_quantity` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `recentorders`
-- (See below for the actual view)
--
CREATE TABLE `recentorders` (
`order_id` int(11)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`total_price` decimal(10,2)
,`order_date` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `user_id`, `product_id`, `rating`, `comment`, `created_at`) VALUES
(1, 1, 1, 5, 'Delicious! Highly recommended.', '2024-12-10 05:16:17'),
(2, 2, 3, 4, 'Good, but a bit overpriced.', '2024-12-10 05:16:17'),
(3, 3, 5, 5, 'Best I’ve ever tasted!', '2024-12-10 05:16:17'),
(4, 4, 7, 3, 'Average taste, not as expected.', '2024-12-10 05:16:17'),
(5, 5, 9, 4, 'Loved the flavor!', '2024-12-10 05:16:17'),
(6, 6, 2, 5, 'Perfect for any occasion.', '2024-12-10 05:16:17'),
(7, 7, 4, 3, 'Too sweet for my liking.', '2024-12-10 05:16:17'),
(8, 8, 6, 4, 'Nice texture and taste.', '2024-12-10 05:16:17'),
(9, 9, 8, 5, 'A must-try dessert!', '2024-12-10 05:16:17'),
(10, 10, 10, 3, 'Decent quality.', '2024-12-10 05:16:17'),
(11, 11, 12, 4, 'Very satisfying.', '2024-12-10 05:16:17'),
(12, 12, 14, 5, 'Excellent product!', '2024-12-10 05:16:17'),
(13, 13, 15, 4, 'Good, but stock often runs out.', '2024-12-10 05:16:17'),
(14, 14, 13, 5, 'Amazing flavor and texture.', '2024-12-10 05:16:17'),
(15, 15, 11, 4, 'Quite good overall.', '2024-12-10 05:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `shipping`
--

CREATE TABLE `shipping` (
  `shipping_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `shipping_date` timestamp NULL DEFAULT NULL,
  `delivery_date` timestamp NULL DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shipping`
--

INSERT INTO `shipping` (`shipping_id`, `order_id`, `shipping_address`, `shipping_date`, `delivery_date`, `tracking_number`) VALUES
(1, 1, 'Dhaka, Bangladesh', '2024-12-01 18:00:00', '2024-12-03 18:00:00', 'TRACK12345'),
(2, 2, 'Chattogram, Bangladesh', '2024-12-02 18:00:00', '2024-12-05 18:00:00', 'TRACK12346'),
(3, 3, 'Sylhet, Bangladesh', '2024-12-03 18:00:00', '2024-12-07 18:00:00', 'TRACK12347'),
(4, 4, 'Rajshahi, Bangladesh', '2024-12-04 18:00:00', '2024-12-09 18:00:00', 'TRACK12348'),
(5, 5, 'Khulna, Bangladesh', '2024-12-05 18:00:00', NULL, 'TRACK12349'),
(6, 6, 'Barishal, Bangladesh', '2024-12-06 18:00:00', '2024-12-10 18:00:00', 'TRACK12350'),
(7, 7, 'Rangpur, Bangladesh', '2024-12-07 18:00:00', '2024-12-11 18:00:00', 'TRACK12351'),
(8, 8, 'Mymensingh, Bangladesh', '2024-12-08 18:00:00', NULL, 'TRACK12352'),
(9, 9, 'Gazipur, Bangladesh', '2024-12-09 18:00:00', '2024-12-14 18:00:00', 'TRACK12353');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `subscription_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `subscription_type` enum('Free','Basic','Premium') DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('Active','Expired','Cancelled') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supporttickets`
--

CREATE TABLE `supporttickets` (
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` enum('Open','In Progress','Resolved','Closed') DEFAULT 'Open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supporttickets`
--

INSERT INTO `supporttickets` (`ticket_id`, `user_id`, `subject`, `message`, `status`, `created_at`) VALUES
(1, 1, 'Order Issue', 'I did not receive my order.', 'Open', '2024-12-10 05:26:57'),
(2, 2, 'Discount Inquiry', 'How to use discount codes?', 'Resolved', '2024-12-10 05:26:57'),
(3, 3, 'Shipping Delay', 'My delivery is delayed.', 'In Progress', '2024-12-10 05:26:57');

-- --------------------------------------------------------

--
-- Stand-in structure for view `topsellingproducts`
-- (See below for the actual view)
--
CREATE TABLE `topsellingproducts` (
`product_id` int(11)
,`product_name` varchar(100)
,`total_sold` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `address`, `created_at`) VALUES
(1, 'Rahim', 'Ahmed', 'rahim.ahmed@example.com', 'hashed_pw1', '01711111111', 'Dhaka', '2024-12-10 05:10:29'),
(2, 'Karim', 'Hossain', 'karim.hossain@example.com', 'hashed_pw2', '01722222222', 'Chattogram', '2024-12-10 05:10:29'),
(3, 'Sumon', 'Islam', 'sumon.islam@example.com', 'hashed_pw3', '01733333333', 'Sylhet', '2024-12-10 05:10:29'),
(4, 'Rita', 'Sultana', 'rita.sultana@example.com', 'hashed_pw4', '01744444444', 'Rajshahi', '2024-12-10 05:10:29'),
(5, 'Mita', 'Akter', 'mita.akter@example.com', 'hashed_pw5', '01755555555', 'Khulna', '2024-12-10 05:10:29'),
(6, 'Jalal', 'Uddin', 'jalal.uddin@example.com', 'hashed_pw6', '01766666666', 'Barishal', '2024-12-10 05:10:29'),
(7, 'Tina', 'Begum', 'tina.begum@example.com', 'hashed_pw7', '01777777777', 'Rangpur', '2024-12-10 05:10:29'),
(8, 'Mamun', 'Chowdhury', 'mamun.chowdhury@example.com', 'hashed_pw8', '01788888888', 'Mymensingh', '2024-12-10 05:10:29'),
(9, 'Nadia', 'Shikder', 'nadia.shikder@example.com', 'hashed_pw9', '01799999999', 'Gazipur', '2024-12-10 05:10:29'),
(10, 'Rashed', 'Hasan', 'rashed.hasan@example.com', 'hashed_pw10', '01811111111', 'Cumilla', '2024-12-10 05:10:29'),
(11, 'Sadia', 'Pervin', 'sadia.pervin@example.com', 'hashed_pw11', '01822222222', 'Narayanganj', '2024-12-10 05:10:29'),
(12, 'Fahim', 'Rahman', 'fahim.rahman@example.com', 'hashed_pw12', '01833333333', 'Jashore', '2024-12-10 05:10:29'),
(13, 'Rumi', 'Jahan', 'rumi.jahan@example.com', 'hashed_pw13', '01844444444', 'Faridpur', '2024-12-10 05:10:29'),
(14, 'Imran', 'Sikder', 'imran.sikder@example.com', 'hashed_pw14', '01855555555', 'Noakhali', '2024-12-10 05:10:29'),
(15, 'Bithi', 'Khan', 'bithi.khan@example.com', 'hashed_pw15', '01866666666', 'Dinajpur', '2024-12-10 05:10:29');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `LogUserRegistration` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    INSERT INTO ActivityLogs (user_id, action, timestamp)
    VALUES (NEW.user_id, 'User registered.', NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `vendorproducts`
--

CREATE TABLE `vendorproducts` (
  `vendor_product_id` int(11) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `stock_quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendorproducts`
--

INSERT INTO `vendorproducts` (`vendor_product_id`, `vendor_id`, `product_id`, `stock_quantity`, `price`) VALUES
(1, 1, 1, 300, 9.00),
(2, 1, 2, 200, 11.00),
(3, 2, 3, 150, 13.00),
(4, 2, 4, 100, 18.00),
(5, 3, 5, 80, 22.00);

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `vendor_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`vendor_id`, `name`, `email`, `phone_number`, `address`, `created_at`) VALUES
(1, 'Vendor1', 'vendor1@example.com', '01811111111', 'Dhaka, Bangladesh', '2024-12-10 05:27:21'),
(2, 'Vendor2', 'vendor2@example.com', '01822222222', 'Chattogram, Bangladesh', '2024-12-10 05:27:21'),
(3, 'Vendor3', 'vendor3@example.com', '01833333333', 'Sylhet, Bangladesh', '2024-12-10 05:27:21');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `wishlist_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`wishlist_id`, `user_id`, `product_id`, `created_at`) VALUES
(1, 1, 1, '2024-12-10 05:15:50'),
(2, 2, 3, '2024-12-10 05:15:50'),
(3, 3, 5, '2024-12-10 05:15:50'),
(4, 4, 7, '2024-12-10 05:15:50'),
(5, 5, 9, '2024-12-10 05:15:50'),
(6, 6, 2, '2024-12-10 05:15:50'),
(7, 7, 4, '2024-12-10 05:15:50'),
(8, 8, 6, '2024-12-10 05:15:50'),
(9, 9, 8, '2024-12-10 05:15:50'),
(10, 10, 10, '2024-12-10 05:15:50'),
(11, 11, 12, '2024-12-10 05:15:50'),
(12, 12, 14, '2024-12-10 05:15:50'),
(13, 13, 15, '2024-12-10 05:15:50'),
(14, 14, 13, '2024-12-10 05:15:50'),
(15, 15, 11, '2024-12-10 05:15:50');

-- --------------------------------------------------------

--
-- Structure for view `activeusers`
--
DROP TABLE IF EXISTS `activeusers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `activeusers`  AS SELECT `users`.`user_id` AS `user_id`, `users`.`first_name` AS `first_name`, `users`.`last_name` AS `last_name`, `users`.`email` AS `email`, `users`.`created_at` AS `created_at` FROM `users` WHERE `users`.`created_at` >= curdate() - interval 1 year ;

-- --------------------------------------------------------

--
-- Structure for view `pendingsupporttickets`
--
DROP TABLE IF EXISTS `pendingsupporttickets`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pendingsupporttickets`  AS SELECT `st`.`ticket_id` AS `ticket_id`, `u`.`first_name` AS `first_name`, `u`.`last_name` AS `last_name`, `st`.`subject` AS `subject`, `st`.`created_at` AS `created_at` FROM (`supporttickets` `st` join `users` `u` on(`st`.`user_id` = `u`.`user_id`)) WHERE `st`.`status` = 'Open' ;

-- --------------------------------------------------------

--
-- Structure for view `productstockstatus`
--
DROP TABLE IF EXISTS `productstockstatus`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `productstockstatus`  AS SELECT `p`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, `i`.`quantity` AS `stock_quantity` FROM (`products` `p` join `inventory` `i` on(`p`.`product_id` = `i`.`product_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `recentorders`
--
DROP TABLE IF EXISTS `recentorders`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `recentorders`  AS SELECT `o`.`order_id` AS `order_id`, `u`.`first_name` AS `first_name`, `u`.`last_name` AS `last_name`, `o`.`total_price` AS `total_price`, `o`.`order_date` AS `order_date` FROM (`orders` `o` join `users` `u` on(`o`.`user_id` = `u`.`user_id`)) ORDER BY `o`.`order_date` DESC LIMIT 0, 10 ;

-- --------------------------------------------------------

--
-- Structure for view `topsellingproducts`
--
DROP TABLE IF EXISTS `topsellingproducts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `topsellingproducts`  AS SELECT `p`.`product_id` AS `product_id`, `p`.`product_name` AS `product_name`, sum(`od`.`quantity`) AS `total_sold` FROM (`products` `p` join `orderdetails` `od` on(`p`.`product_id` = `od`.`product_id`)) GROUP BY `p`.`product_id`, `p`.`product_name` ORDER BY sum(`od`.`quantity`) DESC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activitylogs`
--
ALTER TABLE `activitylogs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`discount_id`),
  ADD UNIQUE KEY `discount_code` (`discount_code`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `productdiscounts`
--
ALTER TABLE `productdiscounts`
  ADD PRIMARY KEY (`product_discount_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `discount_id` (`discount_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `shipping`
--
ALTER TABLE `shipping`
  ADD PRIMARY KEY (`shipping_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`subscription_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `supporttickets`
--
ALTER TABLE `supporttickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `vendorproducts`
--
ALTER TABLE `vendorproducts`
  ADD PRIMARY KEY (`vendor_product_id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`vendor_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`wishlist_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activitylogs`
--
ALTER TABLE `activitylogs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `discount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `productdiscounts`
--
ALTER TABLE `productdiscounts`
  MODIFY `product_discount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `shipping`
--
ALTER TABLE `shipping`
  MODIFY `shipping_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `subscription_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supporttickets`
--
ALTER TABLE `supporttickets`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `vendorproducts`
--
ALTER TABLE `vendorproducts`
  MODIFY `vendor_product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `vendor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `wishlist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activitylogs`
--
ALTER TABLE `activitylogs`
  ADD CONSTRAINT `activitylogs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `productdiscounts`
--
ALTER TABLE `productdiscounts`
  ADD CONSTRAINT `productdiscounts_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `productdiscounts_ibfk_2` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`discount_id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `shipping`
--
ALTER TABLE `shipping`
  ADD CONSTRAINT `shipping_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `supporttickets`
--
ALTER TABLE `supporttickets`
  ADD CONSTRAINT `supporttickets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `vendorproducts`
--
ALTER TABLE `vendorproducts`
  ADD CONSTRAINT `vendorproducts_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendorproducts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
