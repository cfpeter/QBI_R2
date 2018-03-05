CREATE TABLE [Definition].[DocumentType]
(
[DocumentTypeID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DocCode] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TemplateName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Location] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrinterTray] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PaperSize] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PaperType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrintOrientation] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_DocumentType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_DocumentType_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_DocumentType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_DocumentType_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[DocumentType] ADD CONSTRAINT [PK_DocumentType] PRIMARY KEY CLUSTERED  ([DocumentTypeID]) ON [PRIMARY]
GO
