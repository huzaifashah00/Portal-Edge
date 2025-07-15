-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 14, 2024 at 04:47 PM
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
-- Database: `portal-edge`
--

-- --------------------------------------------------------

--
-- Table structure for table `academic_calendars`
--

CREATE TABLE `academic_calendars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `title` varchar(512) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `addons`
--

CREATE TABLE `addons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `price` double(8,4) NOT NULL COMMENT 'Daily price',
  `feature_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 => Inactive, 1 => Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `addon_subscriptions`
--

CREATE TABLE `addon_subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subscription_id` bigint(20) UNSIGNED DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `feature_id` bigint(20) UNSIGNED NOT NULL,
  `price` double(64,4) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0 => Discontinue next billing, 1 => Continue',
  `payment_transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcement_classes`
--

CREATE TABLE `announcement_classes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `announcement_id` bigint(20) UNSIGNED DEFAULT NULL,
  `class_section_id` bigint(20) UNSIGNED DEFAULT NULL,
  `class_subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

CREATE TABLE `assignments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `class_subject_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `instructions` varchar(1024) DEFAULT NULL,
  `due_date` datetime NOT NULL,
  `points` int(11) DEFAULT NULL,
  `resubmission` tinyint(1) NOT NULL DEFAULT 0,
  `extra_days_for_resubmission` int(11) DEFAULT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL COMMENT 'teacher_user_id',
  `edited_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'teacher_user_id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assignment_submissions`
--

CREATE TABLE `assignment_submissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `assignment_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `feedback` text DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 = Pending/In Review , 1 = Accepted , 2 = Rejected , 3 = Resubmitted',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '0=Absent, 1=Present',
  `date` date NOT NULL,
  `remark` varchar(512) NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(512) NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `certificate_templates`
--

CREATE TABLE `certificate_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `page_layout` varchar(191) NOT NULL COMMENT 'A4 Portrait, A4 Landscape, Custom',
  `height` double(8,2) DEFAULT NULL,
  `width` double(8,2) DEFAULT NULL,
  `user_image_shape` varchar(191) NOT NULL COMMENT 'Round, Square',
  `image_size` double(8,2) DEFAULT NULL,
  `background_image` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `fields` varchar(191) DEFAULT NULL,
  `style` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`style`)),
  `type` varchar(191) DEFAULT NULL COMMENT 'Student, Staff',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(512) NOT NULL,
  `include_semesters` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 - no 1 - yes',
  `medium_id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED DEFAULT NULL,
  `stream_id` bigint(20) UNSIGNED DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`id`, `name`, `include_semesters`, `medium_id`, `shift_id`, `stream_id`, `school_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '9', 0, 1, NULL, NULL, 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(2, '10', 0, 1, NULL, NULL, 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `class_groups`
--

CREATE TABLE `class_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `class_ids` varchar(191) DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `class_sections`
--

CREATE TABLE `class_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `medium_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `class_sections`
--

INSERT INTO `class_sections` (`id`, `class_id`, `section_id`, `medium_id`, `school_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 1, 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(2, 1, 2, 1, 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(3, 2, 1, 1, 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(4, 2, 2, 1, 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(5, 2, 3, 1, 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `class_subjects`
--

CREATE TABLE `class_subjects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `subject_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(32) NOT NULL COMMENT 'Compulsory / Elective',
  `elective_subject_group_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'if type=Elective',
  `semester_id` bigint(20) UNSIGNED DEFAULT NULL,
  `virtual_semester_id` int(11) GENERATED ALWAYS AS (case when `semester_id` is not null then `semester_id` else 0 end) VIRTUAL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `class_teachers`
--

CREATE TABLE `class_teachers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `teacher_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `compulsory_fees`
--

CREATE TABLE `compulsory_fees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `payment_transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('Full Payment','Installment Payment') NOT NULL,
  `installment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mode` enum('Cash','Cheque','Online') NOT NULL,
  `cheque_no` varchar(191) DEFAULT NULL,
  `amount` double(8,2) NOT NULL,
  `due_charges` double(8,2) DEFAULT NULL,
  `fees_paid_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('Success','Pending','Failed') NOT NULL,
  `date` date NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `elective_subject_groups`
--

CREATE TABLE `elective_subject_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `total_subjects` int(11) NOT NULL,
  `total_selectable_subjects` int(11) NOT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `semester_id` bigint(20) UNSIGNED DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `publish` tinyint(4) NOT NULL DEFAULT 0,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_marks`
--

CREATE TABLE `exam_marks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `exam_timetable_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `class_subject_id` bigint(20) UNSIGNED NOT NULL,
  `obtained_marks` double(8,2) NOT NULL,
  `teacher_review` varchar(1024) DEFAULT NULL,
  `passing_status` tinyint(1) NOT NULL COMMENT '1=Pass, 0=Fail',
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `grade` tinytext DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_results`
--

CREATE TABLE `exam_results` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `exam_id` bigint(20) UNSIGNED NOT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `total_marks` int(11) NOT NULL,
  `obtained_marks` double(8,2) NOT NULL,
  `percentage` double(8,2) NOT NULL,
  `grade` tinytext NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0 -> Failed, 1 -> Pass',
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_timetables`
--

CREATE TABLE `exam_timetables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `exam_id` bigint(20) UNSIGNED NOT NULL,
  `class_subject_id` bigint(20) UNSIGNED NOT NULL,
  `total_marks` double(8,2) NOT NULL,
  `passing_marks` double(8,2) NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ref_no` varchar(191) DEFAULT NULL,
  `staff_id` bigint(20) UNSIGNED DEFAULT NULL,
  `basic_salary` bigint(20) NOT NULL DEFAULT 0,
  `paid_leaves` double(8,2) NOT NULL DEFAULT 0.00,
  `month` bigint(20) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `title` varchar(512) NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `amount` double(64,2) NOT NULL,
  `date` date NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `extra_student_datas`
--

CREATE TABLE `extra_student_datas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `form_field_id` bigint(20) UNSIGNED NOT NULL,
  `data` text DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `school_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE `features` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `is_default` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 => No, 1 => Yes',
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `features`
--

INSERT INTO `features` (`id`, `name`, `is_default`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Student Management', 1, 1, '2024-12-14 14:28:56', '2024-12-14 14:29:48'),
(2, 'Academics Management', 1, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(3, 'Slider Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(4, 'Teacher Management', 1, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(5, 'Session Year Management', 1, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(6, 'Holiday Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(7, 'Timetable Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(8, 'Attendance Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(9, 'Exam Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(10, 'Lesson Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(11, 'Assignment Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(12, 'Announcement Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(13, 'Staff Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(14, 'Expense Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(15, 'Staff Leave Management', 0, 1, '2024-12-14 14:29:48', '2024-12-14 14:29:48'),
(16, 'Fees Management', 0, 1, '2024-12-14 14:29:49', '2024-12-14 14:29:49'),
(17, 'School Gallery Management', 0, 1, '2024-12-14 14:29:49', '2024-12-14 14:29:49'),
(18, 'ID Card - Certificate Generation', 0, 1, '2024-12-14 14:29:49', '2024-12-14 14:29:49'),
(19, 'Website Management', 0, 0, '2024-12-14 14:29:49', '2024-12-14 14:29:49');

-- --------------------------------------------------------

--
-- Table structure for table `feature_sections`
--

CREATE TABLE `feature_sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `heading` varchar(191) DEFAULT NULL,
  `rank` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feature_section_lists`
--

CREATE TABLE `feature_section_lists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `feature_section_id` bigint(20) UNSIGNED NOT NULL,
  `feature` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fees`
--

CREATE TABLE `fees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `due_date` date NOT NULL,
  `due_charges` double(8,2) NOT NULL COMMENT 'in percentage (%)',
  `due_charges_amount` double(8,2) NOT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fees_advance`
--

CREATE TABLE `fees_advance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `compulsory_fee_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `parent_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `amount` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fees_class_types`
--

CREATE TABLE `fees_class_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `fees_id` bigint(20) UNSIGNED NOT NULL,
  `fees_type_id` bigint(20) UNSIGNED NOT NULL,
  `amount` double(64,2) NOT NULL,
  `optional` tinyint(1) NOT NULL COMMENT '0 - No, 1 - Yes',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fees_installments`
--

CREATE TABLE `fees_installments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `due_date` date NOT NULL,
  `due_charges_type` enum('fixed','percentage') NOT NULL DEFAULT 'percentage',
  `due_charges` int(11) NOT NULL,
  `fees_id` bigint(20) UNSIGNED NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fees_paids`
--

CREATE TABLE `fees_paids` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fees_id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `is_fully_paid` tinyint(1) NOT NULL COMMENT '0 - No, 1 - Yes',
  `is_used_installment` tinyint(1) NOT NULL COMMENT '0 - No, 1 - Yes',
  `amount` double(8,2) NOT NULL,
  `date` date NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fees_types`
--

CREATE TABLE `fees_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `modal_type` varchar(191) NOT NULL,
  `modal_id` bigint(20) UNSIGNED NOT NULL,
  `file_name` varchar(1024) DEFAULT NULL,
  `file_thumbnail` varchar(1024) DEFAULT NULL,
  `type` tinytext NOT NULL COMMENT '1 = File Upload, 2 = Youtube Link, 3 = Video Upload, 4 = Other Link',
  `file_url` varchar(1024) NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `form_fields`
--

CREATE TABLE `form_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `type` varchar(128) NOT NULL COMMENT 'text,number,textarea,dropdown,checkbox,radio,fileupload',
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `default_values` text DEFAULT NULL COMMENT 'values of radio,checkbox,dropdown,etc',
  `other` text DEFAULT NULL COMMENT 'extra HTML attributes',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `galleries`
--

CREATE TABLE `galleries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `thumbnail` varchar(191) DEFAULT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `starting_range` double(8,2) NOT NULL,
  `ending_range` double(8,2) NOT NULL,
  `grade` tinytext NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guidances`
--

CREATE TABLE `guidances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `link` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(512) NOT NULL,
  `code` varchar(64) NOT NULL,
  `file` varchar(512) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1=>active',
  `is_rtl` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `file`, `status`, `is_rtl`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', 'en.json', 1, 0, '2024-12-14 14:29:49', '2024-12-14 14:29:49');

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

CREATE TABLE `leaves` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `reason` varchar(191) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0 => Pending, 1 => Approved, 2 => Rejected',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `leave_master_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leave_details`
--

CREATE TABLE `leave_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `leave_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `type` varchar(191) NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leave_masters`
--

CREATE TABLE `leave_masters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `leaves` double(8,2) NOT NULL COMMENT 'Leaves per month',
  `holiday` varchar(191) NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(512) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `class_subject_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lesson_topics`
--

CREATE TABLE `lesson_topics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `lesson_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mediums`
--

CREATE TABLE `mediums` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(512) NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mediums`
--

INSERT INTO `mediums` (`id`, `name`, `school_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'English', 1, NULL, '2024-12-14 14:29:55', '2024-12-14 14:29:55'),
(2, 'Hindi', 1, NULL, '2024-12-14 14:29:55', '2024-12-14 14:29:55'),
(3, 'Gujarati', 1, NULL, '2024-12-14 14:29:55', '2024-12-14 14:29:55');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_04_01_091033_create_permission_tables', 1),
(6, '2022_04_01_105826_all_tables', 1),
(7, '2023_11_16_134449_version1-0-1', 1),
(8, '2023_12_07_120054_version1_1_0', 1),
(9, '2024_01_30_092228_version1_2_0', 1),
(10, '2024_03_12_173521_version1_3_0', 1),
(11, '2024_05_21_094714_version1_3_2', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 3),
(2, 'App\\Models\\User', 7),
(2, 'App\\Models\\User', 8),
(2, 'App\\Models\\User', 9),
(3, 'App\\Models\\User', 6),
(4, 'App\\Models\\User', 4),
(5, 'App\\Models\\User', 5);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) NOT NULL,
  `message` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `send_to` varchar(191) NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exams`
--

CREATE TABLE `online_exams` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `class_subject_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(128) NOT NULL,
  `exam_key` bigint(20) NOT NULL,
  `duration` int(11) NOT NULL COMMENT 'in minutes',
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exam_questions`
--

CREATE TABLE `online_exam_questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `class_subject_id` bigint(20) UNSIGNED NOT NULL,
  `question` varchar(1024) NOT NULL,
  `image_url` varchar(1024) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `last_edited_by` bigint(20) UNSIGNED NOT NULL COMMENT 'teacher_user_id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exam_question_choices`
--

CREATE TABLE `online_exam_question_choices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `online_exam_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `marks` int(11) DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exam_question_options`
--

CREATE TABLE `online_exam_question_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `option` varchar(1024) NOT NULL,
  `is_answer` tinyint(4) NOT NULL COMMENT '1 - yes, 0 - no',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_exam_student_answers`
--

CREATE TABLE `online_exam_student_answers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `online_exam_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `option_id` bigint(20) UNSIGNED NOT NULL,
  `submitted_date` date NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `optional_fees`
--

CREATE TABLE `optional_fees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `class_id` bigint(20) UNSIGNED NOT NULL,
  `payment_transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fees_class_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mode` enum('Cash','Cheque','Online') NOT NULL,
  `cheque_no` varchar(191) DEFAULT NULL,
  `amount` double(8,2) NOT NULL,
  `fees_paid_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date` date NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('Success','Pending','Failed') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `tagline` varchar(191) DEFAULT NULL,
  `student_charge` double(8,4) NOT NULL DEFAULT 0.0000,
  `staff_charge` double(8,4) NOT NULL DEFAULT 0.0000,
  `days` int(11) NOT NULL DEFAULT 1,
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '0 => Prepaid, 1 => Postpaid',
  `no_of_students` int(11) NOT NULL DEFAULT 0,
  `no_of_staffs` int(11) NOT NULL DEFAULT 0,
  `charges` double(64,4) NOT NULL DEFAULT 0.0000,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 => Unpublished, 1 => Published',
  `is_trial` int(11) NOT NULL DEFAULT 0,
  `highlight` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 => No, 1 => Yes',
  `rank` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `name`, `description`, `tagline`, `student_charge`, `staff_charge`, `days`, `type`, `no_of_students`, `no_of_staffs`, `charges`, `status`, `is_trial`, `highlight`, `rank`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Pro', 'Unlimited Features', 'Best plan for school', 0.0250, 0.0250, 90, 1, 0, 0, 0.0000, 1, 0, 0, 0, '2024-12-14 14:29:57', '2024-12-14 14:29:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `package_features`
