CREATE TABLE [Map].[ProductWorkflow]
(
[ProductWorkflowID] [int] NOT NULL IDENTITY(1, 1),
[ProductID] [bigint] NOT NULL,
[WorkflowID] [int] NOT NULL,
[StatusGroupMapID] [int] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UUIDCode] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[NOTE] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductWorkflow_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ProductWorkflow_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductWorkflow_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ProductWorkflow_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL,
[StartDate] [date] NULL,
[ProjectedFinishDate] [date] NULL,
[ActualFinishDate] [datetime] NULL,
[NextReminderDate] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductWorkflow] ADD CONSTRAINT [PK_ProductWorkflow] PRIMARY KEY CLUSTERED  ([ProductWorkflowID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductWorkflow] ADD CONSTRAINT [FK_ProductWorkflow_Product] FOREIGN KEY ([ProductID]) REFERENCES [Business].[Product] ([ProductID])
GO
ALTER TABLE [Map].[ProductWorkflow] ADD CONSTRAINT [FK_ProductWorkflow_StatusGroupMap] FOREIGN KEY ([StatusGroupMapID]) REFERENCES [Map].[StatusGroupMap] ([StatusGroupMapID])
GO
ALTER TABLE [Map].[ProductWorkflow] ADD CONSTRAINT [FK_ProductWorkflow_Workflow] FOREIGN KEY ([WorkflowID]) REFERENCES [Workflow].[Workflow] ([WorkflowID])
GO
