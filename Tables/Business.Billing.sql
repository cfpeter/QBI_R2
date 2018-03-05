CREATE TABLE [Business].[Billing]
(
[BillingID] [bigint] NOT NULL IDENTITY(1, 1),
[BillingTypeID] [int] NOT NULL,
[BillingFrequencyID] [int] NOT NULL,
[InitialRevenue] [int] NULL,
[AnnualRevenue] [int] NULL,
[BaseFee] [int] NULL,
[ParticipantFee] [int] NULL,
[TakeoverFee] [int] NULL,
[TakeoverFeeWaived] [dbo].[TRUEFALSE] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL,
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL,
[NonDeferredParticipantFee] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Business].[Billing] ADD CONSTRAINT [PK_Billing] PRIMARY KEY CLUSTERED  ([BillingID]) ON [PRIMARY]
GO
