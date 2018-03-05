CREATE TABLE [Definition].[CompanyType]
(
[CompanyTypeID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_CompanyType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_CompanyType_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_CompanyType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_CompanyType_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[CompanyType] ADD CONSTRAINT [PK_CompanyType] PRIMARY KEY CLUSTERED  ([CompanyTypeID]) ON [PRIMARY]
GO
