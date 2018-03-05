CREATE TABLE [Customer].[Address]
(
[AddressID] [int] NOT NULL IDENTITY(1, 1),
[AddressTypeID] [int] NOT NULL,
[DirectionTypeID] [int] NULL,
[StreetTypeID] [int] NULL,
[CountryID] [int] NOT NULL,
[Address1] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StateID] [int] NULL,
[Zipcode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ZipcodeExt] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Address_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Address_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Address_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Address_UpdatedBy] DEFAULT (user_name()),
[Notes] [dbo].[NOTE] NULL,
[Note] [dbo].[NOTE] NULL,
[ReferenceID] [int] NULL,
[IsCRMImported] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Address] ADD CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED  ([AddressID]) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Address] ADD CONSTRAINT [FK_Address_AddressType] FOREIGN KEY ([AddressTypeID]) REFERENCES [Definition].[AddressType] ([AddressTypeID])
GO
ALTER TABLE [Customer].[Address] ADD CONSTRAINT [FK_Address_Country] FOREIGN KEY ([CountryID]) REFERENCES [Definition].[Country] ([CountryID])
GO
ALTER TABLE [Customer].[Address] ADD CONSTRAINT [FK_Address_DirectionType] FOREIGN KEY ([DirectionTypeID]) REFERENCES [Definition].[DirectionType] ([DirectionTypeID])
GO
ALTER TABLE [Customer].[Address] ADD CONSTRAINT [FK_Address_State] FOREIGN KEY ([StateID]) REFERENCES [Definition].[State] ([StateID])
GO
ALTER TABLE [Customer].[Address] ADD CONSTRAINT [FK_Address_StreetType] FOREIGN KEY ([StreetTypeID]) REFERENCES [Definition].[StreetType] ([StreetTypeID])
GO
