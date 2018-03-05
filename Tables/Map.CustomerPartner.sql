CREATE TABLE [Map].[CustomerPartner]
(
[CustomerPartnerID] [int] NOT NULL IDENTITY(1, 1),
[PartnerID] [int] NOT NULL,
[CustomerID] [bigint] NOT NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_CustomerPartner_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_CustomerPartner_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_CustomerPartner_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_CustomerPartner_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[CustomerPartner] ADD CONSTRAINT [PK_CustomerPartner] PRIMARY KEY CLUSTERED  ([CustomerPartnerID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[CustomerPartner] ADD CONSTRAINT [FK_CustomerPartner_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [Customer].[Customer] ([CustomerID])
GO
ALTER TABLE [Map].[CustomerPartner] ADD CONSTRAINT [FK_CustomerPartner_Partner] FOREIGN KEY ([PartnerID]) REFERENCES [Partner].[Partner] ([PartnerID])
GO
