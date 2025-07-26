/*SHA2 Login Security in MySQL — Use Cases & Examples--
SHA2 is used to store and compare passwords securely. MySQL provides:
syntax:
 SHA2(string, hash_length)

SHA2('your_password', 256) → returns a 64-character hash (SHA-256)
 */

-- checking existing passwords
SELECT user_id, email, password FROM Users;


-- keeping password length should be 64 char long 

ALTER TABLE Users MODIFY password VARCHAR(64);


-- hashing all plain text passwords 

UPDATE Users
SET password = SHA2(password, 256)
WHERE LENGTH(password) < 64;



-- checking the hash code of the passwords

SELECT user_id, email, password FROM Users;

DELIMITER //

CREATE PROCEDURE AuthenticateUser (
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100)
)
BEGIN
    SELECT user_id, full_name
    FROM Users
    WHERE email = p_email AND password = SHA2(p_password, 256);
END //

DELIMITER ;


-- trying login using procedure--
CALL AuthenticateUser('jai@example.com', 'pass@jai');

-- its better to insert password using hashing so that it keeps or credentials secure
INSERT INTO Users (full_name, email, password)
VALUES ('Test User', 'test@example.com', SHA2('mypassword', 256));

-- if a user forget passwords try to reset it manually it again creates a new hashcode

UPDATE Users
SET password = SHA2('Temp@123', 256)
WHERE email = 'jai@example.com';



-- updating through procedures-
DELIMITER //

CREATE PROCEDURE ResetUserPassword (
    IN p_email VARCHAR(100),
    IN p_new_password VARCHAR(100)
)
BEGIN
    DECLARE rows_affected INT;

    -- Update the hashed password
    UPDATE Users
    SET `password` = SHA2(p_new_password, 256)
    WHERE email = p_email;

    -- Check if any row was updated
    SET rows_affected = ROW_COUNT();

    -- Return message
    IF rows_affected > 0 THEN
        SELECT 'Password updated successfully.' AS message;
    ELSE
        SELECT 'Email not found. No password updated.' AS message;
    END IF;
END //

DELIMITER ;


-- calling the procedure---
CALL ResetUserPassword('jai@example.com', 'Temp@123');








-- creating a stored procedure  to login using hashed password
DELIMITER //

CREATE PROCEDURE AuthenticateUser (
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100)
)
BEGIN
    SELECT user_id, full_name
    FROM Users
    WHERE email = p_email 
      AND password = SHA2(p_password, 256);
END //

DELIMITER ;


CALL AuthenticateUser('alice@example.com', 'alice123');

-- it works  if password matches
/*
INSERT INTO Users (full_name, email, password)
VALUES ('Bob', 'bob@example.com', 'bob123');
which is not secure if (db is hacked passwords can be stolen)
*/

-- Migrating exisiting user password to SHA2

UPDATE Users
SET password = SHA2('newpassword@1324', 256)
WHERE LENGTH(password) < 64;

-- trying to validating without stored procedures
SELECT * FROM Users
WHERE email = 'alice@example.com' AND password = SHA2('alice123', 256);
