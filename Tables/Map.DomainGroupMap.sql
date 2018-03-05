CREATE TABLE [Map].[DomainGroupMap]
(
[DomainGroupMapID] [int] NOT NULL IDENTITY(1, 1),
[DomainGroupID] [int] NOT NULL,
[DomainGroupOverrideID] [int] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_DomainGroupMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_DomainGroupMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_DomainGroupMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_DomainGroupMap_UpdatedBy] DEFAULT (user_name()),
[HomeHandler] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NextEvent] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[DomainGroupMap] ADD CONSTRAINT [PK_DomainGroupMap] PRIMARY KEY CLUSTERED  ([DomainGroupMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[DomainGroupMap] ADD CONSTRAINT [FK_DomainGroupMap_DomainGroup] FOREIGN KEY ([DomainGroupID]) REFERENCES [Definition].[DomainGroup] ([DomainGroupID])
GO
ALTER TABLE [Map].[DomainGroupMap] ADD CONSTRAINT [FK_DomainGroupMap_DomainGroupOverride] FOREIGN KEY ([DomainGroupOverrideID]) REFERENCES [Definition].[DomainGroupOverride] ([DomainGroupOverrideID])
GO
