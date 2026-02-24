-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 02/06/2026
-- Copied from /OR/ Adapted from /OR/ Based on
-- Microsoft Copilot
-- Source URL: https://copilot.microsoft.com/
-- If AI tools were used:
-- I wrote the necessary code myself to insert both rows
-- and get the last ID. I then prompted Copilot to double-check
-- my work. It fixed two small syntax errors in my bsg_cert_people
-- insertion, which are currently reflected in the code.


-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_insert_person;
DELIMITER //

-- ------- Write your code below this line -----------

CREATE PROCEDURE sp_insert_person(
    IN fname VARCHAR(255),
    IN lname VARCHAR(255),
    IN age INT,
    IN homeworld INT,
    IN cert_id INT,
    OUT person_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- In case of an error, set the person_id to -99
        SET person_id = -99;
        ROLLBACK;
    END;

    START TRANSACTION;
    
    -- Insert into bsg_people table
    INSERT INTO bsg_people (fname, lname, homeworld, age)
    VALUES (fname, lname, homeworld, age);

    -- Get the last inserted id
    SET person_id = LAST_INSERT_ID();

    -- Insert into bsg_cert_people table
    INSERT INTO bsg_cert_people (cid, pid)
    VALUES (cert_id, person_id);
    
    COMMIT;
END //


-- ------- Do not alter query code below this line -----------
DELIMITER ;