CREATE TABLE [Map].[PlanComboBreakdown]
(
[PlanComboBreakdownID] [int] NOT NULL IDENTITY(1, 1),
[ComboProductTypeMapID] [int] NOT NULL,
[ProductTypeMapID] [int] NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_PlanComboBreakdown_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_PlanComboBreakdown_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_PlanComboBreakdown_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_PlanComboBreakdown_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[PlanComboBreakdown] ADD CONSTRAINT [PK_PlanComboBreakdown] PRIMARY KEY CLUSTERED  ([PlanComboBreakdownID]) ON [PRIMARY]
GO
