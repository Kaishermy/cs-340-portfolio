-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 02/06/2026
-- Copied from /OR/ Adapted from /OR/ Based on
-- Microsoft Copilot
-- Source URL: https://copilot.microsoft.com/
-- If AI tools were used:
-- I wrote the procedure myself by filling in the empty areas.
-- I then showed Copilot and prompted it to verify that it meets
-- the criteria. I was missing a rollback in the first if statement, which
-- I inserted. I then asked it for a quick test statement that
-- was run in the CLI.


-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_add_person_certification;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE PROCEDURE sp_add_person_certification (
    IN person_id INT,
    IN cert_id INT
)
BEGIN
    DECLARE cert_exists INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction in case of an error
        ROLLBACK;
        -- Return -99 to indicate an error
        SELECT -99 AS cert_count;
    END;

    -- Start a transaction
    START TRANSACTION;

    -- Check if the certification exists
    SELECT COUNT(*) INTO cert_exists FROM bsg_cert WHERE id = cert_id;
    IF cert_exists = 0 THEN
    
        -- If the certification does not exist, rollback and return -99
        ROLLBACK;
        SELECT -99 AS cert_count;
    ELSE
        -- If the certification exists, insert the new certification for the person
        INSERT INTO bsg_cert_people (cid, pid)
        VALUES (cert_id, person_id);

        -- Commit the transaction
        COMMIT;

        -- Return the count of people with the new certification
        SELECT func_cert_count((SELECT title FROM bsg_cert WHERE id = cert_id)) AS cert_count;
    END IF;
END //


-- ------- Do not alter query code below this line -----------
DELIMITER ;