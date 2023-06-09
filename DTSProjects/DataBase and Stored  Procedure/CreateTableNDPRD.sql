if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RecapNDPRD]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RecapNDPRD]
GO

CREATE TABLE [dbo].[RecapNDPRD] (
	[SPCode] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[TypeApp] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[BrandCode] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[TerritoryCode] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[BudgetTerritory] [decimal](18, 3) NOT NULL ,
	[BudgetDispro] [decimal](18, 4) NOT NULL ,
	[TotalCoverage] [decimal](18, 3) NOT NULL ,
	[TotalActual] [decimal](18, 3) NOT NULL ,
	[TotalDisc] [decimal](18, 4) NOT NULL ,
	[StartDate] [smalldatetime] NOT NULL ,
	[EndDate] [smalldatetime] NOT NULL ,
	[CreatedDate] [smalldatetime] NULL ,
	[CreatedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ModifiedDate] [smalldatetime] NULL ,
	[ModifiedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

 CREATE  CLUSTERED  INDEX [IX_TargetCoverage] ON [dbo].[RecapNDPRD]([SPCode], [StartDate], [EndDate], [TerritoryCode], [BrandCode]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[RecapNDPRD] ADD 
	CONSTRAINT [DF_TargetCoverage_TypeApp] DEFAULT ('DPRDS') FOR [TypeApp],
	CONSTRAINT [DF_TargetCoverage_BudgetTerritory] DEFAULT (0) FOR [BudgetTerritory],
	CONSTRAINT [DF_TargetCoverage_BudgetDispro] DEFAULT (0) FOR [BudgetDispro],
	CONSTRAINT [DF_TargetCoverage_TotalCoverage] DEFAULT (0) FOR [TotalCoverage],
	CONSTRAINT [DF_TargetCoverage_TotalActual] DEFAULT (0) FOR [TotalActual],
	CONSTRAINT [DF_TargetCoverage_TotalDisc] DEFAULT (0) FOR [TotalDisc],
	CONSTRAINT [PK_TargetCoverage] PRIMARY KEY  NONCLUSTERED 
	(
		[SPCode]
	)  ON [PRIMARY] 
GO

