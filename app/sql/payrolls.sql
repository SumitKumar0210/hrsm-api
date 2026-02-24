-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 24, 2026 at 12:22 PM
-- Server version: 8.4.7
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hrms`
--

-- --------------------------------------------------------

--
-- Table structure for table `payrolls`
--

DROP TABLE IF EXISTS `payrolls`;
CREATE TABLE IF NOT EXISTS `payrolls` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` bigint UNSIGNED NOT NULL,
  `status` enum('generated','processed','paid') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'generated',
  `month` varchar(10) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `year` varchar(10) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `present_days` int DEFAULT NULL,
  `paid_leaves` int DEFAULT NULL,
  `gross_salary` decimal(20,2) DEFAULT NULL,
  `deductions` decimal(20,2) DEFAULT NULL,
  `net_salary` decimal(20,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payrolls_employee_id_month_unique` (`employee_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `payrolls`
--

INSERT INTO `payrolls` (`id`, `employee_id`, `status`, `month`, `year`, `present_days`, `paid_leaves`, `gross_salary`, `deductions`, `net_salary`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 'generated', '1', '2026', 27, 0, 25000.00, 0.00, 35000.00, '2026-02-19 07:10:19', '2026-02-24 09:55:07', NULL),
(2, 3, 'generated', '1', '2026', 27, 0, 12000.00, 0.00, 12399.00, '2026-02-19 07:10:19', '2026-02-24 09:55:07', NULL),
(3, 4, 'generated', '1', '2026', 27, 0, 15000.00, 0.00, 15500.00, '2026-02-19 07:10:19', '2026-02-24 09:55:07', NULL),
(4, 5, 'generated', '1', '2026', 27, 0, 17000.00, 0.00, 21100.00, '2026-02-19 07:10:19', '2026-02-24 09:55:07', NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
