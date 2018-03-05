CREATE TABLE [Map].[SecurityQACustomerMap]
(
[SecurityQACustomerMapID] [int] NOT NULL IDENTITY(1, 1),
[SecurityQAID] [int] NULL,
[CustomerID] [bigint] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_SecurityQACustomerMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_SecurityQACustomerMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_SecurityQACustomerMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_SecurityQACustomerMap_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[SecurityQACustomerMap] ADD CONSTRAINT [PK_SecurityQACustomerMap] PRIMARY KEY CLUSTERED  ([SecurityQACustomerMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[SecurityQACustomerMap] ADD CONSTRAINT [FK_SecurityQACustomerMap_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [Customer].[Customer] ([CustomerID])
GO
