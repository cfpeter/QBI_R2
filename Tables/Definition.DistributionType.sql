CREATE TABLE [Definition].[DistributionType]
(
[DistributionTypeID] [bigint] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[NOTE] NULL,
[MaskID] [int] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_DistributionType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_DistributionType_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_DistributionType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_DistributionType_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[DistributionType] ADD CONSTRAINT [PK_DistributionType] PRIMARY KEY CLUSTERED  ([DistributionTypeID]) ON [PRIMARY]
GO
