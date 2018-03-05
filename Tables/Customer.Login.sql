CREATE TABLE [Customer].[Login]
(
[LoginID] [bigint] NOT NULL IDENTITY(1, 1),
[CustomerID] [bigint] NULL,
[UserName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PassCode] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Salt] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastLoginDateTime] [dbo].[CREATEDDATETIME] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Login_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Login_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Login_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Login_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL,
[LoginAttempts] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Login] ADD CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED  ([LoginID]) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Login] ADD CONSTRAINT [FK_Login_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [Customer].[Customer] ([CustomerID])
GO
