-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 02/06/2026
-- Copied from /OR/ Adapted from /OR/ Based on
-- Microsoft Copilot
-- Source URL: https://copilot.microsoft.com/
-- If AI tools were used:
-- I started with the partial UPDATE query in the assignment hints.
-- Once I hit a wall, I prompted Copilot to fix it based on the requirements.
-- I mostly implemented exactly what it output, but I didn't like the
-- aliasing it used, so I trimmed it off in the code below.


-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_update_cert_count_totals;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE PROCEDURE sp_update_cert_count_totals()
BEGIN
    -- Update the cert_total column with the count of people holding each certificate
    UPDATE bsg_cert
    LEFT JOIN (
        SELECT cid, COUNT(*) AS total
        FROM bsg_cert_people
        GROUP BY cid
    ) AS cp
    ON bsg_cert.id = cp.cid
    SET bsg_cert.cert_total = COALESCE(cp.total, 0);

END //


-- ------- Do not alter query code below this line -----------
DELIMITER ;