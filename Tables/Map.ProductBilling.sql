CREATE TABLE [Map].[ProductBilling]
(
[ProductBillingID] [int] NOT NULL IDENTITY(1, 1),
[BillingID] [int] NOT NULL,
[ProductID] [int] NOT NULL,
[AddressID] [int] NULL,
[InvoiceID] [int] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[NOTE] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductBilling_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ProductBilling_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductBilling_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ProductBilling_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductBilling] ADD CONSTRAINT [PK_ProductBilling] PRIMARY KEY CLUSTERED  ([ProductBillingID]) ON [PRIMARY]
GO
