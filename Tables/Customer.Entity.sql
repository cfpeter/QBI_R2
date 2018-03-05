CREATE TABLE [Customer].[Entity]
(
[EntityID] [int] NOT NULL IDENTITY(1, 1),
[EntityTypeID] [int] NOT NULL,
[ProductOriginID] [int] NULL,
[ProductTypeMapID] [int] NULL,
[InvestmentVendorIDs] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CallerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CallerEmail] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CallerPhone] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LocationZipcode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Location] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Participants] [int] NULL,
[SalesPerson] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Assets] [int] NULL,
[Favorite] [dbo].[TRUEFALSE] NULL,
[FollowUp] [dbo].[TRUEFALSE] NULL,
[FollowUpDate] [date] NULL,
[Rollover] [dbo].[TRUEFALSE] NULL,
[Description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Entity_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Entity_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Entity_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Entity_UpdatedBy] DEFAULT (user_name()),
[ProductID] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Customer].[Entity] ADD CONSTRAINT [PK_Entity] PRIMARY KEY CLUSTERED  ([EntityID]) ON [PRIMARY]
GO
ALTER TABLE [Customer].[Entity] ADD CONSTRAINT [FK_Entity_EntityType1] FOREIGN KEY ([EntityTypeID]) REFERENCES [Definition].[EntityType] ([EntityTypeID])
GO
