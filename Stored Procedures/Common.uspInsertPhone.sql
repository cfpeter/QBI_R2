SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Common].[uspInsertPhone]
	
	@PhoneTypeID int,
	@Number varchar(25), 
	@PersonID bigint,
	@Username varchar(50)
		
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN			
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP
			BEGIN
				INSERT INTO [Customer].[Phone]
					   ([PhoneTypeID]
					   ,[PersonID]
					   ,[Number]
					   ,[CreatedDateTime]
					   ,[CreatedBy]
					   ,[UpdatedDateTime]
					   ,[UpdatedBy]
						)
				 VALUES
					   (
					    @PhoneTypeID
					   ,@PersonID
					   ,@Number
					   ,CURRENT_TIMESTAMP
					   ,@Username
					   ,CURRENT_TIMESTAMP
					   ,@Username
					   )				
			 				
			END

		COMMIT
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
