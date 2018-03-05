CREATE TABLE [Map].[ProductAdvisorMap]
(
[ProductAdvisorMapID] [bigint] NOT NULL IDENTITY(1, 1),
[ProductID] [bigint] NOT NULL,
[AdvisorCustomerID] [bigint] NOT NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL,
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductAdvisorMap] ADD CONSTRAINT [PK_ProductAdvisorMap] PRIMARY KEY CLUSTERED  ([ProductAdvisorMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ProductAdvisorMap] ADD CONSTRAINT [FK_ProductAdvisoMap_AdvisorCutomer] FOREIGN KEY ([AdvisorCustomerID]) REFERENCES [Customer].[Customer] ([CustomerID])
GO
ALTER TABLE [Map].[ProductAdvisorMap] ADD CONSTRAINT [FK_ProductAdvisoMap_Product] FOREIGN KEY ([ProductID]) REFERENCES [Business].[Product] ([ProductID])
GO
