IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Trigger_PO_BrandPack'
	AND TYPE = 'TR')
DROP TRIGGER Trigger_PO_BrandPack 
GO
CREATE TRIGGER ON ORDR_PO_BRANDPACK FOR INSERT,UPDATE
AS
DECLARE @V_PO_ORIGINAL_QTY DECIMAL(18,3),@V_PO_BRANDPACK_ID VARCHAR(39),
@V_OA_BRANDPACK_ID VARCHAR(70),@V_RC INT,@V_QTY_EVEN DECIMAL(18,3),@V_LEFT_QTY DECIMAL(18,3)
,@V_DEVIDED_QTY DECIMAL(18,3)

SET @V_RC = @@ROWCOUNT
IF (@V_RC = 0)
   BEGIN
	PRINT 'No rows affected'
   	RETURN
   END
IF EXISTS(SELECT * FROM Inserted)
   BEGIN
      IF EXISTS(SELECT * FROM Updated)
	 BEGIN
	    SET @V_PO_ORIGINAL_QTY = (SELECT PO_ORGINAL_QTY FROM Inserted)
	    SET @V_PO_BRANDPACK_ID = (SELECT PO_BRANDPACK_ID FROM Inserted)
	    IF (SELECT COUNT(OA_BRANDPACK_ID) FROM ORDR_OA_BRANDPACK WHERE PO_BRANDPACK_ID
  		= @V_PO_BRANDPACK_ID) = 1
		BEGIN
		  SET @V_OA_BRANDPACK_ID = (SELECT OA_BRANDPACK_ID  FROM ORDR_OA_BRANDPACK WHERE PO_BRANDPACK_ID
  		   = @V_PO_BRANDPACK_ID)
		  UPDATE OA_BRANDPACK_ID SET OA_ORIGINAL_QTY = @V_PO_ORIGINAL_QTY,PROG_BRANDPACK_DISC
		  WHERE OA_BRANDPACK_ID = @V_OA_BRANDPACK_ID)
			 	
		END	    
	 END
   END
 	
  		


