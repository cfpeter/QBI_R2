CREATE TABLE [Customer].[Organization]
(
[OrganizationID] [bigint] NOT NULL IDENTITY(1, 1),
[OrganizationTypeID] [int] NOT NULL,
[Name] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Organization_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Organization_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Organization_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Organization_UpdatedBy] DEFAULT (user_name()),
[CompanyTypeID] [int] NULL,
[Note] [dbo].[NOTE] NULL,
[EIN] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Union] [bit] NULL,
[BusinessCode] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AffiliatedGroup] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ControlGroup] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Organization] ADD CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED  ([OrganizationID]) ON [PRIMARY]
GO
