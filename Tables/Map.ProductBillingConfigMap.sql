CREATE TABLE [Map].[ProductBillingConfigMap]
(
[ProductBillingConfigMapID] [bigint] NOT NULL IDENTITY(1, 1),
[ProductID] [bigint] NOT NULL,
[BillingConfigID] [bigint] NOT NULL,
[ConsolidationCode] [bigint] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF__ProductBi__Creat__10E07F16] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF__ProductBi__Updat__11D4A34F] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductBillingConfigMap] ADD CONSTRAINT [PK_ProductBillingConfigMap] PRIMARY KEY CLUSTERED  ([ProductBillingConfigMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductBillingConfigMap] ADD CONSTRAINT [FK_ProductBillingConfigMap_BillingConfig] FOREIGN KEY ([BillingConfigID]) REFERENCES [Accounting].[BillingConfig] ([BillingConfigID])
GO
ALTER TABLE [Map].[ProductBillingConfigMap] ADD CONSTRAINT [FK_ProductBillingConfigMap_Product] FOREIGN KEY ([ProductID]) REFERENCES [Business].[Product] ([ProductID])
GO
