---------------PROCEDURE UNTUK MEMVIEW DATA SHIP_TO-------------------
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME= 'Usp_Create_View_Ship_To' AND TYPE = 'P')
DROP PROCEDURE Usp_Create_View_Ship_To
GO
CREATE PROCEDURE Usp_Create_View_Ship_To
AS
SELECT ST.SHIP_TO_ID,ST.TERRITORY_ID,ST.TM_ID
,ST.CREATE_BY,ST.CREATE_DATE --FROM DIST_DISTRIBUTOR DR RIGHT OUTER JOIN TERRITORY TER
FROM SHIP_TO ST
GO
-----------------------------------------------------------------------------
-------------------PROCEDURE UNTUK MENDELETE DATA SHIP_TO--------------------
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Check_Referenced_Data_SHIP_TO' AND TYPE = 'P')
DROP PROCEDURE Usp_Check_Referenced_Data_SHIP_TO
GO
CREATE PROCEDURE Usp_Check_Referenced_Data_SHIP_TO
@SHIP_TO_ID VARCHAR(25)
AS
 IF EXISTS(SELECT SHIP_TO_ID FROM OA_SHIP_TO WHERE SHIP_TO_ID = @SHIP_TO_ID)
    BEGIN
	RAISERROR('can not deleted data',16,1)
	RETURN(1)
    END	
RETURN(0)
GO
--------------------------------------------------------------------------------------
---------------------------------------PROCEDURE UNTUK MENDELETE DATA SHIP_TO------
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Delete_SHIP_TO' AND TYPE = 'P')
DROP PROCEDURE Usp_Delete_SHIP_TO
GO
CREATE PROCEDURE Usp_Delete_SHIP_TO
@SHIP_TO_ID VARCHAR(25)
AS 
DELETE FROM SHIP_TO WHERE SHIP_TO_ID = @SHIP_TO_ID
GO
----------------------------------------------------------------------------------

----------------------------PROCEDURE UNTUK MENGAMBIL DATA TM DI OA---------
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Get_TM_by_Distributor_ID' AND TYPE = 'P')
DROP PROCEDURE Usp_Get_TM_by_Distributor_ID
GO
CREATE PROCEDURE Usp_Get_TM_by_Distributor_ID
--@DISTRIBUTOR_ID VARCHAR(10)
AS
SELECT ST.SHIP_TO_ID,TER.TERRITORY_AREA,TM.MANAGER
FROM TERRITORY TER INNER JOIN SHIP_TO ST ON TER.TERRITORY_ID = ST.TERRITORY_ID
INNER JOIN TERRITORY_MANAGER TM ON ST.TM_ID = TM.TM_ID
--WHERE ST.TERRITORY_ID = (SELECT TERRITORY_ID FROM DIST_DISTRIBUTOR WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID)
GO
-----------------------------------------------------------------------------------
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Create_View_OA_Ship_To'
   AND TYPE = 'P')
DROP PROCEDURE Usp_Create_View_OA_Ship_To 
GO
CREATE PROCEDURE Usp_Create_View_OA_Ship_To 
@DISTRIBUTOR_ID VARCHAR(10),
@START_DATE SMALLDATETIME,
@END_DATE SMALLDATETIME
AS
SET NOCOUNT ON;
SELECT OPO.PO_REF_NO,OOA.OA_ID AS OA_REF_NO,OOA.OA_DATE,
DR.DISTRIBUTOR_ID AS SHIP_TO_DISTRIBUTOR_ID,DR.DISTRIBUTOR_NAME AS SHIP_TO_DISTRIBUTOR_NAME,
TER.TERRITORY_AREA AS TERRITORY_AREA,TM.MANAGER AS SHIP_TO_TM
FROM ORDR_PURCHASE_ORDER OPO INNER JOIN ORDR_ORDER_ACCEPTANCE OOA ON OPO.PO_REF_NO = OOA.PO_REF_NO
INNER JOIN OA_SHIP_TO OST ON OOA.OA_ID = OST.OA_ID LEFT OUTER JOIN SHIP_TO ST
ON ST.SHIP_TO_ID = OST.SHIP_TO_ID INNER JOIN DIST_DISTRIBUTOR DR
ON OPO.DISTRIBUTOR_ID = DR.DISTRIBUTOR_ID LEFT OUTER JOIN TERRITORY_MANAGER TM ON ST.TM_ID = TM.TM_ID
LEFT OUTER JOIN TERRITORY TER ON ST.TERRITORY_ID
 = TER.TERRITORY_ID 
WHERE OPO.DISTRIBUTOR_ID = @DISTRIBUTOR_ID AND OOA.OA_DATE >= @START_DATE AND 
OOA.OA_DATE <= @END_DATE; 
GO

/*
UPDATE DIST_DISTRIBUTOR SET TERRITORY_ID = NULL


SELECT * FROM OA_SHIP_TO WHERE SHIP_TO_ID = '033004'
SELECT * FROM SHIP_TO WHERE TERRITORY_ID = '033'

DELETE FROM OA_SHIP_TO WHERE SHIP_TO_ID = ''

UPDATE OA_SHIP_TO SET SHIP_TO_ID = NULL
WHERE SHIP_TO_ID = '033004'

UPDATE OA_SHIP_TO SET SHIP_TO_ID = NULL WHERE SHIP_TO_ID
IN (SELECT SHIP_TO_ID FROM SHIP_TO WHERE TERRITORY_ID = '033')

SELECT * FROM OA_SHIP_TO WHERE SHIP_TO_ID = '004041'
033004
033041
033054