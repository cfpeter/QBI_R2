CREATE TABLE [Map].[CustomerSupervisorMap]
(
[CustomerSupervisorMapID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NOT NULL,
[Supervisor_PersonID] [int] NOT NULL,
[Supervisor_CustomerID] [bigint] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_CustomerSupervisorMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_CustomerSupervisorMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_CustomerSupervisorMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_CustomerSupervisorMap_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Map].[CustomerSupervisorMap] ADD CONSTRAINT [PK_CustomerSupervisorMap] PRIMARY KEY CLUSTERED  ([CustomerSupervisorMapID]) ON [PRIMARY]
GO
