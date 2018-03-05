CREATE TABLE [Map].[ReportTypeRoleMap]
(
[ReportRoleMapID] [int] NOT NULL IDENTITY(1, 1),
[ReportTypeMapID] [int] NOT NULL,
[RoleID] [int] NOT NULL,
[Description] [dbo].[NOTE] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ReportTypeRoleMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ReportTypeRoleMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ReportTypeRoleMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ReportTypeRoleMap_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ReportTypeRoleMap] ADD CONSTRAINT [PK_ReportTypeRoleMap] PRIMARY KEY CLUSTERED  ([ReportRoleMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ReportTypeRoleMap] ADD CONSTRAINT [FK_ReportTypeRoleMap_ReportTypeMap] FOREIGN KEY ([ReportTypeMapID]) REFERENCES [Map].[ReportTypeMap] ([ReportTypeMapID])
GO
