-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 02/06/2026
-- Copied from /OR/ Adapted from /OR/ Based on
-- Microsoft Copilot
-- Source URL: https://copilot.microsoft.com/
-- If AI tools were used:
-- Prompted to generate code to convert timeNow to TIME and
-- verify that the given time is within a valid range.


-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_query1;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE PROCEDURE sp_query1 (IN timeNow VARCHAR(4), OUT greeting VARCHAR(50))
BEGIN
    DECLARE current_hour INT;
    DECLARE formatted_time TIME;
    
    -- Validate input format
    IF LENGTH(timeNow) != 4 OR timeNow NOT REGEXP '^[0-2][0-9][0-5][0-9]$' THEN
        SET greeting = 'Invalid time format. Please use HHMM.';
    ELSE
        -- Convert the input timeNow to TIME format
        SET current_hour = CAST(SUBSTRING(timeNow, 1, 2) AS UNSIGNED);
        SET formatted_time = MAKETIME(
            current_hour,
            CAST(SUBSTRING(timeNow, 3, 2) AS UNSIGNED),
            0
        );

        -- Check for valid time range
        IF current_hour > 23 OR CAST(SUBSTRING(timeNow, 3, 2) AS UNSIGNED) > 59 THEN
            SET greeting = 'INVALID time range. Please use HHMM between 0000 and 2359.';
        ELSE
        -- SET OUTVAR 'greeting' to a string value based on current_hour
            -- e.g. SET greeting = 'Good evening';
            IF current_hour < 6 THEN
                SET greeting = 'My it\'s late, shouldn\'t you be in bed?';
            ELSEIF current_hour < 12 THEN
                SET greeting = 'Good morning';
            ELSEIF current_hour < 17 THEN
                SET greeting = 'Good afternoon';
            ELSE
                SET greeting = 'Good evening';
            END IF;
        END IF;
    END IF;
END //
-- ------- Do not alter query code below this line -----------
DELIMITER ;