CREATE TABLE [Map].[ConsultantAssistance]
(
[ConsultantAssistanceID] [int] NOT NULL IDENTITY(1, 1),
[ConsultantPersonID] [int] NOT NULL,
[AssistancePersonID] [int] NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ConsultantAssistance_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ConsultantAssistance_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ConsultantAssistance_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ConsultantAssistance_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ConsultantAssistance] ADD CONSTRAINT [PK_ConsultantAssistance] PRIMARY KEY CLUSTERED  ([ConsultantAssistanceID]) ON [PRIMARY]
GO
