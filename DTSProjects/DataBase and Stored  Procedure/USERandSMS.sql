--delete from syst_menu

---PROCEDURE UNTUK MEMVIEW DATA_USER
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Sp_GetViewUser' AND TYPE = 'P')
DROP PROCEDURE Sp_GetViewUser
GO
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_GetViewUser' AND TYPE = 'P')
DROP PROCEDURE Usp_GetViewUser
GO
CREATE PROCEDURE Usp_GetViewUser
AS
--SELECT SYST_USERNAME.[USER_ID],SYST_USERNAME.[PASSWORD],SYST_USERNAME.LAST_LOGIN,
--SYST_USERNAME.LAST_LOGOUT,SYST_USERNAME.LAST_FORM,SYST_USERNAME.STATUS,SYST_USERNAME.ISADMIN,SYST
--FROM SYST_USERNAME
 --ORDER BY SYST_USERNAME.[USER_ID]
 SELECT SU.[USER_ID],SU.[PASSWORD],SU.LAST_LOGIN,SU.LAST_LOGOUT,SU.LAST_FORM,SU.STATUS,SU.ISADMIN,SU.INActive
 FROM SYST_USERNAME SU ORDER BY SU.[USER_ID]
GO
-------------------------------------------------------------------------
---------------------------------------------------------------------------
--PROCEDURE UNTUK MEMVIEW DATA_SMS LOG
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_GetView_LOG_MESSAGE' AND TYPE = 'P')
DROP PROCEDURE Usp_GetView_LOG_MESSAGE
GO
CREATE PROCEDURE Usp_GetView_LOG_MESSAGE
@FROM_DATE DATETIME,
@UNTIL_DATE DATETIME,
@STATUS_SENT BIT
AS
SET NOCOUNT ON ; 
SELECT TransactionID,CONTACT_PERSON,CONTACT_MOBILE,ORIGIN_COMPANY,MESSAGE,STATUS_SENT,SENT_DATE,SENT_BY FROM SMS_TABLE WHERE SENT_DATE >= @FROM_DATE AND SENT_DATE <= @UNTIL_DATE
AND STATUS_SENT = @STATUS_SENT
UNION 
SELECT TransactionID,SENT_TO AS CONTACT_PERSON,MOBILE AS CONTACT_MOBILE,ORIGIN_COMPANY,MESSAGE,STATUS_SENT,SENt_DATE,SENT_BY FROM GON_SMS WHERE SENT_DATE >= @FROM_DATE AND SENT_DATE <= @UNTIL_DATE
AND STATUS_SENT = @STATUS_SENT
GO

--------------------------------------------------------------------------------------------------------
--EXEC Usp_GetView_PO_SMS

--SELECT * FROM ORDR_PURCHASE_ORDER WHERE DATEDIFF(DAY,PO_REF_DATE,GETDATE()) <= 14
--PROCEDURE UNTUK MENGINPUT SMS_TABLE BERDASARKAN OTHER SMS
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Insert_SMS_TABLE' AND TYPE = 'P')
DROP PROCEDURE Usp_Insert_SMS_TABLE
GO
CREATE PROCEDURE Usp_Insert_SMS_TABLE
@PO_REF_NO VARCHAR(25),
@CONTACT_PERSON VARCHAR(30),
@ORIGIN_COMPANY VARCHAR(50),
@CONTACT_MOBILE VARCHAR(20),
@MESSAGE VARCHAR(1000),
@STATUS_SENT BIT,
@SENT_BY VARCHAR(30),
@CreatedDate smalldatetime
AS
SET NOCOUNT ON;
 INSERT INTO SMS_TABLE(PO_REF_NO,CONTACT_PERSON,CONTACT_MOBILE,ORIGIN_COMPANY,MESSAGE,STATUS_SENT,SENT_DATE,SENT_BY)
 VALUES(@PO_REF_NO,@CONTACT_PERSON,@CONTACT_MOBILE,@ORIGIN_COMPANY,@MESSAGE,@STATUS_SENT, CURRENT_TIMESTAMP,@SENT_BY,)
GO
--------------------------------------------------------------------------------------
--PROCEDURE UNTUK MENGECEK VALIDITY DISTRIBUTOR
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Chek_Validity_Distributor' AND TYPE = 'P')
DROP PROCEDURE Usp_Chek_Validity_Distributor
GO
CREATE PROCEDURE Usp_Chek_Validity_Distributor
@DISTRIBUTOR_ID VARCHAR(10)
AS
DECLARE @CONTACT_PERSON VARCHAR(35),@CONTACT_MOBILE VARCHAR(20)
SET @CONTACT_MOBILE = (SELECT HP FROM DIST_DISTRIBUTOR WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID)
SET @CONTACT_PERSON = (SELECT CONTACT FROM DIST_DISTRIBUTOR WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID)
IF (@CONTACT_MOBILE IS NULL OR @CONTACT_MOBILE = '')
	RETURN(1)
