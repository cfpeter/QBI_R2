CREATE TABLE [Definition].[AddressType]
(
[AddressTypeID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_AddressType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_AddressType_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_AddressType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_AddressType_UpdatedBy] DEFAULT (user_name()),
[Notes] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[AddressType] ADD CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED  ([AddressTypeID]) ON [PRIMARY]
GO
