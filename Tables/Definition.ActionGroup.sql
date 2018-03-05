CREATE TABLE [Definition].[ActionGroup]
(
[ActionGroupID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ActionGroup_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ActionGroup_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ActionGroup_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ActionGroup_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[ActionGroup] ADD CONSTRAINT [PK_ActionGroup] PRIMARY KEY CLUSTERED  ([ActionGroupID]) ON [PRIMARY]
GO
