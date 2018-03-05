CREATE TABLE [Map].[ReportTypeMap]
(
[ReportTypeMapID] [int] NOT NULL IDENTITY(1, 1),
[ReportTypeID] [int] NOT NULL,
[ReportSubTypeID] [int] NOT NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ReportTypeMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ReportTypeMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ReportTypeMap] ADD CONSTRAINT [PK_ReportTypeMap] PRIMARY KEY CLUSTERED  ([ReportTypeMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ReportTypeMap] ADD CONSTRAINT [FK_ReportTypeMap_ReportSubType] FOREIGN KEY ([ReportSubTypeID]) REFERENCES [Definition].[ReportSubType] ([ReportSubTypeID])
GO
ALTER TABLE [Map].[ReportTypeMap] ADD CONSTRAINT [FK_ReportTypeMap_ReportType] FOREIGN KEY ([ReportTypeID]) REFERENCES [Definition].[ReportType] ([ReportTypeID])
GO
