CREATE TABLE [Map].[OrganizationMemo]
(
[OrganizationMemoID] [bigint] NOT NULL IDENTITY(1, 1),
[OrganizationBranchID] [int] NOT NULL,
[MemoID] [int] NOT NULL,
[IsActive] [dbo].[TRUEFALSE] NULL,
[SortOrder] [int] NULL,
[CreatedDateTime] [dbo].[CREATEDDATETIME] NOT NULL CONSTRAINT [DF_OrganizationMemo_CreatedDateTime] DEFAULT (getdate()),
[CreatedBy] [dbo].[CREATEDBY] NOT NULL CONSTRAINT [DF_OrganizationMemo_CreatedBy] DEFAULT (user_name()),
[UpdatedDateTime] [dbo].[UPDATEDDATETIME] NOT NULL CONSTRAINT [DF_OrganizationMemo_UpdatedDateTime] DEFAULT (getdate()),
[UpdatedBy] [dbo].[UPDATEDBY] NOT NULL CONSTRAINT [DF_OrganizationMemo_UpdatedBy] DEFAULT (user_name())
) ON [PRIMARY]
GO
ALTER TABLE [Map].[OrganizationMemo] ADD CONSTRAINT [PK_OrganizationMemo] PRIMARY KEY CLUSTERED  ([OrganizationMemoID]) ON [PRIMARY]
GO
