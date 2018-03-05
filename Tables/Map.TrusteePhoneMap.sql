CREATE TABLE [Map].[TrusteePhoneMap]
(
[TrusteePhoneID] [bigint] NOT NULL IDENTITY(1, 1),
[TrusteeID] [bigint] NOT NULL,
[PhoneID] [int] NOT NULL,
[IsPrimary] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_TrusteePhoneMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_TrusteePhoneMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[TrusteePhoneMap] ADD CONSTRAINT [PK_TrusteePhone] PRIMARY KEY CLUSTERED  ([TrusteePhoneID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[TrusteePhoneMap] ADD CONSTRAINT [FK_TrusteePhoneMap_PhoneID] FOREIGN KEY ([PhoneID]) REFERENCES [Customer].[Phone] ([PhoneID])
GO
ALTER TABLE [Map].[TrusteePhoneMap] ADD CONSTRAINT [FK_TrusteePhoneMap_TrusteeID] FOREIGN KEY ([TrusteeID]) REFERENCES [Business].[Trustee] ([TrusteeID])
GO
