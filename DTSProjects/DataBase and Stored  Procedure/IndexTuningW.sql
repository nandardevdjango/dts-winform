/* Created by: Index Tuning Wizard 	*/
/* Date: 03/02/2010 			*/
/* Time: 10:15:52 			*/
/* Server Name: DTS 			*/
/* Database Name: Nufarm 			*/
/* Workload File Name: D:\my sojftware\my document\DTS\Discount Tracking System\DTSProjects\DataBase and Stored  Procedure\View.sql */


USE [Nufarm] 
go

SET QUOTED_IDENTIFIER ON 
SET ARITHABORT ON 
SET CONCAT_NULL_YIELDS_NULL ON 
SET ANSI_NULLS ON 
SET ANSI_PADDING ON 
SET ANSI_WARNINGS ON 
SET NUMERIC_ROUNDABORT OFF 
go

DECLARE @bErrors as bit

BEGIN TRANSACTION
SET @bErrors = 0

DROP INDEX [dbo].[ORDR_OA_BRANDPACK].[IX_ORDR_OA_BRANDPACK_1]
DROP INDEX [dbo].[ORDR_OA_BRANDPACK].[IX_ORDR_OA_BRANDPACK]
IF( @bErrors = 0 )
  COMMIT TRANSACTION
ELSE
  ROLLBACK TRANSACTION

BEGIN TRANSACTION
SET @bErrors = 0

DROP INDEX [dbo].[ORDR_OA_BRANDPACK_DISC].[IX_ORDR_OA_BRANDPACK_DISC]
DROP INDEX [dbo].[ORDR_OA_BRANDPACK_DISC].[IX_ORDR_OA_BRANDPACK_DISC_6]
DROP INDEX [dbo].[ORDR_OA_BRANDPACK_DISC].[IX_ORDR_OA_BRANDPACK_DISC_4]
DROP INDEX [dbo].[ORDR_OA_BRANDPACK_DISC].[IX_ORDR_OA_BRANDPACK_DISC_5]
DROP INDEX [dbo].[ORDR_OA_BRANDPACK_DISC].[IX_ORDR_OA_BRANDPACK_DISC_1]
DROP INDEX [dbo].[ORDR_OA_BRANDPACK_DISC].[IX_ORDR_OA_BRANDPACK_DISC_2]
DROP INDEX [dbo].[ORDR_OA_BRANDPACK_DISC].[IX_ORDR_OA_BRANDPACK_DISC_3]
DROP INDEX [dbo].[ORDR_OA_BRANDPACK_DISC].[IX_ORDR_OA_BRANDPACK_DISC_7]
IF( @bErrors = 0 )
  COMMIT TRANSACTION
ELSE
  ROLLBACK TRANSACTION

BEGIN TRANSACTION
SET @bErrors = 0

DROP INDEX [dbo].[SPPB_BRANDPACK].[IX_SPPB_BRANDPACK]
DROP INDEX [dbo].[SPPB_BRANDPACK].[IX_SPPB_BRANDPACK_1]
DROP INDEX [dbo].[SPPB_BRANDPACK].[IX_SPPB_BRANDPACK_2]
IF( @bErrors = 0 )
  COMMIT TRANSACTION
ELSE
  ROLLBACK TRANSACTION

BEGIN TRANSACTION
SET @bErrors = 0

DROP INDEX [dbo].[ORDR_PO_BRANDPACK].[IX_ORDR_PO_BRANDPACK]
DROP INDEX [dbo].[ORDR_PO_BRANDPACK].[IX_ORDR_PO_BRANDPACK_1]
IF( @bErrors = 0 )
  COMMIT TRANSACTION
ELSE
  ROLLBACK TRANSACTION

BEGIN TRANSACTION
SET @bErrors = 0

DROP INDEX [dbo].[ORDR_ORDER_ACCEPTANCE].[IX_ORDR_ORDER_ACCEPTANCE_1]
DROP INDEX [dbo].[ORDR_ORDER_ACCEPTANCE].[IX_ORDR_ORDER_ACCEPTANCE]
IF( @bErrors = 0 )
  COMMIT TRANSACTION
ELSE
  ROLLBACK TRANSACTION

BEGIN TRANSACTION
SET @bErrors = 0

DROP INDEX [dbo].[ORDR_PURCHASE_ORDER].[IX_ORDR_PURCHASE_ORDER_1]
DROP INDEX [dbo].[ORDR_PURCHASE_ORDER].[IX_ORDR_PURCHASE_ORDER]
IF( @bErrors = 0 )
  COMMIT TRANSACTION
ELSE
  ROLLBACK TRANSACTION

BEGIN TRANSACTION
SET @bErrors = 0

DROP INDEX [dbo].[ORDR_OA_REMAINDING].[IX_ORDR_OA_REMAINDING]
DROP INDEX [dbo].[ORDR_OA_REMAINDING].[IX_ORDR_OA_REMAINDING_2]
DROP INDEX [dbo].[ORDR_OA_REMAINDING].[IX_ORDR_OA_REMAINDING_1]
IF( @bErrors = 0 )
  COMMIT TRANSACTION
ELSE
  ROLLBACK TRANSACTION

BEGIN TRANSACTION
SET @bErrors = 0

DROP INDEX [dbo].[SPPB_HEADER].[IX_SPPB_HEADER]
DROP INDEX [dbo].[SPPB_HEADER].[IX_SPPB_HEADER_1]
IF( @bErrors = 0 )
  COMMIT TRANSACTION
ELSE
  ROLLBACK TRANSACTION

BEGIN TRANSACTION
SET @bErrors = 0

DROP INDEX [dbo].[BRND_BRANDPACK].[IX_BRND_BRANDPACK_1]
DROP INDEX [dbo].[BRND_BRANDPACK].[IX_BRND_BRANDPACK]
IF( @bErrors = 0 )
  COMMIT TRANSACTION
ELSE
  ROLLBACK TRANSACTION

