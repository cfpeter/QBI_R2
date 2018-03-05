CREATE TABLE [Customer].[OrganizationBranch]
(
[OrganizationBranchID] [bigint] NOT NULL IDENTITY(1, 1),
[OrganizationID] [bigint] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneNumber] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FaxNumber] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_OrganizationBranch_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_OrganizationBranch_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_OrganizationBranch_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_OrganizationBranch_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL,
[YearCoBegan] [varchar] (45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalEmployees] [int] NULL,
[IsPrimaryBranch] [bit] NULL,
[NatureOfBusiness] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PayrollProviderID] [int] NULL,
[PayrollFrequencyID] [int] NULL,
[WeekStart] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FYEDay] [int] NULL,
[FYEMonth] [int] NULL,
[IRCSection] [varchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyShortName] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Customer].[OrganizationBranch] ADD CONSTRAINT [PK_OrganizationBranch] PRIMARY KEY CLUSTERED  ([OrganizationBranchID]) ON [PRIMARY]
GO
ALTER TABLE [Customer].[OrganizationBranch] ADD CONSTRAINT [FK_OrganizationBranch_Organization] FOREIGN KEY ([OrganizationID]) REFERENCES [Customer].[Organization] ([OrganizationID])
GO
