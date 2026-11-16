ALTER TABLE `youth_survey_responses`
  ADD COLUMN `respondent_key` char(64) DEFAULT NULL AFTER `area_code`,
  ADD KEY `idx_youth_response_latest` (`respondent_key`, `area_code`, `created_at`);
