-- CREATE
CREATE OR REPLACE FUNCTION fnCreateLocations(
    p_QrCodeId INT,
    p_BuildingName VARCHAR,
    p_Description TEXT
)
RETURNS INT AS $$
DECLARE
    new_id INT;
BEGIN
    INSERT INTO Locations (QrCodeId, BuildingName, Description)
    VALUES (p_QrCodeId, p_BuildingName, p_Description)
    RETURNING Locations.LocationId INTO new_id;
    RETURN new_id;
END;
$$ LANGUAGE plpgsql;


-- READ
CREATE OR REPLACE FUNCTION fnReadLocations(p_LocationId INT)
RETURNS TABLE (
    LocationId INT,
    QrCodeId INT,
    BuildingName VARCHAR,
    Description TEXT
) AS $$
BEGIN
    RETURN QUERY 
    SELECT Locations.LocationId, Locations.QrCodeId, Locations.BuildingName, Locations.Description
    FROM Locations
    WHERE Locations.LocationId = p_LocationId;
END;
$$ LANGUAGE plpgsql;


-- UPDATE
CREATE OR REPLACE FUNCTION fnUpdateLocations(
    p_LocationId INT,
    p_QrCodeId INT,
    p_BuildingName VARCHAR,
    p_Description TEXT
)
RETURNS VOID AS $$
BEGIN
    UPDATE Locations
    SET QrCodeId = p_QrCodeId,
        BuildingName = p_BuildingName,
        Description = p_Description
    WHERE Locations.LocationId = p_LocationId;
END;
$$ LANGUAGE plpgsql;


-- DELETE
CREATE OR REPLACE FUNCTION fnDeleteLocations(p_LocationId INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM Locations
    WHERE Locations.LocationId = p_LocationId;
END;
$$ LANGUAGE plpgsql;


-- GET ALL
CREATE OR REPLACE FUNCTION fnGetAllLocations()
RETURNS TABLE (
    LocationId INT,
    QrCodeId INT,
    BuildingName VARCHAR,
    Description TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT Locations.LocationId, Locations.QrCodeId, Locations.BuildingName, Locations.Description
    FROM Locations
    ORDER BY Locations.LocationId;
END;
$$ LANGUAGE plpgsql;
