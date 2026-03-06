-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 06, 2026 at 12:09 PM
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
-- Table structure for table `attendances`
--

DROP TABLE IF EXISTS `attendances`;
CREATE TABLE IF NOT EXISTS `attendances` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `sign_in` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `sign_out` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `total_hours` decimal(5,2) DEFAULT NULL,
  `status` enum('absent','casual_leave','compensatory_off','earned_leave','half_day','leave_without_pay','maternity_leave','paternity_leave','present','public_holiday','sick_leave') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'present' COMMENT '''absent'',''casual_leave'',''compensatory_off'',''earned_leave'',''half_day'',''leave_without_pay'',''maternity_leave'',''paternity_leave'',''present'',''public_holiday'',''sick_leave''',
  `is_corrected` enum('yes','no') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no' COMMENT 'manual correction applied or not',
  `reason` text COLLATE utf8mb3_unicode_ci,
  `action_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attendance_employee_id_date_unique` (`employee_id`,`date`)
) ENGINE=MyISAM AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `attendances`
--

INSERT INTO `attendances` (`id`, `employee_id`, `date`, `sign_in`, `sign_out`, `total_hours`, `status`, `is_corrected`, `reason`, `action_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 5, '2026-01-01', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(2, 4, '2026-01-01', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(3, 3, '2026-01-01', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(4, 2, '2026-01-01', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(5, 5, '2026-01-02', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(6, 4, '2026-01-02', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(7, 3, '2026-01-02', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(8, 2, '2026-01-02', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-24 09:47:30', NULL),
(9, 5, '2026-01-03', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(10, 4, '2026-01-03', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-24 09:52:54', NULL),
(11, 3, '2026-01-03', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(12, 2, '2026-01-03', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-24 09:14:03', NULL),
(13, 5, '2026-01-04', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(14, 4, '2026-01-04', NULL, NULL, 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-24 09:54:59', NULL),
(15, 3, '2026-01-04', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(16, 2, '2026-01-04', NULL, NULL, 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-27 07:11:24', NULL),
(17, 5, '2026-01-05', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(18, 4, '2026-01-05', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(19, 3, '2026-01-05', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(20, 2, '2026-01-05', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(21, 5, '2026-01-06', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(22, 4, '2026-01-06', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(23, 3, '2026-01-06', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(24, 2, '2026-01-06', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-24 09:47:42', NULL),
(25, 5, '2026-01-07', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(26, 4, '2026-01-07', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(27, 3, '2026-01-07', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(28, 2, '2026-01-07', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(29, 5, '2026-01-08', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(30, 4, '2026-01-08', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(31, 3, '2026-01-08', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(32, 2, '2026-01-08', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(33, 5, '2026-01-09', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(34, 4, '2026-01-09', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(35, 3, '2026-01-09', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(36, 2, '2026-01-09', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(37, 5, '2026-01-10', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(38, 4, '2026-01-10', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(39, 3, '2026-01-10', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(40, 2, '2026-01-10', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(41, 5, '2026-01-11', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(42, 4, '2026-01-11', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(43, 3, '2026-01-11', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(44, 2, '2026-01-11', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(45, 5, '2026-01-12', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(46, 4, '2026-01-12', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(47, 3, '2026-01-12', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(48, 2, '2026-01-12', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(49, 5, '2026-01-13', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(50, 4, '2026-01-13', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(51, 3, '2026-01-13', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(52, 2, '2026-01-13', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(53, 5, '2026-01-14', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(54, 4, '2026-01-14', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(55, 3, '2026-01-14', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(56, 2, '2026-01-14', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(57, 5, '2026-01-15', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(58, 4, '2026-01-15', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(59, 3, '2026-01-15', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(60, 2, '2026-01-15', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(61, 5, '2026-01-16', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(62, 4, '2026-01-16', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(63, 3, '2026-01-16', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(64, 2, '2026-01-16', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(65, 5, '2026-01-17', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(66, 4, '2026-01-17', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(67, 3, '2026-01-17', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(68, 2, '2026-01-17', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(69, 5, '2026-01-18', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(70, 4, '2026-01-18', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(71, 3, '2026-01-18', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(72, 2, '2026-01-18', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(73, 5, '2026-01-19', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(74, 4, '2026-01-19', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(75, 3, '2026-01-19', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(76, 2, '2026-01-19', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(77, 5, '2026-01-20', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(78, 4, '2026-01-20', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(79, 3, '2026-01-20', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(80, 2, '2026-01-20', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(81, 5, '2026-01-21', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(82, 4, '2026-01-21', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(83, 3, '2026-01-21', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(84, 2, '2026-01-21', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(85, 5, '2026-01-22', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(86, 4, '2026-01-22', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(87, 3, '2026-01-22', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(88, 2, '2026-01-22', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(89, 5, '2026-01-23', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(90, 4, '2026-01-23', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(91, 3, '2026-01-23', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(92, 2, '2026-01-23', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(93, 5, '2026-01-24', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(94, 4, '2026-01-24', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(95, 3, '2026-01-24', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(96, 2, '2026-01-24', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(97, 5, '2026-01-25', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(98, 4, '2026-01-25', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(99, 3, '2026-01-25', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(100, 2, '2026-01-25', '', '', 0.00, 'absent', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(101, 5, '2026-01-26', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(102, 4, '2026-01-26', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(103, 3, '2026-01-26', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(104, 2, '2026-01-26', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(105, 5, '2026-01-27', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(106, 4, '2026-01-27', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(107, 3, '2026-01-27', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(108, 2, '2026-01-27', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(109, 5, '2026-01-28', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(110, 4, '2026-01-28', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(111, 3, '2026-01-28', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(112, 2, '2026-01-28', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(113, 5, '2026-01-29', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(114, 4, '2026-01-29', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(115, 3, '2026-01-29', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(116, 2, '2026-01-29', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(117, 5, '2026-01-30', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(118, 4, '2026-01-30', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(119, 3, '2026-01-30', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(120, 2, '2026-01-30', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(121, 5, '2026-01-31', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(122, 4, '2026-01-31', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(123, 3, '2026-01-31', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(124, 2, '2026-01-31', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-18 11:17:47', '2026-02-18 11:17:47', NULL),
(145, 5, '2026-02-18', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-19 09:37:28', '2026-02-19 09:37:28', NULL),
(146, 4, '2026-02-18', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-19 09:37:28', '2026-02-19 09:37:28', NULL),
(147, 3, '2026-02-18', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-19 09:37:28', '2026-02-19 09:37:28', NULL),
(148, 2, '2026-02-18', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-19 09:37:28', '2026-02-19 09:37:28', NULL),
(149, 5, '2026-02-24', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-24 12:12:37', '2026-02-24 12:13:30', NULL),
(150, 4, '2026-02-24', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-24 12:12:37', '2026-02-24 12:13:30', NULL),
(151, 3, '2026-02-24', '10:00:00', '18:00:00', 8.00, 'present', 'no', NULL, NULL, '2026-02-24 12:12:37', '2026-02-24 12:13:30', NULL),
(152, 2, '2026-02-24', '10:00:00', '14:00:00', 4.00, 'half_day', 'yes', '.', 1, '2026-02-24 12:12:37', '2026-02-24 12:15:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('hrms-cache-dveDDmufTpRAGDsd', 'a:1:{s:11:\"valid_until\";i:1770292244;}', 1801828304),
('hrms-cache-7p5WEvkvyhgehCog', 'a:1:{s:11:\"valid_until\";i:1770292696;}', 1801828696),
('hrms-cache-IGISjG9eu3Lg2cEf', 'a:1:{s:11:\"valid_until\";i:1770292742;}', 1801828802);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'IT', 'active', '2026-02-04 03:51:55', '2026-02-10 06:40:38', NULL),
(2, 'Department', 'active', '2026-02-04 04:07:34', '2026-02-10 06:31:50', NULL),
(3, 'Admin', 'active', '2026-02-10 06:42:32', '2026-02-10 06:42:32', NULL),
(4, 'Sumit Kumar', 'active', '2026-02-10 06:42:43', '2026-02-10 06:42:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `designations`
--

DROP TABLE IF EXISTS `designations`;
CREATE TABLE IF NOT EXISTS `designations` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `designations`
--

INSERT INTO `designations` (`id`, `name`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Manager', 'active', '2026-02-04 03:51:55', '2026-02-10 06:40:38', NULL),
(2, 'Staff', 'active', '2026-02-04 04:07:34', '2026-02-11 05:48:24', NULL),
(3, 'Supervisor', 'active', '2026-02-10 06:42:32', '2026-02-11 05:47:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` bigint UNSIGNED NOT NULL,
  `document_type` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `file_path` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `documents_employee_id_document_type_unique` (`employee_id`,`document_type`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `employee_id`, `document_type`, `file_path`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 'id_proof', 'employees/2/idProof_1771233351_113LmYtA.png', '2026-02-16 09:15:51', '2026-02-16 09:15:51', NULL),
(2, 2, 'address_proof', 'employees/2/addressProof_1771233351_TBnA0ADe.png', '2026-02-16 09:15:51', '2026-02-16 09:15:51', NULL),
(3, 2, 'bank_details', 'employees/2/bankDetails_1771233351_H3nXWRBm.png', '2026-02-16 09:15:51', '2026-02-16 09:15:51', NULL),
(4, 2, 'contract_letter', 'employees/2/contractLetter_1771233351_OcBmMS7F.png', '2026-02-16 09:15:51', '2026-02-16 09:15:51', NULL),
(5, 2, 'profile_image', 'employees/2/profileImage_1771233351_sB4Ztp14.png', '2026-02-16 09:15:51', '2026-02-16 09:15:51', NULL),
(6, 3, 'id_proof', 'employees/3/idProof_1771234085_yAztXb04.png', '2026-02-16 09:28:05', '2026-02-16 09:28:05', NULL),
(7, 3, 'address_proof', 'employees/3/addressProof_1771234085_fjvZFdsA.png', '2026-02-16 09:28:05', '2026-02-16 09:28:05', NULL),
(8, 3, 'bank_details', 'employees/3/bankDetails_1771234085_OdLRdc58.png', '2026-02-16 09:28:05', '2026-02-16 09:28:05', NULL),
(9, 3, 'contract_letter', 'employees/3/contractLetter_1771234085_XmgtRNt6.png', '2026-02-16 09:28:05', '2026-02-16 09:28:05', NULL),
(10, 3, 'profile_image', 'employees/3/profileImage_1771234085_N0504aeb.JPG', '2026-02-16 09:28:05', '2026-02-16 09:28:05', NULL),
(11, 4, 'id_proof', 'employees/4/idProof_1771234988_IFeusMoI.png', '2026-02-16 09:43:08', '2026-02-24 10:53:23', '2026-02-24 10:53:23'),
(12, 4, 'address_proof', 'employees/4/addressProof_1771234988_h4uqkZbI.png', '2026-02-16 09:43:08', '2026-02-24 10:53:23', '2026-02-24 10:53:23'),
(13, 4, 'bank_details', 'employees/4/bankDetails_1771234988_9URDeCHZ.png', '2026-02-16 09:43:08', '2026-02-24 10:53:23', '2026-02-24 10:53:23'),
(14, 4, 'contract_letter', 'employees/4/contractLetter_1771234988_17DXyXVN.png', '2026-02-16 09:43:08', '2026-02-24 10:53:23', '2026-02-24 10:53:23'),
(15, 4, 'profile_image', 'employees/4/profileImage_1771234988_yu6xUw4z.png', '2026-02-16 09:43:08', '2026-02-24 10:53:23', '2026-02-24 10:53:23'),
(16, 5, 'id_proof', 'employees/5/idProof_1771235199_qWyWrVsz.png', '2026-02-16 09:46:39', '2026-02-16 09:46:39', NULL),
(17, 5, 'address_proof', 'employees/5/addressProof_1771235199_igcXOXcB.png', '2026-02-16 09:46:39', '2026-02-16 09:46:39', NULL),
(18, 5, 'bank_details', 'employees/5/bankDetails_1771235199_iE1TU7a5.png', '2026-02-16 09:46:39', '2026-02-16 09:46:39', NULL),
(19, 5, 'contract_letter', 'employees/5/contractLetter_1771235199_PiwFpvuK.png', '2026-02-16 09:46:39', '2026-02-16 09:46:39', NULL),
(20, 5, 'profile_image', 'employees/5/profileImage_1771235199_3W7DVlPW.JPG', '2026-02-16 09:46:39', '2026-02-16 09:46:39', NULL),
(21, 6, 'id_proof', 'employees/6/idProof_1772773888_k5nkBaqj.pdf', '2026-03-06 05:11:30', '2026-03-06 05:11:30', NULL),
(22, 6, 'address_proof', 'employees/6/addressProof_1772773890_vT8otjLU.pdf', '2026-03-06 05:11:30', '2026-03-06 05:11:30', NULL),
(23, 6, 'bank_details', 'employees/6/bankDetails_1772773890_WrOmD3Ft.pdf', '2026-03-06 05:11:30', '2026-03-06 05:11:30', NULL),
(24, 6, 'contract_letter', 'employees/6/contractLetter_1772773890_3vcO8kYk.pdf', '2026-03-06 05:11:30', '2026-03-06 05:11:30', NULL),
(25, 6, 'profile_image', 'employees/6/profileImage_1772773890_KOy7eIZl.png', '2026-03-06 05:11:30', '2026-03-06 05:11:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_code` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `blood_group` varchar(10) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `aadhar_number` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mobile` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `department_id` bigint UNSIGNED DEFAULT NULL,
  `shift_id` bigint UNSIGNED DEFAULT NULL,
  `date_of_joining` date DEFAULT NULL,
  `employment_type` tinyint NOT NULL DEFAULT '1' COMMENT '1=Full Time, 2=Part Time, 3=Contract',
  `designation_id` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive','terminated') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
  `week_off` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb3_unicode_ci,
  `zip_code` int DEFAULT NULL,
  `city` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `state` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `source` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employees_employee_code_unique` (`employee_code`),
  UNIQUE KEY `employees_mobile_unique` (`mobile`),
  UNIQUE KEY `employees_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `employee_code`, `first_name`, `last_name`, `blood_group`, `aadhar_number`, `mobile`, `email`, `department_id`, `shift_id`, `date_of_joining`, `employment_type`, `designation_id`, `status`, `week_off`, `address`, `zip_code`, `city`, `state`, `source`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'EMP2600001', 'Aman', 'Kumar', 'A-', '985647123025', '9135913699', 'aman@gmail.com', 1, 4, '2026-02-16', 1, '1', 'active', '0', 'Patna Bihar 8015030', 800001, 'patna', 'Bihar', NULL, '2026-02-16 09:15:51', '2026-02-24 10:36:43', NULL),
(3, 'EMP2600002', 'Rima', 'Kumari', 'A+', '985632147521', '9834567890', 'rima@gmail.com', 1, 1, '2026-02-16', 1, '1', 'active', '0', NULL, NULL, NULL, NULL, NULL, '2026-02-16 09:28:05', '2026-02-16 09:28:05', NULL),
(4, 'EMP2600003', 'Ramesh', 'Roy', 'O+', '985632147521', '9843234342', 'ramesh@gmail.com', 1, 2, '2026-02-16', 1, '2', 'active', '0', 'Patna Bihar', NULL, 'patna', 'Bihar', 'online', '2026-02-16 09:43:08', '2026-02-24 10:53:23', NULL),
(5, 'EMP2600004', 'Lala', 'Ram', 'B-', '985632147521', '9134913699', 'lala@gmail.com', 4, 1, NULL, 1, '3', 'active', '0', 'Patna Bihar', 800001, 'Patna', 'Bihar', 'walk-in', '2026-02-16 09:46:39', '2026-02-16 10:04:40', NULL),
(6, 'EMP2600005', 'Amar', 'Naath', 'B+', '362541789012', '9856321047', 'amar@gmail.com', 3, 3, '2026-03-06', 1, '2', 'active', NULL, 'patna bihar 801503', 800001, 'Patna', 'Bihar', 'referral', '2026-03-06 05:11:28', '2026-03-06 05:15:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee_ot_configurations`
--

DROP TABLE IF EXISTS `employee_ot_configurations`;
CREATE TABLE IF NOT EXISTS `employee_ot_configurations` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` bigint UNSIGNED NOT NULL,
  `ot_rate` decimal(8,2) NOT NULL DEFAULT '0.00',
  `min_time` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'minutes',
  `max_time` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'hours',
  `status` enum('active','inactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employee_ot_configurations_employee_id_status_unique` (`employee_id`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `employee_ot_configurations`
--

INSERT INTO `employee_ot_configurations` (`id`, `employee_id`, `ot_rate`, `min_time`, `max_time`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 50.00, 60.00, 4.00, 'inactive', '2026-02-05 01:33:23', '2026-02-05 01:42:32', '2026-02-05 01:42:32'),
(2, 2, 50.00, 60.00, 4.00, 'active', '2026-02-05 01:40:40', '2026-02-17 08:57:58', NULL),
(3, 3, 60.00, 30.00, 4.00, 'active', '2026-02-17 08:52:12', '2026-02-17 08:57:58', NULL),
(4, 4, 50.00, 30.00, 4.00, 'active', '2026-02-17 08:52:42', '2026-02-17 09:09:04', NULL),
(5, 5, 50.00, 30.00, 4.00, 'active', '2026-02-17 09:18:29', '2026-02-25 05:02:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee_salaries`
--

DROP TABLE IF EXISTS `employee_salaries`;
CREATE TABLE IF NOT EXISTS `employee_salaries` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` bigint UNSIGNED NOT NULL,
  `basic_salary` decimal(10,2) NOT NULL,
  `hra` decimal(10,2) NOT NULL DEFAULT '0.00',
  `medical` decimal(10,2) NOT NULL DEFAULT '0.00',
  `conveyance_allowance` decimal(20,2) NOT NULL DEFAULT '0.00',
  `special_allowance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `overtime_rate` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT 'hourly',
  `pf_applicable` tinyint(1) NOT NULL DEFAULT '1',
  `esic_applicable` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('active','inactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
  `uan_number` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `esic_number` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `effective_from` date DEFAULT NULL,
  `previous_salary` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `employee_salaries`
--

INSERT INTO `employee_salaries` (`id`, `employee_id`, `basic_salary`, `hra`, `medical`, `conveyance_allowance`, `special_allowance`, `overtime_rate`, `pf_applicable`, `esic_applicable`, `status`, `uan_number`, `esic_number`, `effective_from`, `previous_salary`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 20000.00, 8000.00, 0.00, 0.00, 2000.00, 200.00, 1, 1, 'inactive', NULL, NULL, NULL, NULL, '2026-02-04 06:26:07', '2026-02-05 00:40:11', NULL),
(5, 1, 25000.00, 8000.00, 0.00, 0.00, 3000.00, 150.00, 1, 1, 'active', '123456789012', 'ESIC987654321', '2025-04-01', '{\"hra\": \"8000.00\", \"pf_amount\": null, \"uan_number\": null, \"esic_amount\": null, \"esic_number\": null, \"basic_salary\": \"20000.00\", \"gross_salary\": null, \"overtime_rate\": \"200.00\", \"pf_applicable\": 1, \"effective_from\": null, \"esic_applicable\": 1, \"medical_allowance\": null, \"special_allowance\": \"2000.00\"}', '2026-02-05 00:40:11', '2026-02-05 00:40:11', NULL),
(6, 5, 17000.00, 2100.00, 0.00, 0.00, 2000.00, 0.00, 1, 0, 'active', NULL, NULL, NULL, 'null', '2026-02-16 10:49:43', '2026-02-16 10:49:43', NULL),
(7, 3, 12000.00, 0.00, 0.00, 0.00, 399.00, 0.00, 0, 1, 'active', NULL, NULL, NULL, 'null', '2026-02-16 11:35:56', '2026-02-16 11:35:56', NULL),
(8, 4, 15000.00, 0.00, 0.00, 0.00, 500.00, 0.00, 1, 1, 'active', NULL, NULL, NULL, 'null', '2026-02-19 04:24:00', '2026-02-19 04:24:00', NULL),
(9, 2, 25000.00, 5000.00, 0.00, 0.00, 0.00, 0.00, 1, 0, 'inactive', NULL, NULL, NULL, 'null', '2026-02-19 04:24:37', '2026-02-19 04:32:18', NULL),
(10, 2, 25000.00, 5000.00, 0.00, 0.00, 2000.00, 0.00, 1, 0, 'inactive', NULL, NULL, NULL, '{\"hra\": \"5000.00\", \"pf_amount\": null, \"uan_number\": null, \"esic_amount\": null, \"esic_number\": null, \"basic_salary\": \"25000.00\", \"gross_salary\": null, \"overtime_rate\": \"0.00\", \"pf_applicable\": 1, \"effective_from\": null, \"esic_applicable\": 0, \"medical_allowance\": null, \"special_allowance\": \"0.00\"}', '2026-02-19 04:32:18', '2026-02-19 04:43:43', NULL),
(11, 2, 25000.00, 5000.00, 0.00, 0.00, 2000.00, 0.00, 1, 0, 'inactive', NULL, NULL, NULL, '{\"hra\": \"5000.00\", \"pf_amount\": null, \"uan_number\": null, \"esic_amount\": null, \"esic_number\": null, \"basic_salary\": \"25000.00\", \"gross_salary\": null, \"overtime_rate\": \"0.00\", \"pf_applicable\": 1, \"effective_from\": null, \"esic_applicable\": 0, \"medical_allowance\": null, \"special_allowance\": \"2000.00\", \"conveyance_allowance\": \"0.00\"}', '2026-02-19 04:43:43', '2026-02-19 04:56:24', NULL),
(12, 2, 25000.00, 5000.00, 3000.00, 1000.00, 2000.00, 0.00, 1, 0, 'inactive', NULL, NULL, NULL, '{\"hra\": \"5000.00\", \"medical\": null, \"pf_amount\": null, \"uan_number\": null, \"esic_amount\": null, \"esic_number\": null, \"basic_salary\": \"25000.00\", \"gross_salary\": null, \"overtime_rate\": \"0.00\", \"pf_applicable\": 1, \"effective_from\": null, \"esic_applicable\": 0, \"special_allowance\": \"2000.00\", \"conveyance_allowance\": \"0.00\"}', '2026-02-19 04:56:24', '2026-02-19 04:56:39', NULL),
(13, 2, 25000.00, 5000.00, 3000.00, 0.00, 2000.00, 0.00, 1, 0, 'active', NULL, NULL, NULL, '{\"hra\": \"5000.00\", \"medical\": null, \"pf_amount\": null, \"uan_number\": null, \"esic_amount\": null, \"esic_number\": null, \"basic_salary\": \"25000.00\", \"gross_salary\": null, \"overtime_rate\": \"0.00\", \"pf_applicable\": 1, \"effective_from\": null, \"esic_applicable\": 0, \"special_allowance\": \"2000.00\", \"conveyance_allowance\": \"1000.00\"}', '2026-02-19 04:56:39', '2026-02-19 04:56:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee_shift_logs`
--

DROP TABLE IF EXISTS `employee_shift_logs`;
CREATE TABLE IF NOT EXISTS `employee_shift_logs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `shift_id` int DEFAULT NULL,
  `employee_id` bigint UNSIGNED NOT NULL,
  `sign_in` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `sign_out` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `action_by` bigint UNSIGNED DEFAULT NULL,
  `status` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `employee_shift_logs`
--

INSERT INTO `employee_shift_logs` (`id`, `shift_id`, `employee_id`, `sign_in`, `sign_out`, `action_by`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(10, 1, 2, NULL, NULL, 1, 'inactive', '2026-02-16 09:15:51', '2026-02-19 06:33:38', NULL),
(14, 2, 4, '10:00', '18:00', 1, 'active', '2026-02-19 05:31:16', '2026-02-24 10:53:23', '2026-02-24 10:53:23'),
(13, 1, 5, NULL, NULL, 1, 'active', '2026-02-16 09:46:39', '2026-02-16 09:46:39', NULL),
(12, 1, 4, NULL, NULL, 1, 'inactive', '2026-02-16 09:43:08', '2026-02-16 09:43:08', '2026-02-19 05:36:41'),
(11, 1, 3, NULL, NULL, 1, 'active', '2026-02-16 09:28:05', '2026-02-16 09:28:05', NULL),
(15, 4, 2, '10:00', '18:00', 1, 'inactive', '2026-02-19 06:33:38', '2026-02-19 06:36:41', NULL),
(16, 4, 2, '10:00', '18:00', 1, 'inactive', '2026-02-19 06:36:41', '2026-02-19 06:38:04', NULL),
(17, 4, 2, '10:00', '18:00', 1, 'inactive', '2026-02-19 06:38:04', '2026-02-19 06:38:33', NULL),
(18, 4, 2, '10:00', '18:00', 1, 'inactive', '2026-02-19 06:38:33', '2026-02-24 10:29:44', NULL),
(19, 4, 2, '10:00', '18:00', 1, 'inactive', '2026-02-24 10:29:44', '2026-02-24 10:31:11', NULL),
(20, 4, 2, '10:00', '18:00', 1, 'inactive', '2026-02-24 10:31:11', '2026-02-24 10:33:29', NULL),
(21, 4, 2, '10:00', '18:00', 1, 'inactive', '2026-02-24 10:33:29', '2026-02-24 10:36:43', NULL),
(22, 4, 2, '10:00', '18:00', 1, 'active', '2026-02-24 10:36:43', '2026-02-24 10:36:43', NULL),
(23, 3, 6, NULL, NULL, 1, 'active', '2026-03-06 05:11:30', '2026-03-06 05:11:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(1, 'ad262a17-719b-47e6-b429-3cbcea9c1b56', 'database', 'default', '{\"uuid\":\"ad262a17-719b-47e6-b429-3cbcea9c1b56\",\"displayName\":\"App\\\\Mail\\\\OnboardingMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:23:\\\"App\\\\Mail\\\\OnboardingMail\\\":3:{s:8:\\\"employee\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Employee\\\";s:2:\\\"id\\\";i:3;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:23:\\\"sumitkrtechie@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1770284143,\"delay\":null}', 'Illuminate\\Database\\Eloquent\\ModelNotFoundException: No query results for model [App\\Models\\Employee]. in F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Eloquent\\Builder.php:780\nStack trace:\n#0 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\SerializesAndRestoresModelIdentifiers.php(110): Illuminate\\Database\\Eloquent\\Builder->firstOrFail()\n#1 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\SerializesAndRestoresModelIdentifiers.php(63): App\\Mail\\OnboardingMail->restoreModel(Object(Illuminate\\Contracts\\Database\\ModelIdentifier))\n#2 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\SerializesModels.php(97): App\\Mail\\OnboardingMail->getRestoredPropertyValue(Object(Illuminate\\Contracts\\Database\\ModelIdentifier))\n#3 [internal function]: App\\Mail\\OnboardingMail->__unserialize(Array)\n#4 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(95): unserialize(\'O:34:\"Illuminat...\')\n#5 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(62): Illuminate\\Queue\\CallQueuedHandler->getCommand(Array)\n#6 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#7 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(485): Illuminate\\Queue\\Jobs\\Job->fire()\n#8 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#9 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#10 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#11 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#12 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#13 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#14 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#15 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#16 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#17 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#18 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#19 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#20 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#21 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#22 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#23 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#24 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#25 F:\\2026\\hrms-backend\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#26 {main}', '2026-02-05 04:16:12'),
(2, 'f86b3fd0-f450-4be7-857c-ab9b0a5e7393', 'database', 'default', '{\"uuid\":\"f86b3fd0-f450-4be7-857c-ab9b0a5e7393\",\"displayName\":\"App\\\\Mail\\\\OnboardingMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:23:\\\"App\\\\Mail\\\\OnboardingMail\\\":3:{s:8:\\\"employee\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Employee\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:23:\\\"sumitkrtechie@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1770284469,\"delay\":null}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Mail\\OnboardingMail has been attempted too many times. in F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\MaxAttemptsExceededException.php:24\nStack trace:\n#0 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(862): Illuminate\\Queue\\MaxAttemptsExceededException::forJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(573): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#2 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(474): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#3 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#4 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#6 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#7 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#13 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#15 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 F:\\2026\\hrms-backend\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#21 {main}', '2026-02-05 04:17:44'),
(3, '30fecced-aa16-45b9-9201-5853ae32bded', 'database', 'default', '{\"uuid\":\"30fecced-aa16-45b9-9201-5853ae32bded\",\"displayName\":\"App\\\\Mail\\\\OnboardingMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:23:\\\"App\\\\Mail\\\\OnboardingMail\\\":3:{s:8:\\\"employee\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Employee\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:23:\\\"sumitkrtechie@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1770284529,\"delay\":null}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Mail\\OnboardingMail has been attempted too many times. in F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\MaxAttemptsExceededException.php:24\nStack trace:\n#0 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(862): Illuminate\\Queue\\MaxAttemptsExceededException::forJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(573): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#2 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(474): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#3 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#4 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#6 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#7 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#13 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#15 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 F:\\2026\\hrms-backend\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#21 {main}', '2026-02-05 04:17:46'),
(4, 'd748bbbc-9cbd-4c64-b2e9-0be0110bd671', 'database', 'default', '{\"uuid\":\"d748bbbc-9cbd-4c64-b2e9-0be0110bd671\",\"displayName\":\"App\\\\Mail\\\\OnboardingMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:23:\\\"App\\\\Mail\\\\OnboardingMail\\\":3:{s:8:\\\"employee\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Employee\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:23:\\\"sumitkrtechie@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1770284553,\"delay\":null}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Mail\\OnboardingMail has been attempted too many times. in F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\MaxAttemptsExceededException.php:24\nStack trace:\n#0 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(862): Illuminate\\Queue\\MaxAttemptsExceededException::forJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(573): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#2 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(474): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#3 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#4 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#6 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#7 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#13 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#15 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 F:\\2026\\hrms-backend\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#21 {main}', '2026-02-05 04:17:48'),
(5, '6958d408-c7e4-40f4-b8b3-879256c308ec', 'database', 'default', '{\"uuid\":\"6958d408-c7e4-40f4-b8b3-879256c308ec\",\"displayName\":\"App\\\\Mail\\\\OnboardingMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:23:\\\"App\\\\Mail\\\\OnboardingMail\\\":3:{s:8:\\\"employee\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Employee\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:23:\\\"sumitkrtechie@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1770284623,\"delay\":null}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Mail\\OnboardingMail has been attempted too many times. in F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\MaxAttemptsExceededException.php:24\nStack trace:\n#0 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(862): Illuminate\\Queue\\MaxAttemptsExceededException::forJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(573): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#2 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(474): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#3 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#4 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#6 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#7 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#13 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#15 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 F:\\2026\\hrms-backend\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#21 {main}', '2026-02-05 04:17:49'),
(6, '1980d490-8e0f-46e7-b1b5-191e278258b0', 'database', 'default', '{\"uuid\":\"1980d490-8e0f-46e7-b1b5-191e278258b0\",\"displayName\":\"App\\\\Mail\\\\OnboardingMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:23:\\\"App\\\\Mail\\\\OnboardingMail\\\":3:{s:8:\\\"employee\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Employee\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:23:\\\"sumitkrtechie@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1770284663,\"delay\":null}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Mail\\OnboardingMail has been attempted too many times. in F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\MaxAttemptsExceededException.php:24\nStack trace:\n#0 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(862): Illuminate\\Queue\\MaxAttemptsExceededException::forJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(573): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#2 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(474): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#3 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#4 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#6 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#7 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#13 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#15 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 F:\\2026\\hrms-backend\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#21 {main}', '2026-02-05 04:17:50'),
(7, '55330b25-162c-4166-89df-f42a870828d0', 'database', 'default', '{\"uuid\":\"55330b25-162c-4166-89df-f42a870828d0\",\"displayName\":\"App\\\\Mail\\\\OnboardingMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:23:\\\"App\\\\Mail\\\\OnboardingMail\\\":3:{s:8:\\\"employee\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Employee\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:23:\\\"sumitkrtechie@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1770284673,\"delay\":null}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Mail\\OnboardingMail has been attempted too many times. in F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\MaxAttemptsExceededException.php:24\nStack trace:\n#0 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(862): Illuminate\\Queue\\MaxAttemptsExceededException::forJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(573): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#2 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(474): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#3 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#4 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(358): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#6 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#7 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#8 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#13 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#15 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 F:\\2026\\hrms-backend\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 F:\\2026\\hrms-backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 F:\\2026\\hrms-backend\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#21 {main}', '2026-02-05 04:17:51');

-- --------------------------------------------------------

--
-- Table structure for table `finalized_payrolls`
--

DROP TABLE IF EXISTS `finalized_payrolls`;
CREATE TABLE IF NOT EXISTS `finalized_payrolls` (
  `id` int NOT NULL AUTO_INCREMENT,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `gross_amount` decimal(30,2) DEFAULT NULL,
  `pf_amount` decimal(30,2) DEFAULT NULL,
  `esic_amount` decimal(30,2) DEFAULT NULL,
  `net_amount` decimal(30,2) DEFAULT NULL,
  `action_by` int DEFAULT NULL,
  `attendance_approval_status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `pf_calculation_status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `esic_calculation_status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `payslip_generation_status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `compliance_status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `management_approval_status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `date_time` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `finalized_payrolls`
--

INSERT INTO `finalized_payrolls` (`id`, `month`, `year`, `gross_amount`, `pf_amount`, `esic_amount`, `net_amount`, `action_by`, `attendance_approval_status`, `pf_calculation_status`, `esic_calculation_status`, `payslip_generation_status`, `compliance_status`, `management_approval_status`, `date_time`, `created_at`, `updated_at`) VALUES
(3, 1, 2026, NULL, 0.00, 0.00, 83999.00, 1, '0', '0', '0', '0', '0', '0', '2026-02-26 06:39:05', '2026-02-26 06:39:05', '2026-02-26 06:39:05');

-- --------------------------------------------------------

--
-- Table structure for table `global_ot_configurations`
--

DROP TABLE IF EXISTS `global_ot_configurations`;
CREATE TABLE IF NOT EXISTS `global_ot_configurations` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `is_ot_applicable` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Enable/Disable OT globally',
  `employee_base_hourly_rate` decimal(10,2) NOT NULL DEFAULT '0.00',
  `employee_ot_percentage` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'e.g. 50% extra',
  `ot_hourly_rate` decimal(10,2) NOT NULL DEFAULT '0.00',
  `ot_hours_worked` decimal(5,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'default', '{\"uuid\":\"4d4f692f-79fe-4ae1-9fe7-85e5bb3d235f\",\"displayName\":\"App\\\\Mail\\\\OnboardingMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:23:\\\"App\\\\Mail\\\\OnboardingMail\\\":3:{s:8:\\\"employee\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:19:\\\"App\\\\Models\\\\Employee\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:14:\\\"amar@gmail.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1772773896,\"delay\":null}', 0, NULL, 1772773897, 1772773897);

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb3_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

DROP TABLE IF EXISTS `leaves`;
CREATE TABLE IF NOT EXISTS `leaves` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `employee_id` bigint UNSIGNED NOT NULL,
  `leave_type` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `total_days` decimal(5,2) NOT NULL,
  `reason` text COLLATE utf8mb3_unicode_ci,
  `status` enum('pending','approved','rejected','cancelled') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pending',
  `rejected_reason` text COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `leaves`
--

INSERT INTO `leaves` (`id`, `employee_id`, `leave_type`, `from_date`, `to_date`, `total_days`, `reason`, `status`, `rejected_reason`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Casual Leave', '2026-02-10', '2026-02-12', 3.00, 'Family function', 'pending', NULL, '2026-02-04 06:40:57', '2026-02-04 06:40:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mail_logs`
--

DROP TABLE IF EXISTS `mail_logs`;
CREATE TABLE IF NOT EXISTS `mail_logs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `mail_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mailable_id` bigint UNSIGNED DEFAULT NULL,
  `mailable_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_id` bigint UNSIGNED DEFAULT NULL,
  `to_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','success','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mail_logs_mailable_type_mailable_id_index` (`mailable_type`,`mailable_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_02_02_104030_create_employees_table', 1),
(5, '2026_02_02_104223_create_departments_table', 1),
(6, '2026_02_02_104315_create_roles_table', 1),
(7, '2026_02_02_104350_create_attendance_table', 1),
(8, '2026_02_02_104423_create_leaves_table', 1),
(9, '2026_02_02_104508_create_salary_structures_table', 1),
(10, '2026_02_02_104556_create_payrolls_table', 1),
(11, '2026_02_02_104632_create_documents_table', 1),
(12, '2026_02_02_104803_create_notifications_table', 1),
(13, '2026_02_02_104839_create_employee_shift_logs_table', 1),
(14, '2026_02_02_104916_create_templates_table', 1),
(15, '2026_02_02_104950_create_employee_ot_configurations_table', 1),
(16, '2026_02_02_105059_create_global_ot_configurations_table', 1),
(17, '2026_02_02_120629_add_two_factor_columns_to_users_table', 1),
(18, '2026_02_02_120704_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `notifiable_id` bigint UNSIGNED NOT NULL,
  `notifiable_type` enum('employee','user') COLLATE utf8mb3_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_id_notifiable_type_index` (`notifiable_id`,`notifiable_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payroll_id` int NOT NULL,
  `amount` decimal(20,2) NOT NULL,
  `due` decimal(20,2) NOT NULL DEFAULT '0.00',
  `mode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `transaction_id` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` tinytext COLLATE utf8mb4_unicode_ci,
  `action_by` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `payroll_id`, `amount`, `due`, `mode`, `date`, `transaction_id`, `remarks`, `action_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, 15862.83, 0.00, 'cash', '2026-03-06', NULL, NULL, 1, '2026-03-06 09:02:24', '2026-03-06 09:02:24', NULL);

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
  `overtime` decimal(20,2) NOT NULL DEFAULT '0.00',
  `basic_amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hra_allowance` decimal(20,2) NOT NULL DEFAULT '0.00',
  `conveyance_allowance` decimal(20,2) NOT NULL DEFAULT '0.00',
  `medical_allowance` decimal(20,2) NOT NULL DEFAULT '0.00',
  `special_allowance` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pf_amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `esic_amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `gross_salary` decimal(20,2) DEFAULT NULL,
  `deductions` decimal(20,2) DEFAULT NULL,
  `net_salary` decimal(20,2) DEFAULT NULL,
  `is_mail_sent` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
  `mail_sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `is_paid` enum('0','1') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `payrolls_employee_id_month_unique` (`employee_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `payrolls`
--

INSERT INTO `payrolls` (`id`, `employee_id`, `status`, `month`, `year`, `present_days`, `paid_leaves`, `overtime`, `basic_amount`, `hra_allowance`, `conveyance_allowance`, `medical_allowance`, `special_allowance`, `pf_amount`, `esic_amount`, `gross_salary`, `deductions`, `net_salary`, `is_mail_sent`, `mail_sent_at`, `created_at`, `updated_at`, `deleted_at`, `is_paid`) VALUES
(1, 2, 'generated', '1', '2026', 27, 0, 0.00, 25000.00, 5000.00, 0.00, 3000.00, 2000.00, 3000.00, 0.00, 40185.19, 3000.00, 37185.19, '0', NULL, '2026-03-02 06:12:42', '2026-03-02 06:12:42', NULL, '0'),
(2, 3, 'generated', '1', '2026', 27, 0, 0.00, 12000.00, 0.00, 0.00, 0.00, 399.00, 0.00, 106.77, 14235.89, 106.77, 14129.12, '0', '2026-03-06 10:08:12', '2026-03-02 06:12:42', '2026-03-06 10:08:12', NULL, '0'),
(3, 4, 'generated', '1', '2026', 27, 0, 0.00, 15000.00, 0.00, 0.00, 0.00, 500.00, 1800.00, 133.47, 17796.30, 1933.47, 15862.83, '0', '2026-03-06 11:55:53', '2026-03-02 06:12:42', '2026-03-06 11:55:53', NULL, '1'),
(4, 5, 'generated', '1', '2026', 27, 0, 0.00, 17000.00, 2100.00, 0.00, 0.00, 2000.00, 2040.00, 0.00, 24225.93, 2040.00, 22185.93, '0', '2026-03-06 10:59:13', '2026-03-02 06:12:42', '2026-03-06 10:59:13', NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb3_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb3_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` smallint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
(1, 'Manager', 'api', '2026-02-04 05:56:09', '2026-02-04 05:56:09', NULL, 1),
(2, 'Admin', 'api', '2026-02-04 05:56:19', '2026-02-04 05:57:57', '2026-02-04 05:57:57', 0);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb3_unicode_ci,
  `payload` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('eFdoXF5Dv5HOERdVImgvuHSGtZbmiRgRdomzP4np', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoibVVxbDRqUzJnbDRYUXZTVTkxYXF5U3BTNUg3SzMya0F2ZjA4OUVqViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6Mjp7aTowO3M6MTA6Il9vbGRfaW5wdXQiO2k6MTtzOjY6ImVycm9ycyI7fXM6MzoibmV3IjthOjA6e319czoxMDoiX29sZF9pbnB1dCI7YTowOnt9czo2OiJlcnJvcnMiO086MzE6IklsbHVtaW5hdGVcU3VwcG9ydFxWaWV3RXJyb3JCYWciOjE6e3M6NzoiACoAYmFncyI7YToxOntzOjc6ImRlZmF1bHQiO086Mjk6IklsbHVtaW5hdGVcU3VwcG9ydFxNZXNzYWdlQmFnIjoyOntzOjExOiIAKgBtZXNzYWdlcyI7YTozOntzOjEwOiJ0ZW1wbGF0ZUlkIjthOjE6e2k6MDtzOjM0OiJUaGUgdGVtcGxhdGUgaWQgZmllbGQgaXMgcmVxdWlyZWQuIjt9czo1OiJlbXBJZCI7YToxOntpOjA7czoyOToiVGhlIGVtcCBpZCBmaWVsZCBpcyByZXF1aXJlZC4iO31zOjI6ImlkIjthOjE6e2k6MDtzOjI1OiJUaGUgaWQgZmllbGQgaXMgcmVxdWlyZWQuIjt9fXM6OToiACoAZm9ybWF0IjtzOjg6IjptZXNzYWdlIjt9fX19', 1772431090),
('ko56sYasPahGrDUrfPhli95rfAnyJ5ApBKCOdmBr', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSjNkSW9uSzRZRHpSZGMwa0N0dTdlUXN1V0xzNkRXSTRubHY2UWJkMCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9fQ==', 1772433849);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `logo` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `application_name` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `about` text COLLATE utf8mb4_unicode_ci,
  `theme_color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `copyright` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `powered_by` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_key` tinytext COLLATE utf8mb4_unicode_ci,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` text COLLATE utf8mb4_unicode_ci,
  `state` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `logo`, `favicon`, `application_name`, `about`, `theme_color`, `copyright`, `powered_by`, `contact`, `email`, `address`, `api_key`, `city`, `country`, `short_description`, `state`, `zip`, `created_at`, `updated_at`) VALUES
(1, 'settings/T1nv5SHOqIJkH3Mrrncgaakckzj3hGnMscXnXuMm.png', 'settings/BPb5QtTuLBIHXhr9Qo7bNzoSttTzflc6mscBPB6x.png', 'HRMS', 'Something went wrong', '#308b8d', 'te', 'test', '1234567890', 'sumitkrtechie@gmail.com', 'patna', 'fgdfgdf', 'patna', 'India', 'Company Short Description', 'Bihar', '800001', '2026-02-05 09:28:10', '2026-02-26 10:15:37');

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

DROP TABLE IF EXISTS `shifts`;
CREATE TABLE IF NOT EXISTS `shifts` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sign_in` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sign_out` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rotational_time` tinyint(1) DEFAULT '0',
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`id`, `name`, `sign_in`, `sign_out`, `rotational_time`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Morning', '10:00', '18:00', 0, 'active', '2026-02-04 05:44:31', '2026-02-10 08:51:58', NULL),
(2, 'Rotational', '06:00', '14:00', 1, 'active', '2026-02-04 05:45:27', '2026-02-11 05:48:38', NULL),
(3, 'Afternoon', '12:00', '22:00', 0, 'active', '2026-02-10 08:36:51', '2026-02-10 09:06:27', NULL),
(4, 'Category 1', '16:38', '23:48', 1, 'active', '2026-02-11 11:08:58', '2026-02-11 11:08:58', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
CREATE TABLE IF NOT EXISTS `templates` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `body` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `subject` varchar(191) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `templates`
--

INSERT INTO `templates` (`id`, `title`, `body`, `subject`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Test', '<p>Dear {{EmployeeName}},\r\nYour salary slip is attached.</p>', 'Test', 'active', NULL, '2026-02-25 06:24:54', '2026-02-25 06:24:54'),
(2, 'Monthly Salary Slip', '<p>Dear&nbsp;{{EmployeeName}},</p><p>We&nbsp;hope&nbsp;this&nbsp;message&nbsp;finds&nbsp;you&nbsp;well.</p><p>Please&nbsp;find&nbsp;attached&nbsp;your&nbsp;salary&nbsp;slip&nbsp;for&nbsp;the&nbsp;month&nbsp;of&nbsp;{{Month}}&nbsp;{{Year}}.</p><p>Kindly&nbsp;review&nbsp;the&nbsp;details&nbsp;carefully.&nbsp;If&nbsp;you&nbsp;have&nbsp;any&nbsp;questions&nbsp;or&nbsp;notice&nbsp;any&nbsp;discrepancies,&nbsp;please&nbsp;feel&nbsp;free&nbsp;to&nbsp;contact&nbsp;the&nbsp;HR&nbsp;or&nbsp;Accounts&nbsp;department.</p><p>Thank&nbsp;you&nbsp;for&nbsp;your&nbsp;continued&nbsp;dedication&nbsp;and&nbsp;contribution&nbsp;to&nbsp;the&nbsp;organization.</p><p>Best&nbsp;regards,</p><p>Sumit&nbsp;Kumar</p><p>{{Designation}}</p><p>XYZ</p><p>98xxxxxx98</p>', 'Salary Slip for {{Month}} {{Year}}', 'active', '2026-02-20 07:11:46', '2026-02-25 06:39:08', NULL),
(3, 'Offer Letter', '<p><strong>To,</strong></p><p>{{EmployeeName}}</p><p><strong>Subject:&nbsp;Job&nbsp;Offer</strong></p><p>Dear&nbsp;[Candidate&nbsp;Name],</p><p>We&nbsp;are&nbsp;pleased&nbsp;to&nbsp;offer&nbsp;you&nbsp;the&nbsp;position&nbsp;of&nbsp;<strong>[Job&nbsp;Title]</strong>&nbsp;at&nbsp;<strong>[Company&nbsp;Name]</strong>&nbsp;starting&nbsp;from&nbsp;<strong>[Joining&nbsp;Date]</strong>&nbsp;at&nbsp;<strong>[Location]</strong>.</p><p>Your&nbsp;annual&nbsp;CTC&nbsp;will&nbsp;be&nbsp;<strong>₹[Amount]</strong>,&nbsp;and&nbsp;you&nbsp;will&nbsp;be&nbsp;on&nbsp;probation&nbsp;for&nbsp;<strong>[3/6&nbsp;months]</strong>&nbsp;as&nbsp;per&nbsp;company&nbsp;policy.&nbsp;Other&nbsp;terms&nbsp;and&nbsp;conditions&nbsp;will&nbsp;be&nbsp;shared&nbsp;in&nbsp;the&nbsp;appointment&nbsp;letter.</p><p>Kindly&nbsp;confirm&nbsp;your&nbsp;acceptance&nbsp;by&nbsp;signing&nbsp;and&nbsp;returning&nbsp;this&nbsp;letter.</p><p>We&nbsp;look&nbsp;forward&nbsp;to&nbsp;working&nbsp;with&nbsp;you.</p><p>Sincerely,</p><p>&nbsp;[Authorized&nbsp;Signatory&nbsp;Name]</p><p>&nbsp;[Designation]</p><p>&nbsp;[Company&nbsp;Name]</p>', 'Offer Letter', 'active', '2026-02-24 05:45:08', '2026-02-25 06:24:56', '2026-02-25 06:24:56'),
(4, 'Test', '<p>test</p>', 'New Letter', 'active', '2026-02-25 06:41:35', '2026-02-25 06:41:35', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `template_variables`
--

DROP TABLE IF EXISTS `template_variables`;
CREATE TABLE IF NOT EXISTS `template_variables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `template_variables`
--

INSERT INTO `template_variables` (`id`, `name`, `value`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'EmployeeName', 'name', '2026-02-20 05:51:30', '2026-02-20 05:51:30', NULL),
(2, 'BloodGroup', 'blood_group', '2026-02-20 06:56:47', '2026-02-20 06:56:47', NULL),
(3, 'AadharNumber', 'aadhar_number', '2026-02-20 07:23:38', '2026-02-20 07:23:38', NULL),
(4, 'empCode', 'employee_code', '2026-02-20 11:24:31', '2026-02-20 11:24:31', NULL),
(5, 'Designation', 'designation', '2026-02-25 06:16:27', '2026-02-25 06:16:27', NULL),
(6, 'Month', 'month', '2026-02-25 07:34:02', '2026-02-25 07:34:02', NULL),
(7, 'Year', 'year', '2026-02-25 07:34:02', '2026-02-25 07:34:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `token` text COLLATE utf8mb3_unicode_ci,
  `two_factor_secret` text COLLATE utf8mb3_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb3_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `current_team_id` bigint UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `token`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
(1, 'sumit kumar', 'admin@techiesquad.com', NULL, '$2y$12$PxFMDlNHVITYamgLuFBDYOHqWgcQDhvq.7rdr2Ir3HUTrcTsq.T5q', '40191b64af7b897bb3cffc1dd3f81e18e4eeb0c435bfab278e572512f09886ee', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-02 06:56:35', '2026-03-06 11:38:04'),
(33, 'Aman Kumar', 'aman@gmail.com', NULL, '$2y$12$OjmoVcY9zBIZ9jlmxDFXbO0B5LSTZMnEoNmnUTZ53QP/MynpQMdKi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-16 09:15:51', '2026-02-16 09:15:51');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
