-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jan 30, 2022 at 12:12 PM
-- Server version: 8.0.22
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aichat`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gender` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `date_of_birth` date NOT NULL,
  `contact_number` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `first_name`, `last_name`, `gender`, `date_of_birth`, `contact_number`, `email`, `created_at`, `updated_at`) VALUES
(1, 'Jane ', 'Doe', 'Female', '1980-07-01', '+6524564444', 'janedoe@gmail.com', '2022-01-30 08:06:52', '2022-01-30 08:06:52'),
(2, 'Riki', 'S', 'Male', '1974-08-04', '+628656555665', 'rikis@gmail.com', '2022-01-30 08:06:52', '2022-01-30 08:06:52');

-- --------------------------------------------------------

--
-- Table structure for table `customers_uploaded_photo`
--

CREATE TABLE `customers_uploaded_photo` (
  `id_upload` int NOT NULL,
  `customers_id` int NOT NULL,
  `file_photo` varchar(1000) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_transaction`
--

CREATE TABLE `purchase_transaction` (
  `id` int NOT NULL,
  `customer_id` int NOT NULL,
  `total_spent` double NOT NULL,
  `total_saving` double(10,2) NOT NULL,
  `transaction_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `purchase_transaction`
--

INSERT INTO `purchase_transaction` (`id`, `customer_id`, `total_spent`, `total_saving`, `transaction_at`) VALUES
(1, 1, 30, 0.00, '2022-01-24 08:19:07'),
(2, 1, 40, 0.00, '2022-01-25 06:19:07'),
(3, 1, 60, 0.00, '2022-01-26 08:21:43'),
(4, 2, 70, 0.00, '2022-01-30 08:22:39'),
(5, 2, 30, 0.00, '2022-01-30 09:47:40'),
(6, 2, 80, 0.00, '2022-01-30 09:48:10');

-- --------------------------------------------------------

--
-- Table structure for table `token_api`
--

CREATE TABLE `token_api` (
  `id_token` int NOT NULL,
  `token` varchar(1000) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `token_api`
--

INSERT INTO `token_api` (`id_token`, `token`) VALUES
(1, 'xxxyyyzzz');

-- --------------------------------------------------------

--
-- Table structure for table `voucher`
--

CREATE TABLE `voucher` (
  `id_voucher` int NOT NULL,
  `voucher_code` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `get_by_customer_id` int DEFAULT NULL,
  `is_locked` int NOT NULL DEFAULT '0',
  `is_locked_timestamp` timestamp NULL DEFAULT NULL,
  `is_redeem` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `voucher`
--

INSERT INTO `voucher` (`id_voucher`, `voucher_code`, `get_by_customer_id`, `is_locked`, `is_locked_timestamp`, `is_redeem`, `created_at`, `updated_at`) VALUES
(1, '345qwertyu', 2, 1, '2022-01-30 11:45:37', 1, NULL, '2022-01-30 11:50:27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers_uploaded_photo`
--
ALTER TABLE `customers_uploaded_photo`
  ADD PRIMARY KEY (`id_upload`);

--
-- Indexes for table `purchase_transaction`
--
ALTER TABLE `purchase_transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `token_api`
--
ALTER TABLE `token_api`
  ADD PRIMARY KEY (`id_token`);

--
-- Indexes for table `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`id_voucher`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customers_uploaded_photo`
--
ALTER TABLE `customers_uploaded_photo`
  MODIFY `id_upload` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_transaction`
--
ALTER TABLE `purchase_transaction`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `token_api`
--
ALTER TABLE `token_api`
  MODIFY `id_token` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `voucher`
--
ALTER TABLE `voucher`
  MODIFY `id_voucher` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
