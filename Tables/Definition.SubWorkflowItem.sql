CREATE TABLE [Definition].[SubWorkflowItem]
(
[SubWorkflowItemID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UUIDCode] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[SortOrder] [int] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_SubWorkFlowItem_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_SubWorkFlowItem_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_SubWorkFlowItem_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_SubWorkFlowItem_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Definition].[SubWorkflowItem] ADD CONSTRAINT [PK_SubWorkFlowItem] PRIMARY KEY CLUSTERED  ([SubWorkflowItemID]) ON [PRIMARY]
GO
