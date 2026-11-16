CREATE TABLE IF NOT EXISTS `youth_survey_areas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL,
  `subdistrict` varchar(128) NOT NULL,
  `district` varchar(128) NOT NULL,
  `province` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_youth_area_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `youth_survey_forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_id` int(11) NOT NULL,
  `version` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_youth_form_version` (`area_id`, `version`),
  CONSTRAINT `fk_youth_form_area` FOREIGN KEY (`area_id`) REFERENCES `youth_survey_areas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `youth_survey_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `section_number` smallint(5) unsigned NOT NULL,
  `title` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_youth_section_number` (`form_id`, `section_number`),
  CONSTRAINT `fk_youth_section_form` FOREIGN KEY (`form_id`) REFERENCES `youth_survey_forms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `youth_survey_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section_id` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `question_number` smallint(5) unsigned NOT NULL,
  `question_text` text NOT NULL,
  `answer_type` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_youth_question_code` (`section_id`, `code`),
  UNIQUE KEY `uq_youth_question_number` (`section_id`, `question_number`),
  CONSTRAINT `fk_youth_question_section` FOREIGN KEY (`section_id`) REFERENCES `youth_survey_sections` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `youth_survey_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `option_code` varchar(16) NOT NULL,
  `option_text` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_youth_option_code` (`question_id`, `option_code`),
  CONSTRAINT `fk_youth_option_question` FOREIGN KEY (`question_id`) REFERENCES `youth_survey_questions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `youth_survey_response_details` (
  `response_id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  PRIMARY KEY (`response_id`),
  KEY `idx_youth_detail_form` (`form_id`),
  CONSTRAINT `fk_youth_detail_response` FOREIGN KEY (`response_id`) REFERENCES `youth_survey_responses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_youth_detail_form` FOREIGN KEY (`form_id`) REFERENCES `youth_survey_forms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `youth_survey_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `response_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `status` varchar(24) NOT NULL,
  `text_value` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_youth_answer_question` (`response_id`, `question_id`),
  KEY `idx_youth_answer_question` (`question_id`),
  CONSTRAINT `fk_youth_answer_response` FOREIGN KEY (`response_id`) REFERENCES `youth_survey_responses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_youth_answer_question` FOREIGN KEY (`question_id`) REFERENCES `youth_survey_questions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `youth_survey_answer_choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_youth_answer_choice` (`answer_id`, `option_id`),
  KEY `idx_youth_choice_question` (`question_id`),
  KEY `idx_youth_choice_option` (`option_id`),
  CONSTRAINT `fk_youth_choice_answer` FOREIGN KEY (`answer_id`) REFERENCES `youth_survey_answers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_youth_choice_question` FOREIGN KEY (`question_id`) REFERENCES `youth_survey_questions` (`id`),
  CONSTRAINT `fk_youth_choice_option` FOREIGN KEY (`option_id`) REFERENCES `youth_survey_options` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `youth_survey_areas` (`code`, `subdistrict`, `district`, `province`) VALUES
  ('thung_saliam', 'ทุ่งเสลี่ยม', 'ทุ่งเสลี่ยม', 'สุโขทัย'),
  ('nam_phai', 'น้ำไผ่', 'น้ำปาด', 'อุตรดิตถ์'),
  ('legacy_unknown', 'ไม่ระบุในข้อมูลเดิม', 'ไม่ระบุ', 'ไม่ระบุ')
ON DUPLICATE KEY UPDATE `code` = VALUES(`code`);

CREATE OR REPLACE VIEW `youth_survey_answer_report` AS
SELECT
  r.id AS response_id,
  s.section_number,
  s.title AS section_title,
  q.code AS question_code,
  q.question_number,
  q.question_text,
  q.answer_type,
  a.status,
  a.text_value,
  o.option_code,
  o.option_text
FROM youth_survey_responses r
JOIN youth_survey_answers a ON a.response_id = r.id
JOIN youth_survey_questions q ON q.id = a.question_id
JOIN youth_survey_sections s ON s.id = q.section_id
LEFT JOIN youth_survey_answer_choices c ON c.answer_id = a.id
LEFT JOIN youth_survey_options o ON o.id = c.option_id;
