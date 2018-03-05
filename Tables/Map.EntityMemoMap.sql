CREATE TABLE [Map].[EntityMemoMap]
(
[EntityMemoMapID] [bigint] NOT NULL IDENTITY(1, 1),
[EntityID] [int] NOT NULL,
[MemoID] [int] NOT NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_EntityMemoMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_EntityMemoMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_EntityMemoMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_EntityMemoMap_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Map].[EntityMemoMap] ADD CONSTRAINT [PK_EntityMemoMap] PRIMARY KEY CLUSTERED  ([EntityMemoMapID]) ON [PRIMARY]
GO
