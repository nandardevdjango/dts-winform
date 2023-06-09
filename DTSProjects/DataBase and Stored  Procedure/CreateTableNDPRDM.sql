SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[RecapDPRDM]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[RecapDPRDM](
	[SPCode] [varchar](16) NOT NULL,
	[TypeApp] [varchar](32) NULL,
	[BrandCode] [varchar](16) NOT NULL,
	[TerritoryCode] [varchar](16) NOT NULL,
	[BudgetTerritory] [decimal](18, 3) NOT NULL CONSTRAINT [DF_NRecapDPRDM_BudgetTerritory]  DEFAULT (0),
	[BudgetDispro] [decimal](18, 2) NOT NULL CONSTRAINT [DF_NRecapDPRDM_BudgetDispro]  DEFAULT (0),
	[TotalCoverage] [decimal](18, 3) NOT NULL CONSTRAINT [DF_NRecapDPRDM_TotalCoverage]  DEFAULT (0),
	[TotalActual] [decimal](18, 3) NOT NULL CONSTRAINT [DF_NRecapDPRDM_TotalActual]  DEFAULT (0),
	[TotalBonus] [decimal](18, 2) NOT NULL CONSTRAINT [DF_NRecapDPRDM_TotalDisc]  DEFAULT (0),
	[StartDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedDate] [smalldatetime] NULL,
 CONSTRAINT [PK_NRecapDPRDM] PRIMARY KEY NONCLUSTERED 
(
	[SPCode] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[RecapDPRDM]') AND name = N'IX_NRecapDPRDM')
CREATE CLUSTERED INDEX [IX_NRecapDPRDM] ON [dbo].[RecapDPRDM] 
(
	[SPCode] ASC,
	[BrandCode] ASC,
	[StartDate] ASC,
	[EndDate] ASC,
	[TerritoryCode] ASC
) ON [PRIMARY]
