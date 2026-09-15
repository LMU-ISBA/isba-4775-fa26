-- Your resume, as data. This file is the source of truth for the site.
-- The application builds resume.db from this file when that file is missing.
-- Update your resume by editing this file, committing, and pushing.
-- The entries below are placeholders. Replace them with your own.
-- This repository is public. Keep your phone number and street address out.

CREATE TABLE IF NOT EXISTS resume_entries (
    id INTEGER PRIMARY KEY,
    section TEXT NOT NULL,
    title TEXT NOT NULL,
    organization TEXT,
    dates TEXT,
    description TEXT
);

-- INSERT OR IGNORE skips an id that already exists, so rerunning this file
-- never duplicates or replaces a row you have edited in the database.

INSERT OR IGNORE INTO resume_entries (id, section, title, organization, dates, description) VALUES
(1, 'experience', 'Sales Associate', 'Example Retail Co.', '2024 - present',
    'Placeholder. Replace with a real role and one line about what you did.'),
(2, 'experience', 'Summer Intern', 'Example Nonprofit', 'Summer 2023',
    'Placeholder. Replace with a real role and one line about what you did.'),
(3, 'education', 'B.S. Information Systems and Business Analytics', 'Loyola Marymount University', 'Expected 2027',
    'Placeholder. Adjust the degree, major, and year.'),
(4, 'projects', 'Home network diagram', 'ISBA 4775', 'September 2026',
    'Found the gateway, DHCP, and DNS addresses on my home network and drew it by hand.'),
(5, 'projects', 'Web server and database troubleshooting', 'ISBA 4775', 'September 2026',
    'Investigated stopped Nginx and MySQL services with process and port checks, then verified recovery.'),
(6, 'skills', 'Python', NULL, NULL, NULL),
(7, 'skills', 'SQL', NULL, NULL, NULL),
(8, 'skills', 'Linux command line', NULL, NULL, NULL);

SELECT section, COUNT(*) AS entries FROM resume_entries GROUP BY section ORDER BY section;
