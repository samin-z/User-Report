-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 29, 2020 at 06:52 PM
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(9, '2020_03_29_114525_create_reports_table', 2),
(10, '2020_03_29_114650_create_report_tasks_table', 2);

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
(3, 7, 'Many investment publications swamp investors with pages of information without any regard to presentation. There is so much information that can be published that many publishers do not know when to say enough! Our principle has been to keep things simple but effective, using only the most powerful ratios and indicators in a standardised way so that all stocks can be compared like for like. A lot of thought has gone into the make up of the Stock Reports, and the reasoning is explained here.', 'Our stock reports focus on metrics that independent research has shown to have a quantifiable impact on future stock returns, while ignoring metrics that don\'t. We have provided references for further reading below. Feel free to give us any feedback on the reports.', '2020-04-05', '2020-03-06 14:05:31', '2020-03-29 13:05:31'),
(4, 1, 'Every company on Stockopedia is graded for its Quality, Value and Momentum - the primary driving forces behind future stock returns. Much of our research goes into compiling a bespoke library of ratios and metrics that actually pay off in the stock market and it finds its fruition in this proprietary set of rankings.', 'Every stock is ranked from zero (worst) to 100 (best) across each of these composite ranks. They are then combined into an overall Stockopedia StockRank™ that has performed extremely well in backtests, especially amongst smaller and mid-cap stocks. You can read up in detail about the StockRanks here.', '2020-04-05', '2020-03-19 15:28:40', '2020-03-29 14:28:40'),
(5, 1, 'One of the first things you will notice about a Stockopedia Stock Report is that it is highly visual in nature; using color, charts and graphical indicators to highlight the important and changing variables for stock pickers. A key component of the page is the extensive use of what we call the TrafficLights™ which come in two formats, horizontal meters and spots.', 'The spots are individually calibrated to colour from green to red for the indicator in question depending on whether the indicator is favourable or not for the stock.', '2020-04-05', '2020-03-03 15:29:26', '2020-03-29 14:29:26'),
(6, 7, 'Most websites show the market capitalisation as a proxy for the size of a company with a complete disregard to how much money the company has borrowed. We publish the Enterprise Value of each firm, adding the company\'s net debt to its market cap to provide a more accurate picture of a company\'s size. At a glance you can tell if a company...', 'Has net cash (an EV less than its Mkt Cap),\n    Is highly levered (EV far greater than Mkt Cap),\n    Or is being sold for less than the cash in their accounts (a negative EV)\n\nAnother indicator of the size of a company is the Mkt Cap Rank which shows how large it is compared to the rest of the Market.', '2020-04-05', '2020-03-28 15:30:00', '2020-03-29 14:30:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `report_tasks`
--

INSERT INTO `report_tasks` (`id`, `report_id`, `task`, `created_at`, `updated_at`) VALUES
(2, 3, 'task A', '2020-03-29 13:05:31', '2020-03-29 13:05:31'),
(3, 3, 'task B', '2020-03-29 13:05:31', '2020-03-29 13:05:31'),
(4, 3, 'task C', '2020-03-29 13:05:31', '2020-03-29 13:05:31'),
(5, 4, 'Task F', '2020-03-29 14:28:40', '2020-03-29 14:28:40'),
(6, 4, 'Task RT', '2020-03-29 14:28:40', '2020-03-29 14:28:40'),
(7, 5, 'Task BB', '2020-03-29 14:29:26', '2020-03-29 14:29:26'),
(8, 6, 'Task OP', '2020-03-29 14:30:00', '2020-03-29 14:30:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `email_verified_at`, `password`, `name`, `last_name`, `is_admin`, `report_count`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin@infusion.com', NULL, '$2y$10$Ye2576/kpDlPMhQ8Nn/6MOXz0AmKiEtFQuZVofzBaogxNJad6mayy', 'admin', 'aa', 1, 2, NULL, '2020-03-28 19:28:20', '2020-03-28 19:28:20'),
(5, 'user@user.com', NULL, '$2y$10$0yW1gxOn1h9L9JJkvNrhG.PClVzLA9ywpxhY4bP6lL4.spReQT9ji', 'user 1', 'last_name 1', 0, 0, NULL, '2020-03-28 20:30:24', '2020-03-28 20:30:24'),
(7, 'john@smith.com', NULL, '$2y$10$WzHtQqVhtBHS/PU7khSlS.YmWYnIOGVvpSQIyXd4BjHYOcEsw1BcW', 'john', 'smith', 0, 9, NULL, '2020-03-29 12:50:59', '2020-03-29 12:50:59');

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
