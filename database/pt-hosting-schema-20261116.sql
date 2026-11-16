-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 16, 2026 at 10:38 AM
-- Server version: 10.6.16-MariaDB-log
-- PHP Version: 8.3.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `iqstrcheal_iqstrc`
--

-- --------------------------------------------------------

--
-- Table structure for table `day`
--

CREATE TABLE `day` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `day` int(11) NOT NULL,
  `n` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `elearning`
--

CREATE TABLE `elearning` (
  `elearning_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `q1` varchar(64) NOT NULL,
  `q2` int(11) NOT NULL,
  `q3` int(11) NOT NULL,
  `q4` int(11) NOT NULL,
  `q5` int(11) NOT NULL,
  `q6` int(11) NOT NULL,
  `q7` int(11) NOT NULL,
  `q8` int(11) NOT NULL,
  `q9` int(11) NOT NULL,
  `q10` int(11) NOT NULL,
  `q11` int(11) NOT NULL,
  `q12` int(11) NOT NULL,
  `q13` int(11) NOT NULL,
  `q14` int(11) NOT NULL,
  `q15` int(11) NOT NULL,
  `q16` int(11) NOT NULL,
  `q17` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `faculty_id` int(11) NOT NULL,
  `university_id` int(11) NOT NULL,
  `faculty_name` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `game`
--

CREATE TABLE `game` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `q1` int(11) NOT NULL,
  `q2` int(11) NOT NULL,
  `q3` int(11) NOT NULL,
  `q4` int(11) NOT NULL,
  `q5` int(11) NOT NULL,
  `q6` int(11) NOT NULL,
  `q7` int(11) NOT NULL,
  `q8` int(11) NOT NULL,
  `q9` int(11) NOT NULL,
  `q10` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `howto`
--

CREATE TABLE `howto` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page`
--

CREATE TABLE `page` (
  `id` int(11) NOT NULL,
  `type` varchar(64) NOT NULL,
  `name` varchar(256) NOT NULL,
  `detail` longtext NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `picture`
--

CREATE TABLE `picture` (
  `id` int(11) NOT NULL,
  `type` varchar(64) NOT NULL,
  `name` varchar(128) NOT NULL,
  `detail` longtext NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `screening`
--

CREATE TABLE `screening` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `aws` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `q1` int(11) NOT NULL,
  `q2` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test_a`
--

CREATE TABLE `test_a` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `week` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `q1` int(11) NOT NULL,
  `q2` int(11) NOT NULL,
  `q3` int(11) NOT NULL,
  `q4` int(11) NOT NULL,
  `q5` int(11) NOT NULL,
  `q6` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test_b`
--

CREATE TABLE `test_b` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `week` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `q1` int(11) NOT NULL,
  `q2` int(11) NOT NULL,
  `q3` int(11) NOT NULL,
  `q4` int(11) NOT NULL,
  `q5` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test_e`
--

CREATE TABLE `test_e` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `week` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `q1` int(11) NOT NULL,
  `q2` int(11) NOT NULL,
  `q3` int(11) NOT NULL,
  `q4` int(11) NOT NULL,
  `q5` int(11) NOT NULL,
  `q6` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test_f`
--

CREATE TABLE `test_f` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `week` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `q1` int(11) NOT NULL,
  `q2` int(11) NOT NULL,
  `q3` int(11) NOT NULL,
  `q4` int(11) NOT NULL,
  `q5` int(11) NOT NULL,
  `q6` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `toppic`
--

CREATE TABLE `toppic` (
  `toppic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `toppic_header` varchar(512) NOT NULL,
  `toppic_detail` longtext NOT NULL,
  `toppic_date` date NOT NULL,
  `toppic_view` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `university`
--

CREATE TABLE `university` (
  `university_id` int(11) NOT NULL,
  `university_name` varchar(256) NOT NULL,
  `university_phone` varchar(16) NOT NULL,
  `university_email` varchar(128) NOT NULL,
  `university_detail` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `university_b`
--

CREATE TABLE `university_b` (
  `university_id` int(11) NOT NULL,
  `university_name` varchar(256) NOT NULL,
  `university_detail` varchar(1024) NOT NULL,
  `university_phone` varchar(16) NOT NULL,
  `university_email` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `university_id` int(11) NOT NULL DEFAULT 0,
  `faculty_id` int(11) NOT NULL DEFAULT 0,
  `applicant_type` varchar(32) NOT NULL DEFAULT 'university',
  `applicant_level` varchar(32) NOT NULL DEFAULT '',
  `user_type` varchar(8) NOT NULL,
  `user_username` varchar(32) NOT NULL,
  `user_password` varchar(128) NOT NULL,
  `user_name` varchar(64) NOT NULL,
  `user_lastname` varchar(64) NOT NULL,
  `user_img` varchar(256) NOT NULL,
  `user_other_name` varchar(128) NOT NULL,
  `user_other_img` varchar(256) NOT NULL,
  `user_gender` varchar(8) NOT NULL,
  `user_birthday` date NOT NULL,
  `user_phone` varchar(12) NOT NULL,
  `pdpa1` int(11) NOT NULL DEFAULT 0,
  `pdpa2` int(11) NOT NULL DEFAULT 0,
  `pdpa3` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `view`
--

CREATE TABLE `view` (
  `id` int(11) NOT NULL,
  `type` varchar(8) NOT NULL,
  `user_id` int(11) NOT NULL,
  `fid` int(11) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `week`
--

CREATE TABLE `week` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nweek` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `youth_survey_answers`
--

CREATE TABLE `youth_survey_answers` (
  `id` int(10) UNSIGNED NOT NULL,
  `response_id` int(10) UNSIGNED NOT NULL,
  `question_id` int(10) UNSIGNED NOT NULL,
  `status` enum('answered','skipped','not_applicable') NOT NULL,
  `text_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `youth_survey_answer_choices`
--

CREATE TABLE `youth_survey_answer_choices` (
  `id` int(10) UNSIGNED NOT NULL,
  `answer_id` int(10) UNSIGNED NOT NULL,
  `question_id` int(10) UNSIGNED NOT NULL,
  `option_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `youth_survey_answer_report`
-- (See below for the actual view)
--
CREATE TABLE `youth_survey_answer_report` (
`response_id` int(10) unsigned
,`section_number` int(10) unsigned
,`section_title` varchar(500)
,`question_code` varchar(40)
,`question_number` int(10) unsigned
,`question_text` text
,`answer_type` varchar(16)
,`status` enum('answered','skipped','not_applicable')
,`text_value` text
,`option_code` varchar(32)
,`option_text` text
);

-- --------------------------------------------------------

--
-- Table structure for table `youth_survey_areas`
--

CREATE TABLE `youth_survey_areas` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(64) NOT NULL,
  `subdistrict` varchar(120) NOT NULL,
  `district` varchar(120) NOT NULL,
  `province` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `youth_survey_forms`
--

CREATE TABLE `youth_survey_forms` (
  `id` int(10) UNSIGNED NOT NULL,
  `area_id` int(10) UNSIGNED NOT NULL,
  `version` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `youth_survey_options`
--

CREATE TABLE `youth_survey_options` (
  `id` int(10) UNSIGNED NOT NULL,
  `question_id` int(10) UNSIGNED NOT NULL,
  `option_code` varchar(32) NOT NULL,
  `option_text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `youth_survey_questions`
--

CREATE TABLE `youth_survey_questions` (
  `id` int(10) UNSIGNED NOT NULL,
  `section_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(40) NOT NULL,
  `question_number` int(10) UNSIGNED NOT NULL,
  `question_text` text NOT NULL,
  `answer_type` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `youth_survey_responses`
--

CREATE TABLE `youth_survey_responses` (
  `id` int(10) UNSIGNED NOT NULL,
  `receipt_hash` char(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `submission_hash` char(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `schema_version` varchar(64) NOT NULL,
  `consent_version` varchar(64) NOT NULL,
  `guardian_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `answers` longtext NOT NULL,
  `area_code` varchar(64) DEFAULT NULL,
  `respondent_key` char(64) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `withdrawn` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `youth_survey_response_details`
--

CREATE TABLE `youth_survey_response_details` (
  `response_id` int(10) UNSIGNED NOT NULL,
  `form_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `youth_survey_sections`
--

CREATE TABLE `youth_survey_sections` (
  `id` int(10) UNSIGNED NOT NULL,
  `form_id` int(10) UNSIGNED NOT NULL,
  `section_number` int(10) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure for view `youth_survey_answer_report`
--
DROP TABLE IF EXISTS `youth_survey_answer_report`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `youth_survey_answer_report`  AS SELECT `a`.`response_id` AS `response_id`, `s`.`section_number` AS `section_number`, `s`.`title` AS `section_title`, `q`.`code` AS `question_code`, `q`.`question_number` AS `question_number`, `q`.`question_text` AS `question_text`, `q`.`answer_type` AS `answer_type`, `a`.`status` AS `status`, `a`.`text_value` AS `text_value`, `o`.`option_code` AS `option_code`, `o`.`option_text` AS `option_text` FROM ((((`youth_survey_answers` `a` join `youth_survey_questions` `q` on(`q`.`id` = `a`.`question_id`)) join `youth_survey_sections` `s` on(`s`.`id` = `q`.`section_id`)) left join `youth_survey_answer_choices` `c` on(`c`.`answer_id` = `a`.`id`)) left join `youth_survey_options` `o` on(`o`.`id` = `c`.`option_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `day`
--
ALTER TABLE `day`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `elearning`
--
ALTER TABLE `elearning`
  ADD PRIMARY KEY (`elearning_id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`faculty_id`);

--
-- Indexes for table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `howto`
--
ALTER TABLE `howto`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page`
--
ALTER TABLE `page`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `picture`
--
ALTER TABLE `picture`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `screening`
--
ALTER TABLE `screening`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test_a`
--
ALTER TABLE `test_a`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test_b`
--
ALTER TABLE `test_b`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test_e`
--
ALTER TABLE `test_e`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test_f`
--
ALTER TABLE `test_f`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `toppic`
--
ALTER TABLE `toppic`
  ADD PRIMARY KEY (`toppic_id`);

--
-- Indexes for table `university`
--
ALTER TABLE `university`
  ADD PRIMARY KEY (`university_id`);

--
-- Indexes for table `university_b`
--
ALTER TABLE `university_b`
  ADD PRIMARY KEY (`university_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_type` (`user_type`),
  ADD KEY `user_username` (`user_username`);

--
-- Indexes for table `view`
--
ALTER TABLE `view`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `week`
--
ALTER TABLE `week`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `youth_survey_answers`
--
ALTER TABLE `youth_survey_answers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ys_response_question` (`response_id`,`question_id`),
  ADD KEY `idx_ys_answer_question` (`question_id`);

--
-- Indexes for table `youth_survey_answer_choices`
--
ALTER TABLE `youth_survey_answer_choices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ys_answer_option` (`answer_id`,`option_id`),
  ADD KEY `idx_ys_choice_question` (`question_id`),
  ADD KEY `idx_ys_choice_option` (`option_id`);

--
-- Indexes for table `youth_survey_areas`
--
ALTER TABLE `youth_survey_areas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ys_area_code` (`code`);

--
-- Indexes for table `youth_survey_forms`
--
ALTER TABLE `youth_survey_forms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ys_form_version` (`area_id`,`version`);

--
-- Indexes for table `youth_survey_options`
--
ALTER TABLE `youth_survey_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ys_option_code` (`question_id`,`option_code`);

--
-- Indexes for table `youth_survey_questions`
--
ALTER TABLE `youth_survey_questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ys_question_code` (`section_id`,`code`);

--
-- Indexes for table `youth_survey_responses`
--
ALTER TABLE `youth_survey_responses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ys_receipt` (`receipt_hash`),
  ADD UNIQUE KEY `uq_ys_submission` (`submission_hash`),
  ADD KEY `idx_ys_area_created` (`area_code`,`created_at`),
  ADD KEY `idx_ys_respondent_latest` (`respondent_key`,`area_code`,`created_at`,`id`);

--
-- Indexes for table `youth_survey_response_details`
--
ALTER TABLE `youth_survey_response_details`
  ADD PRIMARY KEY (`response_id`),
  ADD KEY `idx_ys_response_form` (`form_id`);

--
-- Indexes for table `youth_survey_sections`
--
ALTER TABLE `youth_survey_sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ys_section_number` (`form_id`,`section_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `day`
--
ALTER TABLE `day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `elearning`
--
ALTER TABLE `elearning`
  MODIFY `elearning_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `faculty_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `game`
--
ALTER TABLE `game`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `howto`
--
ALTER TABLE `howto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `page`
--
ALTER TABLE `page`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `picture`
--
ALTER TABLE `picture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `screening`
--
ALTER TABLE `screening`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_a`
--
ALTER TABLE `test_a`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_b`
--
ALTER TABLE `test_b`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_e`
--
ALTER TABLE `test_e`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_f`
--
ALTER TABLE `test_f`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `toppic`
--
ALTER TABLE `toppic`
  MODIFY `toppic_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `university`
--
ALTER TABLE `university`
  MODIFY `university_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `university_b`
--
ALTER TABLE `university_b`
  MODIFY `university_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `view`
--
ALTER TABLE `view`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `week`
--
ALTER TABLE `week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `youth_survey_answers`
--
ALTER TABLE `youth_survey_answers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `youth_survey_answer_choices`
--
ALTER TABLE `youth_survey_answer_choices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `youth_survey_areas`
--
ALTER TABLE `youth_survey_areas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `youth_survey_forms`
--
ALTER TABLE `youth_survey_forms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `youth_survey_options`
--
ALTER TABLE `youth_survey_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `youth_survey_questions`
--
ALTER TABLE `youth_survey_questions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `youth_survey_responses`
--
ALTER TABLE `youth_survey_responses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `youth_survey_sections`
--
ALTER TABLE `youth_survey_sections`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `youth_survey_answers`
--
ALTER TABLE `youth_survey_answers`
  ADD CONSTRAINT `fk_ys_answer_question` FOREIGN KEY (`question_id`) REFERENCES `youth_survey_questions` (`id`),
  ADD CONSTRAINT `fk_ys_answer_response` FOREIGN KEY (`response_id`) REFERENCES `youth_survey_responses` (`id`);

--
-- Constraints for table `youth_survey_answer_choices`
--
ALTER TABLE `youth_survey_answer_choices`
  ADD CONSTRAINT `fk_ys_choice_answer` FOREIGN KEY (`answer_id`) REFERENCES `youth_survey_answers` (`id`),
  ADD CONSTRAINT `fk_ys_choice_option` FOREIGN KEY (`option_id`) REFERENCES `youth_survey_options` (`id`),
  ADD CONSTRAINT `fk_ys_choice_question` FOREIGN KEY (`question_id`) REFERENCES `youth_survey_questions` (`id`);

--
-- Constraints for table `youth_survey_forms`
--
ALTER TABLE `youth_survey_forms`
  ADD CONSTRAINT `fk_ys_form_area` FOREIGN KEY (`area_id`) REFERENCES `youth_survey_areas` (`id`);

--
-- Constraints for table `youth_survey_options`
--
ALTER TABLE `youth_survey_options`
  ADD CONSTRAINT `fk_ys_option_question` FOREIGN KEY (`question_id`) REFERENCES `youth_survey_questions` (`id`);

--
-- Constraints for table `youth_survey_questions`
--
ALTER TABLE `youth_survey_questions`
  ADD CONSTRAINT `fk_ys_question_section` FOREIGN KEY (`section_id`) REFERENCES `youth_survey_sections` (`id`);

--
-- Constraints for table `youth_survey_response_details`
--
ALTER TABLE `youth_survey_response_details`
  ADD CONSTRAINT `fk_ys_detail_form` FOREIGN KEY (`form_id`) REFERENCES `youth_survey_forms` (`id`),
  ADD CONSTRAINT `fk_ys_detail_response` FOREIGN KEY (`response_id`) REFERENCES `youth_survey_responses` (`id`);

--
-- Constraints for table `youth_survey_sections`
--
ALTER TABLE `youth_survey_sections`
  ADD CONSTRAINT `fk_ys_section_form` FOREIGN KEY (`form_id`) REFERENCES `youth_survey_forms` (`id`);
COMMIT;
