-- CREATE
CREATE OR REPLACE FUNCTION fnCreateItems(
    p_Description TEXT,
    p_Category VARCHAR,
    p_ImagePath VARCHAR,
    p_Status VARCHAR
)
RETURNS INT AS $$
DECLARE
    new_id INT;
BEGIN
    INSERT INTO Items (Description, Category, ImagePath, Status)
    VALUES (p_Description, p_Category, p_ImagePath, p_Status)
    RETURNING ItemId INTO new_id;
    RETURN new_id;
END;
$$ LANGUAGE plpgsql;


-- READ
CREATE OR REPLACE FUNCTION fnReadItems(p_ItemId INT)
RETURNS TABLE (
    ItemId INT,
    Description TEXT,
    Category VARCHAR,
    ImagePath VARCHAR,
    DatePosted TIMESTAMP,
    Status VARCHAR
) AS $$
BEGIN
    RETURN QUERY SELECT ItemId, Description, Category, ImagePath, DatePosted, Status
    FROM Items WHERE ItemId = p_ItemId;
END;
$$ LANGUAGE plpgsql;


-- UPDATE
CREATE OR REPLACE FUNCTION fnUpdateItems(
    p_ItemId INT,
    p_Description TEXT,
    p_Category VARCHAR,
    p_ImagePath VARCHAR,
    p_Status VARCHAR
)
RETURNS VOID AS $$
BEGIN
    UPDATE Items
    SET Description = p_Description,
        Category = p_Category,
        ImagePath = p_ImagePath,
        Status = p_Status
    WHERE ItemId = p_ItemId;
END;
$$ LANGUAGE plpgsql;


-- DELETE
CREATE OR REPLACE FUNCTION fnDeleteItems(p_ItemId INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM Items WHERE ItemId = p_ItemId;
END;
$$ LANGUAGE plpgsql;
