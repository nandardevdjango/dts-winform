IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VIEW_SPPB_ALL')
DROP VIEW VIEW_SPPB_ALL
GO
CREATE VIEW VIEW_SPPB_ALL
AS
SELECT OPO.DISTRIBUTOR_ID,DR.DISTRIBUTOR_NAME,OPO.PO_REF_NO,OOA.OA_ID AS OA_REF_NO,ST.TERRITORY_AREA AS SHIP_TO,ST.MANAGER,
OPO.PO_REF_DATE,OPB.BRANDPACK_ID,B.BRAND_NAME,BB.BRANDPACK_NAME,OPB.PO_ORIGINAL_QTY,OOB.QTY_EVEN + ISNULL(OOBD.DISC_QTY,0) AS OA_QTY
,OOB.OA_BRANDPACK_ID,SB.SPPB_NO,SB.SPPB_DATE,ISNULL(SB.SPPB_QTY,0)AS SPPB_QTY,SB.CREATE_DATE,SB.RELEASE_DATE,SB.LEAD_TIME,SB.GON_1_NO,SB.GON_1_DATE,SB.GON_1_QTY,
SB.GON_2_NO,SB.GON_2_DATE,SB.GON_2_QTY,SB.GON_3_NO,SB.GON_3_DATE,SB.GON_3_QTY,SB.GON_4_NO,SB.GON_4_DATE,
SB.GON_4_QTY,SB.GON_5_NO,SB.GON_5_DATE,SB.GON_5_QTY,SB.GON_6_NO,SB.GON_6_DATE,SB.GON_6_QTY,
SB.STATUS,SB.BALANCE,SB.ISREVISION,SB.REMARK,OTP.OTP_NO,OTP.OTP_DATE,OTP.OTP_QTY,OTP.CREATE_DATE AS OTP_CREATE_DATE,DTP.DO_TP_NO,DTP.DO_TP_DATE,
DTP.DO_TP_QTY
FROM ORDR_PURCHASE_ORDER OPO INNER JOIN DIST_DISTRIBUTOR DR ON OPO.DISTRIBUTOR_ID = DR.DISTRIBUTOR_ID
  INNER JOIN ORDR_ORDER_ACCEPTANCE OOA ON OOA.PO_REF_NO = OPO.PO_REF_NO
INNER JOIN ORDR_PO_BRANDPACK OPB
ON OPO.PO_REF_NO = OPB.PO_REF_NO INNER JOIN BRND_BRANDPACK BB ON OPB.BRANDPACK_ID = BB.BRANDPACK_ID
INNER JOIN BRND_BRAND B ON B.BRAND_ID = BB.BRAND_ID
INNER JOIN ORDR_OA_BRANDPACK OOB ON OPB.PO_BRANDPACK_ID = OOB.PO_BRANDPACK_ID AND OOB.OA_ID = OOA.OA_ID
LEFT OUTER JOIN (SELECT SH.SPPB_NO,SH.SPPB_DATE,SB1.OA_BRANDPACK_ID,SB1.SPPB_QTY,SB1.CREATE_DATE,SB1.RELEASE_DATE, DATEDIFF(DAY,SB1.CREATE_DATE,ISNULL(SB1.RELEASE_DATE,SB1.CREATE_DATE)) AS LEAD_TIME,
SB1.GON_1_NO,SB1.GON_1_DATE,SB1.GON_1_QTY,
		 SB1.GON_2_NO,SB1.GON_2_DATE,SB1.GON_2_QTY,SB1.GON_3_NO,SB1.GON_3_DATE,SB1.GON_3_QTY,SB1.GON_4_NO,SB1.GON_4_DATE,
		 SB1.GON_4_QTY,SB1.GON_5_NO,SB1.GON_5_DATE,SB1.GON_5_QTY,SB1.GON_6_NO,SB1.GON_6_DATE,SB1.GON_6_QTY,
		 SB1.STATUS,SB1.BALANCE,SB1.ISREVISION,SB1.REMARK FROM SPPB_HEADER SH INNER JOIN SPPB_BRANDPACK SB1 ON SH.SPPB_NO = SB1.SPPB_NO
                )SB
ON OOB.OA_BRANDPACK_ID = SB.OA_BRANDPACK_ID
LEFT OUTER JOIN (SELECT OOH.OTP_NO,OOH.OTP_DATE,OD.OTP_QTY,OD.CREATE_DATE,OD.OA_BRANDPACK_ID FROM ORDR_OTP_HEADER OOH INNER JOIN OTP_DETAIL OD
	         ON OD.OTP_NO = OOH.OTP_NO
                )OTP 
ON SB.OA_BRANDPACK_ID = OTP.OA_BRANDPACK_ID
LEFT OUTER JOIN (SELECT DTH.DO_TP_NO,DTH.DO_TP_DATE,DTD.DO_TP_QTY,DTD.OA_BRANDPACK_ID FROM DO_TP_HEADER DTH
		  INNER JOIN DO_TP_DETAIL DTD ON DTH.DO_TP_NO = DTD.DO_TP_NO
   		)DTP
