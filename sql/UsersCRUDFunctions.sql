-- CREATE
CREATE OR REPLACE FUNCTION fnCreateUsers(
    p_FirstName VARCHAR,
    p_LastName VARCHAR,
    p_UserType VARCHAR,
    p_Email VARCHAR,
    p_Password VARCHAR,
    p_PhoneNumber VARCHAR
)
RETURNS INT AS $$
DECLARE
    new_id INT;
BEGIN
    INSERT INTO Users (FirstName, LastName, UserType, Email, Password, PhoneNumber)
    VALUES (p_FirstName, p_LastName, p_UserType, p_Email, p_Password, p_PhoneNumber)
    RETURNING Users.UserId INTO new_id;
    RETURN new_id;
END;
$$ LANGUAGE plpgsql;


-- GET ALL
CREATE OR REPLACE FUNCTION fnGetAllUsers()
RETURNS TABLE (
    UserId INT,
    FirstName VARCHAR,
    LastName VARCHAR,
    UserType VARCHAR,
    Email VARCHAR,
    PhoneNumber VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT Users.UserId,
           Users.FirstName,
           Users.LastName,
           Users.UserType,
           Users.Email,
           Users.PhoneNumber
    FROM Users
    ORDER BY Users.LastName, Users.FirstName;
END;
$$ LANGUAGE plpgsql;


-- READ (single)
CREATE OR REPLACE FUNCTION fnReadUsers(p_UserId INT)
RETURNS TABLE (
    UserId INT,
    FirstName VARCHAR,
    LastName VARCHAR,
    UserType VARCHAR,
    Email VARCHAR,
    PhoneNumber VARCHAR
) AS $$
BEGIN
    RETURN QUERY 
    SELECT Users.UserId,
           Users.FirstName,
           Users.LastName,
           Users.UserType,
           Users.Email,
           Users.PhoneNumber
    FROM Users
    WHERE Users.UserId = p_UserId;
END;
$$ LANGUAGE plpgsql;


-- UPDATE
CREATE OR REPLACE FUNCTION fnUpdateUsers(
    p_UserId INT,
    p_FirstName VARCHAR,
    p_LastName VARCHAR,
    p_UserType VARCHAR,
    p_Email VARCHAR,
    p_Password VARCHAR,
    p_PhoneNumber VARCHAR
)
RETURNS VOID AS $$
BEGIN
    UPDATE Users
    SET FirstName = p_FirstName,
        LastName = p_LastName,
        UserType = p_UserType,
        Email = p_Email,
        Password = p_Password,
        PhoneNumber = p_PhoneNumber
    WHERE Users.UserId = p_UserId;
END;
$$ LANGUAGE plpgsql;


-- DELETE
CREATE OR REPLACE FUNCTION fnDeleteUsers(p_UserId INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM Users
    WHERE Users.UserId = p_UserId;
END;
$$ LANGUAGE plpgsql;
