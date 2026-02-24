-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 02/06/2026
-- Copied from /OR/ Adapted from /OR/ Based on
-- Microsoft Copilot
-- Source URL: https://copilot.microsoft.com/
-- If AI tools were used:
-- Prompted to generate SQL from the provided template
-- to aggregate the certification title, first name, last
-- name, and homeworld name from the DB tables.

-- Leave the following query code untouched
DROP VIEW IF EXISTS v_cert_people;

-- ------- Write your code below this line -----------
CREATE VIEW v_cert_people AS
SELECT 
    c.title AS title,
    p.fname AS fname,
    p.lname AS lname,
    hw.name AS planet_name
FROM 
    bsg_cert AS c
JOIN 
    bsg_cert_people AS cp ON cp.cid = c.id
JOIN 
    bsg_people AS p ON cp.pid = p.id
LEFT JOIN 
    bsg_planets AS hw ON p.homeworld = hw.id
ORDER BY 
    c.title, p.lname, p.fname;

