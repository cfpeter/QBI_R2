CREATE TABLE [Definition].[DirectionType]
(
[DirectionTypeID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_DirectionType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_DirectionType_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_DirectionType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_DirectionType_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[DirectionType] ADD CONSTRAINT [PK_DirectionType] PRIMARY KEY CLUSTERED  ([DirectionTypeID]) ON [PRIMARY]
GO
