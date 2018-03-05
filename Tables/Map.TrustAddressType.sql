CREATE TABLE [Map].[TrustAddressType]
(
[TrustAddressTypeID] [bigint] NOT NULL IDENTITY(1, 1),
[AddressTypeID] [int] NOT NULL,
[TrustID] [int] NOT NULL,
[IsPrimary] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_TrustAddressType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_TrustAddressType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[TrustAddressType] ADD CONSTRAINT [PK_TrustAddressType] PRIMARY KEY CLUSTERED  ([TrustAddressTypeID]) ON [PRIMARY]
GO
