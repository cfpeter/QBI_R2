CREATE TABLE [Definition].[ProductType]
(
[ProductTypeID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[NOTE] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ProductType_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ProductType_UpdatedBy] DEFAULT (user_name()),
[ActiveForSales] [bit] NULL CONSTRAINT [DF__ProductTy__Activ__6CD828CA] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[ProductType] ADD CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED  ([ProductTypeID]) ON [PRIMARY]
GO
