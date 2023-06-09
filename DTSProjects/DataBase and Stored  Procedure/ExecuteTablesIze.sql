
--USE TEMPDB
--EXECUTE SP_SPACEUSED '##T_PRICE'
--DROP TABLe ##T_PRICE

--TRANSAKSI ITEM PKD 

USE Nufarm ;
GO
SELECT * INTO ##T_ITEM_PKD FROM AGREE_BRANDPACK_INCLUDE
WHERE YEAR(CREATE_DATE) >= 2010 AND YEAR(CREATE_DATE) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_ITEM_PKD';
DROP TABLE ##T_ITEM_PKD;
GO

--TRANSAKSI REGISTER DISPRO PKD
USE Nufarm ;
GO
SELECT * INTO ##T_DISPRO_PKD FROM AGREE_PROG_DISC
WHERE YEAR(CREATE_DATE) >= 2010 AND YEAR(CREATE_DATE) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_DISPRO_PKD';
DROP TABLE ##T_DISPRO_PKD;
GO

--TRANSAKSI ITEM OA
USE Nufarm;
GO

SELECT * INTO ##T_ITEM_OA FROM ORDR_OA_BRANDPACK
WHERE YEAR(CREATE_DATE) >= 2010 AND YEAR(CREATE_DATE) <= 2011;
GO
USE TEMPDB
GO
EXECUTE SP_SPACEUSED '##T_ITEM_OA'
DROP TABLE ##T_ITEM_OA
GO

--TRANSAKSI PO
USE Nufarm;
GO
SELECT * INTO ##T_TRANSAKSI_PO FROM ORDR_ORDER_ACCEPTANCE WHERE YEAR(CREATE_DATE) >=2010
AND YEAR(CREATE_DATE) <= 2011; 
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_TRANSAKSI_PO'
DROP TABLE ##T_TRANSAKSI_PO
GO

--TRANSAKSI ITEM SPPB
USE Nufarm ;
GO
SELECT * INTO ##T_ITEM_SPPB FROM SPPB_BRANDPACK WHERE YEAR(CREATE_DATE) >= 2010
AND YEAR(CREATE_DATE) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_ITEM_SPPB'
DROP TABLE ##T_ITEM_SPPB
GO

--TRANSAKSI SPPB HEADER
USE Nufarm ;
GO

SELECT * INTO ##T_TRANSAKSI_SPPB_HEADER FROM SPPB_HEADER WHERE YEAR(CREATE_DATE) >= 2010
AND YEAR(CREATE_DATE) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_TRANSAKSI_SPPB_HEADER'
DROP TABLE ##T_TRANSAKSI_SPPB_HEADER
GO
--TRANSAKSI SAVING GENERATE DISCOUNT Q1/Q2/Q3/Q4/Y
USE Nufarm ;
GO
SELECT * INTO ##T_SAVING_PKD FROM ACCRUED_DETAIL 
WHERE YEAR(CREATE_DATE) >= 2010 AND YEAR(CREATE_DATE) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_SAVING_PKD'
DROP TABLE ##T_SAVING_PKD
GO


--TRANSAKSI REGISTER SALES PROGRAM
USE Nufarm ;
GO
SELECT * INTO ##T_SALES_PROGRAM FROM MRKT_BRANDPACK_DISTRIBUTOR
WHERE YEAR(CREATE_DATE) >= 2010 AND YEAR(CREATE_DATE) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_SALES_PROGRAM';
DROP TABLE ##T_SALES_PROGRAM;
GO

--TRANSAKSI REGISTER PLANTATION_PRICE
USE Nufarm ;
GO
SELECT * INTO ##T_REG_PLANT_PRICE FROM DIST_PLANT_PRICE WHERE YEAR(CREATE_DATE) >= 2010
AND YEAR(CREATE_DATE) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_REG_PLANT_PRICE';
DROP TABLE ##T_REG_PLANT_PRICE;
GO

--TRANSAKSI DPRD DI REKAP KE DTS
USE Nufarm ;
GO
EXECUTE SP_SPACEUSED 'SalesOrdersDetail_2010';
GO

--TRANSAKSI BONUS DPRDS DI REKAP KE DTS
SELECT * INTO ##T_BONUS_DPRD FROM DetailReaching WHERE YEAR(CreatedDate) >= 2010
AND YEAR(CreatedDate) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_BONUS_DPRD';
DROP TABLE ##T_BONUS_DPRD;
GO

--DATA MASTER DTS
--1 DISTRIBUTOR
USE Nufarm ;
GO
EXECUTE SP_SPACEUSED 'DIST_DISTRIBUTOR'

--2 PRODUCT
SELECT * INTO ##T_PRODUCT FROM BRND_BRANDPACK WHERE YEAR(CREATE_DATE)>= 2009
AND YEAR(CREATE_DATE) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_PRODUCT';
DROP TABLE ##T_PRODUCT;
GO

--3 KIOS
USE Nufarm ;
GO
SELECT * INTO ##T_TEMP_KIOS FROM [Kios] WHERE YEAR(CreatedDate) >= 2010
AND YEAR(CreatedDate) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_TEMP_KIOS';
DROP TABLE ##T_TEMP_KIOS;
GO

--PRICE 
USE Nufarm ;
GO
SELECT * INTO ##T_GENERATE_PRICE FROM BRND_PRICE_HISTORY WHERE YEAR(CREATE_DATE) >= 2009
AND YEAR(CREATE_DATE) <= 2011;
GO
USE TEMPDB;
GO
EXECUTE SP_SPACEUSED '##T_GENERATE_PRICE';
DROP TABLE ##T_GENERATE_PRICE;
GO






