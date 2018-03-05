CREATE TABLE [Customer].[Customer]
(
[CustomerID] [bigint] NOT NULL IDENTITY(1, 1),
[CustomerTypeID] [int] NOT NULL,
[StatusGroupMapID] [int] NOT NULL,
[PersonID] [bigint] NULL,
[CRMContactID] [int] NULL,
[CRMClientID] [int] NULL,
[EntityID] [int] NULL,
[SalesPersonID] [int] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsPrimary] [dbo].[TRUEFALSE] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Customer_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Customer_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Customer_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Customer_UpdatedBy] DEFAULT (user_name()),
[MainClient] [bit] NULL,
[isActivationEmailSent] [bit] NULL,
[Note] [dbo].[NOTE] NULL,
[ReferenceID] [int] NULL,
[VerificationCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MainCustomerID] [bigint] NULL,
[AdvisorTypeID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Customer] ADD CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Customer] ADD CONSTRAINT [FK_39yfheau11pqs83xw5r8gkkvy] FOREIGN KEY ([StatusGroupMapID]) REFERENCES [Map].[StatusGroupMap] ([StatusGroupMapID])
GO
ALTER TABLE [Customer].[Customer] WITH NOCHECK ADD CONSTRAINT [FK_Customer_CustomerSupervisorMap] FOREIGN KEY ([CustomerTypeID]) REFERENCES [Map].[CustomerSupervisorMap] ([CustomerSupervisorMapID])
GO
ALTER TABLE [Customer].[Customer] ADD CONSTRAINT [FK_Customer_CustomerType] FOREIGN KEY ([CustomerTypeID]) REFERENCES [Definition].[CustomerType] ([CustomerTypeID])
GO
ALTER TABLE [Customer].[Customer] ADD CONSTRAINT [FK_Customer_Entity1] FOREIGN KEY ([EntityID]) REFERENCES [Customer].[Entity] ([EntityID])
GO
ALTER TABLE [Customer].[Customer] ADD CONSTRAINT [FK_Customer_Person] FOREIGN KEY ([PersonID]) REFERENCES [Customer].[Person] ([PersonID])
GO
ALTER TABLE [Customer].[Customer] NOCHECK CONSTRAINT [FK_Customer_CustomerSupervisorMap]
GO
