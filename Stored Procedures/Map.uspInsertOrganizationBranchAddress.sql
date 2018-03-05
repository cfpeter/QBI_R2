SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Map].[uspInsertOrganizationBranchAddress]
	
	  @OrganizationBranchID int
	 ,@AddressID int
	 ,@IsPrimary int
	 ,@UserName varchar(50)
	 ,@Note [Note] = NULL
	 ,@out_OrganizationBranchAddressMap int out
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN			
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP
			BEGIN
			
			
				if @IsPrimary  = 1
				BEGIN
					UPDATE [Map].[OrganizationBranchAddress]
					   SET 
						   [IsPrimary] = 0
						  ,[UpdatedDateTime] = @UpdateDateTime
						  ,[UpdatedBy] = @UserName
						  ,[Note] = @Note
					 WHERE [OrganizationBranchID] = @OrganizationBranchID
				END 				 		

				INSERT INTO [Map].[OrganizationBranchAddress]
					(
					 [OrganizationBranchID]
					,[AddressID]
					,[IsPrimary]
					,[CreatedDateTime]
					,[CreatedBy]
					,[UpdatedDateTime]
					,[UpdatedBy]
					,[Note])
				VALUES
					(@OrganizationBranchID
					,@AddressID
					,IsNull(@IsPrimary,0)
					,@UpdateDateTime
					,@UserName
					,@UpdateDateTime
					,@UserName
					,@Note
					)
				
			 	 SET @out_OrganizationBranchAddressMap = scope_identity()			


				 
			END

		COMMIT	
		return @out_OrganizationBranchAddressMap
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
