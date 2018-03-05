CREATE TABLE [Temp].[ReportProduct]
(
[ReportProductID] [bigint] NOT NULL IDENTITY(1, 1),
[ReportID] [bigint] NOT NULL,
[ReportSubTypeID] [bigint] NOT NULL,
[ProductID] [bigint] NULL,
[ClientID] [int] NULL,
[EIN] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Type] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Attention] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StateID] [int] NULL,
[ZipCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DistributionTypeID] [bigint] NULL,
[OptionList] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RunDate] [datetime] NOT NULL,
[FileName] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ReportProduct_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ReportProduct_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ReportProduct_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ReportProduct_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Temp].[ReportProduct] ADD CONSTRAINT [PK_ReportProduct] PRIMARY KEY CLUSTERED  ([ReportProductID]) ON [PRIMARY]
GO
ALTER TABLE [Temp].[ReportProduct] ADD CONSTRAINT [FK_ReportProduct_StateID] FOREIGN KEY ([StateID]) REFERENCES [Definition].[State] ([StateID])
GO
