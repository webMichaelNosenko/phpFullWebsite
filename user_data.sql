-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 03, 2021 at 11:30 PM
-- Server version: 10.4.16-MariaDB
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `user_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `city_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `city_name`) VALUES
(1, 'Волгоград'),
(9, 'Краснодар'),
(2, 'Москва'),
(5, 'Ростов'),
(8, 'Рязань'),
(4, 'Самара'),
(7, 'Санкт-Петербург'),
(3, 'Саратов'),
(6, 'Уфа');

-- --------------------------------------------------------

--
-- Table structure for table `city_owners`
--

CREATE TABLE `city_owners` (
  `id` int(11) NOT NULL,
  `city_name` varchar(40) NOT NULL,
  `party_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `city_owners`
--

INSERT INTO `city_owners` (`id`, `city_name`, `party_name`) VALUES
(2, 'Москва', 'ЛДПР'),
(3, 'Уфа', 'ЛДПР'),
(5, 'Ростов', 'ЛДПР'),
(7, 'Волгоград', 'ЛДПР'),
(8, 'Краснодар', 'ЛДПР');

-- --------------------------------------------------------

--
-- Table structure for table `credentials`
--

CREATE TABLE `credentials` (
  `id` int(11) NOT NULL,
  `party_name` varchar(40) NOT NULL,
  `password` text NOT NULL,
  `email` text NOT NULL,
  `admin_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `credentials`
--

INSERT INTO `credentials` (`id`, `party_name`, `password`, `email`, `admin_name`) VALUES
(1, 's', 's', 's@s.ru', 's'),
(2, 'ЛДПР', '$2y$10$ng1EnyAdnI/YGjFgGfNu/.tIUORBt/cauGFXi9sfYNNMALC448G5W', 'ldpr@mail.ru', 'Lexx'),
(4, 'aaa', 'aaa', 'aaa@a.ru', 'aaa'),
(5, 'КПРФ', '1', 'kprf@r.ru', 'ыыыыыы'),
(7, 'sss', 'ssssss', 'sss@s.ss', 'ss'),
(9, 'q', '$2y$10$QCPddvEGCknEj2lXWzhy5.rClNtzrw129sFLnpuOso28jPDOBdtou', 'q@q.w', 'q');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `party_name` varchar(40) NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `time` datetime NOT NULL,
  `city_name` varchar(40) NOT NULL,
  `theme` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `party_name`, `event_name`, `time`, `city_name`, `theme`) VALUES
(2, 'ЛДПР', 'Собрание', '2022-01-09 12:33:14', 'Москва', 'ffffff'),
(7, 'ЛДПР', 'Айайа', '2020-12-08 18:17:01', 'Волгоград', 'Ачачач');

-- --------------------------------------------------------

--
-- Table structure for table `event_attendees`
--