ELSE IF (@CONTACT_PERSON IS NULL OR @CONTACT_PERSON = '')
	RETURN(2)
ELSE
	RETURN(0)
GO


--------------------------------------------------------------------------------------------
--PROCEDURE UNTUK MENGINSERT DATA USER_USERNAME
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Sp_Insert_SYST_USERNAME' AND TYPE = 'P')
DROP PROCEDURE Sp_Insert_SYST_USERNAME
GO
CREATE PROCEDURE Sp_Insert_SYST_USERNAME
@USER_ID VARCHAR(15),
@PASSWORD VARCHAR(30),
@CREATE_BY VARCHAR(30),
@O_MESSAGE VARCHAR(100)OUTPUT

AS
BEGIN
SET @O_MESSAGE = ''
IF (SELECT COUNT ([USER_ID]) FROM SYST_USERNAME WHERE [USER_ID] = @USER_ID) > 0
   BEGIN
	SET @O_MESSAGE = 'User Name has existed' 
	RETURN(0)
   END		
INSERT INTO SYST_USERNAME([USER_ID],[PASSWORD],CREATE_DATE,CREATE_BY,STATUS,ISADMIN)
VALUES(@USER_ID,@PASSWORD,GETDATE(),@CREATE_BY,0,0)
END
GO

-----------------------------------------------------------------------------
--PROCEDURE UNTUK MENGUPDATE USER_USERNAME
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Sp_Update_SYST_USERNAME' AND TYPE = 'P')
DROP PROCEDURE Sp_Update_SYST_USERNAME
GO
CREATE PROCEDURE Sp_Update_SYST_USERNAME
@USER_ID VARCHAR(15),
@PASSWORD VARCHAR(30),
@MODIFY_BY VARCHAR(30)
AS
UPDATE SYST_USERNAME
SET [USER_ID] = @USER_ID,[PASSWORD] = @PASSWORD,MODIFY_BY = @MODIFY_BY,
MODIFY_DATE = GETDATE() WHERE [USER_ID] = @USER_ID
GO
------------------------------------------------------------------------
--PROCEDURE UNTUK LOGOUT USER
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Sp_Logout_USER' AND TYPE = 'P')
DROP PROCEDURE Sp_Logout_USER
GO
CREATE PROCEDURE Sp_Logout_USER
@USER_ID VARCHAR(30),
@LAST_FORM VARCHAR(30)
AS
UPDATE SYST_USERNAME SET LAST_LOGOUT =  CURRENT_TIMESTAMP,LAST_FORM = @LAST_FORM,STATUS = 0
WHERE [USER_ID] = @USER_ID 
GO
-------------------------------------------------------------------------------
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Sp_Login_USER' AND TYPE = 'P')
DROP PROCEDURE Sp_Login_USER
GO
CREATE PROCEDURE Sp_Login_USER
@USER_ID VARCHAR(30),
@PASSWORD VARCHAR(30),
@O_PASSWORD VARCHAR(30)OUTPUT,
@O_MESSAGE VARCHAR(100) OUTPUT,
@O_GETDATE DATETIME OUTPUT,
@O_ISADMIN BIT OUTPUT
AS
BEGIN
SET @O_MESSAGE = '' ;

	IF NOT EXISTS(SELECT [USER_ID] FROM SYST_USERNAME WHERE [USER_ID] = @USER_ID) 
		BEGIN
		SET @O_MESSAGE = 'User Name does not exist';
		RETURN(0);
		END 
	ELSE IF EXISTS(SELECT [USER_ID] FROM SYST_USERNAME WHERE [USER_ID] = @USER_ID AND INActive = 1)
		BEGIN
		SET @O_MESSAGE = 'User Name has been in active';
		RETURN(0);
		END
	SET @O_PASSWORD = (SELECT [PASSWORD] FROM SYST_USERNAME WHERE [USER_ID] = @USER_ID AND INActive = 0)
	IF (@PASSWORD != @O_PASSWORD)
		BEGIN
		SET @O_MESSAGE = 'Incorect USER_ID or Password'
		RETURN(0)
		END 
	SET @O_ISADMIN = (SELECT ISADMIN FROM SYST_USERNAME WHERE [USER_ID] = @USER_ID)
	UPDATE SYST_USERNAME SET LAST_LOGIN =  CURRENT_TIMESTAMP,STATUS = 1  WHERE [USER_ID] = @USER_ID
	SET @O_GETDATE = (SELECT GETDATE())
END
GO

