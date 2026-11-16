CREATE TABLE IF NOT EXISTS `youth_survey_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receipt_hash` char(64) NOT NULL,
  `submission_hash` char(64) NOT NULL,
  `schema_version` varchar(64) NOT NULL,
  `consent_version` varchar(64) NOT NULL,
  `guardian_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `answers` longtext NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `withdrawn` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_youth_response_receipt` (`receipt_hash`),
  UNIQUE KEY `uq_youth_response_submission` (`submission_hash`),
  KEY `idx_youth_response_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
