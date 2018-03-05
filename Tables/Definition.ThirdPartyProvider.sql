CREATE TABLE [Definition].[ThirdPartyProvider]
(
[ThirdPartyProviderID] [int] NOT NULL IDENTITY(1, 1),
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[NOTE] NULL,
[CreatedBy] [dbo].[CREATEDBY] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Definition].[ThirdPartyProvider] ADD CONSTRAINT [PK_ThirdPartyProvider] PRIMARY KEY CLUSTERED  ([ThirdPartyProviderID]) ON [PRIMARY]
GO
