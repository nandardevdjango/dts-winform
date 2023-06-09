if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SalesOrdersDetail_2010]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SalesOrdersDetail_2010]
GO

CREATE TABLE [dbo].[SalesOrdersDetail_2010] (
	[IDApp] [bigint] IDENTITY (1, 1) NOT FOR REPLICATION  NOT NULL ,
	[CodeApp] [varchar] (24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TypeApp] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NameApp] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BrandPackCode] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Quantity] [decimal](16, 3) NULL ,
	[FKCode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CreatedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CreatedDate] [smalldatetime] NULL ,
	[ModifiedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ModifiedDate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

 CREATE  CLUSTERED  INDEX [IX_SalesOrdersDetail_2010_1] ON [dbo].[SalesOrdersDetail_2010]([BrandPackCode], [FKCode]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SalesOrdersDetail_2010] ADD 
	CONSTRAINT [PK_SalesOrdersDetail_2010] PRIMARY KEY  NONCLUSTERED 
	(
		[IDApp]
	)  ON [PRIMARY] ,
	CONSTRAINT [IX_SalesOrdersDetail_2010] UNIQUE  NONCLUSTERED 
	(
		[IDApp]
	)  ON [PRIMARY] 
GO

