CREATE TABLE [Map].[StatusGroupMap]
(
[StatusGroupMapID] [int] NOT NULL IDENTITY(1, 1),
[StatusID] [int] NOT NULL,
[StatusGroupID] [int] NOT NULL,
[StatusMaskID] [int] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[SortoOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_StatusGroupMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_StatusGroupMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_StatusGroupMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_StatusGroupMap_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[StatusGroupMap] ADD CONSTRAINT [PK_StatusGroupMap] PRIMARY KEY CLUSTERED  ([StatusGroupMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[StatusGroupMap] ADD CONSTRAINT [FK_StatusGroupMap_Status] FOREIGN KEY ([StatusID]) REFERENCES [Definition].[Status] ([StatusID])
GO
ALTER TABLE [Map].[StatusGroupMap] ADD CONSTRAINT [FK_StatusGroupMap_StatusGroup] FOREIGN KEY ([StatusGroupID]) REFERENCES [Definition].[StatusGroup] ([StatusGroupID])
GO
