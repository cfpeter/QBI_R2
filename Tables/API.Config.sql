CREATE TABLE [API].[Config]
(
[ConfigID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EndPoint] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Version] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[ClientID] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SecretKey] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Token] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefreshToken] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SessionToken] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TokenExpireDateTime] [datetime] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NULL,
[CreatedBy] [dbo].[CREATEDBY] NULL CONSTRAINT [DF_Config_CreatedBy] DEFAULT (user_name()),
[CreatedDateTime] [dbo].[CREATEDDATETIME] NULL CONSTRAINT [DF_Config_CreatedDateTime] DEFAULT (getdate()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [API].[Config] ADD CONSTRAINT [PK_Config_1] PRIMARY KEY CLUSTERED  ([ConfigID]) ON [PRIMARY]
GO