--

CREATE TABLE `package_features` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `package_id` bigint(20) UNSIGNED NOT NULL,
  `feature_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `package_features`
--

INSERT INTO `package_features` (`id`, `package_id`, `feature_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(2, 1, 2, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(3, 1, 3, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(4, 1, 4, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(5, 1, 5, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(6, 1, 6, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(7, 1, 7, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(8, 1, 8, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(9, 1, 9, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(10, 1, 10, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(11, 1, 11, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(12, 1, 12, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(13, 1, 13, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(14, 1, 14, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(15, 1, 15, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(16, 1, 16, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(17, 1, 17, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(18, 1, 18, '2024-12-14 14:29:57', '2024-12-14 14:29:57'),
(19, 1, 19, '2024-12-14 14:29:57', '2024-12-14 14:29:57');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_configurations`
--

CREATE TABLE `payment_configurations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_method` varchar(191) NOT NULL,
  `api_key` varchar(191) NOT NULL,
  `secret_key` varchar(191) NOT NULL,
  `webhook_secret_key` varchar(191) NOT NULL,
  `currency_code` varchar(128) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 - Disabled, 1 - Enabled',
  `school_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_transactions`
--

CREATE TABLE `payment_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `amount` double(64,2) NOT NULL,
  `payment_gateway` varchar(191) NOT NULL,
  `order_id` varchar(191) DEFAULT NULL COMMENT 'order_id / payment_intent_id',
  `payment_id` varchar(191) DEFAULT NULL,
  `payment_signature` varchar(191) DEFAULT NULL,
  `payment_status` enum('failed','succeed','pending') NOT NULL,
  `school_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll_settings`
--

CREATE TABLE `payroll_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `amount` double DEFAULT NULL,
  `percentage` double(8,2) DEFAULT NULL,
  `type` varchar(191) NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'role-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(2, 'role-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(3, 'role-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(4, 'role-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(5, 'medium-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(6, 'medium-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(7, 'medium-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(8, 'medium-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(9, 'section-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(10, 'section-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(11, 'section-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(12, 'section-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(13, 'class-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(14, 'class-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(15, 'class-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(16, 'class-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(17, 'class-section-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(18, 'class-section-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(19, 'class-section-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(20, 'class-section-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(21, 'subject-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(22, 'subject-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(23, 'subject-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(24, 'subject-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(25, 'teacher-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(26, 'teacher-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(27, 'teacher-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(28, 'teacher-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(29, 'guardian-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(30, 'guardian-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(31, 'guardian-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(32, 'guardian-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(33, 'session-year-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(34, 'session-year-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(35, 'session-year-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(36, 'session-year-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(37, 'student-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(38, 'student-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(39, 'student-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(40, 'student-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(41, 'timetable-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(42, 'timetable-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(43, 'timetable-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(44, 'timetable-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(45, 'attendance-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(46, 'attendance-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(47, 'attendance-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(48, 'attendance-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(49, 'holiday-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(50, 'holiday-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(51, 'holiday-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(52, 'holiday-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(53, 'announcement-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(54, 'announcement-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(55, 'announcement-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(56, 'announcement-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(57, 'slider-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(58, 'slider-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(59, 'slider-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(60, 'slider-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(61, 'promote-student-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(62, 'promote-student-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(63, 'promote-student-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(64, 'promote-student-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(65, 'language-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(66, 'language-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(67, 'language-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(68, 'language-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(69, 'lesson-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(70, 'lesson-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(71, 'lesson-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(72, 'lesson-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(73, 'topic-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(74, 'topic-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(75, 'topic-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(76, 'topic-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(77, 'schools-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(78, 'schools-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(79, 'schools-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(80, 'schools-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(81, 'form-fields-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(82, 'form-fields-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(83, 'form-fields-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(84, 'form-fields-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(85, 'grade-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(86, 'grade-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(87, 'grade-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(88, 'grade-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(89, 'package-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(90, 'package-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(91, 'package-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(92, 'package-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(93, 'addons-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(94, 'addons-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(95, 'addons-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(96, 'addons-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(97, 'guidance-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(98, 'guidance-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(99, 'guidance-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(100, 'guidance-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(101, 'assignment-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(102, 'assignment-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(103, 'assignment-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(104, 'assignment-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(105, 'assignment-submission', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(106, 'exam-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(107, 'exam-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(108, 'exam-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(109, 'exam-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(110, 'exam-timetable-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(111, 'exam-timetable-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(112, 'exam-timetable-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(113, 'exam-timetable-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(114, 'exam-upload-marks', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(115, 'exam-result', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(116, 'exam-result-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(117, 'system-setting-manage', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(118, 'fcm-setting-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(119, 'email-setting-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(120, 'privacy-policy', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(121, 'contact-us', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(122, 'about-us', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(123, 'terms-condition', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(124, 'class-teacher', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(125, 'student-reset-password', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(126, 'reset-password-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(127, 'student-change-password', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(128, 'fees-classes', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(129, 'fees-paid', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(130, 'fees-config', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(131, 'school-setting-manage', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(132, 'app-settings', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(133, 'subscription-view', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(134, 'online-exam-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(135, 'online-exam-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(136, 'online-exam-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(137, 'online-exam-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(138, 'online-exam-questions-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(139, 'online-exam-questions-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(140, 'online-exam-questions-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(141, 'online-exam-questions-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(142, 'online-exam-result-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(143, 'fees-type-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(144, 'fees-type-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(145, 'fees-type-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(146, 'fees-type-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(147, 'fees-class-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(148, 'fees-class-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(149, 'fees-class-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(150, 'fees-class-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(151, 'staff-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(152, 'staff-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(153, 'staff-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(154, 'staff-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(155, 'expense-category-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(156, 'expense-category-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(157, 'expense-category-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(158, 'expense-category-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(159, 'expense-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(160, 'expense-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(161, 'expense-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(162, 'expense-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(163, 'semester-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(164, 'semester-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(165, 'semester-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(166, 'semester-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(167, 'payroll-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(168, 'payroll-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(169, 'payroll-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(170, 'payroll-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(171, 'stream-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(172, 'stream-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(173, 'stream-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(174, 'stream-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(175, 'shift-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(176, 'shift-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(177, 'shift-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(178, 'shift-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(179, 'leave-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(180, 'leave-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(181, 'leave-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(182, 'leave-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(183, 'approve-leave', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(184, 'faqs-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(185, 'faqs-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(186, 'faqs-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(187, 'faqs-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(188, 'fcm-setting-manage', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(189, 'fees-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(190, 'fees-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(191, 'fees-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(192, 'fees-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(193, 'transfer-student-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(194, 'transfer-student-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(195, 'transfer-student-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(196, 'transfer-student-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(197, 'gallery-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(198, 'gallery-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(199, 'gallery-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(200, 'gallery-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(201, 'notification-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(202, 'notification-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(203, 'notification-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(204, 'notification-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(205, 'payment-settings', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(206, 'subscription-settings', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(207, 'subscription-change-bills', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(208, 'school-terms-condition', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(209, 'id-card-settings', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(210, 'subscription-bill-payment', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(211, 'web-settings', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(212, 'certificate-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(213, 'certificate-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(214, 'certificate-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(215, 'certificate-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(216, 'payroll-settings-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(217, 'payroll-settings-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(218, 'payroll-settings-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(219, 'payroll-settings-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(220, 'school-web-settings', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(221, 'class-group-list', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(222, 'class-group-create', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(223, 'class-group-edit', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(224, 'class-group-delete', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45'),
(225, 'email-template', 'web', '2024-12-14 14:29:33', '2024-12-14 14:30:45');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promote_students`
--

CREATE TABLE `promote_students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `result` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1=>Pass,0=>fail',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1=>continue,0=>leave',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `school_id` bigint(20) UNSIGNED DEFAULT NULL,
  `custom_role` tinyint(1) NOT NULL DEFAULT 1,
  `editable` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `school_id`, `custom_role`, `editable`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'web', NULL, 0, 0, '2024-12-14 14:29:33', '2024-12-14 14:29:33'),
(2, 'School Admin', 'web', NULL, 0, 0, '2024-12-14 14:29:36', '2024-12-14 14:29:36'),
(3, 'Teacher', 'web', NULL, 1, 1, '2024-12-14 14:29:45', '2024-12-14 14:29:45'),
(4, 'Guardian', 'web', 1, 0, 0, '2024-12-14 14:29:51', '2024-12-14 14:29:51'),
(5, 'Student', 'web', 1, 0, 0, '2024-12-14 14:29:51', '2024-12-14 14:29:51'),
(6, 'Teacher', 'web', 1, 0, 1, '2024-12-14 14:29:51', '2024-12-14 14:29:51'),
(7, 'Guardian', 'web', 2, 0, 0, '2024-12-14 14:29:53', '2024-12-14 14:29:53'),
(8, 'Student', 'web', 2, 0, 0, '2024-12-14 14:29:53', '2024-12-14 14:29:53'),
(9, 'Teacher', 'web', 2, 0, 1, '2024-12-14 14:29:53', '2024-12-14 14:29:53'),
(10, 'Guardian', 'web', 3, 0, 0, '2024-12-14 14:34:09', '2024-12-14 14:34:09'),
(11, 'Student', 'web', 3, 0, 0, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(12, 'Teacher', 'web', 3, 0, 1, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(13, 'Guardian', 'web', 4, 0, 0, '2024-12-14 14:55:59', '2024-12-14 14:55:59'),
(14, 'Student', 'web', 4, 0, 0, '2024-12-14 14:55:59', '2024-12-14 14:55:59'),
(15, 'Teacher', 'web', 4, 0, 1, '2024-12-14 14:55:59', '2024-12-14 14:55:59'),
(16, 'Guardian', 'web', 5, 0, 0, '2024-12-14 15:01:44', '2024-12-14 15:01:44'),
(17, 'Student', 'web', 5, 0, 0, '2024-12-14 15:01:44', '2024-12-14 15:01:44'),
(18, 'Teacher', 'web', 5, 0, 1, '2024-12-14 15:01:44', '2024-12-14 15:01:44');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(17, 3),
(17, 6),
(17, 9),
(17, 12),
(17, 15),
(17, 18),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2),
(29, 2),
(30, 2),
(31, 2),
(32, 2),
(33, 2),
(34, 2),
(35, 2),
(36, 2),
(37, 2),
(37, 3),
(37, 6),
(37, 9),
(37, 12),
(37, 15),
(37, 18),
(38, 2),
(39, 2),
(40, 2),
(41, 2),
(41, 3),
(41, 6),
(41, 9),
(41, 12),
(41, 15),
(41, 18),
(42, 2),
(43, 2),
(44, 2),
(45, 2),
(45, 3),
(46, 3),
(47, 3),
(48, 3),
(49, 2),
(49, 3),
(49, 6),
(49, 9),
(49, 12),
(49, 15),
(49, 18),
(50, 2),
(51, 2),
(52, 2),
(53, 2),
(53, 3),
(53, 6),
(53, 9),
(53, 12),
(53, 15),
(53, 18),
(54, 2),
(54, 3),
(54, 6),
(54, 9),
(54, 12),
(54, 15),
(54, 18),
(55, 2),
(55, 3),
(55, 6),
(55, 9),
(55, 12),
(55, 15),
(55, 18),
(56, 2),
(56, 3),
(56, 6),
(56, 9),
(56, 12),
(56, 15),
(56, 18),
(57, 2),
(58, 2),
(59, 2),
(60, 2),
(61, 2),
(62, 2),
(63, 2),
(64, 2),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 3),
(69, 6),
(69, 9),
(69, 12),
(69, 15),
(69, 18),
(70, 3),
(70, 6),
(70, 9),
(70, 12),
(70, 15),
(70, 18),
(71, 3),
(71, 6),
(71, 9),
(71, 12),
(71, 15),
(71, 18),
(72, 3),
(72, 6),
(72, 9),
(72, 12),
(72, 15),
(72, 18),
(73, 3),
(73, 6),
(73, 9),
(73, 12),
(73, 15),
(73, 18),
(74, 3),
(74, 6),
(74, 9),
(74, 12),
(74, 15),
(74, 18),
(75, 3),
(75, 6),
(75, 9),
(75, 12),
(75, 15),
(75, 18),
(76, 3),
(76, 6),
(76, 9),
(76, 12),
(76, 15),
(76, 18),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 2),
(82, 2),
(83, 2),
(84, 2),
(85, 2),
(86, 2),
(87, 2),
(88, 2),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1),
(98, 1),
(99, 1),
(100, 1),
(101, 3),
(101, 6),
(101, 9),
(101, 12),
(101, 15),
(101, 18),
(102, 3),
(102, 6),
(102, 9),
(102, 12),
(102, 15),
(102, 18),
(103, 3),
(103, 6),
(103, 9),
(103, 12),
(103, 15),
(103, 18),
(104, 3),
(104, 6),
(104, 9),
(104, 12),
(104, 15),
(104, 18),
(105, 2),
(105, 3),
(105, 6),
(105, 9),
(105, 12),
(105, 15),
(105, 18),
(106, 2),
(107, 2),
(108, 2),
(109, 2),
(110, 2),
(111, 2),
(113, 2),
(114, 3),
(115, 2),
(115, 3),
(116, 2),
(117, 1),
(118, 1),
(119, 1),
(120, 1),
(121, 1),
(122, 1),
(123, 1),
(125, 2),
(126, 2),
(127, 2),
(129, 2),
(130, 2),
(131, 2),
(132, 1),
(133, 1),
(134, 2),
(134, 3),
(134, 6),
(134, 9),
(134, 12),
(134, 15),
(134, 18),
(135, 2),
(135, 3),
(135, 6),
(135, 9),
(135, 12),
(135, 15),
(135, 18),
(136, 2),
(136, 3),
(136, 6),
(136, 9),
(136, 12),
(136, 15),
(136, 18),
(137, 2),
(137, 3),
(137, 6),
(137, 9),
(137, 12),
(137, 15),
(137, 18),
(138, 2),
(138, 3),
(138, 6),
(138, 9),
(138, 12),
(138, 15),
(138, 18),
(139, 2),
(139, 3),
(139, 6),
(139, 9),
(139, 12),
(139, 15),
(139, 18),
(140, 2),
(140, 3),
(140, 6),
(140, 9),
(140, 12),
(140, 15),
(140, 18),
(141, 2),
(141, 3),
(141, 6),
(141, 9),
(141, 12),
(141, 15),
(141, 18),
(142, 2),
(142, 3),
(142, 6),
(142, 9),
(142, 12),
(142, 15),
(142, 18),
(143, 2),
(144, 2),
(145, 2),
(146, 2),
(147, 2),
(148, 2),
(149, 2),
(150, 2),
(151, 1),
(151, 2),
(152, 1),
(152, 2),
(153, 1),
(153, 2),
(154, 1),
(154, 2),
(155, 2),
(156, 2),
(157, 2),
(158, 2),
(159, 2),
(160, 2),
(161, 2),
(162, 2),
(163, 2),
(164, 2),
(165, 2),
(166, 2),
(167, 2),
(168, 2),
(169, 2),
(170, 2),
(171, 2),
(172, 2),
(173, 2),
(174, 2),
(175, 2),
(176, 2),
(177, 2),
(178, 2),
(179, 3),
(179, 6),
(179, 9),
(179, 12),
(179, 15),
(179, 18),
(180, 3),
(180, 6),
(180, 9),
(180, 12),
(180, 15),
(180, 18),
(181, 3),
(181, 6),
(181, 9),
(181, 12),
(181, 15),
(181, 18),
(182, 3),
(182, 6),
(182, 9),
(182, 12),
(182, 15),
(182, 18),
(183, 2),
(184, 1),
(184, 2),
(185, 1),
(185, 2),
(186, 1),
(186, 2),
(187, 1),
(187, 2),
(188, 1),
(189, 2),
(190, 2),
(191, 2),
(192, 2),
(193, 2),
(194, 2),
(195, 2),
(196, 2),
(197, 2),
(198, 2),
(199, 2),
(200, 2),
(201, 2),
(202, 2),
(204, 2),
(206, 1),
(207, 1),
(208, 1),
(209, 2),
(210, 1),
(211, 1),
(212, 2),
(213, 2),
(214, 2),
(215, 2),
(216, 2),
(217, 2),
(218, 2),
(219, 2),
(220, 2),
(221, 2),
(222, 2),
(223, 2),
(224, 2),
(225, 2);

-- --------------------------------------------------------

--
-- Table structure for table `schools`
--

CREATE TABLE `schools` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `address` varchar(191) NOT NULL,
  `support_phone` varchar(191) NOT NULL,
  `support_email` varchar(191) NOT NULL,
  `tagline` varchar(191) NOT NULL,
  `logo` varchar(191) NOT NULL,
  `admin_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'user_id',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 => Deactivate, 1 => Active',
  `domain` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `schools`
--

INSERT INTO `schools` (`id`, `name`, `address`, `support_phone`, `support_email`, `tagline`, `logo`, `admin_id`, `status`, `domain`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'School 1', 'Bhuj', '1234567890', 'school1@gmail.com', 'We Provide Best Education', 'school/logo.png', 2, 0, NULL, '2024-12-14 14:29:50', '2024-12-14 14:39:49', '2024-12-14 14:39:49'),
(2, 'School 2', 'Bhuj', '1234567890', 'school2@gmail.com', 'We Provide Best Education', 'school/logo.png', 3, 0, NULL, '2024-12-14 14:29:50', '2024-12-14 14:39:44', '2024-12-14 14:39:44'),
(3, 'University of Lahore', 'Sargodha', '03441179414', 'huzaifashah4500@gmail.com', '#uni', 'school/675d9761606db7.201472691734186849.png', 7, 1, 'uol', '2024-12-14 14:34:09', '2024-12-14 14:39:37', NULL),
(4, 'Qauid Public Model School', 'Sargodha', '12345678', 'huzaifa.appdev@gmail.com', '#uni', 'school/675d9c7f202cf1.446636951734188159.png', 8, 0, 'QPM', '2024-12-14 14:55:59', '2024-12-14 15:07:24', '2024-12-14 15:07:24'),
(5, 'School1', 'SGD', '2345678556789', '70162436@student.uol.edu.pk', '#uni', 'school/675d9dd888b717.739674281734188504.jpg', 9, 0, 'school', '2024-12-14 15:01:44', '2024-12-14 15:01:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `school_settings`
--

CREATE TABLE `school_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `data` text NOT NULL,
  `type` varchar(191) DEFAULT NULL COMMENT 'datatype like string , file etc',
  `school_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `school_settings`
--

INSERT INTO `school_settings` (`id`, `name`, `data`, `type`, `school_id`) VALUES
(1, 'school_name', 'School 1', 'string', 1),
(2, 'school_email', 'school1@gmail.com', 'string', 1),
(3, 'school_phone', '1234567890', 'number', 1),
(4, 'school_tagline', 'We Provide Best Education', 'string', 1),
(5, 'school_address', 'Bhuj', 'string', 1),
(6, 'session_year', '1', 'number', 1),
(7, 'horizontal_logo', '', 'file', 1),
(8, 'vertical_logo', '', 'file', 1),
(9, 'timetable_start_time', '09:00:00', 'time', 1),
(10, 'timetable_end_time', '18:00:00', 'time', 1),
(11, 'timetable_duration', '01:00:00', 'time', 1),
(12, 'auto_renewal_plan', '1', 'integer', 1),
(13, 'currency_code', 'INR', 'string', 1),
(14, 'currency_symbol', '₹', 'string', 1),
(15, 'date_format', 'd-m-Y', 'string', 1),
(16, 'time_format', 'h:i A', 'string', 1),
(17, 'domain', '', 'string', 1),
(18, 'email-template-staff', '&lt;p&gt;Dear {full_name},&lt;/p&gt; &lt;p&gt;Welcome to {school_name}!&lt;/p&gt; &lt;p&gt;We are excited to have you join our team. Below are your registration details to access the {school_name}:&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Your Registration Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Registration URL:&lt;/strong&gt; {url}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Steps to Complete Your Registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Click on the registration URL provided above.&lt;/li&gt; &lt;li&gt;Enter your email and password.&lt;/li&gt; &lt;li&gt;Follow the on-screen instructions to set up your profile.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please change your password upon your first login.&lt;/li&gt; &lt;li&gt;If you have any questions or need assistance during the registration process, please contact our support team at {support_email} or call {support_contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;&lt;strong&gt;App Download Links:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Android:&lt;/strong&gt; {android_app}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;iOS:&lt;/strong&gt; {ios_app}&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;We look forward to a successful academic year with you on our team. Thank you for your commitment to excellence in education.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{school_name}&lt;br&gt;{support_email}&lt;br&gt;{support_contact}&lt;br&gt;{url}&lt;/p&gt;', 'text', 1),
(19, 'email-template-parent', '&lt;p&gt;Dear {parent_name},&lt;/p&gt; &lt;p&gt;We are delighted to welcome {child_name} to {school_name}!&lt;/p&gt; &lt;p&gt;As part of our registration process, we have created accounts for both you and your child in our {school_name}. Below are the registration details you will need to access the system, along with links to download our mobile app for your convenience.&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Student Credential Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Name:&lt;/strong&gt; {child_name}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Admission No.: &lt;/strong&gt;{admission_no}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;GR No.:&lt;/strong&gt; {grno}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {child_password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Parent Credential Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Name:&lt;/strong&gt; {parent_name}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;App Download Links:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Android:&lt;/strong&gt; {android_app}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;iOS:&lt;/strong&gt; {ios_app}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Steps to Complete the Registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Download the school management app using the links above for easier access on your mobile devices.&lt;/li&gt; &lt;li&gt;Enter the email and password for either the student or parent account.&lt;/li&gt; &lt;li&gt;Follow the on-screen instructions to complete the profile setup.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please ensure that both the student and parent passwords are changed upon first login.&lt;/li&gt; &lt;li&gt;If you encounter any issues during the registration process, please do not hesitate to contact our support team at {support_email} or call {support_contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;We look forward to an enriching educational experience for {child_name} at {school_name}. Thank you for entrusting us with your child&#039;s education.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{school_name}&lt;br&gt;{support_email}&lt;/p&gt;', 'text', 1),
(20, 'school_name', 'School 2', 'string', 2),
(21, 'school_email', 'school2@gmail.com', 'string', 2),
(22, 'school_phone', '1234567890', 'number', 2),
(23, 'school_tagline', 'We Provide Best Education', 'string', 2),
(24, 'school_address', 'Bhuj', 'string', 2),
(25, 'session_year', '2', 'number', 2),
(26, 'horizontal_logo', '', 'file', 2),
(27, 'vertical_logo', '', 'file', 2),
(28, 'timetable_start_time', '09:00:00', 'time', 2),
(29, 'timetable_end_time', '18:00:00', 'time', 2),
(30, 'timetable_duration', '01:00:00', 'time', 2),
(31, 'auto_renewal_plan', '1', 'integer', 2),
(32, 'currency_code', 'INR', 'string', 2),
(33, 'currency_symbol', '₹', 'string', 2),
(34, 'date_format', 'd-m-Y', 'string', 2),
(35, 'time_format', 'h:i A', 'string', 2),
(36, 'domain', '', 'string', 2),
(37, 'email-template-staff', '&lt;p&gt;Dear {full_name},&lt;/p&gt; &lt;p&gt;Welcome to {school_name}!&lt;/p&gt; &lt;p&gt;We are excited to have you join our team. Below are your registration details to access the {school_name}:&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Your Registration Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Registration URL:&lt;/strong&gt; {url}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Steps to Complete Your Registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Click on the registration URL provided above.&lt;/li&gt; &lt;li&gt;Enter your email and password.&lt;/li&gt; &lt;li&gt;Follow the on-screen instructions to set up your profile.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please change your password upon your first login.&lt;/li&gt; &lt;li&gt;If you have any questions or need assistance during the registration process, please contact our support team at {support_email} or call {support_contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;&lt;strong&gt;App Download Links:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Android:&lt;/strong&gt; {android_app}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;iOS:&lt;/strong&gt; {ios_app}&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;We look forward to a successful academic year with you on our team. Thank you for your commitment to excellence in education.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{school_name}&lt;br&gt;{support_email}&lt;br&gt;{support_contact}&lt;br&gt;{url}&lt;/p&gt;', 'text', 2),
(38, 'email-template-parent', '&lt;p&gt;Dear {parent_name},&lt;/p&gt; &lt;p&gt;We are delighted to welcome {child_name} to {school_name}!&lt;/p&gt; &lt;p&gt;As part of our registration process, we have created accounts for both you and your child in our {school_name}. Below are the registration details you will need to access the system, along with links to download our mobile app for your convenience.&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Student Credential Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Name:&lt;/strong&gt; {child_name}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Admission No.: &lt;/strong&gt;{admission_no}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;GR No.:&lt;/strong&gt; {grno}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {child_password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Parent Credential Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Name:&lt;/strong&gt; {parent_name}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;App Download Links:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Android:&lt;/strong&gt; {android_app}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;iOS:&lt;/strong&gt; {ios_app}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Steps to Complete the Registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Download the school management app using the links above for easier access on your mobile devices.&lt;/li&gt; &lt;li&gt;Enter the email and password for either the student or parent account.&lt;/li&gt; &lt;li&gt;Follow the on-screen instructions to complete the profile setup.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please ensure that both the student and parent passwords are changed upon first login.&lt;/li&gt; &lt;li&gt;If you encounter any issues during the registration process, please do not hesitate to contact our support team at {support_email} or call {support_contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;We look forward to an enriching educational experience for {child_name} at {school_name}. Thank you for entrusting us with your child&#039;s education.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{school_name}&lt;br&gt;{support_email}&lt;/p&gt;', 'text', 2),
(39, 'school_name', 'University of Lahore', 'string', 3),
(40, 'school_email', 'huzaifashah4500@gmail.com', 'string', 3),
(41, 'school_phone', '03441179414', 'number', 3),
(42, 'school_tagline', '#uni', 'string', 3),
(43, 'school_address', 'Sargodha', 'string', 3),
(44, 'session_year', '5', 'number', 3),
(45, 'horizontal_logo', '', 'file', 3),
(46, 'vertical_logo', '', 'file', 3),
(47, 'timetable_start_time', '09:00:00', 'time', 3),
(48, 'timetable_end_time', '18:00:00', 'time', 3),
(49, 'timetable_duration', '01:00:00', 'time', 3),
(50, 'auto_renewal_plan', '1', 'integer', 3),
(51, 'currency_code', 'INR', 'string', 3),
(52, 'currency_symbol', '₹', 'string', 3),
(53, 'date_format', 'd-m-Y', 'string', 3),
(54, 'time_format', 'h:i A', 'string', 3),
(55, 'domain', 'uol', 'string', 3),
(56, 'email-template-staff', '&lt;p&gt;Dear {full_name},&lt;/p&gt; &lt;p&gt;Welcome to {school_name}!&lt;/p&gt; &lt;p&gt;We are excited to have you join our team. Below are your registration details to access the {school_name}:&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Your Registration Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Registration URL:&lt;/strong&gt; {url}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Steps to Complete Your Registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Click on the registration URL provided above.&lt;/li&gt; &lt;li&gt;Enter your email and password.&lt;/li&gt; &lt;li&gt;Follow the on-screen instructions to set up your profile.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please change your password upon your first login.&lt;/li&gt; &lt;li&gt;If you have any questions or need assistance during the registration process, please contact our support team at {support_email} or call {support_contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;&lt;strong&gt;App Download Links:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Android:&lt;/strong&gt; {android_app}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;iOS:&lt;/strong&gt; {ios_app}&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;We look forward to a successful academic year with you on our team. Thank you for your commitment to excellence in education.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{school_name}&lt;br&gt;{support_email}&lt;br&gt;{support_contact}&lt;br&gt;{url}&lt;/p&gt;', 'text', 3),
(57, 'email-template-parent', '&lt;p&gt;Dear {parent_name},&lt;/p&gt; &lt;p&gt;We are delighted to welcome {child_name} to {school_name}!&lt;/p&gt; &lt;p&gt;As part of our registration process, we have created accounts for both you and your child in our {school_name}. Below are the registration details you will need to access the system, along with links to download our mobile app for your convenience.&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Student Credential Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Name:&lt;/strong&gt; {child_name}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Admission No.: &lt;/strong&gt;{admission_no}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;GR No.:&lt;/strong&gt; {grno}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {child_password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Parent Credential Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Name:&lt;/strong&gt; {parent_name}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;App Download Links:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Android:&lt;/strong&gt; {android_app}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;iOS:&lt;/strong&gt; {ios_app}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Steps to Complete the Registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Download the school management app using the links above for easier access on your mobile devices.&lt;/li&gt; &lt;li&gt;Enter the email and password for either the student or parent account.&lt;/li&gt; &lt;li&gt;Follow the on-screen instructions to complete the profile setup.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please ensure that both the student and parent passwords are changed upon first login.&lt;/li&gt; &lt;li&gt;If you encounter any issues during the registration process, please do not hesitate to contact our support team at {support_email} or call {support_contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;We look forward to an enriching educational experience for {child_name} at {school_name}. Thank you for entrusting us with your child&#039;s education.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{school_name}&lt;br&gt;{support_email}&lt;/p&gt;', 'text', 3),
(58, 'school_name', 'Qauid Public Model School', 'string', 4),
(59, 'school_email', 'huzaifa.appdev@gmail.com', 'string', 4),
(60, 'school_phone', '12345678', 'number', 4),
(61, 'school_tagline', '#uni', 'string', 4),
(62, 'school_address', 'Sargodha', 'string', 4),
(63, 'session_year', '6', 'number', 4),
(64, 'horizontal_logo', '', 'file', 4),
(65, 'vertical_logo', '', 'file', 4),
(66, 'timetable_start_time', '09:00:00', 'time', 4),
(67, 'timetable_end_time', '18:00:00', 'time', 4),
(68, 'timetable_duration', '01:00:00', 'time', 4),
(69, 'auto_renewal_plan', '1', 'integer', 4),
(70, 'currency_code', 'INR', 'string', 4),
(71, 'currency_symbol', '₹', 'string', 4),
(72, 'date_format', 'd-m-Y', 'string', 4),
(73, 'time_format', 'h:i A', 'string', 4),
(74, 'domain', 'QPM', 'string', 4),
(75, 'email-template-staff', '&lt;p&gt;Dear {full_name},&lt;/p&gt; &lt;p&gt;Welcome to {school_name}!&lt;/p&gt; &lt;p&gt;We are excited to have you join our team. Below are your registration details to access the {school_name}:&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Your Registration Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Registration URL:&lt;/strong&gt; {url}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Steps to Complete Your Registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Click on the registration URL provided above.&lt;/li&gt; &lt;li&gt;Enter your email and password.&lt;/li&gt; &lt;li&gt;Follow the on-screen instructions to set up your profile.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please change your password upon your first login.&lt;/li&gt; &lt;li&gt;If you have any questions or need assistance during the registration process, please contact our support team at {support_email} or call {support_contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;&lt;strong&gt;App Download Links:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Android:&lt;/strong&gt; {android_app}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;iOS:&lt;/strong&gt; {ios_app}&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;We look forward to a successful academic year with you on our team. Thank you for your commitment to excellence in education.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{school_name}&lt;br&gt;{support_email}&lt;br&gt;{support_contact}&lt;br&gt;{url}&lt;/p&gt;', 'text', 4),
(76, 'email-template-parent', '&lt;p&gt;Dear {parent_name},&lt;/p&gt; &lt;p&gt;We are delighted to welcome {child_name} to {school_name}!&lt;/p&gt; &lt;p&gt;As part of our registration process, we have created accounts for both you and your child in our {school_name}. Below are the registration details you will need to access the system, along with links to download our mobile app for your convenience.&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Student Credential Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Name:&lt;/strong&gt; {child_name}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Admission No.: &lt;/strong&gt;{admission_no}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;GR No.:&lt;/strong&gt; {grno}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {child_password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Parent Credential Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Name:&lt;/strong&gt; {parent_name}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;App Download Links:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Android:&lt;/strong&gt; {android_app}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;iOS:&lt;/strong&gt; {ios_app}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Steps to Complete the Registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Download the school management app using the links above for easier access on your mobile devices.&lt;/li&gt; &lt;li&gt;Enter the email and password for either the student or parent account.&lt;/li&gt; &lt;li&gt;Follow the on-screen instructions to complete the profile setup.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please ensure that both the student and parent passwords are changed upon first login.&lt;/li&gt; &lt;li&gt;If you encounter any issues during the registration process, please do not hesitate to contact our support team at {support_email} or call {support_contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;We look forward to an enriching educational experience for {child_name} at {school_name}. Thank you for entrusting us with your child&#039;s education.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{school_name}&lt;br&gt;{support_email}&lt;/p&gt;', 'text', 4),
(77, 'school_name', 'School1', 'string', 5),
(78, 'school_email', '70162436@student.uol.edu.pk', 'string', 5),
(79, 'school_phone', '2345678556789', 'number', 5),
(80, 'school_tagline', '#uni', 'string', 5),
(81, 'school_address', 'SGD', 'string', 5),
(82, 'session_year', '7', 'number', 5),
(83, 'horizontal_logo', '', 'file', 5),
(84, 'vertical_logo', '', 'file', 5),
(85, 'timetable_start_time', '09:00:00', 'time', 5),
(86, 'timetable_end_time', '18:00:00', 'time', 5),
(87, 'timetable_duration', '01:00:00', 'time', 5),
(88, 'auto_renewal_plan', '1', 'integer', 5),
(89, 'currency_code', 'INR', 'string', 5),
(90, 'currency_symbol', '₹', 'string', 5),
(91, 'date_format', 'd-m-Y', 'string', 5),
(92, 'time_format', 'h:i A', 'string', 5),
(93, 'domain', 'school', 'string', 5),
(94, 'email-template-staff', '&lt;p&gt;Dear {full_name},&lt;/p&gt; &lt;p&gt;Welcome to {school_name}!&lt;/p&gt; &lt;p&gt;We are excited to have you join our team. Below are your registration details to access the {school_name}:&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Your Registration Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Registration URL:&lt;/strong&gt; {url}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Steps to Complete Your Registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Click on the registration URL provided above.&lt;/li&gt; &lt;li&gt;Enter your email and password.&lt;/li&gt; &lt;li&gt;Follow the on-screen instructions to set up your profile.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please change your password upon your first login.&lt;/li&gt; &lt;li&gt;If you have any questions or need assistance during the registration process, please contact our support team at {support_email} or call {support_contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;&lt;strong&gt;App Download Links:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Android:&lt;/strong&gt; {android_app}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;iOS:&lt;/strong&gt; {ios_app}&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;We look forward to a successful academic year with you on our team. Thank you for your commitment to excellence in education.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{school_name}&lt;br&gt;{support_email}&lt;br&gt;{support_contact}&lt;br&gt;{url}&lt;/p&gt;', 'text', 5),
(95, 'email-template-parent', '&lt;p&gt;Dear {parent_name},&lt;/p&gt; &lt;p&gt;We are delighted to welcome {child_name} to {school_name}!&lt;/p&gt; &lt;p&gt;As part of our registration process, we have created accounts for both you and your child in our {school_name}. Below are the registration details you will need to access the system, along with links to download our mobile app for your convenience.&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Student Credential Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Name:&lt;/strong&gt; {child_name}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Admission No.: &lt;/strong&gt;{admission_no}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;GR No.:&lt;/strong&gt; {grno}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {child_password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Parent Credential Details:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Name:&lt;/strong&gt; {parent_name}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;App Download Links:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Android:&lt;/strong&gt; {android_app}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;iOS:&lt;/strong&gt; {ios_app}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Steps to Complete the Registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Download the school management app using the links above for easier access on your mobile devices.&lt;/li&gt; &lt;li&gt;Enter the email and password for either the student or parent account.&lt;/li&gt; &lt;li&gt;Follow the on-screen instructions to complete the profile setup.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please ensure that both the student and parent passwords are changed upon first login.&lt;/li&gt; &lt;li&gt;If you encounter any issues during the registration process, please do not hesitate to contact our support team at {support_email} or call {support_contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;We look forward to an enriching educational experience for {child_name} at {school_name}. Thank you for entrusting us with your child&#039;s education.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{school_name}&lt;br&gt;{support_email}&lt;/p&gt;', 'text', 5);

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(512) NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `name`, `school_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'A', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(2, 'B', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(3, 'C', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `semesters`
--

CREATE TABLE `semesters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `start_month` tinyint(4) NOT NULL,
  `end_month` tinyint(4) NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `session_years`
--

CREATE TABLE `session_years` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(512) NOT NULL,
  `default` tinyint(4) NOT NULL DEFAULT 0,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `session_years`
--

INSERT INTO `session_years` (`id`, `name`, `default`, `start_date`, `end_date`, `school_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '2024', 1, '2024-01-01', '2024-12-31', 1, '2024-12-14 14:29:53', '2024-12-14 14:29:53', NULL),
(2, '2024', 1, '2024-01-01', '2024-12-31', 2, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(3, '2024-25', 0, '2024-06-01', '2025-04-30', 1, '2024-12-14 14:29:56', '2024-12-14 14:29:56', NULL),
(4, '2025-26', 0, '2025-06-01', '2026-04-30', 1, '2024-12-14 14:29:56', '2024-12-14 14:29:56', NULL),
(5, '2024', 1, '2024-01-01', '2024-12-31', 3, '2024-12-14 14:34:10', '2024-12-14 14:34:10', NULL),
(6, '2024', 1, '2024-01-01', '2024-12-31', 4, '2024-12-14 14:56:00', '2024-12-14 14:56:00', NULL),
(7, '2024', 1, '2024-01-01', '2024-12-31', 5, '2024-12-14 15:01:45', '2024-12-14 15:01:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(1024) NOT NULL,
  `link` varchar(191) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '1 => App, 2 => web, 3 => Both',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staffs`
--

CREATE TABLE `staffs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `qualification` varchar(512) DEFAULT NULL,
  `salary` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `staffs`
--

INSERT INTO `staffs` (`id`, `user_id`, `qualification`, `salary`, `created_at`, `updated_at`) VALUES
(1, 6, 'MSC IT', 100000, '2024-12-14 14:29:57', '2024-12-14 14:29:57');

-- --------------------------------------------------------

--
-- Table structure for table `staff_payrolls`
--

CREATE TABLE `staff_payrolls` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `expense_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payroll_setting_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `percentage` double(8,2) DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff_salaries`
--

CREATE TABLE `staff_salaries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `staff_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payroll_setting_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `percentage` double(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff_support_schools`
--

CREATE TABLE `staff_support_schools` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `streams`
--

CREATE TABLE `streams` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `admission_no` varchar(512) NOT NULL,
  `roll_number` int(11) DEFAULT NULL,
  `admission_date` date NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `guardian_id` bigint(20) UNSIGNED NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `class_section_id`, `admission_no`, `roll_number`, `admission_date`, `school_id`, `guardian_id`, `session_year_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 5, 3, '12345667', 1, '2022-04-01', 1, 4, 1, '2024-12-14 14:29:56', '2024-12-14 14:29:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student_online_exam_statuses`
--

CREATE TABLE `student_online_exam_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `online_exam_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '1 - in progress 2 - completed',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_subjects`
--

CREATE TABLE `student_subjects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `class_subject_id` bigint(20) UNSIGNED NOT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `session_year_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(512) NOT NULL,
  `code` varchar(64) DEFAULT NULL,
  `bg_color` varchar(32) NOT NULL,
  `image` varchar(512) NOT NULL,
  `medium_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(64) NOT NULL COMMENT 'Theory / Practical',
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `name`, `code`, `bg_color`, `image`, `medium_id`, `type`, `school_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Maths', 'MA', '#5031f7', 'subject.png', 1, 'Practical', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(2, 'Science', 'SC', '#5031f7', 'subject.png', 1, 'Practical', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(3, 'English', 'EN', '#5031f7', 'subject.png', 1, 'Theory', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(4, 'Gujarati', 'GJ', '#5031f7', 'subject.png', 1, 'Theory', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(5, 'Sanskrit', 'SN', '#5031f7', 'subject.png', 1, 'Theory', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(6, 'Hindi', 'HN', '#5031f7', 'subject.png', 1, 'Theory', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(7, 'Computer', 'CMP', '#5031f7', 'subject.png', 1, 'Practical', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL),
(8, 'PT', 'PT', '#5031f7', 'subject.png', 1, 'Practical', 1, '2024-12-14 14:29:55', '2024-12-14 14:29:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `subject_teachers`
--

CREATE TABLE `subject_teachers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `subject_id` bigint(20) UNSIGNED NOT NULL,
  `teacher_id` bigint(20) UNSIGNED NOT NULL COMMENT 'user_id',
  `class_subject_id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `package_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `student_charge` double(8,4) NOT NULL,
  `staff_charge` double(8,4) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `package_type` int(11) NOT NULL DEFAULT 1 COMMENT '0 => Prepaid, 1 => Postpaid',
  `no_of_students` int(11) NOT NULL DEFAULT 0,
  `no_of_staffs` int(11) NOT NULL DEFAULT 0,
  `charges` double(64,4) NOT NULL DEFAULT 0.0000,
  `billing_cycle` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `school_id`, `package_id`, `name`, `student_charge`, `staff_charge`, `start_date`, `end_date`, `package_type`, `no_of_students`, `no_of_staffs`, `charges`, `billing_cycle`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 'Pro', 0.0250, 0.0250, '2024-12-14', '2025-03-13', 1, 0, 0, 0.0000, 90, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(2, 4, 1, 'Pro', 0.0250, 0.0250, '2024-12-14', '2025-03-13', 1, 0, 0, 0.0000, 90, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(3, 5, 1, 'Pro', 0.0250, 0.0250, '2024-12-14', '2025-03-13', 1, 0, 0, 0.0000, 90, '2024-12-14 15:01:45', '2024-12-14 15:01:45');

-- --------------------------------------------------------

--
-- Table structure for table `subscription_bills`
--

CREATE TABLE `subscription_bills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subscription_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `amount` double(64,4) NOT NULL,
  `total_student` bigint(20) NOT NULL,
  `total_staff` bigint(20) NOT NULL,
  `payment_transaction_id` bigint(20) UNSIGNED DEFAULT NULL,
  `due_date` date NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_features`
--

CREATE TABLE `subscription_features` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subscription_id` bigint(20) UNSIGNED NOT NULL,
  `feature_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscription_features`
--

INSERT INTO `subscription_features` (`id`, `subscription_id`, `feature_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(2, 1, 2, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(3, 1, 3, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(4, 1, 4, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(5, 1, 5, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(6, 1, 6, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(7, 1, 7, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(8, 1, 8, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(9, 1, 9, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(10, 1, 10, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(11, 1, 11, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(12, 1, 12, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(13, 1, 13, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(14, 1, 14, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(15, 1, 15, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(16, 1, 16, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(17, 1, 17, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(18, 1, 18, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(19, 1, 19, '2024-12-14 14:34:10', '2024-12-14 14:34:10'),
(20, 2, 1, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(21, 2, 2, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(22, 2, 3, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(23, 2, 4, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(24, 2, 5, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(25, 2, 6, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(26, 2, 7, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(27, 2, 8, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(28, 2, 9, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(29, 2, 10, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(30, 2, 11, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(31, 2, 12, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(32, 2, 13, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(33, 2, 14, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(34, 2, 15, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(35, 2, 16, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(36, 2, 17, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(37, 2, 18, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(38, 2, 19, '2024-12-14 14:56:00', '2024-12-14 14:56:00'),
(39, 3, 1, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(40, 3, 2, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(41, 3, 3, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(42, 3, 4, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(43, 3, 5, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(44, 3, 6, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(45, 3, 7, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(46, 3, 8, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(47, 3, 9, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(48, 3, 10, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(49, 3, 11, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(50, 3, 12, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(51, 3, 13, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(52, 3, 14, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(53, 3, 15, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(54, 3, 16, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(55, 3, 17, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(56, 3, 18, '2024-12-14 15:01:45', '2024-12-14 15:01:45'),
(57, 3, 19, '2024-12-14 15:01:45', '2024-12-14 15:01:45');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `data` text NOT NULL,
  `type` varchar(191) DEFAULT NULL COMMENT 'datatype like string , file etc'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `name`, `data`, `type`) VALUES
(1, 'hero_title_1', 'Opt for eSchool Saas 14+ robust features for an enhanced educational experience.', 'text'),
(2, 'hero_title_2', 'Top Rated Instructors', 'text'),
(3, 'about_us_title', 'A modern and unique style', 'text'),
(4, 'about_us_heading', 'Why it is best?', 'text'),
(5, 'about_us_description', 'eSchool is the pinnacle of school management, offering advanced technology, user-friendly features, and personalized solutions. It simplifies communication, streamlines administrative tasks, and elevates the educational experience for all stakeholders. With eSchool, excellence in education management is guaranteed.', 'text'),
(6, 'about_us_points', 'Affordable price,Easy to manage admin panel,Data Security', 'text'),
(7, 'custom_package_status', '1', 'text'),
(8, 'custom_package_description', 'Tailor your experience with our custom package options. From personalized services to bespoke solutions, we offer flexibility to meet your unique needs.', 'text'),
(9, 'download_our_app_description', 'Join the ranks of true trivia champions and quench your thirst for knowledge with Masters of Trivia - the ultimate quiz app designed to test your wits and unlock a world of fun facts. Challenge your brain, compete with friends, and discover fascinating tidbits from diverse categories. Don\'t miss out on the exhilarating experience that awaits you - get started now!Join the ranks of true trivia champions and quench your thirst for knowledge with Masters of Trivia - the ultimate quiz app designed to test your wits and unlock a world of fun facts.', 'text'),
(10, 'theme_primary_color', '#56cc99', 'text'),
(11, 'theme_secondary_color', '#215679', 'text'),
(12, 'theme_secondary_color_1', '#38a3a5', 'text'),
(13, 'theme_primary_background_color', '#f2f5f7', 'text'),
(14, 'theme_text_secondary_color', '#5c788c', 'text'),
(15, 'tag_line', 'Transform School Management With eSchool SaaS', 'text'),
(16, 'mobile', 'xxxxxxxxxx', 'text'),
(17, 'hero_description', 'Experience the future of education with our eSchool SaaS platform. Streamline attendance, assignments, exams, and more. Elevate your school\'s efficiency and engagement.', 'text'),
(18, 'display_school_logos', '1', 'text'),
(19, 'display_counters', '1', 'text'),
(20, 'email_template_school_registration', '&lt;p&gt;Dear {school_admin_name},&lt;/p&gt; &lt;p&gt;Welcome to {system_name}!&lt;/p&gt; &lt;p&gt;We are excited to have you as part of our educational community. Below are your registration details to access the system:&lt;/p&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;School Name:&lt;/strong&gt; {school_name}&lt;/p&gt; &lt;p&gt;&lt;strong&gt;System URL:&lt;/strong&gt; {url}&lt;/p&gt; &lt;p&gt;&lt;strong&gt;Your Login Credentials:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;&lt;strong&gt;Email:&lt;/strong&gt; {email}&lt;/li&gt; &lt;li&gt;&lt;strong&gt;Password:&lt;/strong&gt; {password}&lt;/li&gt; &lt;/ul&gt; &lt;hr&gt; &lt;p&gt;&lt;strong&gt;Please follow these steps to complete your registration:&lt;/strong&gt;&lt;/p&gt; &lt;ol&gt; &lt;li&gt;Click on the system URL provided above.&lt;/li&gt; &lt;li&gt;Enter your email and password.&lt;/li&gt; &lt;li&gt;Follow the instructions to complete your profile setup.&lt;/li&gt; &lt;/ol&gt; &lt;p&gt;&lt;strong&gt;Important:&lt;/strong&gt;&lt;/p&gt; &lt;ul&gt; &lt;li&gt;For security reasons, please change your password after your first login.&lt;/li&gt; &lt;li&gt;If you encounter any issues during the registration process, please do not hesitate to contact our support team at {support_email} or call {contact}.&lt;/li&gt; &lt;/ul&gt; &lt;p&gt;Thank you for choosing {system_name}. We are committed to providing you with the best educational tools and resources.&lt;/p&gt; &lt;p&gt;Best regards,&lt;/p&gt; &lt;p&gt;{super_admin_name}&lt;br&gt;{system_name}&lt;br&gt;{support_email}&lt;br&gt;{url}&lt;/p&gt;', 'text'),
(21, 'system_version', '1.3.3', 'string'),
(22, 'time_zone', 'Asia/Kolkata', 'string'),
(23, 'date_format', 'd-m-Y', 'date'),
(24, 'time_format', 'h:i A', 'time'),
(25, 'theme_color', '#22577A', 'string'),
(26, 'session_year', '1', 'string'),
(27, 'email_verified', '1', 'string'),
(28, 'subscription_alert', '7', 'integer'),
(29, 'currency_code', 'USD', 'string'),
(30, 'currency_symbol', '$', 'string'),
(31, 'additional_billing_days', '5', 'integer'),
(32, 'system_name', 'eSchool Saas - School Management System', 'string'),
(33, 'address', '#262-263, Time Square Empire, SH 42 Mirjapar highway, Bhuj - Kutch 370001 Gujarat India.', 'string'),
(34, 'billing_cycle_in_days', '30', 'integer'),
(35, 'current_plan_expiry_warning_days', '7', 'integer'),
(36, 'front_site_theme_color', '#e9f9f3', 'text'),
(37, 'primary_color', '#3ccb9b', 'text'),
(38, 'secondary_color', '#245a7f', 'text'),
(39, 'short_description', 'eSchool-Saas - Manage Your School', 'text'),
(40, 'facebook', 'https://www.facebook.com/wrteam.in/', 'text'),
(41, 'instagram', 'https://www.instagram.com/wrteam.in/', 'text'),
(42, 'linkedin', 'https://in.linkedin.com/company/wrteam', 'text'),
(43, 'footer_text', '<p>&copy;&nbsp;<strong><a href=\'https://wrteam.in/\' target=\'_blank\' rel=\'noopener noreferrer\'>WRTeam</a></strong>. All Rights Reserved</p>', 'text'),
(44, 'tagline', 'We Provide the best Education', 'text'),
(45, 'super_admin_name', 'Super Admin', 'text'),
(112, 'mail_mailer', 'smtp', 'string'),
(113, 'mail_host', 'smtp.gmail.com', 'string'),
(114, 'mail_port', '465', 'string'),
(115, 'mail_username', 'uolconnect.app@gmail.com', 'string'),
(116, 'mail_password', 'mlbosouxhkmfqgls', 'string'),
(117, 'mail_encryption', 'tls', 'string'),
(118, 'mail_send_from', 'uolconnect.app@gmail.com', 'string');

-- --------------------------------------------------------

--
-- Table structure for table `timetables`
--

CREATE TABLE `timetables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subject_teacher_id` bigint(20) UNSIGNED DEFAULT NULL,
  `class_section_id` bigint(20) UNSIGNED NOT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `note` varchar(1024) DEFAULT NULL,
  `day` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
  `type` enum('Lecture','Break') NOT NULL,
  `semester_id` bigint(20) UNSIGNED DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(128) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `mobile` varchar(191) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `gender` varchar(16) DEFAULT NULL,
  `image` varchar(512) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `current_address` varchar(191) DEFAULT NULL,
  `permanent_address` varchar(191) DEFAULT NULL,
  `occupation` varchar(128) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `reset_request` tinyint(4) NOT NULL DEFAULT 0,
  `fcm_id` varchar(1024) DEFAULT NULL,
  `school_id` bigint(20) UNSIGNED DEFAULT NULL,
  `language` varchar(191) NOT NULL DEFAULT 'en',
  `remember_token` varchar(100) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `mobile`, `email`, `password`, `gender`, `image`, `dob`, `current_address`, `permanent_address`, `occupation`, `status`, `reset_request`, `fcm_id`, `school_id`, `language`, `remember_token`, `email_verified_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'super', 'admin', '03304054500', 'superadmin@gmail.com', '$2y$10$fNkibsRWMj5b03cM39HnxeMp3Op2sQR9NTOgPxHdsCXyVpN/QPuSG', 'male', 'user/675d96e28d0e19.591553621734186722.jpg', '1970-01-01', 'SGD', 'SGD', NULL, 1, 0, NULL, NULL, 'en', NULL, NULL, '2024-12-14 14:29:49', '2024-12-14 14:32:02', NULL),
(2, 'School 1', 'Demo 1', '1234567890', 'school1@gmail.com', '$2y$10$UCOekMU4IwAwwJOzhjiKQ.972Or6vHlx1Ohs/2fx04nKx.Ltz/cya', 'male', 'users/school_admin.png', NULL, 'Bhuj', 'Bhuj', NULL, 1, 0, NULL, 1, 'en', NULL, NULL, '2024-12-14 14:29:50', '2024-12-14 14:39:49', '2024-12-14 14:39:49'),
(3, 'School 2', 'Demo 2', '1234567890', 'school2@gmail.com', '$2y$10$xmJzyrCH1KkruV7JGOdGReRwk5D9rG6FytQoWYqO3MtiC.tkRRiq.', 'male', 'users/school_admin.png', NULL, 'Bhuj', 'Bhuj', NULL, 1, 0, NULL, 2, 'en', NULL, NULL, '2024-12-14 14:29:50', '2024-12-14 14:39:44', '2024-12-14 14:39:44'),
(4, 'Guardian', 'Demo', '1234567890', 'guardian@gmail.com', '$2y$10$Cg/Nq.YxRvHk3skAIrvpw.FHnvoEzMt5TYnOysNgrAf5CgilbKJ0O', 'female', 'guardian/user.png', NULL, 'Bhuj', 'Bhuj', NULL, 1, 0, NULL, NULL, 'en', NULL, NULL, '2024-12-14 14:29:56', '2024-12-14 14:29:56', NULL),
(5, 'Student', 'Demo', '1234567890', 'student@gmail.com', '$2y$10$9Fmhmr.ZPRWWzv0sZyKCtuV61j2EprwKmp8Fc7P6G00tApjuda2Ni', 'male', 'students/user.png', NULL, 'Bhuj', 'Bhuj', NULL, 1, 0, NULL, 1, 'en', NULL, NULL, '2024-12-14 14:29:56', '2024-12-14 14:29:56', NULL),
(6, 'Teacher', 'Demo', '1234567890', 'teacher@gmail.com', '$2y$10$apQZ7p91CUiZfpPB5Cil3OketlDgv7iLWTW.kf0P0HcvJTc/TQAZa', 'male', 'teachers/user.png', NULL, 'Bhuj', 'Bhuj', NULL, 1, 0, NULL, 1, 'en', NULL, NULL, '2024-12-14 14:29:56', '2024-12-14 14:29:56', NULL),
(7, 'Huzaifa', 'Shah', '03304054500', 'huzaifashah4500@gmail.com', '$2y$10$GaxDpKrn6ALvdPEHgGW97ukSUdYDLlJyBSv8veY.6QJefn8dBFMMi', NULL, 'user/675d9761b07101.225465371734186849.jpg', NULL, NULL, NULL, NULL, 1, 0, NULL, 3, 'en', NULL, NULL, '2024-12-14 14:34:09', '2024-12-14 14:34:09', NULL),
(8, 'Huzaifa', 'Shah', '03304054500', 'huzaifa.appdev@gmail.com', '$2y$10$4SDbI/2Ej5WS1mcOcW3OAutRZYUeE8nYoUjsSoMKNznek3mbK6Gn6', NULL, 'user/675d9c7f63ca85.682666961734188159.jpg', NULL, NULL, NULL, NULL, 1, 0, NULL, 4, 'en', NULL, NULL, '2024-12-14 14:55:59', '2024-12-14 15:07:24', '2024-12-14 15:07:24'),
(9, 'Huzaifa', 'Shah', '456785434567', '70162436@student.uol.edu.pk', '$2y$10$JnyC6NCvN50jhSHUruB80u0SKgDR6wdslXFodaru9gI.4.F21iNNK', NULL, 'user/675d9dd8c7cd06.419190921734188504.jpg', NULL, NULL, NULL, NULL, 1, 0, NULL, 5, 'en', NULL, NULL, '2024-12-14 15:01:44', '2024-12-14 15:01:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_status_for_next_cycles`
--

CREATE TABLE `user_status_for_next_cycles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL,
  `school_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_calendars`
--
ALTER TABLE `academic_calendars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `academic_calendars_school_id_foreign` (`school_id`),
  ADD KEY `academic_calendars_session_year_id_foreign` (`session_year_id`);

--
-- Indexes for table `addons`
--
ALTER TABLE `addons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `addons_feature_id_unique` (`feature_id`);

--
-- Indexes for table `addon_subscriptions`
--
ALTER TABLE `addon_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addon_subscriptions_school_id_foreign` (`school_id`),
  ADD KEY `addon_subscriptions_feature_id_foreign` (`feature_id`),
  ADD KEY `addon_subscriptions_subscription_id_foreign` (`subscription_id`),
  ADD KEY `addon_subscriptions_payment_transaction_id_foreign` (`payment_transaction_id`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `announcements_school_id_foreign` (`school_id`),
  ADD KEY `announcements_session_year_id_foreign` (`session_year_id`);

--
-- Indexes for table `announcement_classes`
--
ALTER TABLE `announcement_classes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_columns` (`announcement_id`,`class_section_id`,`school_id`),
  ADD KEY `announcement_classes_school_id_foreign` (`school_id`),
  ADD KEY `announcement_classes_announcement_id_index` (`announcement_id`),
  ADD KEY `announcement_classes_class_section_id_index` (`class_section_id`),
  ADD KEY `announcement_classes_class_subject_id_foreign` (`class_subject_id`);

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignments_school_id_foreign` (`school_id`),
  ADD KEY `assignments_class_section_id_foreign` (`class_section_id`),
  ADD KEY `assignments_class_subject_id_foreign` (`class_subject_id`),
  ADD KEY `assignments_session_year_id_foreign` (`session_year_id`),
  ADD KEY `assignments_created_by_foreign` (`created_by`),
  ADD KEY `assignments_edited_by_foreign` (`edited_by`);

--
-- Indexes for table `assignment_submissions`
--
ALTER TABLE `assignment_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_submissions_assignment_id_foreign` (`assignment_id`),
  ADD KEY `assignment_submissions_school_id_foreign` (`school_id`),
  ADD KEY `assignment_submissions_session_year_id_foreign` (`session_year_id`),
  ADD KEY `assignment_submissions_student_id_foreign` (`student_id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendances_school_id_foreign` (`school_id`),
  ADD KEY `attendances_class_section_id_foreign` (`class_section_id`),
  ADD KEY `attendances_session_year_id_foreign` (`session_year_id`),
  ADD KEY `attendances_student_id_foreign` (`student_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_school_id_foreign` (`school_id`);

--
-- Indexes for table `certificate_templates`
--
ALTER TABLE `certificate_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificate_templates_school_id_foreign` (`school_id`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `classes_school_id_foreign` (`school_id`),
  ADD KEY `classes_medium_id_foreign` (`medium_id`),
  ADD KEY `classes_shift_id_foreign` (`shift_id`),
  ADD KEY `classes_stream_id_foreign` (`stream_id`);

--
-- Indexes for table `class_groups`
--
ALTER TABLE `class_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_groups_school_id_foreign` (`school_id`);

--
-- Indexes for table `class_sections`
--
ALTER TABLE `class_sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_id` (`class_id`,`section_id`,`medium_id`),
  ADD KEY `class_sections_school_id_foreign` (`school_id`),
  ADD KEY `class_sections_section_id_foreign` (`section_id`),
  ADD KEY `class_sections_medium_id_foreign` (`medium_id`);

--
-- Indexes for table `class_subjects`
--
ALTER TABLE `class_subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_ids` (`class_id`,`subject_id`,`virtual_semester_id`),
  ADD KEY `class_subjects_elective_subject_group_id_foreign` (`elective_subject_group_id`),
  ADD KEY `class_subjects_school_id_foreign` (`school_id`),
  ADD KEY `class_subjects_subject_id_foreign` (`subject_id`),
  ADD KEY `class_subjects_semester_id_foreign` (`semester_id`);

--
-- Indexes for table `class_teachers`
--
ALTER TABLE `class_teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_id` (`class_section_id`,`teacher_id`),
  ADD KEY `class_teachers_school_id_foreign` (`school_id`),
  ADD KEY `class_teachers_teacher_id_foreign` (`teacher_id`);

--
-- Indexes for table `compulsory_fees`
--
ALTER TABLE `compulsory_fees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `compulsory_fees_payment_transaction_id_foreign` (`payment_transaction_id`),
  ADD KEY `compulsory_fees_installment_id_foreign` (`installment_id`),
  ADD KEY `compulsory_fees_fees_paid_id_foreign` (`fees_paid_id`),
  ADD KEY `compulsory_fees_school_id_foreign` (`school_id`),
  ADD KEY `compulsory_fees_student_id_foreign` (`student_id`);

--
-- Indexes for table `elective_subject_groups`
--
ALTER TABLE `elective_subject_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `elective_subject_groups_school_id_foreign` (`school_id`),
  ADD KEY `elective_subject_groups_class_id_foreign` (`class_id`),
  ADD KEY `elective_subject_groups_semester_id_foreign` (`semester_id`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exams_school_id_foreign` (`school_id`),
  ADD KEY `exams_class_id_foreign` (`class_id`),
  ADD KEY `exams_session_year_id_foreign` (`session_year_id`);

--
-- Indexes for table `exam_marks`
--
ALTER TABLE `exam_marks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_marks_school_id_foreign` (`school_id`),
  ADD KEY `exam_marks_exam_timetable_id_foreign` (`exam_timetable_id`),
  ADD KEY `exam_marks_class_subject_id_foreign` (`class_subject_id`),
  ADD KEY `exam_marks_session_year_id_foreign` (`session_year_id`),
  ADD KEY `exam_marks_student_id_foreign` (`student_id`);

--
-- Indexes for table `exam_results`
--
ALTER TABLE `exam_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_results_school_id_foreign` (`school_id`),
  ADD KEY `exam_results_exam_id_foreign` (`exam_id`),
  ADD KEY `exam_results_class_section_id_foreign` (`class_section_id`),
  ADD KEY `exam_results_session_year_id_foreign` (`session_year_id`),
  ADD KEY `exam_results_student_id_foreign` (`student_id`);

--
-- Indexes for table `exam_timetables`
--
ALTER TABLE `exam_timetables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_timetables_exam_id_foreign` (`exam_id`),
  ADD KEY `exam_timetables_school_id_foreign` (`school_id`),
  ADD KEY `exam_timetables_class_subject_id_foreign` (`class_subject_id`),
  ADD KEY `exam_timetables_session_year_id_foreign` (`session_year_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `salary_unique_records` (`staff_id`,`month`,`year`),
  ADD KEY `expenses_school_id_foreign` (`school_id`),
  ADD KEY `expenses_category_id_foreign` (`category_id`),
  ADD KEY `expenses_session_year_id_foreign` (`session_year_id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expense_categories_school_id_foreign` (`school_id`);

--
-- Indexes for table `extra_student_datas`
--
ALTER TABLE `extra_student_datas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `extra_student_datas_form_field_id_foreign` (`form_field_id`),
  ADD KEY `extra_student_datas_school_id_foreign` (`school_id`),
  ADD KEY `extra_student_datas_student_id_foreign` (`student_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faqs_school_id_foreign` (`school_id`);

--
-- Indexes for table `features`
--
ALTER TABLE `features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feature_sections`
--
ALTER TABLE `feature_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feature_section_lists`
--
ALTER TABLE `feature_section_lists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feature_section_lists_feature_section_id_foreign` (`feature_section_id`);

--
-- Indexes for table `fees`
--
ALTER TABLE `fees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fees_class_id_foreign` (`class_id`),
  ADD KEY `fees_school_id_foreign` (`school_id`),
  ADD KEY `fees_session_year_id_foreign` (`session_year_id`);

--
-- Indexes for table `fees_advance`
--
ALTER TABLE `fees_advance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fees_advance_compulsory_fee_id_foreign` (`compulsory_fee_id`),
  ADD KEY `fees_advance_student_id_foreign` (`student_id`),
  ADD KEY `fees_advance_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `fees_class_types`
--
ALTER TABLE `fees_class_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_ids` (`class_id`,`fees_type_id`,`school_id`,`fees_id`),
  ADD KEY `fees_class_types_fees_id_foreign` (`fees_id`),
  ADD KEY `fees_class_types_fees_type_id_foreign` (`fees_type_id`),
  ADD KEY `fees_class_types_school_id_foreign` (`school_id`);

--
-- Indexes for table `fees_installments`
--
ALTER TABLE `fees_installments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fees_installments_fees_id_foreign` (`fees_id`),
  ADD KEY `fees_installments_session_year_id_foreign` (`session_year_id`),
  ADD KEY `fees_installments_school_id_foreign` (`school_id`);

--
-- Indexes for table `fees_paids`
--
ALTER TABLE `fees_paids`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_ids` (`student_id`,`fees_id`,`school_id`),
  ADD KEY `fees_paids_fees_id_foreign` (`fees_id`),
  ADD KEY `fees_paids_school_id_foreign` (`school_id`);

--
-- Indexes for table `fees_types`
--
ALTER TABLE `fees_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fees_types_school_id_foreign` (`school_id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `files_modal_type_modal_id_index` (`modal_type`,`modal_id`),
  ADD KEY `files_school_id_foreign` (`school_id`);

--
-- Indexes for table `form_fields`
--
ALTER TABLE `form_fields`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`,`school_id`),
  ADD KEY `form_fields_school_id_foreign` (`school_id`);

--
-- Indexes for table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `galleries_session_year_id_foreign` (`session_year_id`),
  ADD KEY `galleries_school_id_foreign` (`school_id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `grades_school_id_foreign` (`school_id`);

--
-- Indexes for table `guidances`
--
ALTER TABLE `guidances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `holidays_school_id_foreign` (`school_id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `languages_code_unique` (`code`);

--
-- Indexes for table `leaves`
--
ALTER TABLE `leaves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leaves_user_id_foreign` (`user_id`),
  ADD KEY `leaves_school_id_foreign` (`school_id`),
  ADD KEY `leaves_leave_master_id_foreign` (`leave_master_id`);

--
-- Indexes for table `leave_details`
--
ALTER TABLE `leave_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leave_details_leave_id_foreign` (`leave_id`),
  ADD KEY `leave_details_school_id_foreign` (`school_id`);

--
-- Indexes for table `leave_masters`
--
ALTER TABLE `leave_masters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leave_masters_session_year_id_foreign` (`session_year_id`),
  ADD KEY `leave_masters_school_id_foreign` (`school_id`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lessons_school_id_foreign` (`school_id`),
  ADD KEY `lessons_class_section_id_foreign` (`class_section_id`),
  ADD KEY `lessons_class_subject_id_foreign` (`class_subject_id`);

--
-- Indexes for table `lesson_topics`
--
ALTER TABLE `lesson_topics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lesson_topics_lesson_id_foreign` (`lesson_id`),
  ADD KEY `lesson_topics_school_id_foreign` (`school_id`);

--
-- Indexes for table `mediums`
--
ALTER TABLE `mediums`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mediums_school_id_foreign` (`school_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_session_year_id_foreign` (`session_year_id`),
  ADD KEY `notifications_school_id_foreign` (`school_id`);

--
-- Indexes for table `online_exams`
--
ALTER TABLE `online_exams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `online_exams_school_id_foreign` (`school_id`),
  ADD KEY `online_exams_class_section_id_foreign` (`class_section_id`),
  ADD KEY `online_exams_class_subject_id_foreign` (`class_subject_id`),
  ADD KEY `online_exams_session_year_id_foreign` (`session_year_id`);

--
-- Indexes for table `online_exam_questions`
--
ALTER TABLE `online_exam_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `online_exam_questions_school_id_foreign` (`school_id`),
  ADD KEY `online_exam_questions_class_section_id_foreign` (`class_section_id`),
  ADD KEY `online_exam_questions_class_subject_id_foreign` (`class_subject_id`),
  ADD KEY `online_exam_questions_last_edited_by_foreign` (`last_edited_by`);

--
-- Indexes for table `online_exam_question_choices`
--
ALTER TABLE `online_exam_question_choices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `online_exam_question_choices_school_id_foreign` (`school_id`),
  ADD KEY `online_exam_question_choices_online_exam_id_foreign` (`online_exam_id`),
  ADD KEY `online_exam_question_choices_question_id_foreign` (`question_id`);

--
-- Indexes for table `online_exam_question_options`
--
ALTER TABLE `online_exam_question_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `online_exam_question_options_question_id_foreign` (`question_id`),
  ADD KEY `online_exam_question_options_school_id_foreign` (`school_id`);

--
-- Indexes for table `online_exam_student_answers`
--
ALTER TABLE `online_exam_student_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `online_exam_student_answers_school_id_foreign` (`school_id`),
  ADD KEY `online_exam_student_answers_online_exam_id_foreign` (`online_exam_id`),
  ADD KEY `online_exam_student_answers_question_id_foreign` (`question_id`),
  ADD KEY `online_exam_student_answers_option_id_foreign` (`option_id`),
  ADD KEY `online_exam_student_answers_student_id_foreign` (`student_id`);

--
-- Indexes for table `optional_fees`
--
ALTER TABLE `optional_fees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `optional_fees_class_id_foreign` (`class_id`),
  ADD KEY `optional_fees_payment_transaction_id_foreign` (`payment_transaction_id`),
  ADD KEY `optional_fees_fees_class_id_foreign` (`fees_class_id`),
  ADD KEY `optional_fees_fees_paid_id_foreign` (`fees_paid_id`),
  ADD KEY `optional_fees_school_id_foreign` (`school_id`),
  ADD KEY `optional_fees_student_id_foreign` (`student_id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `package_features`
--
ALTER TABLE `package_features`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`package_id`,`feature_id`),
  ADD KEY `package_features_package_id_index` (`package_id`),
  ADD KEY `package_features_feature_id_index` (`feature_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payment_configurations`
--
ALTER TABLE `payment_configurations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_configurations_school_id_foreign` (`school_id`);

--
-- Indexes for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_transactions_user_id_foreign` (`user_id`),
  ADD KEY `payment_transactions_school_id_foreign` (`school_id`);

--
-- Indexes for table `payroll_settings`
--
ALTER TABLE `payroll_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payroll_settings_school_id_foreign` (`school_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `promote_students`
--
ALTER TABLE `promote_students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_columns` (`student_id`,`class_section_id`,`session_year_id`),
  ADD KEY `promote_students_school_id_foreign` (`school_id`),
  ADD KEY `promote_students_class_section_id_foreign` (`class_section_id`),
  ADD KEY `promote_students_session_year_id_foreign` (`session_year_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_school_id_unique` (`name`,`guard_name`,`school_id`),
  ADD KEY `roles_school_id_foreign` (`school_id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `schools`
--
ALTER TABLE `schools`
  ADD PRIMARY KEY (`id`),
  ADD KEY `schools_admin_id_foreign` (`admin_id`);

--
-- Indexes for table `school_settings`
--
ALTER TABLE `school_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `school_settings_name_school_id_unique` (`name`,`school_id`),
  ADD KEY `school_settings_school_id_foreign` (`school_id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sections_school_id_foreign` (`school_id`);

--
-- Indexes for table `semesters`
--
ALTER TABLE `semesters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `semesters_school_id_foreign` (`school_id`);

--
-- Indexes for table `session_years`
--
ALTER TABLE `session_years`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_years_name_school_id_unique` (`name`,`school_id`),
  ADD KEY `session_years_school_id_foreign` (`school_id`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shifts_school_id_foreign` (`school_id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sliders_school_id_foreign` (`school_id`);

--
-- Indexes for table `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staffs_user_id_foreign` (`user_id`);

--
-- Indexes for table `staff_payrolls`
--
ALTER TABLE `staff_payrolls`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_ids` (`expense_id`,`payroll_setting_id`),
  ADD KEY `staff_payrolls_payroll_setting_id_foreign` (`payroll_setting_id`),
  ADD KEY `staff_payrolls_school_id_foreign` (`school_id`);

--
-- Indexes for table `staff_salaries`
--
ALTER TABLE `staff_salaries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_ids` (`staff_id`,`payroll_setting_id`),
  ADD KEY `staff_salaries_payroll_setting_id_foreign` (`payroll_setting_id`);

--
-- Indexes for table `staff_support_schools`
--
ALTER TABLE `staff_support_schools`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_school` (`user_id`,`school_id`),
  ADD KEY `staff_support_schools_school_id_foreign` (`school_id`);

--
-- Indexes for table `streams`
--
ALTER TABLE `streams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `streams_school_id_foreign` (`school_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `students_school_id_foreign` (`school_id`),
  ADD KEY `students_user_id_foreign` (`user_id`),
  ADD KEY `students_class_section_id_foreign` (`class_section_id`),
  ADD KEY `students_guardian_id_foreign` (`guardian_id`),
  ADD KEY `students_session_year_id_foreign` (`session_year_id`);

--
-- Indexes for table `student_online_exam_statuses`
--
ALTER TABLE `student_online_exam_statuses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_online_exam_statuses_school_id_foreign` (`school_id`),
  ADD KEY `student_online_exam_statuses_online_exam_id_foreign` (`online_exam_id`),
  ADD KEY `student_online_exam_statuses_student_id_foreign` (`student_id`);

--
-- Indexes for table `student_subjects`
--
ALTER TABLE `student_subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_subjects_school_id_foreign` (`school_id`),
  ADD KEY `student_subjects_class_subject_id_foreign` (`class_subject_id`),
  ADD KEY `student_subjects_class_section_id_foreign` (`class_section_id`),
  ADD KEY `student_subjects_session_year_id_foreign` (`session_year_id`),
  ADD KEY `student_subjects_student_id_foreign` (`student_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subjects_school_id_foreign` (`school_id`),
  ADD KEY `subjects_medium_id_foreign` (`medium_id`);

--
-- Indexes for table `subject_teachers`
--
ALTER TABLE `subject_teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_ids` (`class_section_id`,`class_subject_id`,`teacher_id`),
  ADD KEY `subject_teachers_school_id_foreign` (`school_id`),
  ADD KEY `subject_teachers_subject_id_foreign` (`subject_id`),
  ADD KEY `subject_teachers_teacher_id_foreign` (`teacher_id`),
  ADD KEY `subject_teachers_class_subject_id_foreign` (`class_subject_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscriptions_package_id_foreign` (`package_id`),
  ADD KEY `subscriptions_school_id_foreign` (`school_id`);

--
-- Indexes for table `subscription_bills`
--
ALTER TABLE `subscription_bills`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscription_bill` (`subscription_id`,`school_id`),
  ADD KEY `subscription_bills_school_id_foreign` (`school_id`),
  ADD KEY `subscription_bills_payment_transaction_id_foreign` (`payment_transaction_id`);

--
-- Indexes for table `subscription_features`
--
ALTER TABLE `subscription_features`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique` (`subscription_id`,`feature_id`),
  ADD KEY `subscription_features_feature_id_foreign` (`feature_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `system_settings_name_unique` (`name`);

--
-- Indexes for table `timetables`
--
ALTER TABLE `timetables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timetables_subject_teacher_id_foreign` (`subject_teacher_id`),
  ADD KEY `timetables_school_id_foreign` (`school_id`),
  ADD KEY `timetables_class_section_id_foreign` (`class_section_id`),
  ADD KEY `timetables_subject_id_foreign` (`subject_id`),
  ADD KEY `timetables_semester_id_foreign` (`semester_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_school_id_foreign` (`school_id`);

--
-- Indexes for table `user_status_for_next_cycles`
--
ALTER TABLE `user_status_for_next_cycles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_status_for_next_cycles_user_id_unique` (`user_id`),
  ADD KEY `user_status_for_next_cycles_school_id_foreign` (`school_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_calendars`
--
ALTER TABLE `academic_calendars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `addons`
--
ALTER TABLE `addons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `addon_subscriptions`
--
ALTER TABLE `addon_subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `announcement_classes`
--
ALTER TABLE `announcement_classes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assignment_submissions`
--
ALTER TABLE `assignment_submissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificate_templates`
--
ALTER TABLE `certificate_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `class_groups`
--
ALTER TABLE `class_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `class_sections`
--
ALTER TABLE `class_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `class_subjects`
--
ALTER TABLE `class_subjects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `class_teachers`
--
ALTER TABLE `class_teachers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `compulsory_fees`
--
ALTER TABLE `compulsory_fees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `elective_subject_groups`
--
ALTER TABLE `elective_subject_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_marks`
--
ALTER TABLE `exam_marks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_results`
--
ALTER TABLE `exam_results`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_timetables`
--
ALTER TABLE `exam_timetables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `extra_student_datas`
--
ALTER TABLE `extra_student_datas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `features`
--
ALTER TABLE `features`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `feature_sections`
--
ALTER TABLE `feature_sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feature_section_lists`
--
ALTER TABLE `feature_section_lists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fees`
--
ALTER TABLE `fees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fees_advance`
--
ALTER TABLE `fees_advance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fees_class_types`
--
ALTER TABLE `fees_class_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fees_installments`
--
ALTER TABLE `fees_installments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fees_paids`
--
ALTER TABLE `fees_paids`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fees_types`
--
ALTER TABLE `fees_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `form_fields`
--
ALTER TABLE `form_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guidances`
--
ALTER TABLE `guidances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `leaves`
--
ALTER TABLE `leaves`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leave_details`
--
ALTER TABLE `leave_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leave_masters`
--
ALTER TABLE `leave_masters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lesson_topics`
--
ALTER TABLE `lesson_topics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mediums`
--
ALTER TABLE `mediums`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exams`
--
ALTER TABLE `online_exams`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exam_questions`
--
ALTER TABLE `online_exam_questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exam_question_choices`
--
ALTER TABLE `online_exam_question_choices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exam_question_options`
--
ALTER TABLE `online_exam_question_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `online_exam_student_answers`
--
ALTER TABLE `online_exam_student_answers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `optional_fees`
--
ALTER TABLE `optional_fees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `package_features`
--
ALTER TABLE `package_features`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `payment_configurations`
--
ALTER TABLE `payment_configurations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll_settings`
--
ALTER TABLE `payroll_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=459;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promote_students`
--
ALTER TABLE `promote_students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `schools`
--
ALTER TABLE `schools`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `school_settings`
--
ALTER TABLE `school_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `semesters`
--
ALTER TABLE `semesters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `session_years`
--
ALTER TABLE `session_years`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staffs`
--
ALTER TABLE `staffs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `staff_payrolls`
--
ALTER TABLE `staff_payrolls`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff_salaries`
--
ALTER TABLE `staff_salaries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff_support_schools`
--
ALTER TABLE `staff_support_schools`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `streams`
--
ALTER TABLE `streams`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_online_exam_statuses`
--
ALTER TABLE `student_online_exam_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_subjects`
--
ALTER TABLE `student_subjects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `subject_teachers`
--
ALTER TABLE `subject_teachers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subscription_bills`
--
ALTER TABLE `subscription_bills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_features`
--
ALTER TABLE `subscription_features`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `timetables`
--
ALTER TABLE `timetables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user_status_for_next_cycles`
--
ALTER TABLE `user_status_for_next_cycles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `academic_calendars`
--
ALTER TABLE `academic_calendars`
  ADD CONSTRAINT `academic_calendars_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `academic_calendars_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`);

--
-- Constraints for table `addons`
--
ALTER TABLE `addons`
  ADD CONSTRAINT `addons_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`);

--
-- Constraints for table `addon_subscriptions`
--
ALTER TABLE `addon_subscriptions`
  ADD CONSTRAINT `addon_subscriptions_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `addon_subscriptions_payment_transaction_id_foreign` FOREIGN KEY (`payment_transaction_id`) REFERENCES `payment_transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `addon_subscriptions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `addon_subscriptions_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `announcements_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`);

--
-- Constraints for table `announcement_classes`
--
ALTER TABLE `announcement_classes`
  ADD CONSTRAINT `announcement_classes_announcement_id_foreign` FOREIGN KEY (`announcement_id`) REFERENCES `announcements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `announcement_classes_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `announcement_classes_class_subject_id_foreign` FOREIGN KEY (`class_subject_id`) REFERENCES `class_subjects` (`id`),
  ADD CONSTRAINT `announcement_classes_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `assignments_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `assignments_class_subject_id_foreign` FOREIGN KEY (`class_subject_id`) REFERENCES `class_subjects` (`id`),
  ADD CONSTRAINT `assignments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `assignments_edited_by_foreign` FOREIGN KEY (`edited_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `assignments_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assignments_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`);

--
-- Constraints for table `assignment_submissions`
--
ALTER TABLE `assignment_submissions`
  ADD CONSTRAINT `assignment_submissions_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assignment_submissions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assignment_submissions_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`),
  ADD CONSTRAINT `assignment_submissions_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `attendances_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `attendances_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendances_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`),
  ADD CONSTRAINT `attendances_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `certificate_templates`
--
ALTER TABLE `certificate_templates`
  ADD CONSTRAINT `certificate_templates_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_medium_id_foreign` FOREIGN KEY (`medium_id`) REFERENCES `mediums` (`id`),
  ADD CONSTRAINT `classes_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `classes_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`),
  ADD CONSTRAINT `classes_stream_id_foreign` FOREIGN KEY (`stream_id`) REFERENCES `streams` (`id`);

--
-- Constraints for table `class_groups`
--
ALTER TABLE `class_groups`
  ADD CONSTRAINT `class_groups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `class_sections`
--
ALTER TABLE `class_sections`
  ADD CONSTRAINT `class_sections_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  ADD CONSTRAINT `class_sections_medium_id_foreign` FOREIGN KEY (`medium_id`) REFERENCES `mediums` (`id`),
  ADD CONSTRAINT `class_sections_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `class_sections_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`);

--
-- Constraints for table `class_subjects`
--
ALTER TABLE `class_subjects`
  ADD CONSTRAINT `class_subjects_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  ADD CONSTRAINT `class_subjects_elective_subject_group_id_foreign` FOREIGN KEY (`elective_subject_group_id`) REFERENCES `elective_subject_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `class_subjects_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `class_subjects_semester_id_foreign` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`),
  ADD CONSTRAINT `class_subjects_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`);

--
-- Constraints for table `class_teachers`
--
ALTER TABLE `class_teachers`
  ADD CONSTRAINT `class_teachers_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `class_teachers_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `class_teachers_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `compulsory_fees`
--
ALTER TABLE `compulsory_fees`
  ADD CONSTRAINT `compulsory_fees_fees_paid_id_foreign` FOREIGN KEY (`fees_paid_id`) REFERENCES `fees_paids` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `compulsory_fees_installment_id_foreign` FOREIGN KEY (`installment_id`) REFERENCES `fees_installments` (`id`),
  ADD CONSTRAINT `compulsory_fees_payment_transaction_id_foreign` FOREIGN KEY (`payment_transaction_id`) REFERENCES `payment_transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `compulsory_fees_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `compulsory_fees_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `elective_subject_groups`
--
ALTER TABLE `elective_subject_groups`
  ADD CONSTRAINT `elective_subject_groups_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  ADD CONSTRAINT `elective_subject_groups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `elective_subject_groups_semester_id_foreign` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`);

--
-- Constraints for table `exams`
--
ALTER TABLE `exams`
  ADD CONSTRAINT `exams_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  ADD CONSTRAINT `exams_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exams_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`);

--
-- Constraints for table `exam_marks`
--
ALTER TABLE `exam_marks`
  ADD CONSTRAINT `exam_marks_class_subject_id_foreign` FOREIGN KEY (`class_subject_id`) REFERENCES `class_subjects` (`id`),
  ADD CONSTRAINT `exam_marks_exam_timetable_id_foreign` FOREIGN KEY (`exam_timetable_id`) REFERENCES `exam_timetables` (`id`),
  ADD CONSTRAINT `exam_marks_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exam_marks_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`),
  ADD CONSTRAINT `exam_marks_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `exam_results`
--
ALTER TABLE `exam_results`
  ADD CONSTRAINT `exam_results_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `exam_results_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`),
  ADD CONSTRAINT `exam_results_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exam_results_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`),
  ADD CONSTRAINT `exam_results_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `exam_timetables`
--
ALTER TABLE `exam_timetables`
  ADD CONSTRAINT `exam_timetables_class_subject_id_foreign` FOREIGN KEY (`class_subject_id`) REFERENCES `class_subjects` (`id`),
  ADD CONSTRAINT `exam_timetables_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exam_timetables_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exam_timetables_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `expense_categories` (`id`),
  ADD CONSTRAINT `expenses_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `expenses_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`),
  ADD CONSTRAINT `expenses_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`id`);

--
-- Constraints for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD CONSTRAINT `expense_categories_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `extra_student_datas`
--
ALTER TABLE `extra_student_datas`
  ADD CONSTRAINT `extra_student_datas_form_field_id_foreign` FOREIGN KEY (`form_field_id`) REFERENCES `form_fields` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `extra_student_datas_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `extra_student_datas_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `faqs`
--
ALTER TABLE `faqs`
  ADD CONSTRAINT `faqs_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feature_section_lists`
--
ALTER TABLE `feature_section_lists`
  ADD CONSTRAINT `feature_section_lists_feature_section_id_foreign` FOREIGN KEY (`feature_section_id`) REFERENCES `feature_sections` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fees`
--
ALTER TABLE `fees`
  ADD CONSTRAINT `fees_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  ADD CONSTRAINT `fees_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fees_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fees_advance`
--
ALTER TABLE `fees_advance`
  ADD CONSTRAINT `fees_advance_compulsory_fee_id_foreign` FOREIGN KEY (`compulsory_fee_id`) REFERENCES `compulsory_fees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fees_advance_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fees_advance_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fees_class_types`
--
ALTER TABLE `fees_class_types`
  ADD CONSTRAINT `fees_class_types_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fees_class_types_fees_id_foreign` FOREIGN KEY (`fees_id`) REFERENCES `fees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fees_class_types_fees_type_id_foreign` FOREIGN KEY (`fees_type_id`) REFERENCES `fees_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fees_class_types_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fees_installments`
--
ALTER TABLE `fees_installments`
  ADD CONSTRAINT `fees_installments_fees_id_foreign` FOREIGN KEY (`fees_id`) REFERENCES `fees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fees_installments_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fees_installments_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fees_paids`
--
ALTER TABLE `fees_paids`
  ADD CONSTRAINT `fees_paids_fees_id_foreign` FOREIGN KEY (`fees_id`) REFERENCES `fees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fees_paids_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fees_paids_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `fees_types`
--
ALTER TABLE `fees_types`
  ADD CONSTRAINT `fees_types_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `form_fields`
--
ALTER TABLE `form_fields`
  ADD CONSTRAINT `form_fields_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `galleries`
--
ALTER TABLE `galleries`
  ADD CONSTRAINT `galleries_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `galleries_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `grades_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `holidays`
--
ALTER TABLE `holidays`
  ADD CONSTRAINT `holidays_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `leaves`
--
ALTER TABLE `leaves`
  ADD CONSTRAINT `leaves_leave_master_id_foreign` FOREIGN KEY (`leave_master_id`) REFERENCES `leave_masters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leaves_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leaves_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `leave_details`
--
ALTER TABLE `leave_details`
  ADD CONSTRAINT `leave_details_leave_id_foreign` FOREIGN KEY (`leave_id`) REFERENCES `leaves` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leave_details_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `leave_masters`
--
ALTER TABLE `leave_masters`
  ADD CONSTRAINT `leave_masters_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `leave_masters_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `lessons_class_subject_id_foreign` FOREIGN KEY (`class_subject_id`) REFERENCES `class_subjects` (`id`),
  ADD CONSTRAINT `lessons_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lesson_topics`
--
ALTER TABLE `lesson_topics`
  ADD CONSTRAINT `lesson_topics_lesson_id_foreign` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lesson_topics_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mediums`
--
ALTER TABLE `mediums`
  ADD CONSTRAINT `mediums_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `online_exams`
--
ALTER TABLE `online_exams`
  ADD CONSTRAINT `online_exams_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `online_exams_class_subject_id_foreign` FOREIGN KEY (`class_subject_id`) REFERENCES `class_subjects` (`id`),
  ADD CONSTRAINT `online_exams_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `online_exams_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`);

--
-- Constraints for table `online_exam_questions`
--
ALTER TABLE `online_exam_questions`
  ADD CONSTRAINT `online_exam_questions_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `online_exam_questions_class_subject_id_foreign` FOREIGN KEY (`class_subject_id`) REFERENCES `class_subjects` (`id`),
  ADD CONSTRAINT `online_exam_questions_last_edited_by_foreign` FOREIGN KEY (`last_edited_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `online_exam_questions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `online_exam_question_choices`
--
ALTER TABLE `online_exam_question_choices`
  ADD CONSTRAINT `online_exam_question_choices_online_exam_id_foreign` FOREIGN KEY (`online_exam_id`) REFERENCES `online_exams` (`id`),
  ADD CONSTRAINT `online_exam_question_choices_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `online_exam_questions` (`id`),
  ADD CONSTRAINT `online_exam_question_choices_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `online_exam_question_options`
--
ALTER TABLE `online_exam_question_options`
  ADD CONSTRAINT `online_exam_question_options_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `online_exam_questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `online_exam_question_options_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `online_exam_student_answers`
--
ALTER TABLE `online_exam_student_answers`
  ADD CONSTRAINT `online_exam_student_answers_online_exam_id_foreign` FOREIGN KEY (`online_exam_id`) REFERENCES `online_exams` (`id`),
  ADD CONSTRAINT `online_exam_student_answers_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `online_exam_question_options` (`id`),
  ADD CONSTRAINT `online_exam_student_answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `online_exam_question_choices` (`id`),
  ADD CONSTRAINT `online_exam_student_answers_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `online_exam_student_answers_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `optional_fees`
--
ALTER TABLE `optional_fees`
  ADD CONSTRAINT `optional_fees_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `optional_fees_fees_class_id_foreign` FOREIGN KEY (`fees_class_id`) REFERENCES `fees_class_types` (`id`),
  ADD CONSTRAINT `optional_fees_fees_paid_id_foreign` FOREIGN KEY (`fees_paid_id`) REFERENCES `fees_paids` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `optional_fees_payment_transaction_id_foreign` FOREIGN KEY (`payment_transaction_id`) REFERENCES `payment_transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `optional_fees_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `optional_fees_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `package_features`
--
ALTER TABLE `package_features`
  ADD CONSTRAINT `package_features_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`),
  ADD CONSTRAINT `package_features_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`);

--
-- Constraints for table `payment_configurations`
--
ALTER TABLE `payment_configurations`
  ADD CONSTRAINT `payment_configurations_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payment_transactions`
--
ALTER TABLE `payment_transactions`
  ADD CONSTRAINT `payment_transactions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payment_transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payroll_settings`
--
ALTER TABLE `payroll_settings`
  ADD CONSTRAINT `payroll_settings_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `promote_students`
--
ALTER TABLE `promote_students`
  ADD CONSTRAINT `promote_students_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `promote_students_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `promote_students_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`),
  ADD CONSTRAINT `promote_students_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `roles`
--
ALTER TABLE `roles`
  ADD CONSTRAINT `roles_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `schools`
--
ALTER TABLE `schools`
  ADD CONSTRAINT `schools_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `school_settings`
--
ALTER TABLE `school_settings`
  ADD CONSTRAINT `school_settings_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `semesters`
--
ALTER TABLE `semesters`
  ADD CONSTRAINT `semesters_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `session_years`
--
ALTER TABLE `session_years`
  ADD CONSTRAINT `session_years_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `shifts`
--
ALTER TABLE `shifts`
  ADD CONSTRAINT `shifts_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sliders`
--
ALTER TABLE `sliders`
  ADD CONSTRAINT `sliders_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `staffs`
--
ALTER TABLE `staffs`
  ADD CONSTRAINT `staffs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `staff_payrolls`
--
ALTER TABLE `staff_payrolls`
  ADD CONSTRAINT `staff_payrolls_expense_id_foreign` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_payrolls_payroll_setting_id_foreign` FOREIGN KEY (`payroll_setting_id`) REFERENCES `payroll_settings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_payrolls_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `staff_salaries`
--
ALTER TABLE `staff_salaries`
  ADD CONSTRAINT `staff_salaries_payroll_setting_id_foreign` FOREIGN KEY (`payroll_setting_id`) REFERENCES `payroll_settings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_salaries_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `staff_support_schools`
--
ALTER TABLE `staff_support_schools`
  ADD CONSTRAINT `staff_support_schools_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `staff_support_schools_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `streams`
--
ALTER TABLE `streams`
  ADD CONSTRAINT `streams_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `students_guardian_id_foreign` FOREIGN KEY (`guardian_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `students_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `students_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `students_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `student_online_exam_statuses`
--
ALTER TABLE `student_online_exam_statuses`
  ADD CONSTRAINT `student_online_exam_statuses_online_exam_id_foreign` FOREIGN KEY (`online_exam_id`) REFERENCES `online_exams` (`id`),
  ADD CONSTRAINT `student_online_exam_statuses_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_online_exam_statuses_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `student_subjects`
--
ALTER TABLE `student_subjects`
  ADD CONSTRAINT `student_subjects_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `student_subjects_class_subject_id_foreign` FOREIGN KEY (`class_subject_id`) REFERENCES `class_subjects` (`id`),
  ADD CONSTRAINT `student_subjects_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_subjects_session_year_id_foreign` FOREIGN KEY (`session_year_id`) REFERENCES `session_years` (`id`),
  ADD CONSTRAINT `student_subjects_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_medium_id_foreign` FOREIGN KEY (`medium_id`) REFERENCES `mediums` (`id`),
  ADD CONSTRAINT `subjects_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subject_teachers`
--
ALTER TABLE `subject_teachers`
  ADD CONSTRAINT `subject_teachers_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `subject_teachers_class_subject_id_foreign` FOREIGN KEY (`class_subject_id`) REFERENCES `class_subjects` (`id`),
  ADD CONSTRAINT `subject_teachers_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subject_teachers_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`),
  ADD CONSTRAINT `subject_teachers_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages` (`id`),
  ADD CONSTRAINT `subscriptions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subscription_bills`
--
ALTER TABLE `subscription_bills`
  ADD CONSTRAINT `subscription_bills_payment_transaction_id_foreign` FOREIGN KEY (`payment_transaction_id`) REFERENCES `payment_transactions` (`id`),
  ADD CONSTRAINT `subscription_bills_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscription_bills_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`);

--
-- Constraints for table `subscription_features`
--
ALTER TABLE `subscription_features`
  ADD CONSTRAINT `subscription_features_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`),
  ADD CONSTRAINT `subscription_features_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`);

--
-- Constraints for table `timetables`
--
ALTER TABLE `timetables`
  ADD CONSTRAINT `timetables_class_section_id_foreign` FOREIGN KEY (`class_section_id`) REFERENCES `class_sections` (`id`),
  ADD CONSTRAINT `timetables_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `timetables_semester_id_foreign` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`),
  ADD CONSTRAINT `timetables_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`),
  ADD CONSTRAINT `timetables_subject_teacher_id_foreign` FOREIGN KEY (`subject_teacher_id`) REFERENCES `subject_teachers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_status_for_next_cycles`
--
ALTER TABLE `user_status_for_next_cycles`
  ADD CONSTRAINT `user_status_for_next_cycles_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_status_for_next_cycles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
