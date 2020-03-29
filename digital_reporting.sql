-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 29, 2020 at 11:39 AM
-- Server version: 5.7.24
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `digital_reporting`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(7, '2020_03_28_183124_create_reports_table', 2),
(8, '2020_03_28_183347_create_report_tasks_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE IF NOT EXISTS `reports` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `current_week` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `next_week` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `next_week_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_user_id_foreign` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `user_id`, `current_week`, `next_week`, `next_week_date`, `created_at`, `updated_at`) VALUES
(2, 2, 'At the heart of Stockopedia are over 2300 Stock Reports covering every company listed on the London Stock Exchange Main Market, AIM and PLUS markets. These pages have been designed from the ground up to give the modern investor the essential information he needs to make his decisions.', 'A lot of thought has gone into the make up of the Stock Reports, and the reasoning is explained here.\r\n\r\nOur stock reports focus on metrics that independent research has shown to have a quantifiable impact on future stock returns.', '2020-04-04', '2020-03-28 19:22:13', '2020-03-28 19:22:13'),
(3, 3, 'very company on Stockopedia is graded for its Quality, Value and Momentum - the primary driving forces behind future stock returns. Much of our research goes into compiling a bespoke library of ratios and metrics that actually pay off in the stock market and it finds its fruition in this proprietary set of rankings.', 'At the heart of Stockopedia are over 2300 Stock Reports covering every company listed on the London Stock Exchange Main Market, AIM and PLUS markets. These pages have been designed from the ground up to give the modern investor the essential information he needs to make his decisions.\n\nMany investment publications swamp investors with pages of information without any regard to presentation. There is so much information that can be published that many publishers do not know when to say enough! Our principle has been to keep things simple but effective, using only the most powerful ratios and indicators in a standardised way so that all stocks can be compared like for like. A lot of thought has gone into the make up of the Stock Reports, and the reasoning is explained here.\n\nOur stock reports focus on metrics that independent research has shown to have a quantifiable impact on future stock returns, while ignoring metrics that don\'t. We have provided references for further reading below. Feel free to give us any feedback on the reports.\n\nYou can watch a video introduction to the Stock Reports here.\nStockRanks™\n\nEvery company on Stockopedia is graded for its Quality, Value and Momentum - the primary driving forces behind future stock returns. Much of our research goes into compiling a bespoke library of ratios and metrics that actually pay off in the stock market and it finds its fruition in this proprietary set of rankings.\n\nEvery stock is ranked from zero (worst) to 100 (best) across each of these composite ranks. They are then combined into an overall Stockopedia StockRank™ that has performed extremely well in backtests, especially amongst smaller and mid-cap stocks. You can read up in detail about the StockRanks here.', '2020-04-04', '2020-03-28 20:29:29', '2020-03-28 20:29:29'),
(5, 5, 'One of the first things you will notice about a Stockopedia Stock Report is that it is highly visual in nature; using color, charts and graphical indicators to highlight the important and changing variables for stock pickers. A key component of the page is the extensive use of what we call the TrafficLights™ which come in two formats, horizontal meters and spots.', 'The spots are individually calibrated to colour from green to red for the indicator in question depending on whether the indicator is favourable or not for the stock.', '2020-04-04', '2020-03-28 20:31:52', '2020-03-28 20:31:52'),
(6, 6, 'aaaaa', 'aaaaa', '2020-04-04', '2020-03-28 21:46:19', '2020-03-28 21:46:19');

--
-- Triggers `reports`
--
DROP TRIGGER IF EXISTS `new_report`;
DELIMITER $$
CREATE TRIGGER `new_report` AFTER INSERT ON `reports` FOR EACH ROW BEGIN
            UPDATE users SET report_count = report_count + 1 WHERE id = NEW.user_id;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `report_tasks`
--

DROP TABLE IF EXISTS `report_tasks`;
CREATE TABLE IF NOT EXISTS `report_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_id` bigint(20) UNSIGNED NOT NULL,
  `task` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_tasks_report_id_foreign` (`report_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `report_tasks`
--

INSERT INTO `report_tasks` (`id`, `report_id`, `task`, `created_at`, `updated_at`) VALUES
(1, 2, 'aaa', '2020-03-28 19:22:13', '2020-03-28 19:22:13'),
(2, 2, 'bbb', '2020-03-28 19:22:13', '2020-03-28 19:22:13'),
(3, 2, 'ccc', '2020-03-28 19:22:13', '2020-03-28 19:22:13'),
(4, 3, 'set of rankings.', '2020-03-28 20:29:30', '2020-03-28 20:29:30'),
(5, 3, 'this proprietary', '2020-03-28 20:29:30', '2020-03-28 20:29:30'),
(6, 3, 'finds its fruition', '2020-03-28 20:29:30', '2020-03-28 20:29:30'),
(8, 5, 'horizontal meters', '2020-03-28 20:31:52', '2020-03-28 20:31:52'),
(9, 5, 'each ratio (e.g. PE Ratio)', '2020-03-28 20:31:52', '2020-03-28 20:31:52'),
(10, 5, 'an investor can judge', '2020-03-28 20:31:52', '2020-03-28 20:31:52'),
(11, 5, 'growth and momentum', '2020-03-28 20:31:52', '2020-03-28 20:31:52'),
(12, 6, 'aaa', '2020-03-28 21:46:19', '2020-03-28 21:46:19'),
(13, 6, 'www', '2020-03-28 21:46:19', '2020-03-28 21:46:19');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` char(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` char(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `report_count` int(11) NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `email_verified_at`, `password`, `name`, `last_name`, `is_admin`, `report_count`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin@infusion.com', NULL, '$2y$10$Ye2576/kpDlPMhQ8Nn/6MOXz0AmKiEtFQuZVofzBaogxNJad6mayy', 'admin', 'aa', 1, 0, NULL, '2020-03-28 19:28:20', '2020-03-28 19:28:20'),
(2, 'sam@gmail.com', NULL, '$2y$10$aKWfltWUj.ZmeJmq3Lm.KuiPwXDpg74j2.F3I.fBc1PpSe2fS3Lkq', 'sam', 'samian', 0, 1, NULL, '2020-03-28 15:55:18', '2020-03-28 15:55:18'),
(3, 'aa@aa.com', NULL, '$2y$10$2j.O0ViOKPblXgrSnatcw.B5k2gAHJdkX6hEHv9M91A8mS27/PUJO', 'aa', 'aa', 0, 1, NULL, '2020-03-28 17:19:12', '2020-03-28 17:19:12'),
(5, 'user@user.com', NULL, '$2y$10$0yW1gxOn1h9L9JJkvNrhG.PClVzLA9ywpxhY4bP6lL4.spReQT9ji', 'user 1', 'last_name 1', 0, 1, NULL, '2020-03-28 20:30:24', '2020-03-28 20:30:24'),
(6, 'ww@ww.com', NULL, '$2y$10$mrlhiDCKw9LDOud.dC.gY.U.lZrJtd6OgwRg2vFNtcJBNciDAVBca', 'ww', 'www', 0, 1, NULL, '2020-03-28 21:46:02', '2020-03-28 21:46:02');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `report_tasks`
--
ALTER TABLE `report_tasks`
  ADD CONSTRAINT `report_tasks_report_id_foreign` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
