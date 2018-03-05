CREATE TABLE [Definition].[ReportType]
(
[ReportTypeID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ReportType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ReportType_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ReportType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ReportType_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[ReportType] ADD CONSTRAINT [PK_ReportType] PRIMARY KEY CLUSTERED  ([ReportTypeID]) ON [PRIMARY]
GO
