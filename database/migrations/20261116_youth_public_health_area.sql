INSERT INTO `youth_survey_areas` (`code`, `subdistrict`, `district`, `province`)
SELECT 'public_health', 'คณะสาธารณสุขศาสตร์', '', ''
WHERE NOT EXISTS (SELECT 1 FROM `youth_survey_areas` WHERE `code` = 'public_health');
