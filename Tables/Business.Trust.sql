CREATE TABLE [Business].[Trust]
(
[TrustID] [int] NOT NULL IDENTITY(1, 1),
[TrustTypeID] [int] NULL,
[PrefixID] [int] NULL,
[PersonTitleTypeID] [int] NULL,
[IsPrimary] [bit] NULL,
[PrimaryEmail] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherEmail] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AlternativeEmail] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Trust_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Trust_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Trust_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Trust_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Business].[Trust] ADD CONSTRAINT [PK_Trust] PRIMARY KEY CLUSTERED  ([TrustID]) ON [PRIMARY]
GO
