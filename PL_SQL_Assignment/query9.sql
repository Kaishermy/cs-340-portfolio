-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 02/06/2026
-- Copied from /OR/ Adapted from /OR/ Based on
-- All my original work
-- Source URL: N/A
-- If AI tools were used:
-- N/A


-- Leave the following query code untouched
DROP TRIGGER IF EXISTS trigger_after_cert_person_inserted;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE TRIGGER trigger_after_cert_person_inserted

    -- CALL sp_update_cert_count_totals(); in the trigger body
    AFTER INSERT ON bsg_cert_people FOR EACH ROW
    BEGIN
        CALL sp_update_cert_count_totals;
    END //

-- ------- Do not alter query code below this line -----------
DELIMITER ;