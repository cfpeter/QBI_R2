CREATE TABLE [Map].[WorkflowMemoMap]
(
[WorkflowMemoMapID] [int] NOT NULL IDENTITY(1, 1),
[ProductWorkflowID] [int] NOT NULL,
[MemoID] [int] NOT NULL,
[EntityID] [int] NOT NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL,
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL,
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[WorkflowMemoMap] ADD CONSTRAINT [PK_WorkflowMemoMap] PRIMARY KEY CLUSTERED  ([WorkflowMemoMapID]) ON [PRIMARY]
GO
