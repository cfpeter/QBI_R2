CREATE TABLE [Map].[WorkflowActionMap]
(
[WorkflowActionMapID] [bigint] NOT NULL IDENTITY(1, 1),
[WorkflowID] [bigint] NULL,
[ActionID] [int] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ActivityName] [nchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_WorkflowActionMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_WorkflowActionMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_WorkflowActionMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_WorkflowActionMap_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Map].[WorkflowActionMap] ADD CONSTRAINT [PK_WorkflowActionMap] PRIMARY KEY CLUSTERED  ([WorkflowActionMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[WorkflowActionMap] ADD CONSTRAINT [FK_WorkflowActionMap_Action] FOREIGN KEY ([ActionID]) REFERENCES [Definition].[Action] ([ActionID])
GO
