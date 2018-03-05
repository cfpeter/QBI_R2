CREATE TABLE [Workflow].[Config]
(
[ConfigID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsListener] [dbo].[TRUEFALSE] NULL,
[IsSchedule] [dbo].[TRUEFALSE] NULL,
[In] [nvarchar] (350) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Out] [nvarchar] (350) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartDate] [date] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Config_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Config_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Config_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Config_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Workflow].[Config] ADD CONSTRAINT [PK_Config] PRIMARY KEY CLUSTERED  ([ConfigID]) ON [PRIMARY]
GO
