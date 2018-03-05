CREATE TABLE [Map].[ProductTrusteeMap]
(
[ProductTrusteeID] [bigint] NOT NULL IDENTITY(1, 1),
[ProductID] [bigint] NOT NULL,
[TrusteeID] [bigint] NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductTrustee_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ProductTrustee_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ProductTrustee_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ProductTrustee_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductTrusteeMap] ADD CONSTRAINT [PK_ProductTrustee] PRIMARY KEY CLUSTERED  ([ProductTrusteeID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductTrusteeMap] ADD CONSTRAINT [FK_ProductTrustee_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Business].[Product] ([ProductID])
GO
ALTER TABLE [Map].[ProductTrusteeMap] ADD CONSTRAINT [FK_ProductTrustee_TrusteeID] FOREIGN KEY ([TrusteeID]) REFERENCES [Business].[Trustee] ([TrusteeID])
GO
