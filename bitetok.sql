-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 22, 2025 at 11:52 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bitetok`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reel_id` int(11) NOT NULL,
  `dish_name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`id`, `user_id`, `reel_id`, `dish_name`, `price`, `created_at`) VALUES
(9, 1, 3, 'burger', 20.00, '2025-07-22 19:50:07'),
(10, 1, 3, 'burger', 20.00, '2025-07-22 20:01:10'),
(11, 1, 3, 'burger', 20.00, '2025-07-22 20:01:20'),
(12, 1, 1, 'salad', 10.00, '2025-07-22 20:03:52'),
(13, 1, 3, 'burger', 20.00, '2025-07-22 20:05:22'),
(14, 1, 3, 'burger', 20.00, '2025-07-22 20:06:52'),
(15, 1, 1, 'salad', 10.00, '2025-07-22 20:08:03'),
(16, 1, 3, 'burger', 20.00, '2025-07-22 20:18:57'),
(17, 1, 3, 'burger', 20.00, '2025-07-22 20:24:52'),
(21, 2, 5, 'taco', 5.00, '2025-07-22 21:08:11');

-- --------------------------------------------------------

--
-- Table structure for table `reels`
--

CREATE TABLE `reels` (
  `id` int(11) NOT NULL,
  `dish_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `media_type` varchar(50) NOT NULL,
  `media_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reels`
--

INSERT INTO `reels` (`id`, `dish_name`, `description`, `price`, `location`, `created_by`, `created_at`, `media_type`, `media_url`) VALUES
(1, 'salad', 'salad', 10.00, 'batc', NULL, '2025-07-22 13:12:51', 'image', '1753189971_salad.jpeg'),
(3, 'burger', 'burger', 20.00, 'nak nak', NULL, '2025-07-22 19:46:44', 'video', '1753213604_burger2.mp4'),
(4, 'burger beff', 'beef becan burger', 25.00, 'naknak', NULL, '2025-07-22 20:42:34', 'video', '1753216954_burger2.mp4'),
(5, 'taco', 'beef taco', 5.00, 'taco bell', NULL, '2025-07-22 21:07:58', 'image', '1753218478_taco pic.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`) VALUES
(1, 'muntasir', 'masood@gmail.com', '$2y$10$.JAf/ympSoR9DrljP8iIqunhdvDOZmyrYXLk1D2x9b..t2xIIQujq', '2025-07-21 10:02:15'),
(2, 'masood', 'mun@gmail.com', '$2y$10$GH9KrpMWN.Ej7zlgGDjWfOY55GnTqMUR4WURkazioUXR1rIHLmqnG', '2025-07-22 20:35:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reel_id` (`reel_id`);

--
-- Indexes for table `reels`
--
ALTER TABLE `reels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `reels`
--
ALTER TABLE `reels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`reel_id`) REFERENCES `reels` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_reel_id` FOREIGN KEY (`reel_id`) REFERENCES `reels` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
