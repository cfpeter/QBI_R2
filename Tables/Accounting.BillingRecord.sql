CREATE TABLE [Accounting].[BillingRecord]
(
[BillingRecordID] [bigint] NOT NULL IDENTITY(1, 1),
[ProductBillingConfigMapID] [bigint] NOT NULL,
[ConsolidationCode] [bigint] NULL,
[Billed] [bit] NULL,
[BillStatus] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BillDate] [date] NOT NULL,
[BillAmount] [int] NOT NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL,
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Accounting].[BillingRecord] ADD CONSTRAINT [PK_BillingRecord] PRIMARY KEY CLUSTERED  ([BillingRecordID]) ON [PRIMARY]
GO
ALTER TABLE [Accounting].[BillingRecord] ADD CONSTRAINT [FK_BillingRecord_ProductBillingConfigMap] FOREIGN KEY ([ProductBillingConfigMapID]) REFERENCES [Map].[ProductBillingConfigMap] ([ProductBillingConfigMapID])
GO
