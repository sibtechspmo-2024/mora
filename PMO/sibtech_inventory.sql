-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 14, 2026 at 02:00 AM
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
-- Database: `sibtech_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `borrow_requests`
--

CREATE TABLE `borrow_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `request_group_id` varchar(100) NOT NULL,
  `requisitioner_name` varchar(255) NOT NULL,
  `department` varchar(100) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `borrow_date` date NOT NULL,
  `expected_return_date` date NOT NULL,
  `scheduled_time` varchar(50) DEFAULT '09:00 AM - 10:00 AM',
  `purpose` text DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `item_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrow_requests`
--

INSERT INTO `borrow_requests` (`id`, `user_id`, `request_group_id`, `requisitioner_name`, `department`, `item_id`, `quantity`, `borrow_date`, `expected_return_date`, `scheduled_time`, `purpose`, `status`, `created_at`, `item_name`) VALUES
(1, 2, 'BRW-20260908020837-289', 'Joey Morales', 'SPMO', 0, 1, '2026-09-08', '2026-09-11', '09:00 AM - 10:00 AM', 'For office use', 'Approved', '2026-09-08 08:08:37', 'projector'),
(3, 2, 'BRW-20260909062415-329', 'Joey L Morales', 'SPMO', 0, 1, '2026-09-09', '2026-09-12', '09:00 AM - 10:00 AM', 'For office use', 'Approved', '2026-09-09 12:24:15', 'projector'),
(4, 6, 'BRW-20260911014051-119', 'Joey L. Morales', 'CTI', 0, 1, '2026-09-11', '2026-09-14', '09:00 AM - 10:00 AM', 'd', 'Pending', '2026-09-11 07:40:51', 'projector'),
(5, 6, 'BRW-20260911014051-119', 'Joey L. Morales', 'CTI', 0, 1, '2026-09-11', '2026-09-14', '09:00 AM - 10:00 AM', 'd', 'Pending', '2026-09-11 07:40:51', 'extension'),
(6, 6, 'BRW-20260911072702-980', 'Joey L. Morales', 'CTE', 0, 1, '2026-09-11', '2026-09-14', '10:00 AM - 11:00 AM', 'class', 'Rejected', '2026-09-11 13:27:02', 'speaker');

-- --------------------------------------------------------

--
-- Table structure for table `calendar_schedules`
--

CREATE TABLE `calendar_schedules` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `department` text DEFAULT NULL,
  `event_date` date NOT NULL,
  `scheduled_time` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `created_by` text DEFAULT 'Admin',
  `created_at` datetime DEFAULT current_timestamp(),
  `room_reserved` varchar(255) DEFAULT '',
  `room` text DEFAULT NULL,
  `equipment` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` text DEFAULT 'Approved'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_printing_requests`
--

CREATE TABLE `document_printing_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `request_group_id` varchar(100) NOT NULL,
  `requisitioner_name` varchar(255) NOT NULL,
  `department` varchar(100) NOT NULL,
  `document_file` varchar(255) NOT NULL,
  `paper_size` varchar(50) NOT NULL DEFAULT 'A4',
  `print_color` varchar(50) NOT NULL DEFAULT 'Black & White',
  `print_sides` varchar(50) NOT NULL DEFAULT 'Single-sided',
  `binding_option` varchar(50) NOT NULL DEFAULT 'None',
  `page_count` int(11) NOT NULL DEFAULT 1,
  `copies` int(11) NOT NULL DEFAULT 1,
  `total_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `purpose` text DEFAULT NULL,
  `date_needed` date DEFAULT NULL,
  `scheduled_time` varchar(50) DEFAULT '09:00 AM - 10:00 AM',
  `status` varchar(50) NOT NULL DEFAULT 'Pending',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `actual_stocks` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `item_name`, `unit`, `actual_stocks`, `created_at`, `image`) VALUES
