-- Recreate the resume database for the portfolio site. This file contains no credentials.
-- Existing rows, including your own edits and additional IDs, are preserved.
-- The entries below are placeholders. Replace them with your own resume.
CREATE DATABASE IF NOT EXISTS portfolio;

CREATE TABLE IF NOT EXISTS portfolio.resume_entries (
    id INT PRIMARY KEY,
    section VARCHAR(20) NOT NULL,
    title VARCHAR(100) NOT NULL,
    organization VARCHAR(100),
    dates VARCHAR(40),
    description VARCHAR(255)
);

INSERT INTO portfolio.resume_entries (id, section, title, organization, dates, description)
SELECT 1, 'experience', 'Sales Associate', 'Example Retail Co.', '2024 - present',
       'Placeholder. Replace with a real role and one line about what you did.'
WHERE NOT EXISTS (SELECT 1 FROM portfolio.resume_entries WHERE id = 1);
INSERT INTO portfolio.resume_entries (id, section, title, organization, dates, description)
SELECT 2, 'experience', 'Summer Intern', 'Example Nonprofit', 'Summer 2023',
       'Placeholder. Replace with a real role and one line about what you did.'
WHERE NOT EXISTS (SELECT 1 FROM portfolio.resume_entries WHERE id = 2);
INSERT INTO portfolio.resume_entries (id, section, title, organization, dates, description)
SELECT 3, 'education', 'B.S. Information Systems and Business Analytics', 'Loyola Marymount University', 'Expected 2027',
       'Placeholder. Adjust the degree, major, and year.'
WHERE NOT EXISTS (SELECT 1 FROM portfolio.resume_entries WHERE id = 3);
INSERT INTO portfolio.resume_entries (id, section, title, organization, dates, description)
SELECT 4, 'projects', 'Home network diagram', 'ISBA 4775', 'September 2026',
       'Found the gateway, DHCP, and DNS addresses on my home network and drew it by hand.'
WHERE NOT EXISTS (SELECT 1 FROM portfolio.resume_entries WHERE id = 4);
INSERT INTO portfolio.resume_entries (id, section, title, organization, dates, description)
SELECT 5, 'projects', 'Web server and database troubleshooting', 'ISBA 4775', 'September 2026',
       'Investigated stopped Nginx and MySQL services with process and port checks, then verified recovery.'
WHERE NOT EXISTS (SELECT 1 FROM portfolio.resume_entries WHERE id = 5);
INSERT INTO portfolio.resume_entries (id, section, title, organization, dates, description)
SELECT 6, 'skills', 'Python', NULL, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM portfolio.resume_entries WHERE id = 6);
INSERT INTO portfolio.resume_entries (id, section, title, organization, dates, description)
SELECT 7, 'skills', 'MySQL', NULL, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM portfolio.resume_entries WHERE id = 7);
INSERT INTO portfolio.resume_entries (id, section, title, organization, dates, description)
SELECT 8, 'skills', 'Linux command line', NULL, NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM portfolio.resume_entries WHERE id = 8);

SELECT section, COUNT(*) AS entries FROM portfolio.resume_entries GROUP BY section ORDER BY section;
