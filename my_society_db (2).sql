-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2026 at 04:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `my_society_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `allotments`
--

CREATE TABLE `allotments` (
  `id` int(11) NOT NULL,
  `flat_id` int(11) NOT NULL,
  `resident_name` varchar(100) NOT NULL,
  `contact_no` varchar(15) NOT NULL,
  `allotment_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `allotments`
--

INSERT INTO `allotments` (`id`, `flat_id`, `resident_name`, `contact_no`, `allotment_date`) VALUES
(1, 1, 'Mallesh Bhandari', '9881339770', '2026-01-10'),
(2, 2, 'Sandeep Kulkarni', '9822113344', '2026-01-15'),
(3, 3, 'Sunita Deshpande', '9988776655', '2026-02-01'),
(4, 4, 'Amol Shinde', '9123456789', '2026-02-10'),
(5, 5, 'Priyanka More', '8877665544', '2026-03-01'),
(6, 6, 'Vijay Gawade', '9456781230', '2026-01-12'),
(7, 7, 'Anjali Jadhav', '9678451234', '2026-01-20'),
(8, 8, 'Suresh Patil', '9812345678', '2026-02-05'),
(9, 9, 'Manish Tiwari', '9000111222', '2026-02-18'),
(10, 10, 'Kiran Pawar', '9111222333', '2026-03-05'),
(11, 11, 'Santosh Nair', '9222333444', '2026-01-08'),
(12, 12, 'Rohan Joshi', '9333444555', '2026-01-25'),
(13, 13, 'Deepak Varma', '9444555666', '2026-02-02'),
(14, 14, 'Rajesh Khanna', '9555666777', '2026-02-14'),
(15, 15, 'Asha Bhosle', '9666777888', '2026-03-02'),
(16, 16, 'Vikrant Meshram', '9777888999', '2026-01-11'),
(17, 17, 'Siddharth Rane', '9888999000', '2026-01-28'),
(18, 18, 'Kavita Iyer', '9999000111', '2026-02-07'),
(19, 19, 'Ajay Devgn', '9012345678', '2026-02-22'),
(20, 20, 'Kunal Kamble', '9123456780', '2026-03-10'),
(21, 21, 'Sanjay Gupta', '9234567891', '2026-01-05'),
(22, 22, 'Rahul Dravid', '9345678902', '2026-01-18'),
(23, 23, 'Anand Iyer', '9456789013', '2026-02-12'),
(24, 24, 'Harish Salve', '9567890124', '2026-02-25'),
(25, 25, 'Tushar Kapoor', '9678901235', '2026-03-12'),
(26, 26, 'Shruti Haasan', '9789012346', '2026-01-14'),
(27, 27, 'Rajiv Gandhi', '9890123457', '2026-01-30'),
(28, 28, 'Arvind Kejriwal', '9901234568', '2026-02-09'),
(29, 29, 'Prashant Bhushan', '9012345679', '2026-02-28'),
(30, 30, 'Nitin Gadkari', '9123456781', '2026-03-15'),
(31, 31, 'Mahesh Bhatt', '9234567892', '2026-01-09'),
(32, 32, 'Irfan Pathan', '9345678903', '2026-01-22'),
(33, 33, 'Vinod Kambli', '9456789014', '2026-02-15'),
(34, 34, 'Ashish Nehra', '9567890125', '2026-02-27'),
(35, 35, 'Kartik Aryan', '9678901236', '2026-03-18'),
(36, 36, 'Sarla Devi', '9789012347', '2026-01-16'),
(37, 37, 'Jyoti Malhotra', '9890123458', '2026-02-04'),
(38, 38, 'Archana Puran', '9901234569', '2026-02-19'),
(39, 39, 'Ishwar Singh', '9012345670', '2026-03-20'),
(40, 40, 'Tanmay Bhat', '9123456782', '2026-01-07'),
(41, 41, 'Ramesh Powar', '9234567893', '2026-01-24'),
(42, 42, 'Hemant Soren', '9345678904', '2026-02-11'),
(43, 43, 'Kamal Haasan', '9456789015', '2026-02-26'),
(44, 44, 'Jatin Sapru', '9567890126', '2026-03-22'),
(45, 45, 'Ravi Shastri', '9678901237', '2026-01-13'),
(46, 46, 'Shubman Gill', '9789012348', '2026-01-29'),
(47, 47, 'Yogesh Dutt', '9890123459', '2026-02-13'),
(48, 48, 'Madhavan R.', '9901234560', '2026-02-24'),
(49, 49, 'Vishal Dadlani', '9012345671', '2026-03-25'),
(50, 50, 'Savitri Bai', '9123456783', '2026-01-01');

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `id` int(11) NOT NULL,
  `allotment_id` int(11) NOT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `bill_month` varchar(20) NOT NULL,
  `bill_amount` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT 'Unpaid',
  `due_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`id`, `allotment_id`, `amount`, `bill_month`, `bill_amount`, `status`, `due_date`, `created_at`) VALUES
(1, 1, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(2, 2, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(3, 3, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(4, 4, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(5, 5, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(6, 6, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(7, 7, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(8, 8, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(9, 9, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(10, 10, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(11, 11, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(12, 12, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(13, 13, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(14, 14, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(15, 15, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(16, 16, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(17, 17, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(18, 18, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(19, 19, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(20, 20, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(21, 21, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(22, 22, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(23, 23, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(24, 24, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(25, 25, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(26, 26, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(27, 27, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(28, 28, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(29, 29, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(30, 30, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(31, 31, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(32, 32, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(33, 33, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(34, 34, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(35, 35, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(36, 36, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(37, 37, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(38, 38, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(39, 39, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(40, 40, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(41, 41, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(42, 42, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(43, 43, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(44, 44, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(45, 45, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(46, 46, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(47, 47, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(48, 48, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(49, 49, 4500.00, 'February 2026', 0.00, 'Unpaid', '2026-03-10', '2026-03-28 14:49:26'),
(50, 50, 4500.00, 'February 2026', 0.00, 'Paid', '2026-03-10', '2026-03-28 14:49:26'),
(51, 1, NULL, 'March 2026', 4500.00, 'Paid', NULL, '2026-04-19 06:49:00'),
(52, 2, NULL, 'March 2026', 4500.00, 'Paid', NULL, '2026-04-19 06:50:27'),
(53, 2, NULL, 'March 2026', 4500.00, 'Paid', NULL, '2026-04-19 06:51:00');

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` int(11) NOT NULL,
  `allotment_id` int(11) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `resident_name` varchar(100) NOT NULL,
  `flat_no` varchar(50) NOT NULL,
  `complaint_type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `status` varchar(20) DEFAULT 'Pending',
  `date_reported` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `allotment_id`, `category`, `resident_name`, `flat_no`, `complaint_type`, `description`, `status`, `date_reported`, `created_at`) VALUES
(1, 1, 'Plumbing', '', '', '', 'Kitchen tap is leaking since morning.', 'In Progress', '2026-03-25', '2026-03-28 15:03:56'),
(2, 5, 'Electricity', '', '', '', 'Common area lights are flickering.', 'Resolved', '2026-03-24', '2026-03-28 15:03:56'),
(3, 12, 'Lift', '', '', '', 'Lift B is making unusual noise.', 'In Progress', '2026-03-27', '2026-03-28 15:03:56'),
(4, 8, 'Security', '', '', '', 'Intercom not working properly.', 'In Progress', '2026-03-28', '2026-03-28 15:03:56'),
(5, 20, 'Cleaning', '', '', '', 'Garbage not collected from 5th floor.', 'Resolved', '2026-03-22', '2026-03-28 15:03:56'),
(6, 15, 'Plumbing', '', '', '', 'Water leakage in bathroom ceiling.', 'In Progress', '2026-03-26', '2026-03-28 15:03:56'),
(7, 30, 'Others', '', '', '', 'Gym equipment needs oiling.', 'Pending', '2026-03-28', '2026-03-28 15:03:56'),
(8, 45, 'Electricity', '', '', '', 'Short circuit in passage box.', 'Resolved', '2026-03-20', '2026-03-28 15:03:56'),
(9, 2, 'Security', '', '', '', 'Unknown person seen near parking.', 'Pending', '2026-03-28', '2026-03-28 15:03:56'),
(10, 33, 'Lift', '', '', '', 'Buttons not responding on 4th floor.', 'In Progress', '2026-03-27', '2026-03-28 15:03:56'),
(11, 1, 'Plumbing', '', '', '', '\"The kitchen tap is leaking continuously even when it\'s tightly closed, causing water wastage and a messy floor.\"', 'Pending', NULL, '2026-03-29 08:05:55');

-- --------------------------------------------------------

--
-- Table structure for table `flats`
--

CREATE TABLE `flats` (
  `id` int(11) NOT NULL,
  `flat_no` varchar(50) NOT NULL,
  `floor` int(11) NOT NULL,
  `flat_type` varchar(50) DEFAULT '2BHK',
  `block` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flats`
