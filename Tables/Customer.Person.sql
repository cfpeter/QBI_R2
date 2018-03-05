CREATE TABLE [Customer].[Person]
(
[PersonID] [bigint] NOT NULL IDENTITY(1, 1),
[OrganizationBranchID] [bigint] NULL,
[DepartmentID] [int] NULL,
[PersonTitleTypeID] [int] NULL,
[PrefixTypeID] [int] NULL,
[FirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateOfBirth] [date] NULL,
[Gender] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Person_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Person_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Person_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Person_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL,
[SSN] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSNKey] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DistributeTo] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED  ([PersonID]) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT [FK_laqxdsn6f89pfdt8y9cq0937n] FOREIGN KEY ([OrganizationBranchID]) REFERENCES [Customer].[OrganizationBranch] ([OrganizationBranchID])
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT [FK_Person_Department] FOREIGN KEY ([DepartmentID]) REFERENCES [Definition].[Department] ([DepartmentID])
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT [FK_Person_PersonTitleType] FOREIGN KEY ([PersonTitleTypeID]) REFERENCES [Definition].[PersonTitleType] ([PersonTitleTypeID])
GO
ALTER TABLE [Customer].[Person] ADD CONSTRAINT [FK_Person_SuffixType] FOREIGN KEY ([PrefixTypeID]) REFERENCES [Definition].[SuffixType] ([SuffixTypeID])
GO