--------------------------------------------------------------------------
--PRCEDURE UNTUK MENDELETE DATA USER
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Sp_Delete_USER' AND TYPE = 'P')
DROP PROCEDURE Sp_Delete_USER
GO
CREATE PROCEDURE Sp_Delete_USER
@USER_ID VARCHAR(30),
@O_MESSAGE VARCHAR(100) OUTPUT
AS
BEGIN
    SET @O_MESSAGE = ''
    IF (SELECT STATUS FROM SYST_USERNAME WHERE [USER_ID] = @USER_ID) > 0
	BEGIN
	    SET @O_MESSAGE = 'User is still using system'
	    RETURN(0)
	END
     DELETE FROM SYST_PRIVILEGE WHERE [USER_ID] = @USER_ID
     DELETE FROM SYST_USERNAME WHERE [USER_ID] = @USER_ID
END
GO
----------------------------------------------------------------
-----------------------PROCEUDRE UNTUK MENGAMBIL DATA TM--PADA SAAT SEND SMS---
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Get_TM_Description_By_PO'
   AND TYPE = 'P')
DROP PROCEDURE Usp_Get_TM_Description_By_PO
GO
CREATE PROCEDURE Usp_Get_TM_Description_By_PO
@PO_REF_NO VARCHAR(30)
AS
SET NOCOUNT ON;
BEGIN
SELECT MANAGER,HP FROM TERRITORY_MANAGER WHERE TM_ID = ANY(SELECT TM_ID FROM
SHIP_TO WHERE SHIP_TO_ID = ANY(SELECT SHIP_TO_ID FROM OA_SHIP_TO WHERE OA_ID
= ANY(SELECT  OA.OA_ID FROM ORDR_ORDER_ACCEPTANCE OA INNER JOIN ORDR_OA_BRANDPACK OOAB ON OOAB.OA_ID = OA.OA_ID WHERE OA.PO_REF_NO = @PO_REF_NO)))
END
GO

-----------------------------------------------------------------------------
--PROCEDURE UNTUK MENGAKSES PRIVILEGE
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Sp_Get_User_Privilege' AND TYPE = 'P')
DROP PROCEDURE Sp_Get_User_Privilege
GO
CREATE PROCEDURE Sp_Get_User_Privilege
@USER_ID VARCHAR(30)
AS
SELECT SYST_PRIVILEGE.[USER_ID],SYST_MENU.FORM_ID,SYST_MENU.FORM_NAME,SYST_PRIVILEGE.ALLOW_VIEW,SYST_PRIVILEGE.ALLOW_INSERT,SYST_PRIVILEGE.ALLOW_DELETE,
SYST_PRIVILEGE.ALLOW_UPDATE FROM SYST_MENU,SYST_PRIVILEGE
WHERE SYST_PRIVILEGE.FORM_ID = SYST_MENU.FORM_ID AND SYST_PRIVILEGE.[USER_ID] = @USER_ID
GO

--exec Sp_GetViewUser
--EXEC Sp_Get_User_Privilege @USER_ID = 'Nandar'
---------------------------------------------------------------------------------
--PROCEUDRE UNTUK MENDELETE SMS_TABLE
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Delete_Message' AND TYPE = 'P')
DROP PROCEDURE Usp_Delete_Message
GO
CREATE PROCEDURE Usp_Delete_Message
@ID UNIQUEIDENTIFIER
AS
BEGIN
	DELETE FROM SMS_Table WHERE [TransactionID] = CAST((@ID) AS VARCHAR(100))
