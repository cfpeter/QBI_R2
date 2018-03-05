CREATE TABLE [Customer].[Phone]
(
[PhoneID] [int] NOT NULL IDENTITY(1, 1),
[PhoneTypeID] [int] NOT NULL,
[PersonID] [bigint] NULL,
[Number] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Phone_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Phone_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL,
[Note] [dbo].[NOTE] NULL,
[IsPrimary] [bit] NULL CONSTRAINT [DF__Phone__IsPrimary__13FCE2E3] DEFAULT ((1)),
[NumberExt] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Phone] ADD CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED  ([PhoneID]) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Phone] ADD CONSTRAINT [FK_Phone_Person] FOREIGN KEY ([PersonID]) REFERENCES [Customer].[Person] ([PersonID])
GO
ALTER TABLE [Customer].[Phone] ADD CONSTRAINT [FK_Phone_PhoneType] FOREIGN KEY ([PhoneTypeID]) REFERENCES [Definition].[PhoneType] ([PhoneTypeID])
GO
