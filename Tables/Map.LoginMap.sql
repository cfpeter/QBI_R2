CREATE TABLE [Map].[LoginMap]
(
[LoginMapID] [bigint] NOT NULL IDENTITY(1, 1),
[LoginID] [bigint] NOT NULL,
[DomainGroupMapID] [int] NOT NULL,
[AuthenticationTypeID] [int] NOT NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_LoginMap_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_LoginMap_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_LoginMap_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_LoginMap_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Map].[LoginMap] ADD CONSTRAINT [PK_LoginMap] PRIMARY KEY CLUSTERED  ([LoginMapID]) ON [PRIMARY]
GO
ALTER TABLE [Map].[LoginMap] ADD CONSTRAINT [FK_LoginMap_AuthenticationType] FOREIGN KEY ([AuthenticationTypeID]) REFERENCES [Definition].[AuthenticationType] ([AuthenticationTypeID])
GO
ALTER TABLE [Map].[LoginMap] ADD CONSTRAINT [FK_LoginMap_DomainGroupMap] FOREIGN KEY ([DomainGroupMapID]) REFERENCES [Map].[DomainGroupMap] ([DomainGroupMapID])
GO
ALTER TABLE [Map].[LoginMap] ADD CONSTRAINT [FK_LoginMap_Login] FOREIGN KEY ([LoginID]) REFERENCES [Customer].[Login] ([LoginID])
GO
