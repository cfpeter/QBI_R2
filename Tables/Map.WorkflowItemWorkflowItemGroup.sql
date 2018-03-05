CREATE TABLE [Map].[WorkflowItemWorkflowItemGroup]
(
[WorkflowItemWorkflowItemGroupID] [int] NOT NULL IDENTITY(1, 1),
[WorkflowItemID] [int] NOT NULL,
[WorkflowItemGroupID] [int] NOT NULL,
[Name] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UUIDCode] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[SortOrder] [int] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_WorkflowItemWorkflowItemGroup_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_WorkflowItemWorkflowItemGroup_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_WorkflowItemWorkflowItemGroup_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_WorkflowItemWorkflowItemGroup_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Map].[WorkflowItemWorkflowItemGroup] ADD CONSTRAINT [PK_WorkflowItemWorkflowItemGroup] PRIMARY KEY CLUSTERED  ([WorkflowItemWorkflowItemGroupID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[WorkflowItemWorkflowItemGroup] ADD CONSTRAINT [FK_WorkflowItemWorkflowItemGroup_WorkflowItem] FOREIGN KEY ([WorkflowItemID]) REFERENCES [Definition].[WorkflowItem] ([WorkflowItemID])
GO
ALTER TABLE [Map].[WorkflowItemWorkflowItemGroup] ADD CONSTRAINT [FK_WorkflowItemWorkflowItemGroup_WorkflowItemGroup] FOREIGN KEY ([WorkflowItemGroupID]) REFERENCES [Definition].[WorkflowItemGroup] ([WorkflowItemGroupID])
GO
