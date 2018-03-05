CREATE TABLE [Map].[ReportSubTypeRoleMap]
(
[ReportSubTypeRoleMapID] [int] NOT NULL IDENTITY(1, 1),
[ReportTypeID] [int] NOT NULL,
[ReportSubTypeID] [int] NOT NULL,
[RoleID] [int] NOT NULL,
[Description] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[CreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_ReportSubTypeRoleMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UpdatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_ReportSubTypeRoleMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ReportSubTypeRoleMap] ADD CONSTRAINT [PK_ReportSubTypeRoleMap] PRIMARY KEY CLUSTERED  ([ReportSubTypeRoleMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ReportSubTypeRoleMap] ADD CONSTRAINT [FK_ReportSubTypeRoleMap_ReportSubType] FOREIGN KEY ([ReportSubTypeID]) REFERENCES [Definition].[ReportSubType] ([ReportSubTypeID])
GO
ALTER TABLE [Map].[ReportSubTypeRoleMap] ADD CONSTRAINT [FK_ReportSubTypeRoleMap_ReportType] FOREIGN KEY ([ReportTypeID]) REFERENCES [Definition].[ReportType] ([ReportTypeID])
GO
ALTER TABLE [Map].[ReportSubTypeRoleMap] ADD CONSTRAINT [FK_ReportSubTypeRoleMap_Role] FOREIGN KEY ([RoleID]) REFERENCES [Definition].[Role] ([RoleID])
GO
