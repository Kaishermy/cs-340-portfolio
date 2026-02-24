-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 02/06/2026
-- Copied from /OR/ Adapted from /OR/ Based on
-- Microsoft Copilot
-- Source URL: https://copilot.microsoft.com/
-- If AI tools were used:
-- I started with a SELECT query in the specified area.
-- This did not work, so I prompted Copilot to fix it for me
-- with minimal changes.


-- Leave the following query code untouched
Drop TABLE IF EXISTS diag_function_cert_use;
CREATE TABLE diag_function_cert_use (
    used INT DEFAULT 0
);

INSERT INTO diag_function_cert_use (used) VALUES (0)
ON DUPLICATE KEY UPDATE used = used;

DELIMITER //
DROP FUNCTION  IF EXISTS func_cert_count;

-- ------- Write your code below this line -----------
CREATE FUNCTION func_cert_count(cert_title VARCHAR(255)) 
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE cert_count INT;

    -- SELECT query to get the certificate count
    SELECT COUNT(*) INTO cert_count
    FROM v_cert_people
    WHERE title = cert_title;

    -- Increment the used attribute
    UPDATE diag_function_cert_use SET used = used + 1;
    RETURN cert_count;
END //


-- ------- Do not alter query code below this line -----------
DELIMITER ;