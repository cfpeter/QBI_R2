CREATE TABLE [Map].[ProductTrust]
(
[ProductTrustID] [bigint] NOT NULL IDENTITY(1, 1),
[ProductID] [bigint] NOT NULL,
[TrustID] [int] NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductTrust_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ProductTrust_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductTrust_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ProductTrust_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductTrust] ADD CONSTRAINT [PK_ProductTrust] PRIMARY KEY CLUSTERED  ([ProductTrustID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductTrust] ADD CONSTRAINT [FK_ProductTrust_Product] FOREIGN KEY ([ProductID]) REFERENCES [Business].[Product] ([ProductID])
GO
ALTER TABLE [Map].[ProductTrust] ADD CONSTRAINT [FK_ProductTrust_Trust] FOREIGN KEY ([TrustID]) REFERENCES [Business].[Trust] ([TrustID])
GO
