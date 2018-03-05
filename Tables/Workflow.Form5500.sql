CREATE TABLE [Workflow].[Form5500]
(
[Form5500ID] [int] NOT NULL IDENTITY(1, 1),
[FormSource] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormYear] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EIN] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PlanName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PlanNumber] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BusinessCode] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalParticipants] [int] NULL,
[TotalAssets] [int] NULL,
[FormDocType] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FilePath] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorMessage] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorDetail] [dbo].[NOTE] NULL,
[SortOrder] [dbo].[SORTORDER] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_Form5500_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_Form5500_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_Form5500_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_Form5500_UpdatedBy] DEFAULT (user_name()),
[Note] [dbo].[NOTE] NULL,
[ConsultantName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ConsultantEMail] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VerifiesAddress] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Workflow].[Form5500] ADD CONSTRAINT [PK_Form5500] PRIMARY KEY CLUSTERED  ([Form5500ID]) ON [PRIMARY]
GO
