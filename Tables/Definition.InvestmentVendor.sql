CREATE TABLE [Definition].[InvestmentVendor]
(
[InvestmentVendorID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[DisclosureDocument] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NULL,
[CreatedBy] [dbo].[CREATEDBY] NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[InvestmentVendor] ADD CONSTRAINT [PK_InvestmentVendor] PRIMARY KEY CLUSTERED  ([InvestmentVendorID]) ON [PRIMARY]
GO
