CREATE TABLE [Definition].[BillingType]
(
[BillingTypeID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_BillingType_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_BillingType_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_BillingType_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_BillingType_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[BillingType] ADD CONSTRAINT [PK_BillingType] PRIMARY KEY CLUSTERED  ([BillingTypeID]) ON [PRIMARY]
GO
