SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <01/25/2017>
-- Description:	<Insert new workflow for product and and product type>
-- =============================================
CREATE PROCEDURE [Workflow].[uspInsertProductWorkflow] 
	-- Add the parameters for the stored procedure here
	 @ProductID bigint
    ,@WorkflowID int
    ,@Name varchar(50)
	,@UpdatedBy [dbo].[UPDATEDBY]
    ,@UUIDCode varchar(250) = null
    ,@Description [dbo].[NOTE] = null
    ,@IsActive [dbo].[TRUEFALSE] = null
    ,@SortOrder [dbo].[SORTORDER] = null  
    ,@Note [dbo].[NOTE]
AS
BEGIN
	DECLARE @statusGroupMapID int 
	EXECUTE [Customer].[uspGetStatusGroupMapIDByStatusNameAndStatusGroupname] 'In Progress', 'workflow', @statusGroupMapID out
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @UpdatedDateTime datetime = CURRENT_TIMESTAMP
    INSERT INTO [Map].[ProductWorkflow]
           ([ProductID]
           ,[WorkflowID]
           ,[Name]
		   ,[StatusGroupMapID]
           ,[UUIDCode]
           ,[Description]
           ,[IsActive]
           ,[SortOrder]
           ,[CreatedDateTime]
           ,[CreatedBy]
           ,[UpdatedDateTime]
           ,[UpdatedBy]
           ,[Note])
     VALUES
           (@ProductID
           ,@WorkflowID
           ,@Name
		   ,@statusGroupMapID
           ,@UUIDCode
           ,@Description
           ,@IsActive
           ,@SortOrder
           ,@UpdatedDateTime
           ,@UpdatedBy
           ,@UpdatedDateTime
           ,@UpdatedBy
           ,@Note)
END












GO