END
GO
-------------------------------------------------------------------------------
--PROCEDURE UNTUK MENDELETE USER PRIVILEGE
----PROCEDURE UNTUK MENGINSERT BRANDPACK PO_DESCRIPTION
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Get_PO_Description' AND TYPE = 'P')
DROP PROCEDURE Usp_Get_PO_Description
GO
CREATE PROCEDURE Usp_Get_PO_Description
@PO_REF_NO VARCHAR(25)
AS
SELECT OPB.PO_ORIGINAL_QTY,BB.BRANDPACK_NAME,(OPB.PO_ORIGINAL_QTY * OPB.PO_PRICE_PERQTY) * 1.1 AS TOTAL
FROM ORDR_PO_BRANDPACK OPB INNER JOIN BRND_BRANDPACK BB ON BB.BRANDPACK_ID = OPB.BRANDPACK_ID
WHERE OPB.PO_REF_NO = @PO_REF_NO
GO
-----------------------------------------------------------------------------------------------
--PROCEDURE UNTUK MEMVIEW_PO_YANG BELUM DI SEND_SMS
IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_GetView_PO_SMS' AND TYPE = 'P')
DROP PROCEDURE Usp_GetView_PO_SMS
GO
CREATE PROCEDURE Usp_GetView_PO_SMS
AS
SET NOCOUNT ON;
DECLARE @ParamValue INT;
SELECT @ParamValue = CAST((SELECT ParamValue FROM RefBussinesRules WHERE CodeApp = 'MSC0001')AS INT);
SELECT PO.PO_REF_NO,PO.PO_REF_DATE,PO.DISTRIBUTOR_ID,DR.DISTRIBUTOR_NAME
FROM ORDR_PURCHASE_ORDER PO INNER JOIN DIST_DISTRIBUTOR DR ON PO.DISTRIBUTOR_ID = DR.DISTRIBUTOR_ID
WHERE (DR.HP IS NOT NULL AND DR.HP != '') AND
NOT EXISTS(SELECT PO_REF_NO FROM SMS_TABLE WHERE PO_REF_NO  = PO.PO_REF_NO)
AND EXISTS(SELECT PO_REF_NO FROM ORDR_PO_BRANDPACK WHERE PO_REF_NO = PO.PO_REF_NO)
AND DATEDIFF(DAY,PO.PO_REF_DATE,GETDATE()) <=  @ParamValue ;
GO
-----------------------------------------------------------------------------------------------------
--exec sp_executesql N'SET NOCOUNT ON ; 
--DECLARE @ParamValue INT ; 
--SELECT @ParamValue = CAST((SELECT ParamValue FROM RefBussinesRules WHERE CodeApp = ''MSC0001'')AS INT); 
--SELECT G.TransactionID,G.GON_NO,G.SPPB_NO,G.GON_DATE,G.PO_REF_NO,G.DISTRIBUTOR_ID,DR.DISTRIBUTOR_NAME,G.ITEM_DESCRIPTION,G.MESSAGE FROM 
--GON_SMS G
-- INNER JOIN DIST_DISTRIBUTOR DR ON G.DISTRIBUTOR_ID = DR.DISTRIBUTOR_ID WHERE G.STATUS_SENT IS NULL 
-- AND DATEDIFF(DAY,G.GON_DATE,@GETDATE) <= @ParamValue ;', N'@GETDATE datetime', @GETDATE = '08/05/2011'
-- SELECT TransactionID,CONTACT_MOBILE,MESSAGE FROM SMS_TABLE WHERE STATUS_SENT = 0 ORDER BY SENT_DATE DESC ;
--exec Usp_GetView_LOG_MESSAGE @FROM_DATE='2021-08-01 00:00:00',@UNTIL_DATE='2021-10-06 00:00:00',@STATUS_SENT=1

 Use Nufarm;
 GO
SELECT * FROM SMS_Table WHERE STATUS_SENT = 0;
SELECT * FROM GON_SMS WHERE STATUS_SENT = 0;
--SELECT * FROM SALES_PERSON_REMINDER WHERE STATUS_SENT = 0;
--UPDATE SMS_Table SET CONTACT_MOBILE = '08111758139',STATUS_SENT = 0
--WHERE TransactionID IN('2CC1FF80-F812-4CE4-BE85-C01B5E54D98E','F289BA66-9F51-4DD8-BAA3-284FC8723D9E')

--SELECT * FROM SMS_Table WHERE STATUS_SENT = 1 AND DAY(SENT_DATE) = DAY(GETDATE())
--ORDER BY SENT_DATE ASC

--UPDATE SMS_TABLE SET STATUS_SENT = 0 where DAY(SENT_DATE) = DAY(GETDATE())

--exec Usp_Get_PO_Description @PO_REF_NO = 'R20210141'
--DELETE FROM BRND_PRICE_HISTORY WHERE PRICE_TAG IN('00043001LD|30/7/2021','00043004LD|30/7/2021','00053001LD|30/7/2021',
--'00053004LD|30/7/2021',
--'00070001LD|7/30/2021',
--'00070004LD|30/7/2021',
--'00070100MD|30/7/2021',
--'00074020LD|30/7/2021',
--'00540001LD|30/7/2021',
--'00540004LD|30/7/2021',
--'00540020LD|30/7/2021',
--'00601001LD|30/7/2021',
--'0060200200MD|30/7/2021',
--'006020020LD|30/7/2021',
--'00604040LD|30/7/2021',
--'00681001LD|30/7/2021',
--'006820020LD|30/7/2021',
--'00684004LD|30/7/2021',
--'00780001LD|30/7/2021',
--'00780004LD|30/7/2021',
--'007801001LD|30/7/2021',
--'007804004LD|30/7/2021',
--'007820020LD|30/7/2021',
--'00790001LD|30/7/2021',
--'00790004LD|30/7/2021',
--'00793001LD|30/7/2021',
--'00793004LD|30/7/2021',
--'00798001LD|30/7/2021',
--'00798004LD|30/7/2021',
--'00798020LD|30/7/2021');