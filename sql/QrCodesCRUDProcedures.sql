-- CREATE
CREATE OR REPLACE FUNCTION fnCreateQrCodes(
    p_LocationId INT,
    p_QrCodePath VARCHAR
)
RETURNS INT AS $$
DECLARE
    new_id INT;
BEGIN
    INSERT INTO QrCodes (LocationId, QrCodePath)
    VALUES (p_LocationId, p_QrCodePath)
    RETURNING QrCodeId INTO new_id;
    RETURN new_id;
END;
$$ LANGUAGE plpgsql;


-- READ
CREATE OR REPLACE FUNCTION fnReadQrCodes(p_QrCodeId INT)
RETURNS TABLE (
    QrCodeId INT,
    LocationId INT,
    QrCodePath VARCHAR,
    CreatedOn TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT QrCodeId, LocationId, QrCodePath, CreatedOn
    FROM QrCodes WHERE QrCodeId = p_QrCodeId;
END;
$$ LANGUAGE plpgsql;


-- UPDATE
CREATE OR REPLACE FUNCTION fnUpdateQrCodes(
    p_QrCodeId INT,
    p_LocationId INT,
    p_QrCodePath VARCHAR
)
RETURNS VOID AS $$
BEGIN
    UPDATE QrCodes
    SET LocationId = p_LocationId,
        QrCodePath = p_QrCodePath
    WHERE QrCodeId = p_QrCodeId;
END;
$$ LANGUAGE plpgsql;


-- DELETE
CREATE OR REPLACE FUNCTION fnDeleteQrCodes(p_QrCodeId INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM QrCodes WHERE QrCodeId = p_QrCodeId;
END;
$$ LANGUAGE plpgsql;
