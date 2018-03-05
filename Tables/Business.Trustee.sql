CREATE TABLE [Business].[Trustee]
(
[TrusteeID] [bigint] NOT NULL IDENTITY(1, 1),
[TrusteeTypeID] [int] NOT NULL,
[PrefixID] [int] NULL,
[FirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MiddleName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Suffix] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PersonTitleTypeID] [int] NULL,
[CompanyName] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyAlias] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Note] [dbo].[NOTE] NULL,
[Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [bit] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Trustee_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Trustee_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Trustee_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Trustee_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Business].[Trustee] ADD CONSTRAINT [PK_Trustee] PRIMARY KEY CLUSTERED  ([TrusteeID]) ON [PRIMARY]
GO
ALTER TABLE [Business].[Trustee] ADD CONSTRAINT [FK_Trustee_PersonTitleTypeID] FOREIGN KEY ([PersonTitleTypeID]) REFERENCES [Definition].[PersonTitleType] ([PersonTitleTypeID])
GO
ALTER TABLE [Business].[Trustee] ADD CONSTRAINT [FK_Trustee_PrefixID] FOREIGN KEY ([PrefixID]) REFERENCES [Definition].[PrefixType] ([PrefixTypeID])
GO
ALTER TABLE [Business].[Trustee] ADD CONSTRAINT [FK_Trustee_TrusteeTypeID] FOREIGN KEY ([TrusteeTypeID]) REFERENCES [Definition].[TrusteeType] ([TrusteeTypeID])
GO
