CREATE TABLE [Definition].[AdvisorType]
(
[AdvisorTypeID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL,
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[AdvisorType] ADD CONSTRAINT [PK__AdvisorT__EFD52EF63296789C] PRIMARY KEY CLUSTERED  ([AdvisorTypeID]) ON [PRIMARY]
GO
