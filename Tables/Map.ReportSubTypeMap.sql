CREATE TABLE [Map].[ReportSubTypeMap]
(
[ReportSubTypeMapID] [int] NOT NULL IDENTITY(1, 1),
[ReportTypeID] [int] NOT NULL,
[ReportSubTypeID] [int] NOT NULL,
[IsActive] [bit] NULL,
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_ReportSubTypeMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UpdatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_ReportSubTypeMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ReportSubTypeMap] ADD CONSTRAINT [PK_ReportSubTypeMap] PRIMARY KEY CLUSTERED  ([ReportSubTypeMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ReportSubTypeMap] ADD CONSTRAINT [FK_ReportSubTypeMap_ReportSubType] FOREIGN KEY ([ReportSubTypeID]) REFERENCES [Definition].[ReportSubType] ([ReportSubTypeID])
GO
ALTER TABLE [Map].[ReportSubTypeMap] ADD CONSTRAINT [FK_ReportSubTypeMap_ReportType] FOREIGN KEY ([ReportTypeID]) REFERENCES [Definition].[ReportType] ([ReportTypeID])
GO
