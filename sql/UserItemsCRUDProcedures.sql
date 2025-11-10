-- CREATE
CREATE OR REPLACE FUNCTION fnCreateUserItems(
    p_PostedByUserId INT,
    p_LocationId INT,
    p_ItemId INT,
    p_IsFound BOOLEAN
)
RETURNS INT AS $$
DECLARE
    new_id INT;
BEGIN
    INSERT INTO UserItems (PostedByUserId, LocationId, ItemId, IsFound)
    VALUES (p_PostedByUserId, p_LocationId, p_ItemId, p_IsFound)
    RETURNING UserItemId INTO new_id;
    RETURN new_id;
END;
$$ LANGUAGE plpgsql;


-- READ
CREATE OR REPLACE FUNCTION fnReadUserItems(p_UserItemId INT)
RETURNS TABLE (
    UserItemId INT,
    PostedByUserId INT,
    LocationId INT,
    ItemId INT,
    IsFound BOOLEAN,
    DatePosted TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT UserItemId, PostedByUserId, LocationId, ItemId, IsFound, DatePosted
    FROM UserItems WHERE UserItemId = p_UserItemId;
END;
$$ LANGUAGE plpgsql;


-- UPDATE
CREATE OR REPLACE FUNCTION fnUpdateUserItems(
    p_UserItemId INT,
    p_LocationId INT,
    p_ItemId INT,
    p_IsFound BOOLEAN
)
RETURNS VOID AS $$
BEGIN
    UPDATE UserItems
    SET LocationId = p_LocationId,
        ItemId = p_ItemId,
        IsFound = p_IsFound
    WHERE UserItemId = p_UserItemId;
END;
$$ LANGUAGE plpgsql;


-- DELETE
CREATE OR REPLACE FUNCTION fnDeleteUserItems(p_UserItemId INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM UserItems WHERE UserItemId = p_UserItemId;
END;
$$ LANGUAGE plpgsql;
