CREATE TABLE [Map].[RoleActionMap]
(
[RoleActionID] [int] NOT NULL IDENTITY(1, 1),
[RoleID] [int] NOT NULL,
[ActionID] [int] NOT NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_RoleActionMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_RoleActionMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_RoleActionMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_RoleActionMap_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Map].[RoleActionMap] ADD CONSTRAINT [PK_RoleActionMap] PRIMARY KEY CLUSTERED  ([RoleActionID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[RoleActionMap] ADD CONSTRAINT [FK_RoleActionMap_Action] FOREIGN KEY ([ActionID]) REFERENCES [Definition].[Action] ([ActionID])
GO
ALTER TABLE [Map].[RoleActionMap] ADD CONSTRAINT [FK_RoleActionMap_Role] FOREIGN KEY ([RoleID]) REFERENCES [Definition].[Role] ([RoleID])
GO
