CREATE TABLE [Customer].[ActivityLog]
(
[ActivityLogID] [bigint] NOT NULL IDENTITY(1, 1),
[CustomerID] [bigint] NOT NULL,
[Activity] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Status_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Status_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Status_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Status_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Customer].[ActivityLog] ADD CONSTRAINT [PK_ActivityLogID] PRIMARY KEY CLUSTERED  ([ActivityLogID]) ON [PRIMARY]
GO
ALTER TABLE [Customer].[ActivityLog] ADD CONSTRAINT [FK_ActivityLog_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Customer].[Customer] ([CustomerID])
GO
