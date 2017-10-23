-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 23, 2017 at 11:05 AM
-- Server version: 10.1.10-MariaDB
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `amsosv2`
--

-- --------------------------------------------------------

--
-- Table structure for table `postings`
--

CREATE TABLE `postings` (
  `id` int(10) UNSIGNED NOT NULL,
  `uid` int(10) DEFAULT NULL,
  `msg` text,
  `postdate` datetime DEFAULT NULL,
  `ipaddr` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `postings`
--

INSERT INTO `postings` (`id`, `uid`, `msg`, `postdate`, `ipaddr`) VALUES
(16, 1, 'coba posting yes #1', '2017-10-21 12:22:25', '127.0.0.1'),
(2, 2, 'hello world yes..', '2017-10-18 18:41:21', '127.0.0.1'),
(9, 1, 'test ok #update #1', '2017-10-19 22:32:29', '127.0.0.1'),
(11, 2, 'test sabtu pagi..', '2017-10-21 06:06:38', '::1');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `uid` int(10) UNSIGNED NOT NULL,
  `nid` varchar(20) DEFAULT NULL,
  `pass` varchar(50) DEFAULT NULL,
  `fullname` varchar(200) DEFAULT NULL,
  `version` int(10) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `logdate` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `nid`, `pass`, `fullname`, `version`, `status`, `logdate`) VALUES
(1, '190302150', '18cbba939d6435da4eb90cc8ff833793', 'Arif Laksito', 0, 2, NULL),
(2, '190302215', '18cbba939d6435da4eb90cc8ff833793', 'Rizqi Sukma', 0, 2, NULL),
(3, '15.21.0883', '18cbba939d6435da4eb90cc8ff833793', 'Akrilvalerat Deainert Wierfi', 0, 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `version`
--

CREATE TABLE `version` (
  `ver` int(10) UNSIGNED NOT NULL,
  `id` int(10) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `changedate` datetime DEFAULT NULL,
  `ipaddr` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `version`
--

INSERT INTO `version` (`ver`, `id`, `type`, `changedate`, `ipaddr`) VALUES
(1, 1, 'add', '2017-10-18 16:39:21', '127.0.0.1'),
(2, 2, 'add', '2017-10-18 18:41:52', '127.0.0.1'),
(3, 8, 'add', '2017-10-18 21:13:26', '::1'),
(5, 8, 'delete', '2017-10-18 21:56:50', '::1'),
(6, 2, 'update', '2017-10-18 22:30:40', '::1'),
(7, 2, 'update', '2017-10-18 22:39:28', '::1'),
(8, 9, 'add', '2017-10-19 22:33:10', '127.0.0.1'),
(9, 10, 'add', '2017-10-20 15:54:33', '::1'),
(10, 11, 'add', '2017-10-21 06:06:38', '::1'),
(11, 12, 'add', '2017-10-21 06:08:12', '127.0.0.1'),
(12, 13, 'add', '2017-10-21 10:10:10', '127.0.0.1'),
(13, 12, 'delete', '2017-10-21 10:11:40', '::1'),
(14, 14, 'add', '2017-10-21 10:30:28', '127.0.0.1'),
(15, 13, 'delete', '2017-10-21 10:31:21', '::1'),
(16, 14, 'delete', '2017-10-21 10:31:24', '::1'),
(17, 9, 'update', '2017-10-21 11:16:19', '127.0.0.1'),
(18, 9, 'update', '2017-10-21 11:20:03', '::1'),
(19, 1, 'update', '2017-10-21 11:21:35', '127.0.0.1'),
(20, 1, 'update', '2017-10-21 11:27:18', '127.0.0.1'),
(21, 15, 'add', '2017-10-21 12:17:14', '127.0.0.1'),
(22, 10, 'delete', '2017-10-21 12:17:31', '127.0.0.1'),
(23, 15, 'update', '2017-10-21 12:17:57', '127.0.0.1'),
(24, 1, 'delete', '2017-10-21 12:20:22', '127.0.0.1'),
(25, 16, 'add', '2017-10-21 12:22:25', '127.0.0.1'),
(26, 15, 'delete', '2017-10-21 12:22:40', '127.0.0.1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `postings`
--
ALTER TABLE `postings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `nid_unique` (`nid`);

--
-- Indexes for table `version`
--
ALTER TABLE `version`
  ADD PRIMARY KEY (`ver`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `postings`
--
ALTER TABLE `postings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `uid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `version`
--
ALTER TABLE `version`
  MODIFY `ver` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
