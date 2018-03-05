CREATE TABLE [Map].[ProductTypeMap]
(
[ProductTypeMapID] [int] NOT NULL IDENTITY(1, 1),
[ProductTypeID] [int] NOT NULL,
[ProductSubTypeID] [int] NOT NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[NOTE] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductTypeMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ProductTypeMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductTypeMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ProductTypeMap_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductTypeMap] ADD CONSTRAINT [PK_ProductTypeMap] PRIMARY KEY CLUSTERED  ([ProductTypeMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductTypeMap] ADD CONSTRAINT [FK_ProductTypeMap_ProductSubType] FOREIGN KEY ([ProductSubTypeID]) REFERENCES [Definition].[ProductSubType] ([ProductSubTypeID])
GO
ALTER TABLE [Map].[ProductTypeMap] ADD CONSTRAINT [FK_ProductTypeMap_ProductType] FOREIGN KEY ([ProductTypeID]) REFERENCES [Definition].[ProductType] ([ProductTypeID])
GO
