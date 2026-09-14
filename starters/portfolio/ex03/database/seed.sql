-- Recreate the Session 4 sample database. This file contains no credentials.
-- Existing rows, including student edits and additional IDs, are preserved.
CREATE DATABASE IF NOT EXISTS session04;

CREATE TABLE IF NOT EXISTS session04.sales (
    id INT PRIMARY KEY,
    amount DECIMAL(10,2)
);

INSERT INTO session04.sales (id, amount)
SELECT 1, 120.00 WHERE NOT EXISTS (SELECT 1 FROM session04.sales WHERE id = 1);
INSERT INTO session04.sales (id, amount)
SELECT 2, 80.00 WHERE NOT EXISTS (SELECT 1 FROM session04.sales WHERE id = 2);
INSERT INTO session04.sales (id, amount)
SELECT 3, 150.00 WHERE NOT EXISTS (SELECT 1 FROM session04.sales WHERE id = 3);
INSERT INTO session04.sales (id, amount)
SELECT 4, 50.00 WHERE NOT EXISTS (SELECT 1 FROM session04.sales WHERE id = 4);
INSERT INTO session04.sales (id, amount)
SELECT 5, 100.00 WHERE NOT EXISTS (SELECT 1 FROM session04.sales WHERE id = 5);

SELECT COUNT(*) AS sale_count, SUM(amount) AS total FROM session04.sales;
