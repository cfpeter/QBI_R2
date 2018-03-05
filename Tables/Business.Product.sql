CREATE TABLE [Business].[Product]
(
[ProductID] [bigint] NOT NULL IDENTITY(1, 1),
[ProductTypeMapID] [int] NULL,
[CustomerID] [bigint] NOT NULL,
[SalesPersonID] [int] NULL,
[StatusGroupMapID] [int] NULL,
[ProductOriginID] [int] NULL,
[DocumentProviderID] [int] NULL,
[DocumentTypeID] [int] NULL,
[BillingTypeID] [int] NULL,
[BillingFrequencyID] [int] NULL,
[TrustID] [int] NULL,
[ConsultantPersonID] [int] NULL,
[AdvisorPersonID] [int] NULL,
[ReferralPersonID] [int] NULL,
[Number] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProductAssets] [int] NULL,
[NumberOfParticipant] [int] NULL,
[Option316] [dbo].[TRUEFALSE] NULL,
[ProductYearEnd] [date] NULL,
[ValuationDate] [date] NULL,
[FinalYearEndDate] [date] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Product_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Product_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Product_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Product_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL,
[BillingAddressSameAsClient] [bit] NULL,
[PYEMonth] [int] NULL,
[PYEDay] [int] NULL,
[CurrentYearEnd] [date] NULL,
[isProspect] [bit] NULL,
[crmPlanID] [bigint] NULL,
[OneLoginProductID] [bigint] NULL,
[AnyNonDeferredParticipants] [bit] NULL,
[NumberOfNonDeferredParticipants] [int] NULL,
[EligibleAge] [int] NULL,
[EligibleAgeWaived] [bit] NULL,
[AdvisorTypeID] [int] NULL,
[QBIFirstPlanYearEnd] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Business].[Product] ADD CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED  ([ProductID]) ON [PRIMARY]
GO
ALTER TABLE [Business].[Product] ADD CONSTRAINT [FK_Product_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [Customer].[Customer] ([CustomerID])
GO
ALTER TABLE [Business].[Product] ADD CONSTRAINT [FK_Product_ProductOrigin] FOREIGN KEY ([ProductOriginID]) REFERENCES [Definition].[ProductOrigin] ([ProductOriginID])
GO
ALTER TABLE [Business].[Product] ADD CONSTRAINT [FK_Product_ProductTypeMap] FOREIGN KEY ([ProductTypeMapID]) REFERENCES [Map].[ProductTypeMap] ([ProductTypeMapID])
GO
