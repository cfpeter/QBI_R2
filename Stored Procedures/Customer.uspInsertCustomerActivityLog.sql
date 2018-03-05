SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<Insert Customer Activity Log >
-- =============================================
CREATE PROCEDURE [Customer].[uspInsertCustomerActivityLog]
	@customerID [bigint],
	@activity [varchar](100) = 'Logging undefined activity.',

	@notes [dbo].[NOTE] = NULL,
	@name [varchar](50) = NULL,
	@description [text] = NULL,

	@userName [varchar](50),
	
	@activityLogID [int] out

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO [Customer].[ActivityLog]
           ([CustomerID]
           ,[Activity]
           ,[Name]
           ,[Description]
  
           ,[CreatedDateTime]
           ,[CreatedBy]
           ,[UpdatedDateTime]
           ,[UpdatedBy]
           ,[Note])
     VALUES
           (@customerID
           ,@activity
           ,@name
           ,@description
          
           ,CURRENT_TIMESTAMP
           ,@userName
           ,CURRENT_TIMESTAMP
           ,@userName
           ,@notes)

	SET  @activityLogID = scope_identity();

	RETURN @activityLogID
END



GO
