CREATE TABLE [Partner].[Partner]
(
[PartnerID] [int] NOT NULL IDENTITY(1, 1),
[PartnerTypeID] [int] NOT NULL,
[PersonTitleTypeID] [int] NULL,
[CompanyTypeID] [int] NULL,
[Name] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Alias] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StateCode] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ZipCode] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneNumber] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FaxNumber] [nchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Gender] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OwnershipPercent] [float] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Partner_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Partner_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Partner_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Partner_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Partner].[Partner] ADD CONSTRAINT [PK_Partner] PRIMARY KEY CLUSTERED  ([PartnerID]) ON [PRIMARY]
GO
ALTER TABLE [Partner].[Partner] ADD CONSTRAINT [FK_Partner_CompanyType] FOREIGN KEY ([CompanyTypeID]) REFERENCES [Definition].[CompanyType] ([CompanyTypeID])
GO
ALTER TABLE [Partner].[Partner] ADD CONSTRAINT [FK_Partner_PartnerType] FOREIGN KEY ([PartnerTypeID]) REFERENCES [Definition].[PartnerType] ([PartnerTypeID])
GO
ALTER TABLE [Partner].[Partner] ADD CONSTRAINT [FK_Partner_PersonTitleType] FOREIGN KEY ([PersonTitleTypeID]) REFERENCES [Definition].[PersonTitleType] ([PersonTitleTypeID])
GO