(1, 'GD Newsprint 52 gsm. Short (8.5” x 11”) 480’s', 'ream(s)', 0, '2026-08-28 03:13:08', 'img_6a9920331ff878.31758369.png'),
(2, 'GD Newsprint 52 gsm. Long (8.5” x 13”) 480’s', 'ream(s)', 0, '2026-08-28 03:13:08', 'img_6a99202b170954.94880118.png'),
(3, 'Hard Copy 70 gsm. Short (8.5” x 11”) 500’s', 'ream(s)', 0, '2026-08-28 03:13:08', 'img_6a963e16cd73e6.85128318.jpg'),
(4, 'Hard Copy 70 gsm Long (8.5” x 13”) 500’s', 'ream(s)', 26, '2026-08-28 03:13:08', 'img_6a963e0832ec30.63427161.jpg'),
(5, 'Worx Paper 90 gsm. Pale Cream Long (8.5\" x 13\") 10\'s', 'packs', 0, '2026-08-28 03:13:08', 'img_6a9641e0658221.82160853.jpg'),
(6, 'Worx Board 200 gsm. Pale Cream Long (8.5\" x 13\") 10\'s', 'packs', 40, '2026-08-28 03:13:08', 'img_6a9641d89bb3b2.86011069.jpg'),
(7, 'Vellum #120 230 gsm. White Short (8.5\" x 11\") 100\'s', 'pc(s)', 88, '2026-08-28 03:13:08', 'img_6a9641a35e67f7.16133297.jpg'),
(8, 'Vellum #120 230 gsm. White Long (8.5\" x 13\") 100\'s', 'pc(s)', 409, '2026-08-28 03:13:08', 'img_6a96419b809fb3.43247463.jpg'),
(9, 'Oslo Paper (9\' x 12\') 250s', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963fbb205927.26458667.jpg'),
(10, 'Splash Colored Paper Long (8.5” x 13”) 250’s', 'pc(s)', 555, '2026-08-28 03:13:08', 'img_6a9640d4b8bb77.69279021.jpg'),
(11, 'Splash Colored Paper Short (8.5” x 11”) 250’s', 'pc(s)', 510, '2026-08-28 03:13:08', 'img_6a9640e35f56e3.67494555.jpg'),
(12, 'Fluorescent Sticker A4 100’s (Neon Yellow)', 'pc(s)', 460, '2026-08-28 03:13:08', 'img_6a963db03cc5a4.19746065.jpg'),
(13, 'Book Sticker A4 100’s (White/Blue)', 'pc(s)', 229, '2026-08-28 03:13:08', 'img_6a963811807929.41440072.jpg'),
(14, 'Record Book 300-Pages', 'pc(s)', 5, '2026-08-28 03:13:08', 'img_6a96406d7c2514.22286283.jpg'),
(15, 'MK Folder 14 Pts. Short', 'pc(s)', 427, '2026-08-28 03:13:08', 'img_6a963f7a5add95.19562934.jpg'),
(16, 'MK Folder 14 Pts. Long', 'pc(s)', 209, '2026-08-28 03:13:08', 'img_6a963f6f69dce4.91954148.jpg'),
(17, 'Colored Folder Long (Red)', 'pc(s)', 8, '2026-08-28 03:13:08', 'img_6a963ca17a1988.85093285.jpg'),
(18, 'Colored Folder Long (Yellow)', 'pc(s)', 11, '2026-08-28 03:13:08', 'img_6a963cabb742e7.24198209.jpg'),
(19, 'Colored Folder Long (Green)', 'pc(s)', 46, '2026-08-28 03:13:08', 'img_6a963c91986f44.36946436.jpg'),
(20, 'Colored Folder Long (Blue)', 'pc(s)', 86, '2026-08-28 03:13:08', 'img_6a963c83b91801.62062628.jpg'),
(21, 'Pressboard Folder Long (GREEN)', 'pc(s)', 353, '2026-08-28 03:13:08', NULL),
(22, 'Pressboard Folder Long (Blue)', 'pc(s)', 72, '2026-08-28 03:13:08', 'img_6a96403a4d0480.97904494.jpg'),
(23, 'Folder Jacket Short', 'pc(s)', 146, '2026-08-28 03:13:08', 'img_6a963e43618b63.57731152.jpg'),
(24, 'Folder Jacket Long', 'pc(s)', 17, '2026-08-28 03:13:08', 'img_6a963dbe4150a2.73503836.jpg'),
(25, 'Brown Document Envelope 150# Short (9\" x 12\") 500\'s', 'pc(s)', 932, '2026-08-28 03:13:08', 'img_6a963bd5451e78.91857747.jpg'),
(26, 'Brown Document Envelope 150# Long (10\" x 15\") 500\'s', 'pc(s)', 798, '2026-08-28 03:13:08', 'img_6a963bcda71483.28843757.jpg'),
(27, 'White Trojan Letter Envelope Short (6-3/4 X) 500’s', 'pc(s)', 1251, '2026-08-28 03:13:08', 'img_6a9641be33bfb0.43952013.jpg'),
(28, 'White Trojan Letter Envelope Long (10 XX ) 500’s', 'pc(s)', 1058, '2026-08-28 03:13:08', 'img_6a9641b688ade6.20142821.jpg'),
(29, 'Pay Envelope #8 (1/2)  (500\'s)', 'pc(s)', 450, '2026-08-28 03:13:08', 'img_6a963ffc38ed19.64888042.jpg'),
(30, 'Brown Kraft Expanding Envelope Long w/ Garter', 'pc(s)', 362, '2026-08-28 03:13:08', 'img_6a96384ea43422.10693799.jpg'),
(31, 'Brown Kraft Expanding Envelope Short w/ Garter', 'pc(s)', 44, '2026-08-28 03:13:08', 'img_6a96385c3254f4.99710926.jpg'),
(32, 'Plastic Envelope Long (Gauge 4.0)', 'pc(s)', 16, '2026-08-28 03:13:08', 'img_6a96402670d9f3.69350436.jpg'),
(33, 'Arch File 3” Long (Black)', 'pc(s)', 12, '2026-08-28 03:13:08', 'img_6a991f52549ff9.41529255.jpg'),
(34, 'Arch File 3” Long (Blue)', 'pc(s)', 20, '2026-08-28 03:13:08', 'img_6a991f7c2cf054.04668217.jpg'),
(35, 'HBW 9801 Ballpen (Black) 50\'s', 'pc(s)', 311, '2026-08-28 03:13:08', 'img_6a963e2c4123c6.02578691.jpg'),
(36, 'HBW 9801 Ballpen (Red) 50\'s', 'pc(s)', 232, '2026-08-28 03:13:08', 'img_6a963e356dd0a1.60892563.jpg'),
(37, 'GT Super Gel 0.5mm (Black)', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963de914a2c1.67570051.jpg'),
(38, 'Solido Pencil # 2 12\'s', 'pc(s)', 18, '2026-08-28 03:13:08', 'img_6a9640ba79c588.08942479.jpg'),
(39, 'HBW Highlighter - Orange', 'pc(s)', 12, '2026-08-28 03:13:08', 'img_6a963e69b71649.73181273.jpg'),
(40, 'HBW Highlighter - Yellow', 'pc(s)', 1, '2026-08-28 03:13:08', 'img_6a963e7d902060.77108361.jpg'),
(41, 'HBW Highlighter - Green', 'pc(s)', 8, '2026-08-28 03:13:08', 'img_6a963e5dd4f5d4.29420232.jpg'),
(42, 'HBW Highlighter - Pink', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963e7382b105.63412592.jpg'),
(43, 'HBW Highlighter - Blue', 'pc(s)', 5, '2026-08-28 03:13:08', 'img_6a963e4f016a74.07541954.jpg'),
(44, 'Flex Whiteboard Marker (Black) 12\'s', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963d9827e3f7.29224510.jpg'),
(45, 'Flex Whiteboard Marker (Red) 12\'s', 'pc(s)', 37, '2026-08-28 03:13:08', NULL),
(46, 'Flex Office Marker (Black) 12\'s', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963d7bb5dcd2.55054751.jpg'),
(47, 'Flex Office Marker (Red) 12\'s', 'pc(s)', 43, '2026-08-28 03:13:08', NULL),
(48, 'White Craft Glue (L)', 'bottles', 0, '2026-08-28 03:13:08', 'img_6a9641ab8088d5.75272875.jpg'),
(49, 'Joy Glue Stick 9g', 'pc(s)', 2, '2026-08-28 03:13:08', 'img_6a963eb8e2e6a2.53065605.jpg'),
(50, 'Scotch Tape 1/2”', 'rolls', 16, '2026-08-28 03:13:08', 'img_6a964099d49e63.10813483.jpg'),
(51, 'Scotch Tape 1”', 'rolls', 0, '2026-08-28 03:13:08', NULL),
(52, 'Masking Tape 1/2”', 'rolls', 22, '2026-08-28 03:13:08', 'img_6a963f149680b5.22621073.jpg'),
(53, 'Masking Tape 1”', 'rolls', 23, '2026-08-28 03:13:08', 'img_6a963f1ebfd020.16027739.jpg'),
(54, 'Double Sided Tape 1”', 'rolls', 0, '2026-08-28 03:13:08', 'img_6a963cd8637328.97576922.jpg'),
(55, 'Packaging Tape Clear (L)', 'rolls', 19, '2026-08-28 03:13:08', 'img_6a963fcf461423.51351782.jpg'),
(56, 'Paper Clip (S)', 'box(es)', 19, '2026-08-28 03:13:08', 'img_6a963fefc7f532.77450890.jpg'),
(57, 'Paper Clip (L)', 'box(es)', 11, '2026-08-28 03:13:08', 'img_6a963fe46cfe63.72687477.jpg'),
(58, 'Push Pins 30’s', 'box(es)', 38, '2026-08-28 03:13:08', 'img_6a96404c911253.48315786.jpg'),
(59, 'Thumbtacks', 'box(es)', 30, '2026-08-28 03:13:08', 'img_6a96418bbc3636.23078759.jpg'),
(60, 'Rubber Band 50 grams (Round)', 'box(es)', 35, '2026-08-28 03:13:08', 'img_6a96407ea834d6.50757481.jpg'),
(61, 'Binder Clip (1-5/8”)', 'box(es)', 0, '2026-08-28 03:13:08', 'img_6a9637fca32727.30972726.jpg'),
(62, 'Fastener', 'box(es)', 29, '2026-08-28 03:13:08', 'img_6a963d6c475c89.39667208.jpg'),
(63, 'Joy # 35 Stapler w/ Remover #405', 'pc(s)', 2, '2026-08-28 03:13:08', 'img_6a9641286a0fc2.50057544.jpg'),
(64, 'Joy Staplewire # 35', 'box(es)', 13, '2026-08-28 03:13:08', 'img_6a963ed5043c96.57103071.jpg'),
(65, 'Joy PS-120 Power Saving Stapler (120 sheets)', 'pc(s)', 2, '2026-08-28 03:13:08', 'img_6a99210f49bd16.15646223.jpg'),
(66, 'Joy Staplewire #13 (23/13)', 'box(es)', 9, '2026-08-28 03:13:08', 'img_6a9921543c66b6.59495056.webp'),
(67, 'SHIF Scissors 6-1/2\"', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a9640ae80bdd8.49514654.jpg'),
(68, 'Ordinary Cutter (L)', 'pc(s)', 4, '2026-08-28 03:13:08', 'img_6a963fae53dd83.20245572.jpg'),
(69, 'Tape Dispenser', 'pc(s)', 1, '2026-08-28 03:13:08', 'img_6a9641844b2dc4.26748110.jpg'),
(70, 'Heavy Duty 2-Hole Metal Puncher', 'pc(s)', 9, '2026-08-28 03:13:08', 'img_6a963e8a828410.72327750.jpg'),
(71, 'Plain Film Index 1.24cm x 5 pads-25 peels (Assorted)', 'set(s)', 22, '2026-08-28 03:13:08', 'img_6a9640053c2b76.95180562.jpg'),
(72, 'Stick On Note 3” x 3” (Assorted)', 'pad(s)', 25, '2026-08-28 03:13:08', 'img_6a964148828e59.29282027.jpg'),
(73, 'Correction Tape 8m', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963cba1c2777.63805716.jpg'),
(74, 'Plastic 2-Hole Sharpener 24’s', 'pc(s)', 39, '2026-08-28 03:13:08', 'img_6a9640117edc00.33495004.jpg'),
(75, 'Ruler 12”', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a96408b10ef08.08578059.jpg'),
(76, 'Steel Ruler 12”', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a96413cd8fa36.37935810.jpg'),
(77, 'Steel Ruler 24”', 'pc(s)', 0, '2026-08-28 03:13:08', NULL),
(78, 'Energizer AAA', 'pc(s)', 12, '2026-08-28 03:13:08', 'img_6a963cffb2cf58.74223380.jpg'),
(79, 'DVD-RW', 'pc(s)', 28, '2026-08-28 03:13:08', 'img_6a963cf5018962.32125596.jpg'),
(80, 'CD Case', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963bf1db8f15.97232573.jpg'),
(81, 'Jumbo Plastic Cover Gauge 2.60 (Hard - Transparent)', 'rolls', 0, '2026-08-28 03:13:08', 'img_6a963ee715c295.39368383.jpg'),
(82, 'Stamp Pad # 3 (Blue)', 'pc(s)', 5, '2026-08-28 03:13:08', 'img_6a9640f0a51b18.14791327.jpg'),
(83, 'Stamp Pad # 3 (Black)', 'pc(s)', 4, '2026-08-28 03:13:08', NULL),
(84, 'Stamp Pad Ink 30ml Blue', 'bottle(s)', 10, '2026-08-28 03:13:08', 'img_6a96410d93d577.29292888.jpg'),
(85, 'Stamp Pad Ink 30ml Black', 'bottle(s)', 10, '2026-08-28 03:13:08', NULL),
(86, 'EPSON V100 (003) Black Ink Bottle (C13T00V100)', 'bottle(s)', 13, '2026-08-28 03:13:08', 'img_6a963d40536db5.69813760.jpg'),
(87, 'EPSON V200 (003) Cyan Ink Bottle (C13T00V200)', 'bottle(s)', 6, '2026-08-28 03:13:08', 'img_6a963d49932533.95390340.jpg'),
(88, 'EPSON V400 (003) Yellow Ink Bottle (C13T00V400)', 'bottle(s)', 8, '2026-08-28 03:13:08', 'img_6a963d5be86d21.45572497.jpg'),
(89, 'EPSON V300 (003) Magenta Ink Bottle (C13T00V300)', 'bottle(s)', 12, '2026-08-28 03:13:08', 'img_6a963d517add94.94280631.jpg'),
(90, 'Epson T6641 Black Ink Bottle 70ml', 'bottle(s)', 5, '2026-08-28 03:13:08', 'img_6a963d13c30434.72388414.jpg'),
(91, 'Epson T6642 Cyan Ink Bottle 70ml', 'bottle(s)', 12, '2026-08-28 03:13:08', 'img_6a963d21bed147.26011958.jpg'),
(92, 'Epson T6643 Magenta Ink Bottle 70ml', 'bottle(s)', 18, '2026-08-28 03:13:08', 'img_6a963d2e6fbbe9.12292783.jpg'),
(93, 'Epson T6644 Yellow Ink Bottle 70ml', 'bottle(s)', 16, '2026-08-28 03:13:08', 'img_6a963d3841ae34.25378352.jpg'),
(94, 'Kyocera Copier Toner', 'pc(s)', 0, '2026-08-28 03:13:08', NULL),
(95, 'OPP Plastic 4x5 with Adhesive', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963f95a746a2.69578279.jpg'),
(96, 'Certificate Holder Short', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963c0adb9592.19078319.jpg'),
(97, 'Surgical Gloves', 'box(es)', 0, '2026-08-28 03:13:08', NULL),
(98, 'SD Biosensor Nasal Antigen Kits', 'pc(s)', 0, '2026-08-28 03:13:08', NULL),
(99, 'Joinstar Saliva Antigen Kits', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a9920e9bf5755.84850757.jpg'),
(100, 'Unli Bond 70 gsm. Short (8.5’ x 11”)', 'ream(s)', 0, '2026-08-28 03:13:08', NULL),
(101, 'Joy Scissors 8\"', 'pc(s)', 10, '2026-08-28 03:13:08', 'img_6a99213a7549c5.40413100.jpg'),
(102, 'Gun Tacker KANYU 13/4-6-8mm', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a99208607a602.31345586.jpg'),
(103, 'Gun Tacker Staple wire 1008F10x8mm', 'box(es)', 10, '2026-08-28 03:13:08', 'img_6a99209f4fbd81.76148712.jpg'),
(104, 'Opp Plastic 5” x 6” 100’s', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963fa46aadf8.65134237.jpg'),
(105, 'Hard Copy 70 gsm. A4 (8 1/4\' x 11 ¾”)', 'ream(s)', 0, '2026-08-28 03:13:08', 'img_6a963e0f592603.35176442.jpg'),
(106, 'Sunbeam Gel Pen (black)', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a9641559dfe98.94833164.jpg'),
(107, 'Gold International Carbon Paper Blue (Long) 100\'s', 'pc(s)', 76, '2026-08-28 03:13:08', 'img_6a963ddb92c112.37771578.jpg'),
(108, '3-Ring Binder 2\" (L) Black', 'pc(s)', 10, '2026-08-28 03:13:08', 'img_6a9637abcd35b7.77810134.jpg'),
(109, 'Catalog Envelope 6x9\" 500\'s', 'pc(s)', 585, '2026-08-28 03:13:08', 'img_6a963be3cafaa7.33631096.jpg'),
(110, 'Metal Paper Cutter 12x15', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963f648ac799.58756954.jpg'),
(111, 'Energizer AA', 'pc(s)', 8, '2026-08-28 03:13:08', 'img_6a991fff133055.47206230.jpg'),
(112, 'Magazine Box Blue (Stand file box)', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963eff3ad7b4.37842557.jpg'),
(113, 'Matte Photo Paper 200gsm A4 20\'s', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963f4ac0ebc7.53622649.jpg'),
(114, 'Solido Pencil Eraser 40\'s (Joy Eraser for pencil)', 'pc(s)', 7, '2026-08-28 03:13:08', 'img_6a9640c7532f51.50684550.jpg'),
(115, 'Ajustable Hanging File Box (light blue)', 'pc(s)', 9, '2026-08-28 03:13:08', 'img_6a991f24ad9d23.55498937.jpg'),
(116, 'Suspension / Hanging File Folder (Long-Blue)', 'pc(s)', 8, '2026-08-28 03:13:08', 'img_6a964169352e42.60589718.jpg'),
(117, 'Suspension / Hanging File Folder (Long-Red)', 'pc(s)', 8, '2026-08-28 03:13:08', NULL),
(118, 'Suspension / Hanging File Folder (Long-Green)', 'pc(s)', 8, '2026-08-28 03:13:08', NULL),
(119, 'Suspension / Hanging File Folder (Long-Yellow)', 'pc(s)', 8, '2026-08-28 03:13:08', NULL),
(120, 'Suspension / Hanging File Folder (Long-Violet)', 'pc(s)', 8, '2026-08-28 03:13:08', NULL),
(121, 'Diploma Folder Long with Logo', 'pc(s)', 521, '2026-08-28 03:13:08', NULL),
(122, 'Certificate Holder Single Type Short', 'pc(s)', 478, '2026-08-28 03:13:08', 'img_6a963c1ac97707.13702304.jpg'),
(123, '3-Ring Binder 2\" (L) Blue', 'pc(s)', 22, '2026-08-28 03:13:08', 'img_6a991ee6dbf7f1.45480686.webp'),
(124, 'Packaging Tape Brown (L)', 'rolls', 9, '2026-08-28 03:13:08', 'img_6a963fc71fb160.43833584.jpg'),
(125, '12-pocket Accordian File w/ Handle Long (black)', 'pc(s)', 60, '2026-08-28 03:13:08', 'img_6a991fd090cd14.36066024.jpg'),
(126, 'Paper Binding Cover Morocco Board 230gsm A4 100\'s Blue', 'pc(s)', 0, '2026-08-28 03:13:08', NULL),
(127, 'Paper Binding Cover Morocco Board 230gsm short 100\'s Blue', 'pc(s)', 100, '2026-08-28 03:13:08', NULL),
(128, 'Paper Binding Cover Morocco Board 230gsm Long 100\'s Blue', 'pc(s)', 179, '2026-08-28 03:13:08', NULL),
(129, 'Paper Binding Cover Morocco Board 230gsm A4 100\'s Yellow', 'pc(s)', 100, '2026-08-28 03:13:08', NULL),
(130, 'Paper Binding Cover Morocco Board 230gsm short 100\'s Yellow', 'pc(s)', 100, '2026-08-28 03:13:08', NULL),
(131, 'Paper Binding Cover Morocco Board 230gsm Long 100\'s Yellow', 'pc(s)', 90, '2026-08-28 03:13:08', NULL),
(132, 'Paper Binding Cover Morocco Board 230gsm Short 100\'s Green', 'pc(s)', 100, '2026-08-28 03:13:08', NULL),
(133, 'Paper Binding Cover Morocco Board 230gsm Long 100\'s Green', 'pc(s)', 92, '2026-08-28 03:13:08', NULL),
(134, 'Paper Binding Cover Morocco Board 230gsm Short 100\'s Red', 'pc(s)', 100, '2026-08-28 03:13:08', NULL),
(135, 'Paper Binding Cover Morocco Board 230gsm Long 100\'s Red', 'pc(s)', 82, '2026-08-28 03:13:08', NULL),
(136, 'PVC Binding Cover Clear (0.20mm) A4 100\'s', 'pc(s)', 300, '2026-08-28 03:13:08', NULL),
(137, 'PVC Binding Cover Clear (0.20mm) Short 100\'s', 'pc(s)', 0, '2026-08-28 03:13:08', NULL),
(138, 'PVC Binding Cover Clear (0.20mm) Long 100\'s', 'pc(s)', 258, '2026-08-28 03:13:08', NULL),
(139, 'Plastic Ring Binder - Black - 46\" x 06 mm (1/4\")', 'pc(s)', 11, '2026-08-28 03:13:08', NULL),
(140, 'Plastic Ring Binder - Black - 46\" x 08 mm (5/16\")', 'pc(s)', 16, '2026-08-28 03:13:08', NULL),
(141, 'Plastic Ring Binder - Black - 46\" x 10 mm (3/8\")', 'pc(s)', 20, '2026-08-28 03:13:08', NULL),
(142, 'Plastic Ring Binder - Black - 46\" x 11 mm (7/16\")', 'pc(s)', 20, '2026-08-28 03:13:08', NULL),
(143, 'Plastic Ring Binder - Black - 46\" x 12 mm (1/2\")', 'pc(s)', 20, '2026-08-28 03:13:08', NULL),
(144, 'Plastic Ring Binder - Black - 46\" x 14 mm (9/16\")', 'pc(s)', 20, '2026-08-28 03:13:08', NULL),
(145, 'Plastic Ring Binder - Black - 46\" x 16 mm (5/8\")', 'pc(s)', 20, '2026-08-28 03:13:08', NULL),
(146, 'Plastic Ring Binder - Black - 46\" x 20 mm (3/4\")', 'pc(s)', 8, '2026-08-28 03:13:08', NULL),
(147, 'Plastic Ring Binder - Black - 46\" x 22 mm (7/8\")', 'pc(s)', 10, '2026-08-28 03:13:08', NULL),
(148, 'Plastic Ring Binder - Black - 46\" x 25 mm (1\")', 'pc(s)', 8, '2026-08-28 03:13:08', NULL),
(149, 'Plastic Ring Binder - Black - 46\" x 28 mm (1-1/8\")', 'pc(s)', 10, '2026-08-28 03:13:08', NULL),
(150, 'Plastic Ring Binder - Black - 46\" x 32 mm (1-1/4\")', 'pc(s)', 10, '2026-08-28 03:13:08', NULL),
(151, 'Plastic Ring Binder - Black - 46\" x 38 mm (1-1/2\")', 'pc(s)', 8, '2026-08-28 03:13:08', NULL),
(152, 'Plastic Ring Binder - Black - 46\" x 45 mm (1-3/4\")', 'pc(s)', 10, '2026-08-28 03:13:08', NULL),
(153, 'Plastic Ring Binder - Black - 46\" x 51 mm (2\")', 'pc(s)', 10, '2026-08-28 03:13:08', NULL),
(154, 'Wire Mesh 3-Layer In/Out Document Tray', 'pc(s)', 8, '2026-08-28 03:13:08', 'img_6a9641ce76bde3.29211098.jpg'),
(155, 'Document Storage Box w/ Cover (L15.5\"xW12\"xH10\")', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963ccbdb8f31.41479729.jpg'),
(156, 'Gel pen M&G Black', 'pc(s)', 24, '2026-08-28 03:13:08', 'img_6a963dcc54b4f1.06061980.jpg'),
(157, 'Laminating Film Long 100\'s', 'pc(s)', 278, '2026-08-28 03:13:08', 'img_6a963ef3f06329.77615794.jpg'),
(158, 'Double Sided Tape w/ Foam 1\"', 'pc(s)', 8, '2026-08-28 03:13:08', 'img_6a963ce84821a3.41151152.jpg'),
(159, 'Notarial Seal #24', 'box(es)', 121, '2026-08-28 03:13:08', 'img_6a963f8bc423d7.02266621.jpg'),
(160, 'Bookends Big 8-1/2\"', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963838c11c89.97067502.jpg'),
(161, 'CD - RW', 'pc(s)', 20, '2026-08-28 03:13:08', 'img_6a99219d31b793.33949309.webp'),
(162, 'CD Envelope-White Paper', 'pc(s)', 148, '2026-08-28 03:13:08', 'img_6a963c033e7668.83848363.jpg'),
(163, 'Calculator', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963866427ab5.42058966.jpg'),
(164, 'Flex Whiteboard Marker Ink(Black)25ml', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963da61fa812.78046782.jpg'),
(165, 'I.D Holder', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a963e9a01ae92.57343936.jpg'),
(166, 'I.D Holder (Silicone)', 'pc(s)', 0, '2026-08-28 03:13:08', 'img_6a9920c0d50273.60391542.jpg'),
(167, 'PVC Card 250\'s', 'box(es)', 2, '2026-08-28 03:13:08', 'img_6a96405d9bf009.12342441.jpg'),
(168, 'I.D Lace', 'pc(s)', 0, '2026-08-28 03:13:08', NULL),
(169, 'ID Lace (new logo)', 'pc(s)', 0, '2026-08-28 03:13:08', NULL),
(170, 'ACER Extensa 15 Laptop w/  bag', 'pc(s)', 5, '2026-08-28 03:13:08', 'img_6a9637d7670ea9.51600607.jpg'),
(171, 'Smart Ribbon Kit', 'box(es)', 2, '2026-08-28 03:13:08', NULL),
(172, 'Class Card (500\'s)', 'pc(s)', 0, '2026-08-28 03:13:08', NULL),
(173, 'Banknote Tester Pen', 'pc(s)', 12, '2026-08-28 03:13:08', 'img_6a991fa6deef17.94486852.jpg'),
(174, 'Class Card(248\'s)', 'pc(s)', 0, '2026-08-28 03:13:08', NULL),
(175, 'Class Card(250\'s)', 'pc(s)', 9203, '2026-08-28 03:13:08', NULL),
(176, 'Foam Tape (TAN)', 'roll(s)', 4, '2026-08-28 03:13:08', NULL),
(177, 'Pressboard Folder Long (EMERALD GREEN)', 'pc(s)', 100, '2026-08-28 03:13:08', NULL),
(178, 'Report Card Holders', 'pc(s)', 699, '2026-08-28 03:13:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_items`
--

CREATE TABLE `maintenance_items` (
  `id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `actual_stocks` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `maintenance_items`
--

INSERT INTO `maintenance_items` (`id`, `item_name`, `unit`, `actual_stocks`, `created_at`, `image`) VALUES
(1, 'Alcohol Scented Mega Gal', '1G', 5, '2026-08-28 05:53:31', NULL),
(2, 'Fabric Conditioner/Enhancer', '1L', 11, '2026-08-28 05:53:31', NULL),
(3, 'Muriatic Acid', '1G', 8, '2026-08-28 05:53:31', NULL),
(4, 'Disinfectant Solution (3 in 1)', '1G', 8, '2026-08-28 05:53:31', NULL),
(5, 'Liquid Hand Soap', '1L', 13, '2026-08-28 05:53:31', NULL),
(6, 'Toilet Bowl Cleaner (1L)', '1L', 22, '2026-08-28 05:53:31', NULL),
(7, 'Dishwashing Liquid Soap', '1L', 2, '2026-08-28 05:53:31', NULL),
(8, 'Mosquito Repellant', '1L', 14, '2026-08-28 05:53:31', NULL),
(9, 'Air Freshener', '1L', 25, '2026-08-28 05:53:31', NULL),
(10, 'Bleach', 'GAL', 2, '2026-08-28 05:53:31', NULL),
(11, 'Floor Wax', '1L', 13, '2026-08-28 05:53:31', NULL),
(12, 'Disposable Face Mask 50\'s', 'BOX', 11, '2026-08-28 05:53:31', NULL),
(13, 'Face Shield', 'PCS', 140, '2026-08-28 05:53:31', NULL),
(14, 'Black Garbage Bag (small 9x9x20) 100\'s', 'Packs', 10, '2026-08-28 05:53:31', NULL),
(15, 'Black Garbage Bag (large 13x13x32) 100\'s', 'Packs', 1, '2026-08-28 05:53:31', NULL),
(16, 'SIBTECH PPE', 'sets', 19, '2026-08-28 05:53:31', NULL),
(17, 'Black Garbage Bag (XXL 18.5x18.5x40) 100\'s', 'Packs', 3, '2026-08-28 05:53:31', NULL),
(18, 'Black Rectangular Storage(30x16x6\")with wheels with cover', 'pc', 1, '2026-08-28 05:53:31', NULL),
(19, 'Black Woven Type Basket with cover 14x12x5', 'pcs.', 3, '2026-08-28 05:53:31', NULL),
(20, 'Declogger', '1L', 21, '2026-08-28 05:53:31', NULL),
(21, 'Black Garbage Bag(medium 11x11x24)100s', 'Packs', 6, '2026-08-28 05:53:31', NULL),
(22, 'Black Garbage bag(XL 15x15x37)100s', 'Packs', 9, '2026-08-28 05:53:31', NULL),
(23, 'Glass Cleaner w/ sprayer 1L 15\'s', 'box.', 32, '2026-08-28 05:53:31', NULL),
(24, 'Stirrer 540\'s', 'Packs.', 13, '2026-08-28 05:53:31', NULL),
(25, 'Detergent Powder AUP', 'Buck.', 2, '2026-08-28 05:53:31', NULL),
(26, 'Dry Chemical Fire Extinguishers 10lbs', 'Tanks', 25, '2026-08-28 05:53:31', NULL),
(27, 'Solar Street Lights', 'Pcs.', 16, '2026-08-28 05:53:31', NULL),
(28, 'Solar Flood Light', 'Pc', 1, '2026-08-28 05:53:31', NULL),
(29, 'Povidone Iodine 30ml 12\'s/Packs', 'pcs.', 42, '2026-08-28 05:53:31', NULL),
(30, 'Hydrogen Peroxide 60ml 12\'s/Packs', 'pcs', 42, '2026-08-28 05:53:31', NULL),
(31, 'Cotton Applicator Small Sterile 100\'s/Boxes', 'pcs.', 168, '2026-08-28 05:53:31', NULL),
(32, 'Micropore 1\" 12\'s/Boxes', 'pcs', 18, '2026-08-28 05:53:31', NULL),
(33, 'Maintenance Jacket', 'Pcs.', 12, '2026-08-28 05:53:31', NULL),
(34, 'Caramel Macchiato 1kg', 'PCS', 2, '2026-08-28 05:53:31', NULL),
(35, 'Choco Hazelnut 1kg', 'PCS', 1, '2026-08-28 05:53:31', NULL),
(36, 'Brown and Creamy 1kg', 'PCS', 4, '2026-08-28 05:53:31', NULL),
(37, 'White Coffee 1kg', 'PCS', 3, '2026-08-28 05:53:31', NULL),
(38, 'Camppuccino 1kg', 'PCS', 5, '2026-08-28 05:53:31', NULL),
(39, 'Italian Choco 1 Kg', 'PCS', 2, '2026-08-28 05:53:31', NULL),
(40, 'Milk Chocolate 1kg', 'PCS', 2, '2026-08-28 05:53:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_requests`
--

CREATE TABLE `maintenance_requests` (
  `id` int(11) NOT NULL,
  `request_group_id` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `requisitioner_name` varchar(255) DEFAULT NULL,
  `department` varchar(100) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `purpose` text NOT NULL,
  `date_needed` date DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `request_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `approved_at` datetime DEFAULT NULL,
  `scheduled_time` varchar(50) DEFAULT '09:00 AM - 10:00 AM',
  `room_reserved` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `maintenance_requests`
--

INSERT INTO `maintenance_requests` (`id`, `request_group_id`, `user_id`, `requisitioner_name`, `department`, `item_id`, `quantity`, `purpose`, `date_needed`, `status`, `request_date`, `approved_at`, `scheduled_time`, `room_reserved`) VALUES
(1, 'MNT-20260828080840-192', 2, NULL, 'SPMO', 1, 1, 'office use', NULL, 'Approved', '2026-08-28 06:08:40', '2026-08-28 14:35:42', '09:00 AM - 10:00 AM', ''),
(2, 'MNT-20260828083527-346', 2, NULL, 'SPMO', 1, 6, 'office use', NULL, 'Approved', '2026-08-28 06:35:27', '2026-08-28 14:35:55', '09:00 AM - 10:00 AM', ''),
(3, 'MNT-20260828094411-685', 2, NULL, 'SPMO', 2, 1, 'office use', NULL, 'Approved', '2026-08-28 07:44:11', '2026-08-28 15:59:33', '09:00 AM - 10:00 AM', ''),
(4, 'MNT-20260828095927-870', 2, 'Joey Morales', 'SPMO', 2, 1, 'office use', '2006-09-01', 'Approved', '2026-08-28 07:59:27', '2026-08-28 16:04:57', '09:00 AM - 10:00 AM', ''),
(5, 'MNT-20260828095927-870', 2, 'Joey Morales', 'SPMO', 4, 1, 'office use', '2006-09-01', 'Approved', '2026-08-28 07:59:27', '2026-08-28 16:04:57', '09:00 AM - 10:00 AM', ''),
(6, 'MNT-20260828095927-870', 2, 'Joey Morales', 'SPMO', 4, 1, 'office use', '2006-09-01', 'Approved', '2026-08-28 07:59:27', '2026-08-28 16:04:57', '09:00 AM - 10:00 AM', ''),
(7, 'MNT-20260828095927-870', 2, 'Joey Morales', 'SPMO', 15, 1, 'office use', '2006-09-01', 'Approved', '2026-08-28 07:59:27', '2026-08-28 16:04:57', '09:00 AM - 10:00 AM', ''),
(8, 'MNT-20260901040207-150', 2, 'Morales Joey', 'SPMO', 3, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 02:02:07', '2026-09-01 11:10:45', '09:00 AM - 10:00 AM', ''),
(9, 'MNT-20260901040411-680', 2, 'Morales Joey', 'SPMO', 2, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 02:04:11', '2026-09-01 11:10:39', '09:00 AM - 10:00 AM', ''),
(10, 'MNT-20260901100505-531', 2, 'SPMO', 'SPMO', 14, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 08:05:05', '2026-09-01 16:05:22', '09:00 AM - 10:00 AM', ''),
(11, 'MNT-20260901100505-531', 2, 'SPMO', 'SPMO', 15, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 08:05:05', '2026-09-01 16:05:22', '09:00 AM - 10:00 AM', ''),
(12, 'MNT-20260902011357-511', 2, 'SPMO', 'SPMO', 9, 1, 'For office use', '2026-09-02', 'Rejected', '2026-09-01 23:13:57', NULL, '09:00 AM - 10:00 AM', ''),
(13, 'MNT-20260902011357-511', 2, 'SPMO', 'SPMO', 15, 1, 'For office use', '2026-09-02', 'Rejected', '2026-09-01 23:13:58', NULL, '09:00 AM - 10:00 AM', ''),
(14, 'MNT-20260902033340-172', 2, 'SPMO', 'SPMO', 9, 1, 'For office use', '2026-09-01', 'Rejected', '2026-09-02 01:33:40', NULL, '09:00 AM - 10:00 AM', ''),
(15, 'MNT-20260902033340-172', 2, 'SPMO', 'SPMO', 14, 1, 'For office use', '2026-09-01', 'Rejected', '2026-09-02 01:33:40', NULL, '09:00 AM - 10:00 AM', ''),
(16, 'MNT-20260902033340-172', 2, 'SPMO', 'SPMO', 15, 1, 'For office use', '2026-09-01', 'Rejected', '2026-09-02 01:33:40', NULL, '09:00 AM - 10:00 AM', ''),
(17, 'MNT-20260902033400-588', 2, 'SPMO', 'SPMO', 14, 1, 'For office use', '2026-09-02', 'Approved', '2026-09-02 01:34:00', '2026-09-02 09:34:13', '09:00 AM - 10:00 AM', ''),
(18, 'MNT-20260902044927-549', 2, 'SPMO', 'registrar', 9, 1, 'For office use', '2026-09-02', 'Approved', '2026-09-02 02:49:27', '2026-09-02 11:03:12', '09:00 AM - 10:00 AM', ''),
(19, 'MNT-20260902044927-549', 2, 'SPMO', 'registrar', 15, 0, 'For office use', '2026-09-02', 'Approved', '2026-09-02 02:49:27', '2026-09-02 11:03:12', '09:00 AM - 10:00 AM', ''),
(20, 'MNT-20260902082533-442', 2, 'SPMO', 'registrar', 14, 2, 'For office use', '2026-09-02', 'Approved', '2026-09-02 06:25:33', '2026-09-02 14:25:56', '09:00 AM - 10:00 AM', ''),
(21, 'MNT-20260902095135-856', 2, 'SPMO', 'SPMO', 15, 1, 'For office use', '2026-09-02', 'Approved', '2026-09-02 07:51:35', '2026-09-03 07:42:26', '09:00 AM - 10:00 AM', ''),
(22, 'MNT-20260903035947-959', 2, 'SPMO', 'sao', 15, 1, 'd', '2026-09-03', 'Approved', '2026-09-03 01:59:47', '2026-09-03 10:32:32', '09:00 AM - 10:00 AM', ''),
(23, 'MNT-20260903040201-331', 2, 'SPMO', 'sao', 9, 1, 'd', '2026-09-03', 'Approved', '2026-09-03 02:02:01', '2026-09-03 10:02:19', '09:00 AM - 10:00 AM', '');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(4) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `is_read`, `created_at`) VALUES
(1, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901085359-408).', 1, '2026-09-01 06:53:59'),
(2, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901085656-474).', 1, '2026-09-01 06:56:56'),
(3, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901091821-737).', 1, '2026-09-01 07:18:21'),
(4, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901092956-662).', 1, '2026-09-01 07:29:56'),
(5, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901094438-350).', 1, '2026-09-01 07:44:38'),
(6, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901094526-216).', 1, '2026-09-01 07:45:26'),
(7, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901094558-614).', 1, '2026-09-01 07:45:58'),
(8, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901094701-866).', 1, '2026-09-01 07:47:01'),
(9, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901094830-778).', 1, '2026-09-01 07:48:30'),
(10, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901094943-826).', 1, '2026-09-01 07:49:43'),
(11, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901095158-826).', 1, '2026-09-01 07:51:58'),
(12, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901095535-768).', 1, '2026-09-01 07:55:35'),
(13, 2, 'Matagumpay na naisumite ang iyong Office request (REQ-20260901095634-903).', 1, '2026-09-01 07:56:34'),
(14, 2, 'Ang iyong office supply request (REQ-20260902023128-888) ay na-aprubahan na!', 1, '2026-09-02 00:31:55'),
(15, 2, 'Ang iyong office supply request (REQ-20260902023345-728) ay na-aprubahan na!', 1, '2026-09-02 00:34:11'),
(16, 2, 'Ang iyong office supply request (REQ-20260902030758-285) ay na-aprubahan na!', 1, '2026-09-02 01:08:24'),
(17, 2, 'Ang iyong office supply request (REQ-20260902031019-183) ay na-aprubahan na!', 1, '2026-09-02 01:30:52'),
(18, 2, 'Ang iyong office supply request (REQ-20260902011336-579) ay na-aprubahan na!', 1, '2026-09-02 01:33:23'),
(19, 2, 'Ang iyong maintenance request (MNT-20260902033400-588) ay na-aprubahan na!', 1, '2026-09-02 01:34:13'),
(20, 2, 'Ang iyong office supply request (REQ-20260902033430-591) ay na-aprubahan na!', 1, '2026-09-02 01:34:44'),
(21, 2, 'Ang iyong maintenance request (MNT-20260902044927-549) ay na-aprubahan na!', 1, '2026-09-02 03:03:12'),
(22, 2, 'Ang iyong office supply request (REQ-20260902051507-703) ay na-aprubahan na!', 1, '2026-09-02 03:15:19'),
(23, 2, 'Ang iyong office supply request (REQ-20260902044853-869) ay na-aprubahan na!', 1, '2026-09-02 03:15:40'),
(24, 2, 'Ang iyong office supply request (REQ-20260902044059-286) ay tinanggihan / rejected.', 1, '2026-09-02 03:15:59'),
(25, 2, 'Ang iyong office supply request (REQ-20260902044026-500) ay tinanggihan / rejected.', 1, '2026-09-02 03:16:22'),
(26, 2, 'Ang iyong maintenance request (MNT-20260902033340-172) ay tinanggihan / rejected.', 1, '2026-09-02 03:16:42'),
(27, 2, 'Ang iyong maintenance request (MNT-20260902011357-511) ay tinanggihan / rejected.', 1, '2026-09-02 03:16:57'),
(28, 2, 'Ang iyong office supply request (REQ-20260902054421-986) ay na-aprubahan na!', 1, '2026-09-02 03:46:12'),
(29, 2, 'Ang iyong order request (#REQ-20260903040134-906) ay na-aprubahan na ng Admin!', 1, '2026-09-03 02:24:40'),
(30, 2, 'Ang iyong order request (#REQ-20260903040101-761) ay na-aprubahan na ng Admin!', 1, '2026-09-03 02:25:35'),
(31, 2, 'Ang iyong order request (#MNT-20260903035947-959) ay na-aprubahan na ng Admin!', 1, '2026-09-03 02:32:32'),
(32, 2, 'Ang iyong order request (#REQ-20260903043343-785) ay na-aprubahan na ng Admin!', 1, '2026-09-03 02:34:01'),
(33, 2, 'Ang iyong order request (#REQ-20260903054420-701) ay na-aprubahan na ng Admin!', 1, '2026-09-03 03:45:13'),
(34, 2, 'Ang iyong order request (#REQ-20260903055944-325) ay na-aprubahan na ng Admin!', 1, '2026-09-03 04:00:12'),
(35, 2, 'Ang iyong order request (#REQ-20260903061843-297) ay na-aprubahan na ng Admin!', 1, '2026-09-03 04:18:58'),
(36, 2, 'Ang iyong order request (#REQ-20260903091405-141) ay na-aprubahan na ng Admin!', 1, '2026-09-03 07:14:13'),
(37, 2, 'Ang iyong order request (#REQ-20260904053408-990) ay na-aprubahan na ng Admin!', 1, '2026-09-04 03:34:23'),
(38, 2, 'Ang iyong Borrow request (#BRW-20260908020837-289) ay na-approved na!', 1, '2026-09-08 00:08:59'),
(39, 2, 'Ang iyong Borrow request (#BRW-20260908020837-289) ay na-approved na!', 1, '2026-09-08 01:52:03'),
(40, 2, 'Ang iyong Borrow request (#BRW-20260908020837-289) ay na-returned na!', 1, '2026-09-08 03:04:47'),
(41, 2, 'Ang iyong Borrow request (#BRW-20260908020837-289) ay na-rejected na!', 1, '2026-09-08 03:11:16'),
(42, 2, 'Ang iyong Borrow request (#BRW-20260908020837-289) ay na-rejected na!', 1, '2026-09-08 03:20:22'),
(43, 2, 'Ang iyong Borrow request (#BRW-20260908020837-289) ay na-approved na!', 1, '2026-09-08 03:20:30'),
(44, 2, 'Ang iyong Borrow request (#BRW-20260908051041-868) ay na-rejected na!', 1, '2026-09-08 03:26:30'),
(45, 2, 'Ang iyong order request (#REQ-20260908074716-646) ay na-aprubahan na ng Admin!', 0, '2026-09-08 05:47:56'),
(46, 6, 'Inaprubahan ng Admin ang iyong schedule request na \'Class\' para sa 2026-09-09.', 0, '2026-09-09 03:53:28'),
(47, 2, 'Ang iyong order request (#REQ-20260909061237-971) ay na-aprubahan na ng Admin!', 0, '2026-09-09 04:12:47'),
(48, 2, 'Inaprubahan ng Admin ang iyong schedule request na \'Class\' para sa 2026-09-09.', 0, '2026-09-09 04:15:48'),
(49, 2, 'Tinanggihan ng Admin ang iyong schedule request na \'Class\' para sa 2026-09-09.', 0, '2026-09-09 04:17:28'),
(50, 2, 'Inaprubahan ng Admin ang iyong schedule request na \'Class\' para sa 2026-09-09.', 0, '2026-09-09 04:18:09'),
(51, 2, 'Inaprubahan ng Admin ang iyong schedule request na \'Class\' para sa 2026-09-09.', 0, '2026-09-09 04:22:50'),
(52, 2, 'Ang iyong Borrow request (#BRW-20260908051041-868) ay na-rejected na!', 0, '2026-09-09 04:25:27'),
(53, 2, 'Ang iyong Borrow request (#BRW-20260908051041-868) ay na-rejected na!', 0, '2026-09-09 04:26:09'),
(54, 2, 'Inaprubahan ng Admin ang iyong schedule request na \'class\' para sa 2026-09-09.', 0, '2026-09-09 06:41:41'),
(55, 6, 'Ang iyong order request (#REQ-20260911013243-191) ay na-aprubahan na ng Admin!', 0, '2026-09-10 23:32:54'),
(56, 2, 'Ang iyong Borrow request (#BRW-20260909062415-329) ay na-approved na!', 0, '2026-09-10 23:38:48'),
(57, 2, 'Ang iyong Borrow request (#BRW-20260909062415-329) ay na-approved na!', 0, '2026-09-10 23:38:53'),
(58, 2, 'Ang iyong Borrow request (#BRW-20260909062415-329) ay na-approved na!', 0, '2026-09-10 23:41:40'),
(59, 6, 'Ang iyong order request (#REQ-20260911024548-600) ay na-aprubahan na ng Admin!', 0, '2026-09-11 00:46:26'),
(60, 6, 'Inaprubahan ng Admin ang iyong schedule request na \'class\' para sa 2026-09-11.', 0, '2026-09-11 05:18:26'),
(61, 6, 'Inaprubahan ng Admin ang iyong schedule request na \'121\' para sa 2026-09-11.', 0, '2026-09-11 05:19:00'),
(62, 6, 'Ang iyong Borrow request (#BRW-20260911072702-980) ay na-approved na!', 0, '2026-09-11 05:27:27'),
(63, 6, 'Ang iyong Borrow request (#BRW-20260911072702-980) ay na-rejected na!', 0, '2026-09-11 05:27:39'),
(64, 6, 'Inaprubahan ng Admin ang iyong schedule request na \'practice\' para sa 2026-09-11.', 0, '2026-09-11 06:18:50');

-- --------------------------------------------------------

--
-- Table structure for table `stock_history`
--

CREATE TABLE `stock_history` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `category` varchar(50) NOT NULL DEFAULT 'Office',
  `previous_stock` int(11) NOT NULL DEFAULT 0,
  `new_stock` int(11) NOT NULL DEFAULT 0,
  `added_qty` int(11) NOT NULL DEFAULT 0,
  `updated_by` varchar(100) NOT NULL,
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_history`
--

INSERT INTO `stock_history` (`id`, `item_id`, `item_name`, `category`, `previous_stock`, `new_stock`, `added_qty`, `updated_by`, `updated_at`) VALUES
(1, 9, 'Air Freshener', 'Maintenance', 15, 20, 5, 'admin', '2026-09-03 09:56:03'),
(2, 14, 'Black Garbage Bag (small 9x9x20) 100\'s', 'Maintenance', 0, 10, 10, 'admin', '2026-09-03 09:56:27'),
(3, 9, 'Air Freshener', 'Maintenance', 20, 25, 5, 'admin', '2026-09-03 09:59:05'),
(4, 34, 'Arch File 3” Long (Blue)', 'Office', 0, 20, 20, 'admin', '2026-09-03 13:26:44'),
(5, 173, 'Banknote Tester Pen', 'Office', 0, 12, 12, 'admin', '2026-09-03 13:45:25'),
(6, 123, '3-Ring Binder 2\" (L) Blue', 'Office', 22, 22, 0, 'admin', '2026-09-03 15:16:54'),
(7, 115, 'Ajustable Hanging File Box (light blue)', 'Office', 10, 10, 0, 'admin', '2026-09-03 15:17:56'),
(8, 33, 'Arch File 3” Long (Black)', 'Office', 12, 12, 0, 'admin', '2026-09-03 15:18:42'),
(9, 34, 'Arch File 3” Long (Blue)', 'Office', 20, 20, 0, 'admin', '2026-09-03 15:19:13'),
(10, 34, 'Arch File 3” Long (Blue)', 'Office', 20, 20, 0, 'admin', '2026-09-03 15:19:24'),
(11, 173, 'Banknote Tester Pen', 'Office', 12, 12, 0, 'admin', '2026-09-03 15:20:06'),
(12, 125, '12-pocket Accordian File w/ Handle Long (black)', 'Office', 72, 72, 0, 'admin', '2026-09-03 15:20:48'),
(13, 111, 'Energizer AA', 'Office', 8, 8, 0, 'admin', '2026-09-03 15:21:35'),
(14, 2, 'GD Newsprint 52 gsm. Long (8.5” x 13”) 480’s', 'Office', 0, 0, 0, 'admin', '2026-09-03 15:22:19'),
(15, 1, 'GD Newsprint 52 gsm. Short (8.5” x 11”) 480’s', 'Office', 0, 0, 0, 'admin', '2026-09-03 15:22:27'),
(16, 102, 'Gun Tacker KANYU 13/4-6-8mm', 'Office', 0, 0, 0, 'admin', '2026-09-03 15:23:50'),
(17, 103, 'Gun Tacker Staple wire 1008F10x8mm', 'Office', 10, 10, 0, 'admin', '2026-09-03 15:24:15'),
(18, 166, 'I.D Holder (Silicone)', 'Office', 0, 0, 0, 'admin', '2026-09-03 15:24:48'),
(19, 99, 'Joinstar Saliva Antigen Kits', 'Office', 0, 0, 0, 'admin', '2026-09-03 15:25:29'),
(20, 65, 'Joy PS-120 Power Saving Stapler (120 sheets)', 'Office', 2, 2, 0, 'admin', '2026-09-03 15:26:07'),
(21, 101, 'Joy Scissors 8\"', 'Office', 10, 10, 0, 'admin', '2026-09-03 15:26:50'),
(22, 66, 'Joy Staplewire #13 (23/13)', 'Office', 9, 9, 0, 'admin', '2026-09-03 15:27:16'),
(23, 161, 'CD - RW', 'Office', 20, 20, 0, 'admin', '2026-09-03 15:28:29'),
(24, 9, 'Air Freshener', 'Maintenance', 23, 23, 0, 'admin', '2026-09-11 14:32:09'),
(25, 9, 'Air Freshener', 'Maintenance', 23, 25, 2, 'admin', '2026-09-11 14:32:21'),
(26, 125, '12-pocket Accordian File w/ Handle Long (black)', 'Office', 69, 60, -9, 'admin', '2026-09-11 15:04:52');

-- --------------------------------------------------------

--
-- Table structure for table `supply_requests`
--

CREATE TABLE `supply_requests` (
  `id` int(11) NOT NULL,
  `request_group_id` varchar(50) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `requisitioner_name` varchar(255) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `purpose` text DEFAULT NULL,
  `date_needed` date DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `approved_at` datetime DEFAULT NULL,
  `request_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `scheduled_time` varchar(50) DEFAULT '09:00 AM - 10:00 AM',
  `room_reserved` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supply_requests`
--

INSERT INTO `supply_requests` (`id`, `request_group_id`, `user_id`, `requisitioner_name`, `department`, `item_id`, `quantity`, `purpose`, `date_needed`, `status`, `approved_at`, `request_date`, `scheduled_time`, `room_reserved`) VALUES
(13, 'REQ-20260828074001-446', 2, NULL, 'SPMO', 3, 1, 'office use', NULL, 'Approved', '2026-08-28 13:40:12', '2026-08-28 05:40:02', '09:00 AM - 10:00 AM', ''),
(14, 'REQ-20260828074001-446', 2, NULL, 'SPMO', 4, 1, 'office use', NULL, 'Approved', '2026-08-28 13:40:12', '2026-08-28 05:40:02', '09:00 AM - 10:00 AM', ''),
(15, 'REQ-20260828074001-446', 2, NULL, 'SPMO', 6, 1, 'office use', NULL, 'Approved', '2026-08-28 13:40:12', '2026-08-28 05:40:02', '09:00 AM - 10:00 AM', ''),
(16, 'REQ-20260828074401-876', 2, NULL, 'SPMO', 3, 39, 'office use', NULL, 'Approved', '2026-08-28 13:44:14', '2026-08-28 05:44:01', '09:00 AM - 10:00 AM', ''),
(17, 'REQ-20260828080511-762', 2, NULL, 'SPMO', 3, 40, 'office use', NULL, 'Approved', '2026-08-28 14:08:44', '2026-08-28 06:05:11', '09:00 AM - 10:00 AM', ''),
(18, 'REQ-20260828080511-762', 2, NULL, 'SPMO', 9, 560, 'office use', NULL, 'Approved', '2026-08-28 14:08:44', '2026-08-28 06:05:11', '09:00 AM - 10:00 AM', ''),
(19, 'REQ-20260828100437-627', 2, 'joey', 'SPMO', 4, 1, 'DFGSDG', '2026-09-01', 'Approved', '2026-08-28 16:05:00', '2026-08-28 08:04:37', '09:00 AM - 10:00 AM', ''),
(22, 'REQ-20260901020305-300', 2, 'Juan Dela Cruz', 'SPMO', 4, 1, 'DFGSDG', '2026-09-02', 'Approved', '2026-09-01 08:03:17', '2026-09-01 00:03:05', '09:00 AM - 10:00 AM', ''),
(23, 'REQ-20260901020523-454', 2, 'Juan Dela Cruz', 'SPMO', 4, 1, 'DFGSDG', '2026-09-01', 'Approved', '2026-09-01 08:05:26', '2026-09-01 00:05:23', '09:00 AM - 10:00 AM', ''),
(24, 'REQ-20260901020841-532', 2, 'Juan Dela Cruz', 'SPMO', 4, 1, 'DFGSDG', '2026-09-01', 'Approved', '2026-09-01 08:08:53', '2026-09-01 00:08:41', '09:00 AM - 10:00 AM', ''),
(25, 'REQ-20260901021139-688', 2, 'Joey Morales', 'SPMO', 13, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 08:11:50', '2026-09-01 00:11:39', '09:00 AM - 10:00 AM', ''),
(26, 'REQ-20260901021139-688', 2, 'Joey Morales', 'SPMO', 16, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 08:11:50', '2026-09-01 00:11:39', '09:00 AM - 10:00 AM', ''),
(27, 'REQ-20260901021139-688', 2, 'Joey Morales', 'SPMO', 11, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 08:11:50', '2026-09-01 00:11:39', '09:00 AM - 10:00 AM', ''),
(28, 'REQ-20260901021843-319', 2, 'Morales Joey', 'SPMO', 178, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 08:18:49', '2026-09-01 00:18:43', '09:00 AM - 10:00 AM', ''),
(29, 'REQ-20260901023924-861', 2, 'Juan Dela Cruz', 'SPMO', 4, 1, 'For office use', '2026-09-04', 'Approved', '2026-09-01 08:39:32', '2026-09-01 00:39:24', '09:00 AM - 10:00 AM', ''),
(30, 'REQ-20260901023924-861', 2, 'Juan Dela Cruz', 'SPMO', 7, 1, 'For office use', '2026-09-04', 'Approved', '2026-09-01 08:39:32', '2026-09-01 00:39:24', '09:00 AM - 10:00 AM', ''),
(31, 'REQ-20260901023924-861', 2, 'Juan Dela Cruz', 'SPMO', 14, 1, 'For office use', '2026-09-04', 'Approved', '2026-09-01 08:39:32', '2026-09-01 00:39:24', '09:00 AM - 10:00 AM', ''),
(32, 'REQ-20260901023924-861', 2, 'Juan Dela Cruz', 'SPMO', 13, 1, 'For office use', '2026-09-04', 'Approved', '2026-09-01 08:39:32', '2026-09-01 00:39:24', '09:00 AM - 10:00 AM', ''),
(33, 'REQ-20260901023924-861', 2, 'Juan Dela Cruz', 'SPMO', 14, 1, 'For office use', '2026-09-04', 'Approved', '2026-09-01 08:39:32', '2026-09-01 00:39:24', '09:00 AM - 10:00 AM', ''),
(34, 'REQ-20260901023924-861', 2, 'Juan Dela Cruz', 'SPMO', 17, 1, 'For office use', '2026-09-04', 'Approved', '2026-09-01 08:39:32', '2026-09-01 00:39:24', '09:00 AM - 10:00 AM', ''),
(35, 'REQ-20260901023924-861', 2, 'Juan Dela Cruz', 'SPMO', 16, 1, 'For office use', '2026-09-04', 'Approved', '2026-09-01 08:39:32', '2026-09-01 00:39:24', '09:00 AM - 10:00 AM', ''),
(36, 'REQ-20260901023924-861', 2, 'Juan Dela Cruz', 'SPMO', 12, 1, 'For office use', '2026-09-04', 'Approved', '2026-09-01 08:39:32', '2026-09-01 00:39:24', '09:00 AM - 10:00 AM', ''),
(37, 'REQ-20260901040237-371', 2, 'Morales Joey', 'SPMO', 4, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 10:14:22', '2026-09-01 02:02:37', '09:00 AM - 10:00 AM', ''),
(38, 'REQ-20260901040312-157', 2, 'Morales Joey', 'SPMO', 6, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 10:03:30', '2026-09-01 02:03:12', '09:00 AM - 10:00 AM', ''),
(39, 'REQ-20260901041046-899', 2, 'Joey Morales', 'SPMO', 7, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 10:39:24', '2026-09-01 02:10:46', '09:00 AM - 10:00 AM', ''),
(40, 'REQ-20260901041046-899', 2, 'Joey Morales', 'SPMO', 10, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 10:39:24', '2026-09-01 02:10:46', '09:00 AM - 10:00 AM', ''),
(41, 'REQ-20260901041046-899', 2, 'Joey Morales', 'SPMO', 12, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 10:39:24', '2026-09-01 02:10:46', '09:00 AM - 10:00 AM', ''),
(42, 'REQ-20260901041046-899', 2, 'Joey Morales', 'SPMO', 13, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 10:39:24', '2026-09-01 02:10:46', '09:00 AM - 10:00 AM', ''),
(43, 'REQ-20260901041046-899', 2, 'Joey Morales', 'SPMO', 15, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 10:39:24', '2026-09-01 02:10:46', '09:00 AM - 10:00 AM', ''),
(44, 'REQ-20260901041046-899', 2, 'Joey Morales', 'SPMO', 20, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 10:39:24', '2026-09-01 02:10:46', '09:00 AM - 10:00 AM', ''),
(45, 'REQ-20260901041046-899', 2, 'Joey Morales', 'SPMO', 25, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 10:39:24', '2026-09-01 02:10:46', '09:00 AM - 10:00 AM', ''),
(46, 'REQ-20260901051753-860', 2, 'Joey Morales', 'SPMO', 13, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 11:18:21', '2026-09-01 03:17:53', '09:00 AM - 10:00 AM', ''),
(47, 'REQ-20260901051753-860', 2, 'Joey Morales', 'SPMO', 33, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 11:18:21', '2026-09-01 03:17:53', '09:00 AM - 10:00 AM', ''),
(48, 'REQ-20260901051753-860', 2, 'Joey Morales', 'SPMO', 34, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 11:18:21', '2026-09-01 03:17:53', '09:00 AM - 10:00 AM', ''),
(49, 'REQ-20260901051753-860', 2, 'Joey Morales', 'SPMO', 108, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 11:18:21', '2026-09-01 03:17:53', '09:00 AM - 10:00 AM', ''),
(50, 'REQ-20260901051753-860', 2, 'Joey Morales', 'SPMO', 123, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 11:18:21', '2026-09-01 03:17:53', '09:00 AM - 10:00 AM', ''),
(51, 'REQ-20260901051753-860', 2, 'Joey Morales', 'SPMO', 125, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 11:18:21', '2026-09-01 03:17:53', '09:00 AM - 10:00 AM', ''),
(52, 'REQ-20260901051753-860', 2, 'Joey Morales', 'SPMO', 160, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 11:18:21', '2026-09-01 03:17:53', '09:00 AM - 10:00 AM', ''),
(53, 'REQ-20260901051753-860', 2, 'Joey Morales', 'SPMO', 173, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 11:18:21', '2026-09-01 03:17:53', '09:00 AM - 10:00 AM', ''),
(54, 'REQ-20260901052553-934', 2, 'SPMO', 'SPMO', 13, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:38:33', '2026-09-01 03:25:53', '09:00 AM - 10:00 AM', ''),
(55, 'REQ-20260901052553-934', 2, 'SPMO', 'SPMO', 25, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:38:33', '2026-09-01 03:25:53', '09:00 AM - 10:00 AM', ''),
(56, 'REQ-20260901052553-934', 2, 'SPMO', 'SPMO', 33, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:38:33', '2026-09-01 03:25:53', '09:00 AM - 10:00 AM', ''),
(57, 'REQ-20260901052553-934', 2, 'SPMO', 'SPMO', 34, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:38:33', '2026-09-01 03:25:53', '09:00 AM - 10:00 AM', ''),
(58, 'REQ-20260901052553-934', 2, 'SPMO', 'SPMO', 108, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:38:33', '2026-09-01 03:25:53', '09:00 AM - 10:00 AM', ''),
(59, 'REQ-20260901052553-934', 2, 'SPMO', 'SPMO', 123, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:38:33', '2026-09-01 03:25:53', '09:00 AM - 10:00 AM', ''),
(60, 'REQ-20260901052553-934', 2, 'SPMO', 'SPMO', 125, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:38:33', '2026-09-01 03:25:53', '09:00 AM - 10:00 AM', ''),
(61, 'REQ-20260901052553-934', 2, 'SPMO', 'SPMO', 160, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:38:33', '2026-09-01 03:25:53', '09:00 AM - 10:00 AM', ''),
(62, 'REQ-20260901052553-934', 2, 'SPMO', 'SPMO', 173, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:38:33', '2026-09-01 03:25:53', '09:00 AM - 10:00 AM', ''),
(63, 'REQ-20260901054005-618', 2, 'SPMO', 'SPMO', 30, 2, 'For office use', '2026-08-31', 'Approved', '2026-09-01 13:35:15', '2026-09-01 03:40:06', '09:00 AM - 10:00 AM', ''),
(64, 'REQ-20260901054005-618', 2, 'SPMO', 'SPMO', 31, 2, 'For office use', '2026-08-31', 'Approved', '2026-09-01 13:35:15', '2026-09-01 03:40:06', '09:00 AM - 10:00 AM', ''),
(65, 'REQ-20260901054005-618', 2, 'SPMO', 'SPMO', 34, 2, 'For office use', '2026-08-31', 'Approved', '2026-09-01 13:35:15', '2026-09-01 03:40:06', '09:00 AM - 10:00 AM', ''),
(66, 'REQ-20260901054005-618', 2, 'SPMO', 'SPMO', 123, 2, 'For office use', '2026-08-31', 'Approved', '2026-09-01 13:35:15', '2026-09-01 03:40:06', '09:00 AM - 10:00 AM', ''),
(67, 'REQ-20260901054005-618', 2, 'SPMO', 'SPMO', 160, 2, 'For office use', '2026-08-31', 'Approved', '2026-09-01 13:35:15', '2026-09-01 03:40:06', '09:00 AM - 10:00 AM', ''),
(68, 'REQ-20260901054005-618', 2, 'SPMO', 'SPMO', 161, 2, 'For office use', '2026-08-31', 'Approved', '2026-09-01 13:35:15', '2026-09-01 03:40:06', '09:00 AM - 10:00 AM', ''),
(69, 'REQ-20260901054005-618', 2, 'SPMO', 'SPMO', 162, 2, 'For office use', '2026-08-31', 'Approved', '2026-09-01 13:35:15', '2026-09-01 03:40:06', '09:00 AM - 10:00 AM', ''),
(71, 'REQ-20260901073923-605', 2, 'SPMO', 'SPMO', 108, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:40:14', '2026-09-01 05:39:23', '09:00 AM - 10:00 AM', ''),
(72, 'REQ-20260901073923-605', 2, 'SPMO', 'SPMO', 123, 3, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:40:14', '2026-09-01 05:39:23', '09:00 AM - 10:00 AM', ''),
(73, 'REQ-20260901073923-605', 2, 'SPMO', 'SPMO', 125, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:40:14', '2026-09-01 05:39:23', '09:00 AM - 10:00 AM', ''),
(74, 'REQ-20260901074101-807', 2, 'SPMO', 'SPMO', 108, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:41:43', '2026-09-01 05:41:01', '09:00 AM - 10:00 AM', ''),
(75, 'REQ-20260901074101-807', 2, 'SPMO', 'SPMO', 123, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:41:43', '2026-09-01 05:41:01', '09:00 AM - 10:00 AM', ''),
(76, 'REQ-20260901074101-807', 2, 'SPMO', 'SPMO', 125, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:41:43', '2026-09-01 05:41:01', '09:00 AM - 10:00 AM', ''),
(77, 'REQ-20260901074552-897', 2, 'SPMO', 'SPMO', 33, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:48:18', '2026-09-01 05:45:52', '09:00 AM - 10:00 AM', ''),
(78, 'REQ-20260901074552-897', 2, 'SPMO', 'SPMO', 34, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:48:18', '2026-09-01 05:45:52', '09:00 AM - 10:00 AM', ''),
(79, 'REQ-20260901074552-897', 2, 'SPMO', 'SPMO', 173, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:48:18', '2026-09-01 05:45:52', '09:00 AM - 10:00 AM', ''),
(80, 'REQ-20260901074852-575', 2, 'SPMO', 'SPMO', 25, 3, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:49:38', '2026-09-01 05:48:52', '09:00 AM - 10:00 AM', ''),
(81, 'REQ-20260901074852-575', 2, 'SPMO', 'SPMO', 30, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:49:25', '2026-09-01 05:48:52', '09:00 AM - 10:00 AM', ''),
(82, 'REQ-20260901074852-575', 2, 'SPMO', 'SPMO', 31, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:49:11', '2026-09-01 05:48:52', '09:00 AM - 10:00 AM', ''),
(83, 'REQ-20260901075016-929', 2, 'SPMO', 'SPMO', 108, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:54:35', '2026-09-01 05:50:16', '09:00 AM - 10:00 AM', ''),
(84, 'REQ-20260901075016-929', 2, 'SPMO', 'SPMO', 123, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:54:29', '2026-09-01 05:50:16', '09:00 AM - 10:00 AM', ''),
(85, 'REQ-20260901075016-929', 2, 'SPMO', 'SPMO', 125, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:54:26', '2026-09-01 05:50:16', '09:00 AM - 10:00 AM', ''),
(86, 'REQ-20260901075508-877', 2, 'SPMO', 'SPMO', 108, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:55:48', '2026-09-01 05:55:08', '09:00 AM - 10:00 AM', ''),
(88, 'REQ-20260901075508-877', 2, 'SPMO', 'SPMO', 125, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:55:54', '2026-09-01 05:55:08', '09:00 AM - 10:00 AM', ''),
(89, 'REQ-20260901075903-310', 2, 'joey', 'SPMO', 33, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:59:45', '2026-09-01 05:59:03', '09:00 AM - 10:00 AM', ''),
(90, 'REQ-20260901075903-310', 2, 'joey', 'SPMO', 108, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 13:59:34', '2026-09-01 05:59:03', '09:00 AM - 10:00 AM', ''),
(92, 'REQ-20260901080354-236', 2, 'jow', 'SPMO', 31, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:06:52', '2026-09-01 06:03:54', '09:00 AM - 10:00 AM', ''),
(93, 'REQ-20260901080354-236', 2, 'jow', 'SPMO', 109, 3, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:06:52', '2026-09-01 06:03:54', '09:00 AM - 10:00 AM', ''),
(94, 'REQ-20260901080354-236', 2, 'jow', 'SPMO', 161, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:06:52', '2026-09-01 06:03:54', '09:00 AM - 10:00 AM', ''),
(95, 'REQ-20260901081117-952', 2, 'SPMO', 'SPMO', 17, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:27:33', '2026-09-01 06:11:17', '09:00 AM - 10:00 AM', ''),
(96, 'REQ-20260901081117-952', 2, 'SPMO', 'SPMO', 19, 4, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:27:33', '2026-09-01 06:11:17', '09:00 AM - 10:00 AM', ''),
(97, 'REQ-20260901081117-952', 2, 'SPMO', 'SPMO', 20, 3, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:27:33', '2026-09-01 06:11:17', '09:00 AM - 10:00 AM', ''),
(98, 'REQ-20260901081305-915', 2, 'jeremmhe', 'registrar', 33, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:14:24', '2026-09-01 06:13:05', '09:00 AM - 10:00 AM', ''),
(99, 'REQ-20260901081305-915', 2, 'jeremmhe', 'registrar', 34, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:14:24', '2026-09-01 06:13:05', '09:00 AM - 10:00 AM', ''),
(101, 'REQ-20260901081305-915', 2, 'jeremmhe', 'registrar', 160, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:14:24', '2026-09-01 06:13:05', '09:00 AM - 10:00 AM', ''),
(102, 'REQ-20260901083250-706', 2, 'SPMO', 'registrar', 34, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:47:47', '2026-09-01 06:32:50', '09:00 AM - 10:00 AM', ''),
(103, 'REQ-20260901083250-706', 2, 'SPMO', 'registrar', 108, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:47:47', '2026-09-01 06:32:50', '09:00 AM - 10:00 AM', ''),
(104, 'REQ-20260901083250-706', 2, 'SPMO', 'registrar', 125, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:47:47', '2026-09-01 06:32:50', '09:00 AM - 10:00 AM', ''),
(105, 'REQ-20260901083746-728', 2, 'SPMO', 'SPMO', 125, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:52:24', '2026-09-01 06:37:46', '09:00 AM - 10:00 AM', ''),
(106, 'REQ-20260901084019-486', 2, 'SPMO', 'registrar', 108, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:52:06', '2026-09-01 06:40:19', '09:00 AM - 10:00 AM', ''),
(107, 'REQ-20260901084058-242', 2, 'SPMO', 'SPMO', 33, 1, 'For office use', '2026-09-02', 'Rejected', NULL, '2026-09-01 06:40:58', '09:00 AM - 10:00 AM', ''),
(108, 'REQ-20260901084236-792', 2, 'SPMO', 'registrar', 34, 2, 'For office use', '2026-09-09', 'Approved', '2026-09-01 14:47:12', '2026-09-01 06:42:36', '09:00 AM - 10:00 AM', ''),
(109, 'REQ-20260901084833-296', 2, 'SPMO', 'SPMO', 34, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:48:58', '2026-09-01 06:48:33', '09:00 AM - 10:00 AM', ''),
(110, 'REQ-20260901084833-296', 2, 'SPMO', 'SPMO', 108, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:48:58', '2026-09-01 06:48:33', '09:00 AM - 10:00 AM', ''),
(111, 'REQ-20260901084833-296', 2, 'SPMO', 'SPMO', 125, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:48:58', '2026-09-01 06:48:33', '09:00 AM - 10:00 AM', ''),
(112, 'REQ-20260901085359-408', 2, 'Joey Morales', 'SPMO', 125, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 14:54:20', '2026-09-01 06:53:59', '09:00 AM - 10:00 AM', ''),
(113, 'REQ-20260901085656-474', 2, 'SPMO', 'SPMO', 108, 2, 'For office use', '2026-09-01', 'Rejected', NULL, '2026-09-01 06:56:56', '09:00 AM - 10:00 AM', ''),
(114, 'REQ-20260901085656-474', 2, 'SPMO', 'SPMO', 125, 1, 'For office use', '2026-09-01', 'Rejected', NULL, '2026-09-01 06:56:56', '09:00 AM - 10:00 AM', ''),
(115, 'REQ-20260901091821-737', 2, 'SPMO', 'SPMO', 6, 1, 'for office use', '2026-09-02', 'Approved', '2026-09-01 15:18:50', '2026-09-01 07:18:21', '09:00 AM - 10:00 AM', ''),
(116, 'REQ-20260901091821-737', 2, 'SPMO', 'SPMO', 154, 1, 'for office use', '2026-09-02', 'Approved', '2026-09-01 15:18:50', '2026-09-01 07:18:21', '09:00 AM - 10:00 AM', ''),
(117, 'REQ-20260901092956-662', 2, 'SPMO', 'registrar', 26, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 15:30:27', '2026-09-01 07:29:56', '09:00 AM - 10:00 AM', ''),
(118, 'REQ-20260901092956-662', 2, 'SPMO', 'registrar', 34, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 15:30:27', '2026-09-01 07:29:56', '09:00 AM - 10:00 AM', ''),
(119, 'REQ-20260901094438-350', 2, 'SPMO', 'SPMO', 34, 1, 'For office use', '2026-09-01', 'Rejected', NULL, '2026-09-01 07:44:38', '09:00 AM - 10:00 AM', ''),
(120, 'REQ-20260901094438-350', 2, 'SPMO', 'SPMO', 125, 1, 'For office use', '2026-09-01', 'Rejected', NULL, '2026-09-01 07:44:38', '09:00 AM - 10:00 AM', ''),
(121, 'REQ-20260901094438-350', 2, 'SPMO', 'SPMO', 173, 1, 'For office use', '2026-09-01', 'Rejected', NULL, '2026-09-01 07:44:38', '09:00 AM - 10:00 AM', ''),
(122, 'REQ-20260901094526-216', 2, 'SPMO', 'SPMO', 173, 1, 'For office use', '2026-09-01', 'Rejected', NULL, '2026-09-01 07:45:26', '09:00 AM - 10:00 AM', ''),
(123, 'REQ-20260901094558-614', 2, 'SPMO', 'registrar', 34, 1, 'For office use', '2026-09-01', 'Rejected', NULL, '2026-09-01 07:45:58', '09:00 AM - 10:00 AM', ''),
(124, 'REQ-20260901094701-866', 2, 'SPMO', 'SPMO', 27, 1, 'for office use', '2026-09-01', 'Rejected', NULL, '2026-09-01 07:47:01', '09:00 AM - 10:00 AM', ''),
(125, 'REQ-20260901094830-778', 2, 'SPMO', 'SPMO', 27, 1, 'for office use', '2026-09-02', 'Rejected', NULL, '2026-09-01 07:48:30', '09:00 AM - 10:00 AM', ''),
(126, 'REQ-20260901094943-826', 2, 'SPMO', 'SPMO', 13, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 16:03:15', '2026-09-01 07:49:43', '09:00 AM - 10:00 AM', ''),
(127, 'REQ-20260901095158-826', 2, 'SPMO', 'SPMO', 34, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 16:03:04', '2026-09-01 07:51:58', '09:00 AM - 10:00 AM', ''),
(128, 'REQ-20260901095535-768', 2, 'SPMO', 'SPMO', 13, 1, 'For office use', '2026-09-01', 'Approved', '2026-09-01 16:02:50', '2026-09-01 07:55:35', '09:00 AM - 10:00 AM', ''),
(129, 'REQ-20260901095634-903', 2, 'SPMO', 'SPMO', 34, 3, 'For office use', '2026-09-01', 'Approved', '2026-09-01 15:59:38', '2026-09-01 07:56:34', '09:00 AM - 10:00 AM', ''),
(130, 'REQ-20260901095922-400', 2, 'SPMO', 'SPMO', 160, 4, 'For office use', '2026-09-03', 'Approved', '2026-09-01 16:00:02', '2026-09-01 07:59:22', '09:00 AM - 10:00 AM', ''),
(131, 'REQ-20260902011336-579', 2, 'SPMO', 'SPMO', 13, 1, 'For office use', '2026-09-02', 'Approved', '2026-09-02 09:33:23', '2026-09-01 23:13:36', '09:00 AM - 10:00 AM', ''),
(132, 'REQ-20260902011336-579', 2, 'SPMO', 'SPMO', 160, 1, 'For office use', '2026-09-02', 'Approved', '2026-09-02 09:33:23', '2026-09-01 23:13:36', '09:00 AM - 10:00 AM', ''),
(133, 'REQ-20260902023128-888', 2, 'SPMO', 'SPMO', 125, 2, 'For office use', '2026-09-02', 'Approved', '2026-09-02 08:31:55', '2026-09-02 00:31:28', '09:00 AM - 10:00 AM', ''),
(134, 'REQ-20260902023345-728', 2, 'SPMO', 'registrar', 13, 1, 'For office use', '2026-09-02', 'Approved', '2026-09-02 08:34:11', '2026-09-02 00:33:45', '09:00 AM - 10:00 AM', ''),
(135, 'REQ-20260902023345-728', 2, 'SPMO', 'registrar', 160, 1, 'For office use', '2026-09-02', 'Approved', '2026-09-02 08:34:11', '2026-09-02 00:33:45', '09:00 AM - 10:00 AM', ''),
(136, 'REQ-20260902030758-285', 2, 'SPMO', 'SPMO', 13, 2, 'For office use', '2026-09-02', 'Approved', '2026-09-02 09:08:24', '2026-09-02 01:07:58', '09:00 AM - 10:00 AM', ''),
(137, 'REQ-20260902031019-183', 2, 'SPMO', 'SPMO', 13, 10, 'For office use', '2026-09-02', 'Approved', '2026-09-02 09:30:52', '2026-09-02 01:10:19', '09:00 AM - 10:00 AM', ''),
(138, 'REQ-20260902031019-183', 2, 'SPMO', 'SPMO', 160, 8, 'For office use', '2026-09-02', 'Approved', '2026-09-02 09:30:52', '2026-09-02 01:10:19', '09:00 AM - 10:00 AM', ''),
(139, 'REQ-20260902033430-591', 2, 'SPMO', 'SPMO', 160, 13, 'For office use', '2026-09-02', 'Approved', '2026-09-02 09:34:44', '2026-09-02 01:34:30', '09:00 AM - 10:00 AM', ''),
(146, 'REQ-20260902082440-185', 2, 'SPMO', 'SPMO', 12, 2, 'For office use', '2026-09-01', 'Approved', '2026-09-02 14:24:59', '2026-09-02 06:24:40', '09:00 AM - 10:00 AM', ''),
(147, 'REQ-20260902095122-200', 2, 'SPMO', 'Joey L. Morales', 90, 1, 'For office use', '2026-09-02', 'Approved', '2026-09-03 07:42:45', '2026-09-02 07:51:22', '09:00 AM - 10:00 AM', ''),
(148, 'REQ-20260903021025-740', 2, 'SPMO', 'Joey L. Morales', 108, 2, 'For office use', '2026-09-03', 'Rejected', NULL, '2026-09-03 00:10:25', '09:00 AM - 10:00 AM', ''),
(149, 'REQ-20260903021025-740', 2, 'SPMO', 'Joey L. Morales', 125, 1, 'For office use', '2026-09-03', 'Rejected', NULL, '2026-09-03 00:10:25', '09:00 AM - 10:00 AM', ''),
(150, 'REQ-20260903023007-649', 2, 'SPMO', 'sao', 108, 1, 'd', '2026-09-03', 'Rejected', NULL, '2026-09-03 00:30:11', '09:00 AM - 10:00 AM', ''),
(151, 'REQ-20260903023015-635', 2, 'SPMO', 'sao', 108, 1, 'd', '2026-09-03', 'Rejected', NULL, '2026-09-03 00:30:15', '09:00 AM - 10:00 AM', ''),
(152, 'REQ-20260903023016-453', 2, 'SPMO', 'sao', 108, 1, 'd', '2026-09-03', 'Rejected', NULL, '2026-09-03 00:30:16', '09:00 AM - 10:00 AM', ''),
(153, 'REQ-20260903023017-965', 2, 'SPMO', 'sao', 108, 1, 'd', '2026-09-03', 'Rejected', NULL, '2026-09-03 00:30:17', '09:00 AM - 10:00 AM', ''),
(154, 'REQ-20260903023020-545', 2, 'SPMO', 'sao', 108, 1, 'd', '2026-09-03', 'Rejected', NULL, '2026-09-03 00:30:20', '09:00 AM - 10:00 AM', ''),
(155, 'REQ-20260903023020-618', 2, 'SPMO', 'sao', 108, 1, 'd', '2026-09-03', 'Approved', '2026-09-03 08:31:04', '2026-09-03 00:30:20', '09:00 AM - 10:00 AM', ''),
(156, 'REQ-20260903040101-761', 2, 'SPMO', 'sao', 108, 1, 'd', '2026-09-03', 'Approved', '2026-09-03 10:25:35', '2026-09-03 02:01:01', '09:00 AM - 10:00 AM', ''),
(157, 'REQ-20260903040134-906', 2, 'SPMO', 'sao', 125, 1, 'd', '2026-09-03', 'Approved', '2026-09-03 10:24:40', '2026-09-03 02:01:34', '09:00 AM - 10:00 AM', ''),
(158, 'REQ-20260903043343-785', 2, 'SPMO', 'Joey L. Morales', 115, 1, 'For office use', '2026-09-03', 'Approved', '2026-09-03 10:34:01', '2026-09-03 02:33:43', '09:00 AM - 10:00 AM', ''),
(159, 'REQ-20260903054420-701', 2, 'Joey L Morales', 'SPMO', 4, 1, 'For office use', '2026-09-03', 'Approved', '2026-09-03 11:45:13', '2026-09-03 03:44:20', '09:00 AM - 10:00 AM', ''),
(160, 'REQ-20260903054420-701', 2, 'Joey L Morales', 'SPMO', 35, 1, 'For office use', '2026-09-03', 'Approved', '2026-09-03 11:45:13', '2026-09-03 03:44:20', '09:00 AM - 10:00 AM', ''),
(161, 'REQ-20260903055944-325', 2, 'Joey L. Morales', 'SPMO', 25, 1, 'for office use', '2026-09-03', 'Approved', '2026-09-03 12:00:12', '2026-09-03 03:59:44', '09:00 AM - 10:00 AM', ''),
(162, 'REQ-20260903055944-325', 2, 'Joey L. Morales', 'SPMO', 26, 1, 'for office use', '2026-09-03', 'Approved', '2026-09-03 12:00:12', '2026-09-03 03:59:44', '09:00 AM - 10:00 AM', ''),
(163, 'REQ-20260903055944-325', 2, 'Joey L. Morales', 'SPMO', 33, 1, 'for office use', '2026-09-03', 'Approved', '2026-09-03 12:00:12', '2026-09-03 03:59:44', '09:00 AM - 10:00 AM', ''),
(164, 'REQ-20260903061843-297', 2, 'SPMO', 'hb', 115, 1, 'For office use', '2026-09-03', 'Approved', '2026-09-03 12:18:58', '2026-09-03 04:18:43', '09:00 AM - 10:00 AM', ''),
(165, 'REQ-20260903061843-297', 2, 'SPMO', 'hb', 123, 1, 'For office use', '2026-09-03', 'Approved', '2026-09-03 12:18:58', '2026-09-03 04:18:43', '09:00 AM - 10:00 AM', ''),
(166, 'REQ-20260903091405-141', 2, 'SPMO', 'SPMO', 4, 1, 'For office use', '2026-09-03', 'Approved', '2026-09-03 15:14:13', '2026-09-03 07:14:05', '09:00 AM - 10:00 AM', ''),
(167, 'REQ-20260904053408-990', 2, 'morales', 'sao', 108, 1, 'd', '2026-09-04', 'Approved', '2026-09-04 11:34:23', '2026-09-04 03:34:08', '09:00 AM - 10:00 AM', ''),
(168, 'REQ-20260904053408-990', 2, 'morales', 'sao', 125, 1, 'd', '2026-09-04', 'Approved', '2026-09-04 11:34:23', '2026-09-04 03:34:08', '09:00 AM - 10:00 AM', ''),
(169, 'REQ-20260908074716-646', 2, 'Joey Morales', 'SPMO', 25, 1, 'For office use', '2026-09-09', 'Approved', '2026-09-08 13:47:56', '2026-09-08 05:47:16', '08:00 AM - 09:00 AM', ''),
(170, 'REQ-20260908074716-646', 2, 'Joey Morales', 'SPMO', 26, 2, 'For office use', '2026-09-09', 'Approved', '2026-09-08 13:47:56', '2026-09-08 05:47:16', '08:00 AM - 09:00 AM', ''),
(171, 'REQ-20260908074716-646', 2, 'Joey Morales', 'SPMO', 30, 1, 'For office use', '2026-09-09', 'Approved', '2026-09-08 13:47:56', '2026-09-08 05:47:16', '08:00 AM - 09:00 AM', ''),
(172, 'REQ-20260908074716-646', 2, 'Joey Morales', 'SPMO', 31, 1, 'For office use', '2026-09-09', 'Approved', '2026-09-08 13:47:56', '2026-09-08 05:47:16', '08:00 AM - 09:00 AM', ''),
(173, 'REQ-20260909061237-971', 2, 'Joey Morales', 'SPMO', 108, 1, 'For office use', '2026-09-10', 'Approved', '2026-09-09 12:12:47', '2026-09-09 04:12:37', '09:00 AM - 10:00 AM', ''),
(174, 'REQ-20260909061237-971', 2, 'Joey Morales', 'SPMO', 125, 1, 'For office use', '2026-09-10', 'Approved', '2026-09-09 12:12:47', '2026-09-09 04:12:37', '09:00 AM - 10:00 AM', ''),
(175, 'REQ-20260911013243-191', 6, 'Joey L. Morales', 'CTI', 125, 1, 'd', '2026-09-18', 'Approved', '2026-09-11 07:32:54', '2026-09-10 23:32:43', '09:00 AM - 10:00 AM', ''),
(176, 'REQ-20260911024548-600', 6, 'Joey L. Morales', 'CTI', 115, 1, 'd', '2026-09-11', 'Approved', '2026-09-11 08:46:26', '2026-09-11 00:45:48', '09:00 AM - 10:00 AM', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `fullname`, `role`, `created_at`) VALUES
(1, 'admin', '123456', 'System Admin', 'admin', '2026-08-28 03:12:35'),
(2, 'user1', '123456', 'SPMO', 'user', '2026-08-28 03:12:35'),
(3, 'SPMO', '123456', 'SPMO Office', 'admin', '2026-08-28 03:25:58'),
(4, 'HRMO', '$2y$10$wwvE/4XKuMIa95koGZIooeuKiMO1eKoemYi9DL531N0Nu8SGD2KwC', 'HRMO', 'user', '2026-09-01 02:37:14'),
(5, 'REGISTRAR', '$2y$10$4sVvFIstJCB1Yrl.zzxBDuNgOPYmPQxlHI1mqM2RsawloHGimTlSq', 'REGISTRAR', 'user', '2026-09-02 06:49:40'),
(6, 'joey', '$2y$10$PSG2eXOw1jigyzV1neh8fO0obEOKwzKmnUVNyCD6jX5WXMUvRuKhu', 'Joey L. Morales', 'user', '2026-09-08 00:42:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `borrow_requests`
--
ALTER TABLE `borrow_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `calendar_schedules`
--
ALTER TABLE `calendar_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `document_printing_requests`
--
ALTER TABLE `document_printing_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `maintenance_items`
--
ALTER TABLE `maintenance_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_history`
--
ALTER TABLE `stock_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supply_requests`
--
ALTER TABLE `supply_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `borrow_requests`
--
ALTER TABLE `borrow_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `calendar_schedules`
--
ALTER TABLE `calendar_schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `document_printing_requests`
--
ALTER TABLE `document_printing_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=179;

--
-- AUTO_INCREMENT for table `maintenance_items`
--
ALTER TABLE `maintenance_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `stock_history`
--
ALTER TABLE `stock_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `supply_requests`
--
ALTER TABLE `supply_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  ADD CONSTRAINT `maintenance_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `maintenance_requests_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `maintenance_items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `supply_requests`
--
ALTER TABLE `supply_requests`
  ADD CONSTRAINT `supply_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supply_requests_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
