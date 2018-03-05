CREATE TABLE [Map].[WorkflowIteamSubWorkflowIteam]
(
[WorkflowIteamSubWorkflowIteamID] [int] NOT NULL IDENTITY(1, 1),
[WorkflowItemID] [int] NOT NULL,
[SubWorkflowItemID] [int] NOT NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UUIDCode] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[SortOrder] [int] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_WorkflowIteamSubWorkflowIteam_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_WorkflowIteamSubWorkflowIteam_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_WorkflowIteamSubWorkflowIteam_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_WorkflowIteamSubWorkflowIteam_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Map].[WorkflowIteamSubWorkflowIteam] ADD CONSTRAINT [PK_WorkflowIteamSubWorkflowIteam] PRIMARY KEY CLUSTERED  ([WorkflowIteamSubWorkflowIteamID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[WorkflowIteamSubWorkflowIteam] ADD CONSTRAINT [FK_WorkflowIteamSubWorkflowIteam_SubWorkflowItem] FOREIGN KEY ([SubWorkflowItemID]) REFERENCES [Definition].[SubWorkflowItem] ([SubWorkflowItemID])
GO
ALTER TABLE [Map].[WorkflowIteamSubWorkflowIteam] ADD CONSTRAINT [FK_WorkflowIteamSubWorkflowIteam_WorkflowItem] FOREIGN KEY ([WorkflowItemID]) REFERENCES [Definition].[WorkflowItem] ([WorkflowItemID])
GO
