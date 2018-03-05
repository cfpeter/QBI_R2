SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <09/19/2017>
-- Description:	<Switch on and off primary address>
-- =============================================
CREATE PROCEDURE [Business].[uspTrusteeAddressPrimaryCheck]
	@TrusteeID bigint,
	@AddressID int,
	@IsPrimary bit,
	@UserName varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN			
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP
			BEGIN
				UPDATE [Map].[TrusteeAddressMap]
				   SET 
					   [IsPrimary] = 0
				 WHERE TrusteeID = @TrusteeID
				 

				UPDATE [Map].[TrusteeAddressMap]
				   SET 
					   [IsPrimary] = @IsPrimary
					  ,[UpdatedDateTime] = @UpdateDateTime
					  ,[UpdatedBy] = @UserName
				 WHERE [TrusteeID] = @TrusteeID
				 AND [AddressID] = @AddressID
				
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
