CREATE TABLE [Map].[PersonPhoneMap]
(
[PersonPhoneID] [bigint] NOT NULL IDENTITY(1, 1),
[PersonID] [bigint] NOT NULL,
[PhoneID] [int] NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_PersonPhone_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_PersonPhone_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_PersonPhone_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_PersonPhone_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Map].[PersonPhoneMap] ADD CONSTRAINT [PK_PersonPhone] PRIMARY KEY CLUSTERED  ([PersonPhoneID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[PersonPhoneMap] ADD CONSTRAINT [FK_PersonPhone_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Customer].[Person] ([PersonID])
GO
ALTER TABLE [Map].[PersonPhoneMap] ADD CONSTRAINT [FK_PersonPhone_PhoneID] FOREIGN KEY ([PhoneID]) REFERENCES [Customer].[Phone] ([PhoneID])
GO
