CREATE TABLE [Temp].[InvitationEmailLog]
(
[InvitationEmailLogID] [bigint] NOT NULL IDENTITY(1, 1),
[ContactID] [int] NOT NULL,
[ClientID] [int] NOT NULL,
[TemplatePath] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TemplateType] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fullname] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateTimeSent] [datetime] NULL,
[Count] [int] NULL,
[Errored] [bit] NULL,
[Message] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_InvitationEmailLog_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_InvitationEmailLog_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_InvitationEmailLog_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_InvitationEmailLog_UpdatedBy] DEFAULT (user_name()),
[Notes] [dbo].[NOTE] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Temp].[InvitationEmailLog] ADD CONSTRAINT [PK_InvitationEmailLog] PRIMARY KEY CLUSTERED  ([InvitationEmailLogID]) ON [PRIMARY]
GO
