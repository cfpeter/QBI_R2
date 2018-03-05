CREATE TABLE [Temp].[KronosQBIClient]
(
[KronosQBIClientID] [int] NOT NULL IDENTITY(1, 1),
[AccountID] [int] NOT NULL,
[CompanyID] [int] NOT NULL,
[EmployeeID] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AccountStatus] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CompanyName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CompanyShortName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CompanyType] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EIN] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Created] [datetime] NOT NULL,
[Email] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExternalID] [int] NULL,
[FirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Locked] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SecurityProfile] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Username] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ImportedAsQBIClient] [bit] NULL,
[CreateDateTime] [datetime] NOT NULL,
[CreatedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UpdatedDateTime] [datetime] NOT NULL,
[UpdatedBy] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Note] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SendInvitation] [bit] NULL CONSTRAINT [DF__KronosQBI__SendI__4DE98D56] DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Temp].[KronosQBIClient] ADD CONSTRAINT [PK_KronosQBIClient] PRIMARY KEY CLUSTERED  ([KronosQBIClientID]) ON [PRIMARY]
GO
