CREATE TABLE [Map].[TrusteeAddressMap]
(
[TrusteeAddressID] [bigint] NOT NULL IDENTITY(1, 1),
[TrusteeID] [bigint] NOT NULL,
[AddressID] [int] NOT NULL,
[IsPrimary] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_TrusteeAddressMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_TrusteeAddressMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[TrusteeAddressMap] ADD CONSTRAINT [PK_TrusteeAddress] PRIMARY KEY CLUSTERED  ([TrusteeAddressID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[TrusteeAddressMap] ADD CONSTRAINT [FK_TrusteeAddressMap_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Customer].[Address] ([AddressID])
GO
ALTER TABLE [Map].[TrusteeAddressMap] ADD CONSTRAINT [FK_TrusteeAddressMap_TrusteeID] FOREIGN KEY ([TrusteeID]) REFERENCES [Business].[Trustee] ([TrusteeID])
GO
