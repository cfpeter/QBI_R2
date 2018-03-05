CREATE TABLE [Report].[ProductReportDistribution]
(
[ProductReportDistributionID] [int] NOT NULL IDENTITY(1, 1),
[ReportTypeMapID] [int] NOT NULL,
[ProductID] [bigint] NULL,
[DistributionMask] [int] NULL,
[BarCode] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductReportDistribution_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ProductReportDistribution_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductReportDistribution_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ProductReportDistribution_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Report].[ProductReportDistribution] ADD CONSTRAINT [PK_ProductReportDistribution] PRIMARY KEY CLUSTERED  ([ProductReportDistributionID]) ON [PRIMARY]
GO
ALTER TABLE [Report].[ProductReportDistribution] ADD CONSTRAINT [FK_ProductReportDistribution_ReportTypeMap] FOREIGN KEY ([ReportTypeMapID]) REFERENCES [Map].[ReportTypeMap] ([ReportTypeMapID])
GO
