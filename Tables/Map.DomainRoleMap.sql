CREATE TABLE [Map].[DomainRoleMap]
(
[DomainRoleMapID] [bigint] NOT NULL IDENTITY(1, 1),
[DomainGroupMapID] [int] NOT NULL,
[RoleID] [int] NOT NULL,
[SolutionID] [int] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_DomainRoleMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_DomainRoleMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_DomainRoleMap_UpdatedDateTine] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_DomainRoleMap_UpdatedBy] DEFAULT (user_name()),
[IsActive] [dbo].[TRUEFALSE] NULL CONSTRAINT [DF_DomainRoleMap_IsActive] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [Map].[DomainRoleMap] ADD CONSTRAINT [PK_DomainRoleMap] PRIMARY KEY CLUSTERED  ([DomainRoleMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[DomainRoleMap] ADD CONSTRAINT [FK_DomainRoleMap_DomainGroupMap] FOREIGN KEY ([DomainGroupMapID]) REFERENCES [Map].[DomainGroupMap] ([DomainGroupMapID])
GO
ALTER TABLE [Map].[DomainRoleMap] ADD CONSTRAINT [FK_DomainRoleMap_Role] FOREIGN KEY ([RoleID]) REFERENCES [Definition].[Role] ([RoleID])
GO
ALTER TABLE [Map].[DomainRoleMap] ADD CONSTRAINT [FK_DomainRoleMap_Solution] FOREIGN KEY ([SolutionID]) REFERENCES [Definition].[Solution] ([SolutionID])
GO
