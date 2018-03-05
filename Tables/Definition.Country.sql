CREATE TABLE [Definition].[Country]
(
[CountryID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Code] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Country_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Country_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Country_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Country_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[Country] ADD CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED  ([CountryID]) ON [PRIMARY]
GO