ON OTP.OA_BRANDPACK_ID = DTP.OA_BRANDPACK_ID
LEFT OUTER JOIN (SELECT OST.OA_ID,TERR.TERRITORY_AREA,TM.MANAGER
                 FROM OA_SHIP_TO OST INNER JOIN SHIP_TO ST ON OST.SHIP_TO_ID = ST.SHIP_TO_ID
                 INNER JOIN TERRITORY TERR ON TERR.TERRITORY_ID = ST.TERRITORY_ID
                 INNER JOIN TERRITORY_MANAGER TM ON ST.TM_ID = TM.TM_ID
                 )ST
ON OOB.OA_ID = ST.OA_ID
LEFT OUTER JOIN(SELECT OA_BRANDPACK_ID,SUM(DISC_QTY)AS DISC_QTY FROM ORDR_OA_BRANDPACK_DISC
                WHERE GQSY_SGT_P_FLAG = 'RMOA'
		GROUP BY OA_BRANDPACK_ID HAVING SUM(DISC_QTY) > 0
                )OOBD
ON OOB.OA_BRANDPACK_ID = OOBD.OA_BRANDPACK_ID 
WHERE YEAR(OPO.PO_REF_DATE) >= YEAR(GETDATE()) -1
GO

IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Create_View_SPPB_Detail' AND TYPE = 'P')
DROP PROCEDURE Usp_Create_View_SPPB_Detail
GO
CREATE PROCEDURE Usp_Create_View_SPPB_Detail
@DISTRIBUTOR_ID VARCHAR(10),
@FROM_PO_DATE DATETIME,
@UNTIL_PO_DATE DATETIME,
@CATEGORY_DATE VARCHAR(14)
AS
IF (@CATEGORY_DATE = 'ByPO')
   BEGIN
	IF ((@FROM_PO_DATE IS NOT NULL) AND (@UNTIL_PO_DATE IS NOT NULL))
	     BEGIN
		IF (@DISTRIBUTOR_ID IS NOT NULL)
		    BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,
			BRANDPACK_NAME,PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID
			AND PO_REF_DATE >= @FROM_PO_DATE AND PO_REF_DATE <= @UNTIL_PO_DATE
		    END
		ELSE
		    BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,
			BRANDPACK_NAME,PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE PO_REF_DATE >= @FROM_PO_DATE AND PO_REF_DATE <= @UNTIL_PO_DATE
		    END
	     END
	ELSE IF((@FROM_PO_DATE IS NOT NULL) AND (@UNTIL_PO_DATE IS NOT NULL))
		BEGIN
		   IF(@DISTRIBUTOR_ID IS NOT NULL)
		     BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,BRANDPACK_NAME,PO_ORIGINAL_QTY,OA_QTY,
			OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID
			AND PO_REF_DATE >= @FROM_PO_DATE
		     END
		   ELSE
		     BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,BRANDPACK_NAME,
			PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE PO_REF_DATE >= @FROM_PO_DATE
		     END
		END
	ELSE IF ((@FROM_PO_DATE IS NULL) AND (@UNTIL_PO_DATE IS NOT NULL))
		BEGIN
		   IF (@DISTRIBUTOR_ID IS NOT NULL)
		     BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,BRANDPACK_NAME,
			PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID
			AND PO_REF_DATE <= @UNTIL_PO_DATE
		     END
		   ELSE
		     BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,BRANDPACK_NAME,
			PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE PO_REF_DATE <= @UNTIL_PO_DATE
		     END
		END
	ELSE IF ((@FROM_PO_DATE IS NULL) AND (@UNTIL_PO_DATE IS NULL))
		BEGIN
		    IF(@DISTRIBUTOR_ID IS NOT NULL)
		      BEGIN
			 SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID, BRANDPACK_NAME,
			 PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			 GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			 GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			 FROM VIEW_SPPB_ALL VSA WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID
		      END
		     ELSE
		       BEGIN
			  SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID, BRANDPACK_NAME,
			  PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			  GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			  GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			  FROM VIEW_SPPB_ALL VSA 
		       END	
		END
	
   END

