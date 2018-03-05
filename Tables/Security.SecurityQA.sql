CREATE TABLE [Security].[SecurityQA]
(
[SecurityQAID] [int] NOT NULL IDENTITY(1, 1),
[Question] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Answer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL,
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Security].[SecurityQA] ADD CONSTRAINT [PK_SecurityQA] PRIMARY KEY CLUSTERED  ([SecurityQAID]) ON [PRIMARY]
GO
