IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS  WHERE NAME = 'Usp_Select_QS_Flag' AND TYPE = 'P')
DROP PROCEDURE Usp_Select_QS_Flag
GO
CREATE PROCEDURE Usp_Select_QS_Flag
@QS_FLAG CHAR(1),
@AGREE_BRAND_ID VARCHAR(32)
AS
SELECT UNIQUE_ID,AGREE_BRAND_ID,UP_TO_PCT, PRGSV_DISC_PCT , QSY_DISC_FLAG 
FROM AGREE_PROG_DISC
WHERE (QSY_DISC_FLAG = @QS_FLAG) AND (AGREE_BRAND_ID = @AGREE_BRAND_ID)
ORDER BY UP_TO_PCT DESC
GO
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Select_Y_Flag' AND TYPE = 'P')
DROP PROCEDURE Usp_Select_Y_Flag
GO
CREATE PROCEDURE Usp_Select_Y_Flag
@AGREE_BRAND_ID VARCHAR(32)
AS
SELECT UNIQUE_ID,AGREE_BRAND_ID, UP_TO_PCT,PRGSV_DISC_PCT, QSY_DISC_FLAG 
FROM  AGREE_PROG_DISC
WHERE (QSY_DISC_FLAG = 'Y') AND (AGREE_BRAND_ID = @AGREE_BRAND_ID)
ORDER BY UP_TO_PCT DESC
GO