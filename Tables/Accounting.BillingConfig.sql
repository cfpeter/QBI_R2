CREATE TABLE [Accounting].[BillingConfig]
(
[BillingConfigID] [bigint] NOT NULL IDENTITY(1, 1),
[BillingTypeID] [int] NOT NULL,
[BillingFrequencyID] [int] NOT NULL,
[BaseFee] [int] NOT NULL,
[StartDate] [date] NULL,
[TakeoverFeeWaived] [bit] NOT NULL,
[TakeoverFee] [int] NULL,
[DeferredParticipantFee] [int] NOT NULL,
[AnyNonDeferredParticipants] [bit] NOT NULL,
[NonDeferredParticipantFee] [int] NULL,
[InitialRevenue] [int] NOT NULL,
[AnnualRevenue] [int] NOT NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL,
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Accounting].[BillingConfig] ADD CONSTRAINT [PK_BillingConfig] PRIMARY KEY CLUSTERED  ([BillingConfigID]) ON [PRIMARY]
GO