--

INSERT INTO `flats` (`id`, `flat_no`, `floor`, `flat_type`, `block`, `type`, `created_at`) VALUES
(1, 'A-101', 1, '2BHK', 'A', '1BHK', '2026-03-28 14:13:38'),
(2, 'A-201', 2, '2BHK', 'A', '1BHK', '2026-03-28 14:13:38'),
(3, 'A-301', 3, '2BHK', 'A', '1BHK', '2026-03-28 14:13:38'),
(4, 'A-401', 4, '2BHK', 'A', '2BHK', '2026-03-28 14:13:38'),
(5, 'A-501', 5, '2BHK', 'A', '2BHK', '2026-03-28 14:13:38'),
(6, 'A-601', 6, '2BHK', 'A', '2BHK', '2026-03-28 14:13:38'),
(7, 'A-701', 7, '2BHK', 'A', '2BHK', '2026-03-28 14:13:38'),
(8, 'A-801', 8, '2BHK', 'A', '3BHK', '2026-03-28 14:13:38'),
(9, 'A-901', 9, '2BHK', 'A', '3BHK', '2026-03-28 14:13:38'),
(10, 'A-1001', 10, '2BHK', 'A', '3BHK', '2026-03-28 14:13:38'),
(11, 'B-101', 1, '2BHK', 'B', '1BHK', '2026-03-28 14:13:38'),
(12, 'B-201', 2, '2BHK', 'B', '1BHK', '2026-03-28 14:13:38'),
(13, 'B-301', 3, '2BHK', 'B', '1BHK', '2026-03-28 14:13:38'),
(14, 'B-401', 4, '2BHK', 'B', '2BHK', '2026-03-28 14:13:38'),
(15, 'B-501', 5, '2BHK', 'B', '2BHK', '2026-03-28 14:13:38'),
(16, 'B-601', 6, '2BHK', 'B', '2BHK', '2026-03-28 14:13:38'),
(17, 'B-701', 7, '2BHK', 'B', '2BHK', '2026-03-28 14:13:38'),
(18, 'B-801', 8, '2BHK', 'B', '3BHK', '2026-03-28 14:13:38'),
(19, 'B-901', 9, '2BHK', 'B', '3BHK', '2026-03-28 14:13:38'),
(20, 'B-1001', 10, '2BHK', 'B', '3BHK', '2026-03-28 14:13:38'),
(21, 'C-101', 1, '2BHK', 'C', '1BHK', '2026-03-28 14:13:38'),
(22, 'C-201', 2, '2BHK', 'C', '1BHK', '2026-03-28 14:13:38'),
(23, 'C-301', 3, '2BHK', 'C', '1BHK', '2026-03-28 14:13:38'),
(24, 'C-401', 4, '2BHK', 'C', '2BHK', '2026-03-28 14:13:38'),
(25, 'C-501', 5, '2BHK', 'C', '2BHK', '2026-03-28 14:13:38'),
(26, 'C-601', 6, '2BHK', 'C', '2BHK', '2026-03-28 14:13:38'),
(27, 'C-701', 7, '2BHK', 'C', '2BHK', '2026-03-28 14:13:38'),
(28, 'C-801', 8, '2BHK', 'C', '3BHK', '2026-03-28 14:13:38'),
(29, 'C-901', 9, '2BHK', 'C', '3BHK', '2026-03-28 14:13:38'),
(30, 'C-1001', 10, '2BHK', 'C', '3BHK', '2026-03-28 14:13:38'),
(31, 'D-101', 1, '2BHK', 'D', '1BHK', '2026-03-28 14:13:38'),
(32, 'D-201', 2, '2BHK', 'D', '1BHK', '2026-03-28 14:13:38'),
(33, 'D-301', 3, '2BHK', 'D', '1BHK', '2026-03-28 14:13:38'),
(34, 'D-401', 4, '2BHK', 'D', '2BHK', '2026-03-28 14:13:38'),
(35, 'D-501', 5, '2BHK', 'D', '2BHK', '2026-03-28 14:13:38'),
(36, 'D-601', 6, '2BHK', 'D', '2BHK', '2026-03-28 14:13:38'),
(37, 'D-701', 7, '2BHK', 'D', '2BHK', '2026-03-28 14:13:38'),
(38, 'D-801', 8, '2BHK', 'D', '3BHK', '2026-03-28 14:13:38'),
(39, 'D-901', 9, '2BHK', 'D', '3BHK', '2026-03-28 14:13:38'),
(40, 'D-1001', 10, '2BHK', 'D', '3BHK', '2026-03-28 14:13:38'),
(41, 'E-101', 1, '2BHK', 'E', '1BHK', '2026-03-28 14:13:38'),
(42, 'E-201', 2, '2BHK', 'E', '1BHK', '2026-03-28 14:13:38'),
(43, 'E-301', 3, '2BHK', 'E', '1BHK', '2026-03-28 14:13:38'),
(44, 'E-401', 4, '2BHK', 'E', '2BHK', '2026-03-28 14:13:38'),
(45, 'E-501', 5, '2BHK', 'E', '2BHK', '2026-03-28 14:13:38'),
(46, 'E-601', 6, '2BHK', 'E', '2BHK', '2026-03-28 14:13:38'),
(47, 'E-701', 7, '2BHK', 'E', '2BHK', '2026-03-28 14:13:38'),
(48, 'E-801', 8, '2BHK', 'E', '3BHK', '2026-03-28 14:13:38'),
(49, 'E-901', 9, '2BHK', 'E', '3BHK', '2026-03-28 14:13:38'),
(50, 'E-1001', 10, '2BHK', 'E', '3BHK', '2026-03-28 14:13:38');

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE `visitors` (
  `id` int(11) NOT NULL,
  `visitor_name` varchar(100) NOT NULL,
  `phone_no` varchar(15) NOT NULL,
  `whom_to_visit` int(11) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `entry_time` datetime DEFAULT current_timestamp(),
  `exit_time` datetime DEFAULT NULL,
  `status` enum('In','Out') DEFAULT 'In'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visitors`
--

INSERT INTO `visitors` (`id`, `visitor_name`, `phone_no`, `whom_to_visit`, `reason`, `entry_time`, `exit_time`, `status`) VALUES
(1, 'Sanjay Deshpande', '9822114455', 1, 'Guest', '2026-03-25 10:15:00', '2026-03-25 10:30:00', 'Out'),
(2, 'Vijay Kulkarni', '9123456780', 5, 'Electrician', '2026-03-25 11:00:00', '2026-03-25 14:20:00', 'Out'),
(3, 'Sunita Patil', '8877665544', 12, 'Personal', '2026-03-26 09:30:00', '2026-03-26 11:45:00', 'Out'),
(4, 'Ramesh Pawar', '9456781230', 2, 'Delivery', '2026-03-26 13:00:00', '2026-03-26 15:00:00', 'Out'),
(5, 'Anil More', '9678451234', 8, 'Courier', '2026-03-26 16:20:00', '2026-03-26 16:40:00', 'Out'),
(6, 'Ganesh Shinde', '9011223344', 15, 'Guest', '2026-03-27 08:00:00', '2026-03-27 10:00:00', 'Out'),
(7, 'Snehal Jadhav', '9988776655', 20, 'Water Purifier Service', '2026-03-27 09:15:00', '2026-03-27 09:25:00', 'Out'),
(8, 'Mahesh Joshi', '9876543210', 3, 'Guest', '2026-03-27 11:30:00', '2026-03-27 12:15:00', 'Out'),
(9, 'Prakash Gade', '9112233445', 10, 'Broadband Repair', '2026-03-27 14:00:00', '2026-03-27 18:30:00', 'Out'),
(10, 'Nitin Kamble', '9223344556', 10, 'Guest', '2026-03-27 14:05:00', '2026-03-27 18:30:00', 'Out'),
(11, 'Amol Waghmare', '9334455667', 25, 'Zomato Delivery', '2026-03-27 15:00:00', '2026-03-27 21:00:00', 'Out'),
(12, 'Jyoti Sawant', '9445566778', 30, 'Personal', '2026-03-27 17:45:00', '2026-03-27 18:00:00', 'Out'),
(13, 'Sandip Thorat', '9556677889', 40, 'Maintenance', '2026-03-28 07:30:00', '2026-03-28 09:00:00', 'Out'),
(14, 'Vikram Salunkhe', '9667788990', 18, 'Courier', '2026-03-28 08:45:00', '2026-03-28 08:55:00', 'Out'),
(15, 'Rahul Bhosale', '9778899001', 22, 'Guest', '2026-03-28 10:00:00', '2026-03-28 16:00:00', 'Out'),
(16, 'Prashant Naik', '9889900112', 7, 'Amazon Delivery', '2026-03-28 11:20:00', '2026-03-28 11:40:00', 'Out'),
(17, 'Tushar Kadam', '9990011223', 35, 'Guest', '2026-03-28 12:00:00', '2026-03-28 14:30:00', 'Out'),
(18, 'Sagar Mane', '9001122334', 35, 'Personal', '2026-03-28 12:10:00', '2026-03-28 14:35:00', 'Out'),
(19, 'Abhijit Pisal', '9112233440', 11, 'AC Repairing', '2026-03-28 13:00:00', '2026-03-28 14:00:00', 'Out'),
(20, 'Deepak Gaikwad', '9223344551', 19, 'Guest', '2026-03-28 14:45:00', '2026-03-28 19:00:00', 'Out'),
(21, 'Rajendra Shelar', '9334455662', 4, 'Blinkit Delivery', '2026-03-28 15:30:00', '2026-03-28 15:45:00', 'Out'),
(22, 'Kishor Dhone', '9445566773', 9, 'Plumbing Work', '2026-03-28 16:00:00', '2026-03-28 17:30:00', 'Out'),
(23, 'Siddharth Mohite', '9556677884', 14, 'Guest', '2026-03-28 17:15:00', NULL, 'In'),
(24, 'Yogesh Lad', '9667788995', 21, 'Courier', '2026-03-28 18:00:00', '2026-03-28 18:10:00', 'Out'),
(25, 'Manoj Bankar', '9778899006', 42, 'Zomato', '2026-03-28 19:30:00', NULL, 'In'),
(26, 'Ashwin Phadke', '9889900117', 28, 'Personal', '2026-03-28 20:00:00', NULL, 'In'),
(27, 'Dhiraj Deshmukh', '9990011228', 16, 'Guest', '2026-03-28 20:15:00', NULL, 'In'),
(28, 'Suresh Belhekar', '9001122339', 33, 'Delivery', '2026-03-28 20:45:00', NULL, 'In'),
(29, 'Ajit Ranade', '9112233441', 6, 'Guest', '2026-03-28 21:00:00', NULL, 'In'),
(30, 'Narendra Dixit', '9223344552', 50, 'Relative Visit', '2026-03-28 21:15:00', NULL, 'In');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `allotments`
--
ALTER TABLE `allotments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flat_id` (`flat_id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `allotment_id` (`allotment_id`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flats`
--
ALTER TABLE `flats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `allotments`
--
ALTER TABLE `allotments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `flats`
--
ALTER TABLE `flats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `visitors`
--
ALTER TABLE `visitors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `allotments`
--
ALTER TABLE `allotments`
  ADD CONSTRAINT `allotments_ibfk_1` FOREIGN KEY (`flat_id`) REFERENCES `flats` (`id`);

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`allotment_id`) REFERENCES `allotments` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