CREATE TABLE `event_attendees` (
  `id` int(11) NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `party_name` varchar(40) NOT NULL,
  `member_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `event_attendees`
--

INSERT INTO `event_attendees` (`id`, `event_name`, `party_name`, `member_name`) VALUES
(16, 'Собрание', 'ЛДПР', 'Илья Мэддисон'),
(18, 'Айайа', 'ЛДПР', 'Данил Устинов'),
(19, 'Собрание', 'ЛДПР', 'Данил Устинов'),
(20, 'Собрание', 'ЛДПР', 'Михаил Носенко');

-- --------------------------------------------------------

--
-- Table structure for table `party_members`
--

CREATE TABLE `party_members` (
  `id` int(11) NOT NULL,
  `party_name` varchar(40) NOT NULL,
  `name` varchar(100) NOT NULL,
  `birth_date` date NOT NULL,
  `work_time` text NOT NULL,
  `position` text NOT NULL,
  `payout` int(11) NOT NULL,
  `image` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `party_members`
--

INSERT INTO `party_members` (`id`, `party_name`, `name`, `birth_date`, `work_time`, `position`, `payout`, `image`) VALUES
(1, 'ЛДПР', 'Данил Устинов', '1980-11-11', '22', '22', 22, ''),
(2, 'ЛДПР', 'Илья Мэддисон', '1990-12-01', '1 год', 'Главный по молодежи', 10, ''),
(4, 'ЛДПР', 'Михаил Носенко', '1990-01-01', '10 лет', 'Менеджер', 100000, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `redirects`
--

CREATE TABLE `redirects` (
  `id` int(11) NOT NULL,
  `redirect_source` text NOT NULL,
  `request_time` datetime NOT NULL,
  `ip_addr` text NOT NULL,
  `redirect_target` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `redirects`
--

INSERT INTO `redirects` (`id`, `redirect_source`, `request_time`, `ip_addr`, `redirect_target`) VALUES
(24, 'http://localhost:63342/intervolgaWeb/pages/unauth.html?_ijt=svg6dp14u5b1ucqafqgqkv17kp', '2020-12-10 14:58:15', '127.0.0.1', 'login'),
(25, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 14:58:24', '127.0.0.1', 'login'),
(26, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 14:58:24', '127.0.0.1', 'index'),
(27, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-10 14:59:52', '127.0.0.1', 'index'),
(28, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 15:08:31', '127.0.0.1', 'login'),
(29, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:08:56', '127.0.0.1', 'login'),
(30, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:08:57', '127.0.0.1', 'index'),
(31, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 15:11:10', '127.0.0.1', 'login'),
(32, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:11:18', '127.0.0.1', 'index'),
(33, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-10 15:16:31', '127.0.0.1', 'index'),
(34, 'http://localhost:63342/intervolgaWeb/pages/unauth.html?_ijt=unmloc97anq27u5cumshb33s6', '2020-12-10 15:43:48', '127.0.0.1', 'signup'),
(35, 'http://localhost:63342/intervolgaWeb/pages/unauth.html?_ijt=dvdoige457gveav2vl2s6dn9tj', '2020-12-10 15:58:12', '127.0.0.1', 'login'),
(36, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:58:17', '127.0.0.1', 'signup'),
(37, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:58:17', '127.0.0.1', 'login'),
(38, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:58:23', '127.0.0.1', 'signup'),
(39, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:58:24', '127.0.0.1', 'login'),
(40, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:58:35', '127.0.0.1', 'signup'),
(41, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:58:36', '127.0.0.1', 'index'),
(42, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 15:58:38', '127.0.0.1', 'login'),
(43, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:58:40', '127.0.0.1', 'signup'),
(44, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 15:58:41', '127.0.0.1', 'login'),
(45, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 16:00:02', '127.0.0.1', 'login'),
(46, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 16:00:04', '127.0.0.1', 'login'),
(47, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 16:00:07', '127.0.0.1', 'login'),
(48, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:00:12', '127.0.0.1', 'signup'),
(49, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:00:12', '127.0.0.1', 'login'),
(50, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:00:12', '127.0.0.1', 'signup'),
(51, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:00:12', '127.0.0.1', 'login'),
(52, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:00:16', '127.0.0.1', 'login'),
(53, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 16:00:18', '127.0.0.1', 'login'),
(54, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 16:00:24', '127.0.0.1', 'login'),
(55, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:00:31', '127.0.0.1', 'signup'),
(56, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:00:32', '127.0.0.1', 'index'),
(57, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:09:20', '127.0.0.1', 'index'),
(58, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:09:21', '127.0.0.1', 'index'),
(59, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 16:09:56', '127.0.0.1', 'login'),
(60, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-10 16:09:59', '127.0.0.1', 'signup'),
(61, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-10 16:09:59', '127.0.0.1', 'login'),
(62, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-10 16:10:00', '127.0.0.1', 'login'),
(63, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:10:13', '127.0.0.1', 'signup'),
(64, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-10 16:10:13', '127.0.0.1', 'index'),
(65, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 16:10:24', '127.0.0.1', 'signup'),
(66, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-10 16:10:32', '127.0.0.1', 'signup'),
(67, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-10 16:10:39', '127.0.0.1', 'signup'),
(68, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-10 16:13:07', '127.0.0.1', 'login'),
(69, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-10 16:13:15', '127.0.0.1', 'signup'),
(70, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-10 16:13:15', '127.0.0.1', 'login'),
(71, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-10 16:14:42', '127.0.0.1', 'login'),
(72, 'http://localhost:63342/intervolgaWeb/pages/unauth.html?_ijt=7sdbspvk2k3cp6rr7p4n1estoj', '2020-12-10 20:50:48', '127.0.0.1', 'login'),
(73, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-10 20:50:56', '127.0.0.1', 'signup'),
(74, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-10 20:50:56', '127.0.0.1', 'index'),
(75, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php?_ijt=fla4udtf0o709dvoe1au6ibts9', '2020-12-11 10:01:37', '127.0.0.1', 'edit_members'),
(76, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php?_ijt=fla4udtf0o709dvoe1au6ibts9', '2020-12-11 10:02:58', '127.0.0.1', 'edit_members'),
(77, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:03:24', '127.0.0.1', 'edit_members'),
(78, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:03:57', '127.0.0.1', 'edit_members'),
(79, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:04:00', '127.0.0.1', 'edit_members'),
(80, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:05:05', '127.0.0.1', 'edit_members'),
(81, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:08:08', '127.0.0.1', 'edit_members'),
(82, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:08:26', '127.0.0.1', 'edit_members'),
(83, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:08:28', '127.0.0.1', 'edit_members'),
(84, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:08:49', '127.0.0.1', 'edit_members'),
(85, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:09:17', '127.0.0.1', 'edit_members'),
(86, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:10:40', '127.0.0.1', 'edit_members'),
(87, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:11:13', '127.0.0.1', 'edit_members'),
(88, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:11:32', '127.0.0.1', 'edit_members'),
(89, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:11:35', '127.0.0.1', 'edit_members'),
(90, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:12:53', '127.0.0.1', 'index'),
(91, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-11 10:12:55', '127.0.0.1', 'index'),
(92, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-11 10:13:35', '127.0.0.1', 'index'),
(93, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-11 10:13:36', '127.0.0.1', 'edit_members'),
(94, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:13:39', '127.0.0.1', 'index'),
(95, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:13:49', '127.0.0.1', 'index'),
(96, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-11 10:13:52', '127.0.0.1', 'edit_members'),
(97, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:13:55', '127.0.0.1', 'index'),
(98, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-11 10:14:31', '127.0.0.1', 'edit_members'),
(99, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:14:32', '127.0.0.1', 'index'),
(100, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-11 10:14:34', '127.0.0.1', 'edit_members'),
(101, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:14:38', '127.0.0.1', 'index'),
(102, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 10:16:51', '127.0.0.1', 'index'),
(103, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 10:16:52', '127.0.0.1', 'index'),
(104, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 10:17:28', '127.0.0.1', 'index'),
(105, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 10:17:33', '127.0.0.1', 'index'),
(106, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-11 10:17:50', '127.0.0.1', 'login'),
(107, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 10:18:06', '127.0.0.1', 'signup'),
(108, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 10:18:06', '127.0.0.1', 'index'),
(109, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-11 10:18:42', '127.0.0.1', 'index'),
(110, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-11 10:19:07', '127.0.0.1', 'index'),
(111, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-11 10:19:14', '127.0.0.1', 'edit_members'),
(112, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 10:19:19', '127.0.0.1', 'index'),
(113, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-11 10:19:29', '127.0.0.1', 'index'),
(114, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-11 11:00:11', '127.0.0.1', 'login'),
(115, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 11:00:17', '127.0.0.1', 'signup'),
(116, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 11:00:17', '127.0.0.1', 'index'),
(117, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 11:00:18', '127.0.0.1', 'index'),
(118, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-11 11:02:35', '127.0.0.1', 'login'),
(119, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 11:02:39', '127.0.0.1', 'signup'),
(120, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-11 11:02:39', '127.0.0.1', 'login'),
(121, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-11 11:24:27', '127.0.0.1', 'signup'),
(122, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-11 11:24:27', '127.0.0.1', 'index'),
(123, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-11 11:24:31', '127.0.0.1', 'index'),
(124, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-11 11:24:32', '127.0.0.1', 'edit_members'),
(125, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 11:24:57', '127.0.0.1', 'index'),
(126, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-11 11:25:03', '127.0.0.1', 'index'),
(127, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-11 11:25:04', '127.0.0.1', 'edit_members'),
(128, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 11:25:36', '127.0.0.1', 'edit_members'),
(129, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-11 11:26:02', '127.0.0.1', 'index'),
(130, 'http://localhost:63342/intervolgaWeb/pages/unauth.html?_ijt=7n1sdme94fdml22gu99onbg5ip', '2020-12-18 10:43:09', '127.0.0.1', 'login'),
(131, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-18 10:43:15', '127.0.0.1', 'signup'),
(132, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-18 10:43:16', '127.0.0.1', 'index'),
(133, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-18 10:43:47', '127.0.0.1', 'index'),
(134, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-18 10:43:56', '127.0.0.1', 'index'),
(135, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-18 10:44:17', '127.0.0.1', 'index'),
(136, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 10:44:19', '127.0.0.1', 'edit_events'),
(137, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-18 10:45:09', '127.0.0.1', 'index'),
(138, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 10:45:10', '127.0.0.1', 'edit_events'),
(139, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 10:47:59', '127.0.0.1', 'edit_events'),
(140, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 10:48:22', '127.0.0.1', 'edit_events'),
(141, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 10:48:37', '127.0.0.1', 'edit_events'),
(142, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-18 11:03:48', '127.0.0.1', 'index'),
(143, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 11:03:50', '127.0.0.1', 'edit_events'),
(144, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:04:09', '127.0.0.1', 'edit_members'),
(145, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 11:04:15', '127.0.0.1', 'edit_events'),
(146, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:04:44', '127.0.0.1', 'edit_events'),
(147, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:05:30', '127.0.0.1', 'edit_events'),
(148, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:08:15', '127.0.0.1', 'edit_events'),
(149, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:08:23', '127.0.0.1', 'edit_events'),
(150, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:08:26', '127.0.0.1', 'edit_events'),
(151, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:09:23', '127.0.0.1', 'edit_events'),
(152, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:09:28', '127.0.0.1', 'edit_events'),
(153, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:09:35', '127.0.0.1', 'edit_events'),
(154, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:09:38', '127.0.0.1', 'edit_events'),
(155, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-18 11:09:55', '127.0.0.1', 'index'),
(156, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 11:09:57', '127.0.0.1', 'edit_events'),
(157, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 11:12:02', '127.0.0.1', 'edit_events'),
(158, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:12:09', '127.0.0.1', 'edit_events'),
(159, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:12:16', '127.0.0.1', 'edit_events'),
(160, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:12:18', '127.0.0.1', 'edit_events'),
(161, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 11:12:20', '127.0.0.1', 'index'),
(162, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 11:16:56', '127.0.0.1', 'edit_events'),
(163, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 11:29:38', '127.0.0.1', 'edit_events'),
(164, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:11:17', '127.0.0.1', 'edit_events'),
(165, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:13:06', '127.0.0.1', 'edit_events'),
(166, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:13:45', '127.0.0.1', 'edit_events'),
(167, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:13:51', '127.0.0.1', 'edit_events'),
(168, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:25:36', '127.0.0.1', 'edit_events'),
(169, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:26:02', '127.0.0.1', 'edit_events'),
(170, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:26:03', '127.0.0.1', 'edit_events'),
(171, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:26:07', '127.0.0.1', 'edit_events'),
(172, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:27:17', '127.0.0.1', 'edit_events'),
(173, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:27:53', '127.0.0.1', 'edit_events'),
(174, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:27:55', '127.0.0.1', 'edit_events'),
(175, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 12:27:57', '127.0.0.1', 'edit_events'),
(176, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 12:28:00', '127.0.0.1', 'edit_events'),
(177, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 12:28:21', '127.0.0.1', 'edit_events'),
(178, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 12:28:28', '127.0.0.1', 'edit_events'),
(179, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 12:28:30', '127.0.0.1', 'edit_events'),
(180, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 12:39:32', '127.0.0.1', 'edit_events'),
(181, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 12:39:39', '127.0.0.1', 'index'),
(182, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:39:44', '127.0.0.1', 'edit_events'),
(183, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:40:19', '127.0.0.1', 'edit_events'),
(184, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:43:50', '127.0.0.1', 'edit_events'),
(185, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:45:09', '127.0.0.1', 'edit_events'),
(186, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 12:56:48', '127.0.0.1', 'edit_events'),
(187, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 12:56:56', '127.0.0.1', 'edit_events'),
(188, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 12:58:36', '127.0.0.1', 'edit_events'),
(189, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 12:58:43', '127.0.0.1', 'edit_events'),
(190, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:02:44', '127.0.0.1', 'index'),
(191, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:02:46', '127.0.0.1', 'edit_events'),
(192, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:04:29', '127.0.0.1', 'edit_events'),
(193, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:04:35', '127.0.0.1', 'edit_events'),
(194, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:04:56', '127.0.0.1', 'index'),
(195, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:05:02', '127.0.0.1', 'index'),
(196, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:05:26', '127.0.0.1', 'edit_events'),
(197, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:05:29', '127.0.0.1', 'index'),
(198, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:05:30', '127.0.0.1', 'edit_members'),
(199, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-18 13:05:32', '127.0.0.1', 'index'),
(200, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:05:35', '127.0.0.1', 'edit_events'),
(201, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:05:37', '127.0.0.1', 'index'),
(202, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:05:38', '127.0.0.1', 'edit_members'),
(203, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:25:33', '127.0.0.1', 'edit_members'),
(204, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-18 13:25:40', '127.0.0.1', 'index'),
(205, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:25:42', '127.0.0.1', 'edit_events'),
(206, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:25:46', '127.0.0.1', 'edit_events'),
(207, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:26:17', '127.0.0.1', 'edit_events'),
(208, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:27:13', '127.0.0.1', 'edit_events'),
(209, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:27:24', '127.0.0.1', 'index'),
(210, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:29:59', '127.0.0.1', 'index'),
(211, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:30:04', '127.0.0.1', 'edit_events'),
(212, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:30:06', '127.0.0.1', 'edit_events'),
(213, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-18 13:30:07', '127.0.0.1', 'index'),
(214, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-18 13:54:46', '127.0.0.1', 'index'),
(215, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-18 13:55:16', '127.0.0.1', 'index'),
(216, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 13:55:18', '127.0.0.1', 'edit_events'),
(217, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 14:08:19', '127.0.0.1', 'index'),
(218, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:08:20', '127.0.0.1', 'edit_events'),
(219, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:08:40', '127.0.0.1', 'edit_events'),
(220, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:13:43', '127.0.0.1', 'edit_events'),
(221, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:14:29', '127.0.0.1', 'edit_events'),
(222, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 14:14:42', '127.0.0.1', 'index'),
(223, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:15:53', '127.0.0.1', 'edit_events'),
(224, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 14:29:32', '127.0.0.1', 'index'),
(225, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:29:34', '127.0.0.1', 'edit_attendance'),
(226, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:37:00', '127.0.0.1', 'edit_attendance'),
(227, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:37:39', '127.0.0.1', 'edit_attendance'),
(228, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:56:59', '127.0.0.1', 'edit_attendance'),
(229, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 14:57:05', '127.0.0.1', 'edit_events'),
(230, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:58:35', '127.0.0.1', 'edit_attendance'),
(231, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 14:58:39', '127.0.0.1', 'edit_events'),
(232, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:58:42', '127.0.0.1', 'edit_attendance'),
(233, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:59:29', '127.0.0.1', 'edit_attendance'),
(234, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 14:59:49', '127.0.0.1', 'edit_attendance'),
(235, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:04:01', '127.0.0.1', 'index'),
(236, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 15:04:03', '127.0.0.1', 'edit_attendance'),
(237, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 15:05:04', '127.0.0.1', 'edit_attendance'),
(238, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 15:05:08', '127.0.0.1', 'edit_attendance'),
(239, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 15:05:14', '127.0.0.1', 'edit_attendance'),
(240, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-18 15:06:34', '127.0.0.1', 'edit_attendance'),
(241, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:06:36', '127.0.0.1', 'edit_attendance'),
(242, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:06:38', '127.0.0.1', 'edit_attendance'),
(243, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:07:23', '127.0.0.1', 'edit_attendance'),
(244, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:07:25', '127.0.0.1', 'edit_attendance'),
(245, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:07:26', '127.0.0.1', 'edit_attendance'),
(246, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:07:29', '127.0.0.1', 'edit_attendance'),
(247, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:08:38', '127.0.0.1', 'edit_attendance'),
(248, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:13:03', '127.0.0.1', 'edit_attendance'),
(249, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:13:05', '127.0.0.1', 'edit_attendance'),
(250, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:13:07', '127.0.0.1', 'edit_attendance'),
(251, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-18 15:13:08', '127.0.0.1', 'edit_attendance'),
(252, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:19:36', '127.0.0.1', 'edit_attendance'),
(253, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:24:39', '127.0.0.1', 'edit_attendance'),
(254, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:36:48', '127.0.0.1', 'edit_attendance'),
(255, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:36:53', '127.0.0.1', 'edit_attendance'),
(256, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:36:57', '127.0.0.1', 'edit_attendance'),
(257, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:01', '127.0.0.1', 'edit_attendance'),
(258, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:03', '127.0.0.1', 'edit_attendance'),
(259, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:05', '127.0.0.1', 'edit_attendance'),
(260, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:09', '127.0.0.1', 'edit_attendance'),
(261, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:15', '127.0.0.1', 'edit_attendance'),
(262, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:17', '127.0.0.1', 'index'),
(263, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-21 15:37:22', '127.0.0.1', 'edit_attendance'),
(264, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:23', '127.0.0.1', 'edit_attendance'),
(265, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:25', '127.0.0.1', 'index'),
(266, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-21 15:37:32', '127.0.0.1', 'edit_attendance'),
(267, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:34', '127.0.0.1', 'edit_attendance'),
(268, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:40', '127.0.0.1', 'edit_attendance'),
(269, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:42', '127.0.0.1', 'edit_attendance'),
(270, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-21 15:37:49', '127.0.0.1', 'index'),
(271, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-21 16:03:52', '127.0.0.1', 'edit_members'),
(272, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-21 16:05:50', '127.0.0.1', 'edit_members'),
(273, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-21 16:06:14', '127.0.0.1', 'edit_members'),
(274, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-21 16:07:24', '127.0.0.1', 'edit_members'),
(275, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-21 16:08:36', '127.0.0.1', 'edit_members'),
(276, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-21 16:31:22', '127.0.0.1', 'edit_members'),
(277, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-21 16:33:29', '127.0.0.1', 'edit_members'),
(278, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-21 16:34:55', '127.0.0.1', 'edit_members'),
(279, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-21 16:37:51', '127.0.0.1', 'edit_members'),
(280, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-21 16:39:51', '127.0.0.1', 'edit_members'),
(281, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php?_ijt=8nl88o8jamhbo9jr83lioeh326', '2020-12-23 10:32:27', '127.0.0.1', 'index'),
(282, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 10:32:30', '127.0.0.1', 'edit_events'),
(283, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php?_ijt=8nl88o8jamhbo9jr83lioeh326', '2020-12-23 10:34:05', '127.0.0.1', 'edit_events'),
(284, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 10:34:15', '127.0.0.1', 'index'),
(285, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php?_ijt=1dcn8jg9t114d7q11ou66mtiq3', '2020-12-23 10:48:49', '127.0.0.1', 'edit_members'),
(286, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 10:48:53', '127.0.0.1', 'index'),
(287, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 10:48:57', '127.0.0.1', 'edit_members'),
(288, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 10:49:26', '127.0.0.1', 'edit_members'),
(289, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 10:50:07', '127.0.0.1', 'edit_members'),
(290, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 10:50:25', '127.0.0.1', 'edit_members'),
(291, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 11:00:03', '127.0.0.1', 'index'),
(292, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 11:00:06', '127.0.0.1', 'edit_members'),
(293, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:00:22', '127.0.0.1', 'index'),
(294, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:02:08', '127.0.0.1', 'edit_members'),
(295, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:17:46', '127.0.0.1', 'edit_members'),
(296, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:28:05', '127.0.0.1', 'edit_members'),
(297, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:30:25', '127.0.0.1', 'edit_members'),
(298, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:31:24', '127.0.0.1', 'edit_members'),
(299, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:39:15', '127.0.0.1', 'edit_members'),
(300, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:39:37', '127.0.0.1', 'edit_members'),
(301, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:39:57', '127.0.0.1', 'edit_members'),
(302, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:40:09', '127.0.0.1', 'edit_members'),
(303, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:44:23', '127.0.0.1', 'index'),
(304, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 11:45:46', '127.0.0.1', 'index'),
(305, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 11:45:47', '127.0.0.1', 'edit_members'),
(306, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:46:07', '127.0.0.1', 'edit_members'),
(307, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 11:46:13', '127.0.0.1', 'index'),
(308, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 11:46:19', '127.0.0.1', 'edit_events'),
(309, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 11:46:21', '127.0.0.1', 'index'),
(310, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 11:46:24', '127.0.0.1', 'edit_attendance'),
(311, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-23 11:46:25', '127.0.0.1', 'index'),
(312, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 12:23:24', '127.0.0.1', 'index'),
(313, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:23:26', '127.0.0.1', 'edit_cities'),
(314, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:24:22', '127.0.0.1', 'edit_cities'),
(315, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:24:47', '127.0.0.1', 'edit_cities'),
(316, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-23 12:34:20', '127.0.0.1', 'index'),
(317, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:34:22', '127.0.0.1', 'edit_cities'),
(318, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:34:24', '127.0.0.1', 'edit_cities'),
(319, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:34:28', '127.0.0.1', 'edit_cities'),
(320, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:34:29', '127.0.0.1', 'edit_cities'),
(321, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:34:31', '127.0.0.1', 'edit_cities'),
(322, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:34:34', '127.0.0.1', 'edit_cities'),
(323, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:34:36', '127.0.0.1', 'index'),
(324, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:34:44', '127.0.0.1', 'edit_cities'),
(325, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:34:46', '127.0.0.1', 'edit_cities'),
(326, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:34:48', '127.0.0.1', 'index'),
(327, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:34:54', '127.0.0.1', 'edit_cities'),
(328, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:34:58', '127.0.0.1', 'index'),
(329, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:35:01', '127.0.0.1', 'index'),
(330, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:35:18', '127.0.0.1', 'index'),
(331, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:35:21', '127.0.0.1', 'edit_cities'),
(332, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:35:23', '127.0.0.1', 'edit_cities'),
(333, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:35:24', '127.0.0.1', 'index'),
(334, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:37:45', '127.0.0.1', 'edit_cities'),
(335, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:37:48', '127.0.0.1', 'index'),
(336, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:37:51', '127.0.0.1', 'index'),
(337, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:38:21', '127.0.0.1', 'index'),
(338, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:39:46', '127.0.0.1', 'edit_events'),
(339, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 12:39:48', '127.0.0.1', 'index'),
(340, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:40:15', '127.0.0.1', 'edit_cities'),
(341, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:40:20', '127.0.0.1', 'edit_cities'),
(342, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:40:24', '127.0.0.1', 'index'),
(343, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:40:25', '127.0.0.1', 'edit_events'),
(344, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 12:40:56', '127.0.0.1', 'edit_events'),
(345, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 12:40:59', '127.0.0.1', 'index'),
(346, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:41:00', '127.0.0.1', 'edit_attendance'),
(347, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-23 12:41:05', '127.0.0.1', 'edit_attendance'),
(348, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-23 12:41:06', '127.0.0.1', 'index'),
(349, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 12:45:24', '127.0.0.1', 'signup'),
(350, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-23 12:45:44', '127.0.0.1', 'index'),
(351, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:45:47', '127.0.0.1', 'edit_cities'),
(352, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 12:45:51', '127.0.0.1', 'index'),
(353, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:45:53', '127.0.0.1', 'edit_events'),
(354, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 12:45:55', '127.0.0.1', 'index'),
(355, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:45:57', '127.0.0.1', 'edit_attendance'),
(356, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-23 12:46:03', '127.0.0.1', 'index'),
(357, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 12:46:07', '127.0.0.1', 'edit_members'),
(358, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 12:46:10', '127.0.0.1', 'index'),
(359, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 12:46:14', '127.0.0.1', 'index'),
(360, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 12:46:17', '127.0.0.1', 'login'),
(361, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 12:46:30', '127.0.0.1', 'signup'),
(362, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 12:46:30', '127.0.0.1', 'index'),
(363, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 13:30:40', '127.0.0.1', 'index'),
(364, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 13:30:43', '127.0.0.1', 'edit_cities'),
(365, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 13:33:35', '127.0.0.1', 'edit_cities'),
(366, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 13:33:37', '127.0.0.1', 'index'),
(367, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 13:33:40', '127.0.0.1', 'edit_members'),
(368, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 13:33:42', '127.0.0.1', 'index'),
(369, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 13:33:43', '127.0.0.1', 'edit_events'),
(370, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 13:33:45', '127.0.0.1', 'index'),
(371, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 13:33:46', '127.0.0.1', 'edit_attendance'),
(372, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 13:33:47', '127.0.0.1', 'index'),
(373, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 13:33:49', '127.0.0.1', 'edit_cities'),
(374, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 13:44:14', '127.0.0.1', 'index'),
(375, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 13:58:15', '127.0.0.1', 'signup'),
(376, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-23 13:58:16', '127.0.0.1', 'index'),
(377, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 14:17:28', '127.0.0.1', 'signup'),
(378, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 14:24:28', '127.0.0.1', 'signup'),
(379, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 14:24:48', '127.0.0.1', 'signup'),
(380, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 14:25:49', '127.0.0.1', 'login'),
(381, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 14:25:55', '127.0.0.1', 'signup'),
(382, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-23 14:26:05', '127.0.0.1', 'index'),
(383, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 14:33:07', '127.0.0.1', 'signup'),
(384, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-23 14:33:15', '127.0.0.1', 'signup'),
(385, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-23 14:33:27', '127.0.0.1', 'index'),
(386, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-23 14:33:50', '127.0.0.1', 'index'),
(387, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-23 14:33:54', '127.0.0.1', 'index'),
(388, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 14:33:57', '127.0.0.1', 'index'),
(389, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 14:34:38', '127.0.0.1', 'signup'),
(390, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 14:34:48', '127.0.0.1', 'signup'),
(391, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-23 14:35:00', '127.0.0.1', 'index'),
(392, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 14:36:37', '127.0.0.1', 'login'),
(393, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 14:36:46', '127.0.0.1', 'signup'),
(394, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 14:36:46', '127.0.0.1', 'login'),
(395, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:37:01', '127.0.0.1', 'signup'),
(396, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:37:42', '127.0.0.1', 'login'),
(397, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 14:38:29', '127.0.0.1', 'login'),
(398, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 14:39:46', '127.0.0.1', 'login'),
(399, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:39:53', '127.0.0.1', 'signup'),
(400, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:39:53', '127.0.0.1', 'login'),
(401, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:41:33', '127.0.0.1', 'signup'),
(402, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:42:42', '127.0.0.1', 'login'),
(403, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:42:50', '127.0.0.1', 'signup'),
(404, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:42:50', '127.0.0.1', 'login'),
(405, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:46:18', '127.0.0.1', 'login'),
(406, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:46:24', '127.0.0.1', 'signup'),
(407, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:46:24', '127.0.0.1', 'login'),
(408, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:47:51', '127.0.0.1', 'signup'),
(409, 'http://localhost:63342/intervolgaWeb/pages/login.php', '2020-12-23 14:47:52', '127.0.0.1', 'index'),
(410, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:16:05', '127.0.0.1', 'index'),
(411, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:17:20', '127.0.0.1', 'index'),
(412, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:18:41', '127.0.0.1', 'index'),
(413, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:19:49', '127.0.0.1', 'index'),
(414, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:20:08', '127.0.0.1', 'index'),
(415, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:20:17', '127.0.0.1', 'index'),
(416, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:20:32', '127.0.0.1', 'index'),
(417, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:20:35', '127.0.0.1', 'index'),
(418, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:20:43', '127.0.0.1', 'index'),
(419, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:20:53', '127.0.0.1', 'index'),
(420, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:20:56', '127.0.0.1', 'index'),
(421, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:21:01', '127.0.0.1', 'index'),
(422, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:21:04', '127.0.0.1', 'index'),
(423, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 15:21:18', '127.0.0.1', 'login'),
(424, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 15:21:25', '127.0.0.1', 'signup'),
(425, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 15:21:25', '127.0.0.1', 'index'),
(426, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 15:21:41', '127.0.0.1', 'index'),
(427, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:21:44', '127.0.0.1', 'index'),
(428, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:36:45', '127.0.0.1', 'index'),
(429, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:37:02', '127.0.0.1', 'index'),
(430, 'http://localhost:63342/intervolgaWeb/pages/unauth.html?_ijt=m0th1ce92br75bmi5c2gb9ecis', '2020-12-23 15:37:52', '127.0.0.1', 'login'),
(431, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 15:37:58', '127.0.0.1', 'signup'),
(432, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 15:37:59', '127.0.0.1', 'index'),
(433, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 15:40:46', '127.0.0.1', 'index'),
(434, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:41:08', '127.0.0.1', 'index'),
(435, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:41:22', '127.0.0.1', 'index'),
(436, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:44:02', '127.0.0.1', 'index'),
(437, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:44:12', '127.0.0.1', 'index'),
(438, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:44:27', '127.0.0.1', 'index'),
(439, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:44:36', '127.0.0.1', 'index'),
(440, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:44:53', '127.0.0.1', 'index'),
(441, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:45:05', '127.0.0.1', 'index'),
(442, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 15:46:48', '127.0.0.1', 'edit_cities'),
(443, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 15:46:50', '127.0.0.1', 'edit_cities'),
(444, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 15:46:54', '127.0.0.1', 'edit_cities'),
(445, 'http://localhost:63342/intervolgaWeb/pages/edit_cities.php', '2020-12-23 15:46:55', '127.0.0.1', 'index'),
(446, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:49:32', '127.0.0.1', 'index'),
(447, 'http://localhost:63342/intervolgaWeb/pages/statistics.php', '2020-12-23 15:54:56', '127.0.0.1', 'index'),
(448, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 15:54:58', '127.0.0.1', 'edit_events'),
(449, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 15:56:17', '127.0.0.1', 'edit_events'),
(450, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 15:56:24', '127.0.0.1', 'index'),
(451, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 15:59:15', '127.0.0.1', 'index'),
(452, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 16:06:11', '127.0.0.1', 'index'),
(453, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:06:12', '127.0.0.1', 'edit_cities'),
(454, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:06:27', '127.0.0.1', 'edit_cities'),
(455, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:09:49', '127.0.0.1', 'edit_cities'),
(456, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:10:04', '127.0.0.1', 'edit_cities'),
(457, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:10:06', '127.0.0.1', 'edit_cities'),
(458, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:10:13', '127.0.0.1', 'edit_cities'),
(459, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:11:51', '127.0.0.1', 'edit_cities'),
(460, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:39:05', '127.0.0.1', 'index'),
(461, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:39:06', '127.0.0.1', 'edit_cities');
INSERT INTO `redirects` (`id`, `redirect_source`, `request_time`, `ip_addr`, `redirect_target`) VALUES
(462, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:40:24', '127.0.0.1', 'edit_cities'),
(463, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:40:33', '127.0.0.1', 'edit_cities'),
(464, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:40:51', '127.0.0.1', 'edit_cities'),
(465, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:43:05', '127.0.0.1', 'edit_cities'),
(466, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:44:35', '127.0.0.1', 'edit_cities'),
(467, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:45:19', '127.0.0.1', 'edit_cities'),
(468, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:45:52', '127.0.0.1', 'edit_members'),
(469, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:46:03', '127.0.0.1', 'edit_members'),
(470, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:46:08', '127.0.0.1', 'edit_members'),
(471, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:46:21', '127.0.0.1', 'edit_members'),
(472, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:46:39', '127.0.0.1', 'edit_members'),
(473, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:46:44', '127.0.0.1', 'edit_members'),
(474, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:46:48', '127.0.0.1', 'edit_members'),
(475, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:46:51', '127.0.0.1', 'edit_members'),
(476, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:46:53', '127.0.0.1', 'edit_members'),
(477, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:47:09', '127.0.0.1', 'edit_members'),
(478, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:47:12', '127.0.0.1', 'edit_members'),
(479, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:47:27', '127.0.0.1', 'edit_members'),
(480, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:47:31', '127.0.0.1', 'edit_members'),
(481, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:47:32', '127.0.0.1', 'edit_cities'),
(482, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:47:46', '127.0.0.1', 'edit_cities'),
(483, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:47:49', '127.0.0.1', 'edit_cities'),
(484, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:48:02', '127.0.0.1', 'edit_cities'),
(485, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:48:41', '127.0.0.1', 'index'),
(486, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:48:42', '127.0.0.1', 'edit_cities'),
(487, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:48:46', '127.0.0.1', 'edit_members'),
(488, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 16:48:49', '127.0.0.1', 'index'),
(489, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:48:59', '127.0.0.1', 'edit_cities'),
(490, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:50:04', '127.0.0.1', 'edit_cities'),
(491, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 16:50:14', '127.0.0.1', 'index'),
(492, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 16:52:09', '127.0.0.1', 'edit_members'),
(493, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 17:01:14', '127.0.0.1', 'edit_members'),
(494, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 17:01:36', '127.0.0.1', 'index'),
(495, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 17:01:45', '127.0.0.1', 'edit_attendance'),
(496, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-23 17:02:08', '127.0.0.1', 'edit_attendance'),
(497, 'http://localhost:63342/intervolgaWeb/pages/edit_attendance.php', '2020-12-23 17:02:25', '127.0.0.1', 'index'),
(498, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 17:02:29', '127.0.0.1', 'edit_events'),
(499, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 17:03:26', '127.0.0.1', 'edit_events'),
(500, 'http://localhost:63342/intervolgaWeb/pages/edit_events.php', '2020-12-23 17:03:42', '127.0.0.1', 'index'),
(501, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 17:14:39', '127.0.0.1', 'edit_members'),
(502, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 17:15:08', '127.0.0.1', 'edit_members'),
(503, 'http://localhost:63342/intervolgaWeb/pages/edit_members.php', '2020-12-23 17:37:15', '127.0.0.1', 'index'),
(504, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 17:37:17', '127.0.0.1', 'edit_cities'),
(505, 'http://localhost:63342/intervolgaWeb/pages/search.php', '2020-12-23 17:37:49', '127.0.0.1', 'edit_members'),
(506, 'http://localhost:63342/intervolgaWeb/pages/index.php', '2020-12-23 17:38:09', '127.0.0.1', 'edit_cities'),
(507, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 17:38:27', '127.0.0.1', 'signup'),
(508, 'http://localhost:63342/intervolgaWeb/pages/signup.php', '2020-12-23 17:42:54', '127.0.0.1', 'signup'),
(509, 'http://localhost:63342/intervolgaWeb/pages/unauth.html', '2020-12-23 17:46:14', '127.0.0.1', 'login'),
(510, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 17:46:22', '127.0.0.1', 'signup'),
(511, 'http://localhost:63342/intervolgaWeb/pages/login.php?', '2020-12-23 17:46:22', '127.0.0.1', 'index');

-- --------------------------------------------------------

--
-- Table structure for table `unique_visits`
--

CREATE TABLE `unique_visits` (
  `id` int(11) NOT NULL,
  `ip_addr` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `unique_visits`
--

INSERT INTO `unique_visits` (`id`, `ip_addr`) VALUES
(1, '127.0.0.1');

-- --------------------------------------------------------

--
-- Table structure for table `visit_count`
--

CREATE TABLE `visit_count` (
  `id` int(11) NOT NULL,
  `signup_visits` int(11) NOT NULL,
  `login_visits` int(11) NOT NULL,
  `index_visits` int(11) NOT NULL,
  `edit_members_visits` int(11) NOT NULL,
  `edit_cities_visits` int(11) NOT NULL,
  `edit_events_visits` int(11) NOT NULL,
  `edit_attendance_visits` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `visit_count`
--

INSERT INTO `visit_count` (`id`, `signup_visits`, `login_visits`, `index_visits`, `edit_members_visits`, `edit_cities_visits`, `edit_events_visits`, `edit_attendance_visits`) VALUES
(1, 46, 60, 176, 76, 47, 79, 47);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `city_name` (`city_name`);

--
-- Indexes for table `city_owners`
--
ALTER TABLE `city_owners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_name_fk` (`city_name`),
  ADD KEY `party_to_city_fk` (`party_name`);

--
-- Indexes for table `credentials`
--
ALTER TABLE `credentials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_party_name` (`party_name`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_to_party_name_fk` (`party_name`),
  ADD KEY `event_name` (`event_name`),
  ADD KEY `event_to_city_fk` (`city_name`);

--
-- Indexes for table `event_attendees`
--
ALTER TABLE `event_attendees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendee_to_event_fk` (`event_name`),
  ADD KEY `attendee_to_party_name_fk` (`party_name`),
  ADD KEY `attendee_to_member_name_fk` (`member_name`) USING BTREE;

--
-- Indexes for table `party_members`
--
ALTER TABLE `party_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `party_name_fk` (`party_name`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `redirects`
--
ALTER TABLE `redirects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unique_visits`
--
ALTER TABLE `unique_visits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ip_addr` (`ip_addr`) USING HASH;

--
-- Indexes for table `visit_count`
--
ALTER TABLE `visit_count`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `city_owners`
--
ALTER TABLE `city_owners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `credentials`
--
ALTER TABLE `credentials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `event_attendees`
--
ALTER TABLE `event_attendees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `party_members`
--
ALTER TABLE `party_members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `redirects`
--
ALTER TABLE `redirects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=512;

--
-- AUTO_INCREMENT for table `unique_visits`
--
ALTER TABLE `unique_visits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `visit_count`
--
ALTER TABLE `visit_count`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `city_owners`
--
ALTER TABLE `city_owners`
  ADD CONSTRAINT `city_name_fk` FOREIGN KEY (`city_name`) REFERENCES `cities` (`city_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `party_to_city_fk` FOREIGN KEY (`party_name`) REFERENCES `credentials` (`party_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `event_to_city_fk` FOREIGN KEY (`city_name`) REFERENCES `city_owners` (`city_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `event_to_party_name_fk` FOREIGN KEY (`party_name`) REFERENCES `credentials` (`party_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `event_attendees`
--
ALTER TABLE `event_attendees`
  ADD CONSTRAINT `attendee_to_event_fk` FOREIGN KEY (`event_name`) REFERENCES `events` (`event_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attendee_to_member_name_fk` FOREIGN KEY (`member_name`) REFERENCES `party_members` (`name`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `attendee_to_party_name_fk` FOREIGN KEY (`party_name`) REFERENCES `credentials` (`party_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `party_members`
--
ALTER TABLE `party_members`
  ADD CONSTRAINT `party_name_fk` FOREIGN KEY (`party_name`) REFERENCES `credentials` (`party_name`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
