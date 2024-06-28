-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 27, 2024 at 06:34 PM
-- Server version: 5.7.19
-- PHP Version: 8.1.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `seizerdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
CREATE TABLE IF NOT EXISTS `asset` (
  `asset_id` int(11) NOT NULL AUTO_INCREMENT,
  `category` enum('Vehicles','Machinery','Agriculturalural Implements','Earthmover') COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('Car','Truck','Tractor','Cranes','JCB') COLLATE utf8mb4_unicode_ci NOT NULL,
  `make` enum('Maruti','Honda','Ford','Mahindra') COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` enum('Swift','Dezire','Icon','Thar') COLLATE utf8mb4_unicode_ci NOT NULL,
  `fuel_type` enum('Petrol','Diesel','Electric') COLLATE utf8mb4_unicode_ci NOT NULL,
  `engine_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chassis_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int(11) NOT NULL,
  `rto_registration_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wheel_count` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`asset_id`),
  KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asset`
--

INSERT INTO `asset` (`asset_id`, `category`, `type`, `make`, `model`, `fuel_type`, `engine_number`, `chassis_number`, `color`, `capacity`, `rto_registration_number`, `wheel_count`, `owner_id`) VALUES
(1, 'Vehicles', 'Truck', 'Maruti', 'Swift', 'Petrol', '1111111', '333333333', 'Red', 4, 'MTSDSDF', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `asset_custody_log`
--

DROP TABLE IF EXISTS `asset_custody_log`;
CREATE TABLE IF NOT EXISTS `asset_custody_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_date` date NOT NULL,
  `asset_inspection_id` int(11) NOT NULL,
  `asset_condition` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `log_type` enum('Entry','Exit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `staff` (`staff_id`),
  KEY `order` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asset_custody_log`
--

INSERT INTO `asset_custody_log` (`log_id`, `log_date`, `asset_inspection_id`, `asset_condition`, `log_type`, `staff_id`, `order_id`) VALUES
(1, '2024-06-25', 6, 'good', 'Entry', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `asset_inspection`
--

DROP TABLE IF EXISTS `asset_inspection`;
CREATE TABLE IF NOT EXISTS `asset_inspection` (
  `inspection_id` int(11) NOT NULL AUTO_INCREMENT,
  `body_condition` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `accessories_details` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_time` datetime NOT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`inspection_id`),
  KEY `order` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asset_inspection`
--

INSERT INTO `asset_inspection` (`inspection_id`, `body_condition`, `color`, `accessories_details`, `date_time`, `remarks`, `order_id`) VALUES
(6, 'good', 'red', 'sony speakers', '2024-06-27 17:49:03', 'nicec', 2);

-- --------------------------------------------------------

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
CREATE TABLE IF NOT EXISTS `billing` (
  `billing_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `total_days` float NOT NULL,
  `chahrge_per_day` float NOT NULL,
  `total_amount` decimal(10,0) NOT NULL,
  `bill_date` int(11) NOT NULL,
  `due_date` int(11) NOT NULL,
  `status` enum('Paid','Not Paid') COLLATE utf8mb4_unicode_ci NOT NULL,
  `seize_order_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `custody_charge_id` int(11) NOT NULL,
  PRIMARY KEY (`billing_id`),
  KEY `seize_order_id` (`seize_order_id`),
  KEY `staff_id` (`staff_id`),
  KEY `custody_charge_id` (`custody_charge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custodian`
--

DROP TABLE IF EXISTS `custodian`;
CREATE TABLE IF NOT EXISTS `custodian` (
  `custodian_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `proprietor_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pin` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `www` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registration_date` date NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`custodian_id`),
  UNIQUE KEY `email` (`email`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custodian`
--

INSERT INTO `custodian` (`custodian_id`, `company_name`, `proprietor_name`, `address`, `location`, `city`, `pin`, `email`, `www`, `contact_number`, `registration_date`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 'panther', 'daryl', 'dwd', 'dwd', 'dwd', '580009', 'panther@gmail.com', 'www.panther.com', '9380494515', '2024-06-01', 'Active', 4, '2024-06-27 17:42:13', '2024-06-27 17:42:13');

-- --------------------------------------------------------

--
-- Table structure for table `custody_charge`
--

DROP TABLE IF EXISTS `custody_charge`;
CREATE TABLE IF NOT EXISTS `custody_charge` (
  `charge_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('Motorcycle','Car','Trucks','Tractor','Heavy Machines','Others') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Motorcycle',
  `daily_charge` decimal(10,2) NOT NULL,
  `effect_date` date NOT NULL,
  `till_date` date DEFAULT NULL,
  `status` enum('Present','Past') COLLATE utf8mb4_unicode_ci NOT NULL,
  `log_id` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`charge_id`),
  KEY `custody_charge_ibfk_1` (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custody_charge`
--

INSERT INTO `custody_charge` (`charge_id`, `type`, `daily_charge`, `effect_date`, `till_date`, `status`, `log_id`, `created_by`, `created_at`, `updated_at`) VALUES
(35, 'Car', 39.00, '2024-06-15', '2024-06-29', 'Present', 1, NULL, '2024-06-27 18:18:20', '2024-06-27 18:18:20');

-- --------------------------------------------------------

--
-- Table structure for table `financer`
--

DROP TABLE IF EXISTS `financer`;
CREATE TABLE IF NOT EXISTS `financer` (
  `financer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pin` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ifsc_code` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `www` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registration_date` date NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`financer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `financer`
--

INSERT INTO `financer` (`financer_id`, `name`, `address`, `location`, `city`, `pin`, `email`, `ifsc_code`, `www`, `contact_number`, `registration_date`, `status`, `created_at`, `updated_at`) VALUES
(6, 'Canara Bank', 'Vidynagar Hubli', 'BVB Campus', 'Hubli', '12345566', 'minal@gmail.com', 'CAN20334', 'www.can.com', '232424234', '2024-01-01', 'Active', '2024-06-12 13:38:32', '2024-06-12 13:38:32'),
(7, 'SBI', 'Vidyagir', 'Dharwad', 'Dharwad', '45666', 'sbi@2gmail.com', '3434', 'fadf.sbi.com', '3434', '2024-06-04', 'Active', '2024-06-12 13:58:53', '2024-06-12 13:58:53');

-- --------------------------------------------------------

--
-- Table structure for table `financer_branch`
--

DROP TABLE IF EXISTS `financer_branch`;
CREATE TABLE IF NOT EXISTS `financer_branch` (
  `branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `financer_id` int(11) NOT NULL,
  `branch_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pin` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ifsc_code` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `manager_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `established_date` date NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`branch_id`),
  UNIQUE KEY `email` (`email`),
  KEY `financer_id` (`financer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `financer_branch`
--

INSERT INTO `financer_branch` (`branch_id`, `financer_id`, `branch_name`, `address`, `location`, `city`, `pin`, `email`, `ifsc_code`, `contact_number`, `manager_name`, `established_date`, `status`, `created_at`, `updated_at`) VALUES
(11, 6, 'BVB Counter', 'Vidyangar', 'BVB Cmapus', 'Hubli', '45465', 'vbvb@gmail.com', '54545', '5465656', 'Revati', '2024-06-05', 'Active', '2024-06-12 14:00:29', '2024-06-12 14:00:29');

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
CREATE TABLE IF NOT EXISTS `group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`group_id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(6, 'uday', 'user group', '2024-06-27 17:39:17', '2024-06-27 17:39:17');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
CREATE TABLE IF NOT EXISTS `loan` (
  `loan_id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `loan_amount` decimal(15,2) NOT NULL,
  `due_loan_amount` decimal(15,2) NOT NULL,
  `date_of_loan` date NOT NULL,
  `last_repayment_date` date DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `branch_id` (`branch_id`),
  KEY `owner_id` (`owner_id`),
  KEY `asset_id` (`asset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`loan_id`, `branch_id`, `owner_id`, `asset_id`, `loan_amount`, `due_loan_amount`, `date_of_loan`, `last_repayment_date`) VALUES
(6, 11, 1, 1, 567888.00, 4335.00, '2024-06-13', '2024-01-14');

-- --------------------------------------------------------

--
-- Table structure for table `loan_repayment`
--

DROP TABLE IF EXISTS `loan_repayment`;
CREATE TABLE IF NOT EXISTS `loan_repayment` (
  `repayment_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `date` date NOT NULL,
  `loan_id` int(11) NOT NULL,
  KEY `loan_id` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `owner`
--

DROP TABLE IF EXISTS `owner`;
CREATE TABLE IF NOT EXISTS `owner` (
  `owner_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `owner`
--

INSERT INTO `owner` (`owner_id`, `name`, `address`, `city`, `phone_number`, `email`) VALUES
(1, 'Ravi Sahnakar11', 'Vudyanagar', '', '23q534', 'th@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_date` date NOT NULL,
  `amount` float NOT NULL,
  `transaction_details` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bill_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `release_order_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `bill_id` (`bill_id`),
  KEY `staff_id` (`staff_id`),
  KEY `order_id` (`order_id`),
  KEY `release_order_id` (`release_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `release_order`
--

DROP TABLE IF EXISTS `release_order`;
CREATE TABLE IF NOT EXISTS `release_order` (
  `release_order_id` int(11) NOT NULL AUTO_INCREMENT,
  `release_order_date` date DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `custodian_id` int(11) DEFAULT NULL,
  `release_deadline` date DEFAULT NULL,
  PRIMARY KEY (`release_order_id`),
  KEY `order_id` (`agent_id`),
  KEY `agent_id` (`agent_id`),
  KEY `branch_id` (`branch_id`),
  KEY `owner_id` (`owner_id`),
  KEY `loan_id` (`loan_id`),
  KEY `custodian_id` (`custodian_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seizer_agent`
--

DROP TABLE IF EXISTS `seizer_agent`;
CREATE TABLE IF NOT EXISTS `seizer_agent` (
  `agent_id` int(11) NOT NULL AUTO_INCREMENT,
  `financer_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `agent_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_number` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hired_date` date NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`agent_id`),
  UNIQUE KEY `email` (`email`),
  KEY `financer_id` (`financer_id`),
  KEY `financer_branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seizer_agent`
--

INSERT INTO `seizer_agent` (`agent_id`, `financer_id`, `branch_id`, `agent_name`, `address`, `city`, `contact_number`, `email`, `hired_date`, `status`, `created_at`, `updated_at`) VALUES
(17, 6, 11, 'uday', 'dwd', 'dwd', '9380494515', 'uday@gmail.com', '2024-06-06', 'Active', '2024-06-27 17:36:05', '2024-06-27 17:36:05');

-- --------------------------------------------------------

--
-- Table structure for table `seize_order`
--

DROP TABLE IF EXISTS `seize_order`;
CREATE TABLE IF NOT EXISTS `seize_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_date` date DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `custodian_id` int(11) DEFAULT NULL,
  `handover_last_date` date DEFAULT NULL,
  `repayment_deadline` date NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `agent_id` (`agent_id`),
  KEY `branch_id` (`branch_id`),
  KEY `owner_id` (`owner_id`),
  KEY `loan_id` (`loan_id`),
  KEY `custodian_id` (`custodian_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seize_order`
--

INSERT INTO `seize_order` (`order_id`, `order_date`, `agent_id`, `branch_id`, `owner_id`, `loan_id`, `custodian_id`, `handover_last_date`, `repayment_deadline`) VALUES
(2, '2024-06-26', 17, 11, 1, 6, 2, '2024-06-29', '2024-07-01');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `staff_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` blob,
  `date_of_birth` date DEFAULT NULL,
  `date_of_hire` date DEFAULT NULL,
  `date_of_creation` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `date_of_modification` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int(11) DEFAULT NULL,
  `position` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `mobile` (`mobile`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `company_id`, `name`, `address`, `city`, `email`, `mobile`, `gender`, `photo`, `date_of_birth`, `date_of_hire`, `date_of_creation`, `date_of_modification`, `created_by`, `position`) VALUES
(2, 2, 'uday', 'dwd', 'dwd', 'uday@gmail.com', '9380494515', 'male', NULL, '2001-09-05', '2024-06-01', '2024-06-27 17:52:25', '2024-06-27 17:52:25', 4, 'asset inspector');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive','suspended') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `role` enum('admin','user','guest') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `group_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `mobile` (`mobile`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `name`, `email`, `mobile`, `password`, `status`, `role`, `group_id`, `created_at`, `updated_at`) VALUES
(4, 'uday', 'uday@gmail.com', '9380494515', '12345', 'active', 'user', 6, '2024-06-27 17:39:38', '2024-06-27 17:39:38');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asset`
--
ALTER TABLE `asset`
  ADD CONSTRAINT `asset_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`) ON DELETE CASCADE;

--
-- Constraints for table `asset_custody_log`
--
ALTER TABLE `asset_custody_log`
  ADD CONSTRAINT `asset_custody_log_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `seize_order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asset_custody_log_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `asset_inspection`
--
ALTER TABLE `asset_inspection`
  ADD CONSTRAINT `asset_inspection_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `seize_order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `billing`
--
ALTER TABLE `billing`
  ADD CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`custody_charge_id`) REFERENCES `custody_charge` (`charge_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `billing_ibfk_2` FOREIGN KEY (`seize_order_id`) REFERENCES `seize_order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `billing_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `custodian`
--
ALTER TABLE `custodian`
  ADD CONSTRAINT `custodian_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `custody_charge`
--
ALTER TABLE `custody_charge`
  ADD CONSTRAINT `custody_charge_ibfk_1` FOREIGN KEY (`log_id`) REFERENCES `asset_custody_log` (`log_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `financer_branch`
--
ALTER TABLE `financer_branch`
  ADD CONSTRAINT `financer_branch_ibfk_1` FOREIGN KEY (`financer_id`) REFERENCES `financer` (`financer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `financer_branch` (`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`asset_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `loan_ibfk_3` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `loan_repayment`
--
ALTER TABLE `loan_repayment`
  ADD CONSTRAINT `loan_repayment_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `seize_order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`bill_id`) REFERENCES `billing` (`billing_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`release_order_id`) REFERENCES `release_order` (`release_order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_ibfk_4` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `release_order`
--
ALTER TABLE `release_order`
  ADD CONSTRAINT `release_order_ibfk_1` FOREIGN KEY (`agent_id`) REFERENCES `seizer_agent` (`agent_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `release_order_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `financer_branch` (`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `release_order_ibfk_3` FOREIGN KEY (`custodian_id`) REFERENCES `custodian` (`custodian_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `release_order_ibfk_4` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `release_order_ibfk_5` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `seizer_agent`
--
ALTER TABLE `seizer_agent`
  ADD CONSTRAINT `fk_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `financer_branch` (`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_financer_id` FOREIGN KEY (`financer_id`) REFERENCES `financer` (`financer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `seize_order`
--
ALTER TABLE `seize_order`
  ADD CONSTRAINT `seize_order_ibfk_1` FOREIGN KEY (`agent_id`) REFERENCES `seizer_agent` (`agent_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `seize_order_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `financer_branch` (`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `seize_order_ibfk_3` FOREIGN KEY (`custodian_id`) REFERENCES `custodian` (`custodian_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `seize_order_ibfk_4` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `seize_order_ibfk_5` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `custodian` (`custodian_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
