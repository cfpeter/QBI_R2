CREATE TABLE [dbo].[CGLOBAL]
(
[cfid] [char] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[data] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[lvisit] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [id2] ON [dbo].[CGLOBAL] ([cfid]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [id3] ON [dbo].[CGLOBAL] ([lvisit]) ON [PRIMARY]
GO
