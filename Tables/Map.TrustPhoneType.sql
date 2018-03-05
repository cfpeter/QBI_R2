CREATE TABLE [Map].[TrustPhoneType]
(
[TrustPhoneTypeID] [bigint] NOT NULL IDENTITY(1, 1),
[PhoneTypeID] [int] NOT NULL,
[TrustID] [int] NOT NULL,
[IsPrimary] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_TrustPhoneType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_TrustPhoneType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[TrustPhoneType] ADD CONSTRAINT [PK_TrustPhoneType] PRIMARY KEY CLUSTERED  ([TrustPhoneTypeID]) ON [PRIMARY]
GO
