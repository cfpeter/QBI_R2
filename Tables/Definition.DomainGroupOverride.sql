CREATE TABLE [Definition].[DomainGroupOverride]
(
[DomainGroupOverrideID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NULL CONSTRAINT [DF_DomainGroupOverride_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NULL CONSTRAINT [DF_DomainGroupOverride_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_DomainGroupOverride_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_DomainGroupOverride_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[DomainGroupOverride] ADD CONSTRAINT [PK_DomainGroupOverride] PRIMARY KEY CLUSTERED  ([DomainGroupOverrideID]) ON [PRIMARY]
GO
