
SET SERVEROUTPUT ON;

-- 1. Valida se temperatura é crítica

CREATE OR REPLACE FUNCTION FNC_IS_TEMP_CRITICAL (
    P_TEMP IN NUMBER,
    P_LIMIT IN NUMBER
) RETURN NUMBER AS
BEGIN
    IF P_TEMP > P_LIMIT THEN
        RETURN 1;  -- crítico
    ELSE
        RETURN 0;  -- normal
    END IF;
END;
/
SELECT FNC_IS_TEMP_CRITICAL(85, 80) FROM DUAL;
/



-- 2. Média de temperatura de um sensor

CREATE OR REPLACE FUNCTION FNC_CALC_MEDIA_TEMP (
    P_SENSOR_ID IN NUMBER
) RETURN NUMBER AS
    V_MEDIA NUMBER;
BEGIN
    SELECT AVG(TEMPERATURE)
    INTO V_MEDIA
    FROM TB_GS_SENSOR_READINGS
    WHERE SENSOR_ID = P_SENSOR_ID;

    RETURN NVL(V_MEDIA, 0);
END;
/
SELECT FNC_CALC_MEDIA_TEMP(3) FROM DUAL;
/


-- 3. Verifica se sensor existe

CREATE OR REPLACE FUNCTION FNC_SENSOR_ACTIVE (
    P_SENSOR_ID IN NUMBER
) RETURN NUMBER AS
    V_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO V_COUNT
    FROM TB_GS_SENSORS
    WHERE ID_SENSOR = P_SENSOR_ID;

    IF V_COUNT > 0 THEN
        RETURN 1;  -- existe e está ativo
    ELSE
        RETURN 0;  -- não existe
    END IF;
END;
/
SELECT FNC_SENSOR_ACTIVE(5) FROM DUAL;
/
--------------------------------------------------------------------------------
