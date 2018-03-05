CREATE TABLE [dbo].[SocketChannel]
(
[SocketChannelID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[SortOrder] [int] NULL,
[CreatedDateTime] [datetime2] NOT NULL,
[CreatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UpdatedDateTime] [datetime2] NOT NULL,
[UpdatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Note] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SocketChannel] ADD CONSTRAINT [PK__SocketCh__D4C125C6F3182B11] PRIMARY KEY CLUSTERED  ([SocketChannelID]) ON [PRIMARY]
GO
