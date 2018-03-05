CREATE TABLE [Definition].[Action]
(
[ActionID] [int] NOT NULL IDENTITY(1, 1),
[ActionGroupID] [int] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Label] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Handler] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Action_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Action_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Action_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Action_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[Action] ADD CONSTRAINT [PK_Action] PRIMARY KEY CLUSTERED  ([ActionID]) ON [PRIMARY]
GO
ALTER TABLE [Definition].[Action] ADD CONSTRAINT [FK_Action_ActionGroup] FOREIGN KEY ([ActionGroupID]) REFERENCES [Definition].[ActionGroup] ([ActionGroupID])
GO