ELSE
   BEGIN
	IF ((@FROM_PO_DATE IS NOT NULL) AND (@UNTIL_PO_DATE IS NOT NULL))
	     BEGIN
		IF (@DISTRIBUTOR_ID IS NOT NULL)
		    BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,
			BRANDPACK_NAME,PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID
			AND SPPB_DATE >= @FROM_PO_DATE AND SPPB_DATE <= @UNTIL_PO_DATE
		    END
		ELSE
		    BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,
			BRANDPACK_NAME,PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE SPPB_DATE >= @FROM_PO_DATE AND SPPB_DATE <= @UNTIL_PO_DATE
		    END
	     END
	ELSE IF((@FROM_PO_DATE IS NOT NULL) AND (@UNTIL_PO_DATE IS NOT NULL))
		BEGIN
		   IF(@DISTRIBUTOR_ID IS NOT NULL)
		     BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,BRANDPACK_NAME,PO_ORIGINAL_QTY,OA_QTY,
			OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID
			AND SPPB_DATE >= @FROM_PO_DATE
		     END
		   ELSE
		     BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,BRANDPACK_NAME,
			PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE SPPB_DATE >= @FROM_PO_DATE
		     END
		END
	ELSE IF ((@FROM_PO_DATE IS NULL) AND (@UNTIL_PO_DATE IS NOT NULL))
		BEGIN
		   IF (@DISTRIBUTOR_ID IS NOT NULL)
		     BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,BRANDPACK_NAME,
			PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID
			AND SPPB_DATE <= @UNTIL_PO_DATE
		     END
		   ELSE
		     BEGIN
			SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID,BRANDPACK_NAME,
			PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			FROM VIEW_SPPB_ALL VSA WHERE SPPB_DATE <= @UNTIL_PO_DATE
		     END
		END
	ELSE IF ((@FROM_PO_DATE IS NULL) AND (@UNTIL_PO_DATE IS NULL))
		BEGIN
		    IF(@DISTRIBUTOR_ID IS NOT NULL)
		      BEGIN
			 SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID, BRANDPACK_NAME,
			 PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			 GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			 GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			 FROM VIEW_SPPB_ALL VSA WHERE DISTRIBUTOR_ID = @DISTRIBUTOR_ID
		      END
		     ELSE
		       BEGIN
			  SELECT DISTRIBUTOR_ID,DISTRIBUTOR_NAME,SHIP_TO,MANAGER,PO_REF_NO,PO_REF_DATE,OA_REF_NO,BRAND_NAME,BRANDPACK_ID, BRANDPACK_NAME,
			  PO_ORIGINAL_QTY,OA_QTY,OA_BRANDPACK_ID,ISNULL(SPPB_NO,'Undefined')AS SPPB_NO,SPPB_DATE,SPPB_QTY,CREATE_DATE,RELEASE_DATE,LEAD_TIME,GON_1_NO,GON_1_DATE,GON_1_QTY,
			  GON_2_NO,GON_2_DATE,GON_2_QTY,GON_3_NO,GON_3_DATE,GON_3_QTY,GON_4_NO,GON_4_DATE,GON_4_QTY,
			  GON_5_NO,GON_5_DATE,GON_5_QTY,GON_6_NO,GON_6_DATE,GON_6_QTY,ISNULL(STATUS,'PENDING')AS STATUS,ISNULL(BALANCE,0)AS BALANCE,ISREVISION,REMARK
			  FROM VIEW_SPPB_ALL VSA 
		       END	
		END
	
   END	
GO

IF EXISTS(SELECT NAME FROM DBO.SYSOBJECTS WHERE NAME = 'Usp_Create_View_SPPB_Detail_Entry' AND TYPE = 'P')
DROP PROCEDURE Usp_Create_View_SPPB_Detail_Entry
GO
CREATE PROCEDURE Usp_Create_View_SPPB_Detail_Entry
@SPPB_NO VARCHAR(15)
AS
SET NOCOUNT ON;
SELECT OPB.BRANDPACK_ID,SB.OA_BRANDPACK_ID,SB.SPPB_BRANDPACK_ID,
SB.SPPB_NO,SB.SPPB_QTY,SB.GON_1_NO,SB.GON_1_DATE,SB.GON_1_QTY,SB.GON_2_NO,SB.GON_2_DATE,SB.GON_2_QTY,
SB.GON_3_NO,SB.GON_3_DATE,SB.GON_3_QTY,SB.GON_4_NO,SB.GON_4_DATE,SB.GON_4_QTY,SB.GON_5_NO,SB.GON_5_DATE,SB.GON_5_QTY,
SB.GON_6_NO,SB.GON_6_DATE,SB.GON_6_QTY,SB.STATUS,SB.BALANCE,SB.REMARK,SB.ISREVISION,SB.CREATE_BY,SB.CREATE_DATE,SB.RELEASE_DATE,SB.MODIFY_BY,SB.MODIFY_DATE 
FROM  ORDR_PO_BRANDPACK OPB  INNER JOIN ORDR_OA_BRANDPACK OOB
ON OOB.PO_BRANDPACK_ID = OPB.PO_BRANDPACK_ID 
INNER JOIN SPPB_BRANDPACK SB ON  SB.OA_BRANDPACK_ID = OOB.OA_BRANDPACK_ID
WHERE SB.SPPB_NO = @SPPB_NO
GO

--exec Usp_Create_View_SPPB_Detail @DISTRIBUTOR_ID = NULL, @CATEGORY_DATE = 'BySPPB', @FROM_PO_DATE = 'Aug 17 2011', @UNTIL_PO_DATE = 'Dec 15 2011'