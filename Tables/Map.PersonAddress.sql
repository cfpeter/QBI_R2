CREATE TABLE [Map].[PersonAddress]
(
[PersonAddressID] [bigint] NOT NULL IDENTITY(1, 1),
[PersonID] [bigint] NOT NULL,
[AddressID] [int] NULL,
[IsPrimary] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_PersonAddress_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_PersonAddress_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL,
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[PersonAddress] ADD CONSTRAINT [PK_PersonAddress] PRIMARY KEY CLUSTERED  ([PersonAddressID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[PersonAddress] ADD CONSTRAINT [FK_PersonAddress_Address] FOREIGN KEY ([AddressID]) REFERENCES [Customer].[Address] ([AddressID])
GO
ALTER TABLE [Map].[PersonAddress] ADD CONSTRAINT [FK_PersonAddress_Person] FOREIGN KEY ([PersonID]) REFERENCES [Customer].[Person] ([PersonID])
GO
