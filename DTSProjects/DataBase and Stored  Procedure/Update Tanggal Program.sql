SELECT * FROM MRKT_MARKETING_PROGRAM WHERE PROGRAM_ID LIKE '035/PKPP%'

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION
BEGIN
UPDATE MRKT_MARKETING_PROGRAM SET START_DATE = '03/03/2010',END_DATE = '03/10/2010'
WHERE PROGRAM_ID = '035/PKPP/III/10'
IF (@@ERROR > 0)
  BEGIN
  ROLLBACK TRANSACTION; 
  RETURN;
  END
UPDATE MRKT_BRANDPACK
SET START_DATE = '03/03/2010',END_DATE = '03/10/2010'
WHERE PROGRAM_ID = '035/PKPP/III/10'
IF (@@ERROR > 0)
  BEGIN
  ROLLBACK TRANSACTION; 
  RETURN;
  END

UPDATE MRKT_BRANDPACK_DISTRIBUTOR
SET START_DATE = '03/03/2010',END_DATE = '03/10/2010'
WHERE PROG_BRANDPACK_ID IN(SELECT PROG_BRANDPACK_ID
FROM MRKT_BRANDPACK WHERE PROGRAM_ID = '035/PKPP/III/10')
IF (@@ERROR > 0)
  BEGIN
  ROLLBACK TRANSACTION; 
  RETURN;
  END
END
COMMIT TRANSACTION

