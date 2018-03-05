SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Map].[uspInsertPersonAddress]
	
	  @PersonID int
	 ,@AddressID int
	 ,@IsPrimary int
	 ,@UserName varchar(50)
	 ,@Note [Note] = NULL
	 ,@out_personAddressMap int out
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN			
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP
			

			if @IsPrimary  = 1
				BEGIN
					UPDATE [Map].[PersonAddress]
					   SET 
						   [IsPrimary] = 0
						  ,[UpdatedDateTime] = @UpdateDateTime
						  ,[UpdatedBy] = @UserName
						  ,[Note] = @Note
					 WHERE [PersonID] = @personID
				END 
					
				INSERT INTO [Map].[PersonAddress]
					(
					 [PersonID]
					,[AddressID]
					,[IsPrimary]
					,[CreatedDateTime]
					,[CreatedBy]
					,[UpdatedDateTime]
					,[UpdatedBy]
					,[Note])
				VALUES
					(
					 @PersonID
					,@AddressID
					,@IsPrimary
					,@UpdateDateTime
					,@UserName
					,@UpdateDateTime
					,@UserName
					,@Note
					)
				
			 	 SET @out_personAddressMap = scope_identity()			 
		 

		COMMIT	 
		return @out_personAddressMap
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
