CREATE TABLE [Security].[TokenManagement]
(
[TokenManagementID] [bigint] NOT NULL IDENTITY(1, 1),
[Token] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DomainGroupMapID] [int] NOT NULL,
[IsActive] [dbo].[TRUEFALSE] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NULL CONSTRAINT [DF_TokenManagement_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NULL CONSTRAINT [DF_TokenManagement_CreatedBy] DEFAULT (user_name()),
[CustomerID] [bigint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Security].[TokenManagement] ADD CONSTRAINT [PK_TokenManagement] PRIMARY KEY CLUSTERED  ([TokenManagementID]) ON [PRIMARY]
GO
