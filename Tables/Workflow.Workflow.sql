CREATE TABLE [Workflow].[Workflow]
(
[WorkflowID] [int] NOT NULL IDENTITY(1, 1),
[WorkflowTypeID] [int] NOT NULL,
[ConfigID] [int] NULL,
[ProductTypeMapID] [int] NULL,
[WorkflowItemID] [int] NULL,
[PredecessorWorkflowID] [int] NULL,
[SuccessorWorkflowID] [int] NULL,
[Name] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TemplateName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UUIDCode] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ApprovalRequired] [bit] NULL,
[HasSubWorkflow] [bit] NULL,
[IsActive] [bit] NULL,
[SortOrder] [int] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Workflow_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Workflow_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Workflow_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Workflow_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL,
[DurationByDays] [int] NULL,
[CompletionOption] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Workflow].[Workflow] ADD CONSTRAINT [PK_Workflow] PRIMARY KEY CLUSTERED  ([WorkflowID]) ON [PRIMARY]
GO
ALTER TABLE [Workflow].[Workflow] ADD CONSTRAINT [FK_Workflow_Config] FOREIGN KEY ([ConfigID]) REFERENCES [Workflow].[Config] ([ConfigID])
GO
ALTER TABLE [Workflow].[Workflow] ADD CONSTRAINT [FK_Workflow_WorkflowItem] FOREIGN KEY ([WorkflowItemID]) REFERENCES [Definition].[WorkflowItem] ([WorkflowItemID])
GO
ALTER TABLE [Workflow].[Workflow] ADD CONSTRAINT [FK_Workflow_WorkflowType] FOREIGN KEY ([WorkflowTypeID]) REFERENCES [Definition].[WorkflowType] ([WorkflowTypeID])
GO
