ALTER TABLE `youth_survey_responses`
  ADD COLUMN `area_code` varchar(32) DEFAULT NULL AFTER `answers`;
