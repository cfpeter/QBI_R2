CREATE TABLE [Map].[ThirdPartyProviderMap]
(
[ThirdPartyProviderMapID] [bigint] NOT NULL IDENTITY(1, 1),
[CustomerID] [bigint] NULL,
[OneLoginUserID] [bigint] NULL,
[OneLoginAppID] [bigint] NULL,
[ExternalID] [bigint] NULL,
[CompanyID] [bigint] NULL,
[AccountID] [bigint] NULL,
[ThirdPartyProviderID] [int] NULL,
[APISent] [bit] NULL,
[Description] [dbo].[NOTE] NULL,
[CreatedBy] [dbo].[CREATEDBY] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NULL,
[Note] [dbo].[NOTE] NULL,
[OneLoginProductID] [bigint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[ThirdPartyProviderMap] ADD CONSTRAINT [PK_ThirdPartyProviderMap] PRIMARY KEY CLUSTERED  ([ThirdPartyProviderMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[ThirdPartyProviderMap] ADD CONSTRAINT [FK_ThirdPartyProviderMap_customer] FOREIGN KEY ([CustomerID]) REFERENCES [Customer].[Customer] ([CustomerID])
GO
ALTER TABLE [Map].[ThirdPartyProviderMap] ADD CONSTRAINT [FK_ThirdPartyProviderMap_ThirdPartyProvider] FOREIGN KEY ([ThirdPartyProviderID]) REFERENCES [Definition].[ThirdPartyProvider] ([ThirdPartyProviderID])
GO
