CREATE TABLE [Temp].[saashr]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[CompanyID] [int] NOT NULL,
[CompanyName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ShortName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyType] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Temp].[saashr] ADD CONSTRAINT [PK_saashr] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
