CREATE TABLE [Definition].[ProductSubType]
(
[ProductSubTypeID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[NOTE] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductSubType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ProductSubType_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductSubType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ProductSubType_UpdatedBy] DEFAULT (user_name()),
[ActiveForSales] [bit] NULL CONSTRAINT [DF__ProductSu__Activ__662B2B3B] DEFAULT ((0)),
[MoreInfoURL] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[ProductSubType] ADD CONSTRAINT [PK_ProductSubType] PRIMARY KEY CLUSTERED  ([ProductSubTypeID]) ON [PRIMARY]
GO
