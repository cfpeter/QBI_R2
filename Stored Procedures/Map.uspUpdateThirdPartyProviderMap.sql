SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian>
-- Create date: <10/18/2017>
-- Description:	< update third party provider map>
-- =============================================
CREATE PROC [Map].[uspUpdateThirdPartyProviderMap] 
	
		 @CustomerID	bigint  
		,@OneLoginUserID bigint = null
		,@OneLoginAppID bigint  = null 
		,@OneLoginProductID bigint = null
		,@ExternalID bigint  = null
		,@CompanyID bigint  = null
		,@AccountID bigint  = null
		,@ThirdPartyProviderID int  = null
		,@APISent bit 
		,@Description varchar(45) = null
		,@UpdatedBy varchar(45)  = null
		,@note text = 'updated'  
	

AS 
BEGIN
	BEGIN TRY 
			UPDATE [Map].[ThirdPartyProviderMap]
			   SET 
				   [CustomerID]			= IsNull( @CustomerID			,[CustomerID] )
				  ,[OneLoginUserID]		= IsNull( @OneLoginUserID		,[OneLoginUserID] )
				  ,[OneLoginAppID]		= IsNull( @OneLoginAppID		,[OneLoginAppID] )
				  ,[OneLoginProductID]	= IsNull( @OneLoginProductID		,[OneLoginProductID] )
				  ,[ExternalID]			= IsNull( @ExternalID			,[ExternalID] )
				  ,[CompanyID]			= IsNull( @CompanyID			,[CompanyID] )
				  ,[AccountID]			= IsNull( @AccountID			,[AccountID] )
				,[ThirdPartyProviderID] = IsNull( @ThirdPartyProviderID ,[ThirdPartyProviderID] )
				  ,[APISent]			= @APISent
				  ,[Description]		= IsNull( @Description			,[Description] ) 
				  ,[UpdatedBy]			= IsNull( @UpdatedBy			,[UpdatedBy] )
				  ,[UpdatedDateTime]	= CURRENT_TIMESTAMP
				  ,[Note]				= IsNull( @Note					,[Note] )
			
			 WHERE CustomerID = @CustomerID
  

	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			EXEC dbo.uspRethrowError
		END
	END CATCH
END


















GO
