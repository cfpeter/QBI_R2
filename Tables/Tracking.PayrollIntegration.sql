CREATE TABLE [Tracking].[PayrollIntegration]
(
[PayrollIntegrationID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [bigint] NULL,
[ReferenceID] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[clientID] [int] NULL,
[client] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[policyID] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[processType] [smallint] NULL,
[processStart] [datetime] NOT NULL,
[vendor] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[result] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[originalFileName] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[sentFileName] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[processEnd] [datetime] NOT NULL,
[processMessages] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [dbo].[DESCRIPTION] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL,
[CreatedBy] [dbo].[CREATEDBY] NOT NULL,
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL,
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL,
[Note] [dbo].[NOTE] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Tracking].[PayrollIntegration] ADD CONSTRAINT [PK_PayrollIntegration] PRIMARY KEY CLUSTERED  ([PayrollIntegrationID]) ON [PRIMARY]
GO
