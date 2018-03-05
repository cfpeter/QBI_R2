CREATE TABLE [Map].[OrganizationBranchAddress]
(
[OrganizationBranchAddressID] [bigint] NOT NULL IDENTITY(1, 1),
[OrganizationBranchID] [bigint] NOT NULL,
[AddressID] [int] NULL,
[IsPrimary] [dbo].[TRUEFALSE] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_OrganizationBranchAddress_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_OrganizationBranchAddress_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_OrganizationBranchAddress_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_OrganizationBranchAddress_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[OrganizationBranchAddress] ADD CONSTRAINT [PK_OrganizationBranchAddress] PRIMARY KEY CLUSTERED  ([OrganizationBranchAddressID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[OrganizationBranchAddress] ADD CONSTRAINT [FK_OrganizationBranchAddress_Address] FOREIGN KEY ([AddressID]) REFERENCES [Customer].[Address] ([AddressID])
GO
ALTER TABLE [Map].[OrganizationBranchAddress] ADD CONSTRAINT [FK_OrganizationBranchAddress_OrganizationBranch] FOREIGN KEY ([OrganizationBranchID]) REFERENCES [Customer].[OrganizationBranch] ([OrganizationBranchID])
GO
