CREATE TABLE [Map].[ActionOperationMap]
(
[ActionOperationID] [int] NOT NULL IDENTITY(1, 1),
[ActionID] [int] NOT NULL,
[OperationID] [int] NOT NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_ActionOperationMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_ActionOperationMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_ActionOperationMap_UpdatedDateTime] DEFAULT (getdate()),
[updatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_ActionOperationMap_updatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ActionOperationMap] ADD CONSTRAINT [PK_ActionOperation] PRIMARY KEY CLUSTERED  ([ActionOperationID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ActionOperationMap] ADD CONSTRAINT [FK_ActionOperationMap_Action] FOREIGN KEY ([ActionID]) REFERENCES [Definition].[Action] ([ActionID])
GO
ALTER TABLE [Map].[ActionOperationMap] ADD CONSTRAINT [FK_ActionOperationMap_Operation] FOREIGN KEY ([OperationID]) REFERENCES [Definition].[Operation] ([OperationID])
GO
