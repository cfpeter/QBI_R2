CREATE TABLE [Log].[Error]
(
[ErrorID] [bigint] NOT NULL IDENTITY(1, 1),
[TrackingID] [int] NOT NULL,
[Detail] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsResolved] [dbo].[TRUEFALSE] NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Error_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Error_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Error_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Error_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Log].[Error] ADD CONSTRAINT [PK_Error] PRIMARY KEY CLUSTERED  ([ErrorID]) ON [PRIMARY]
GO
