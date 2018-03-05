CREATE TABLE [Map].[ReportTypeDocument]
(
[ReportTypeDocumentID] [int] NOT NULL IDENTITY(1, 1),
[ReportTypeMapID] [int] NOT NULL,
[DocumentTypeID] [int] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PageOrder] [int] NULL,
[ReportDocumentCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ReportTypeDocument_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ReportTypeDocument_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ReportTypeDocument_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ReportTypeDocument_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL,
[Alias] [varchar] (45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ReportTypeDocument] ADD CONSTRAINT [PK_ReportTypeDocument] PRIMARY KEY CLUSTERED  ([ReportTypeDocumentID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ReportTypeDocument] ADD CONSTRAINT [FK_ReportTypeDocument_DocumentType] FOREIGN KEY ([DocumentTypeID]) REFERENCES [Definition].[DocumentType] ([DocumentTypeID])
GO
ALTER TABLE [Map].[ReportTypeDocument] ADD CONSTRAINT [FK_ReportTypeDocument_ReportTypeMap] FOREIGN KEY ([ReportTypeMapID]) REFERENCES [Map].[ReportTypeMap] ([ReportTypeMapID])
GO
