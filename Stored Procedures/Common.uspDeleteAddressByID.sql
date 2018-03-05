SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <9/11/2017>
-- Description:	<Delete organization branch or person address by given addressID >
-- =============================================
CREATE PROCEDURE [Common].[uspDeleteAddressByID] 
	@AddressID				int,
	@OrganizationBranchID	bigint,
	@CustomerID				bigint, 
	@AddressTypeMap			varchar(50)
AS
BEGIN

	BEGIN TRY
		BEGIN TRAN	 
		
		
			DECLARE @Msg3 varchar(150)  = 'Code:50000 Unable to delete the the primary address. Please choose a different address as a primary and try again!'
			, @PrimaryAddressID bigint
			IF( @AddressTypeMap = 'Organization' )
				BEGIN
					DELETE FROM [Map].[OrganizationBranchAddress]
						WHERE AddressID = @AddressID AND OrganizationBranchID = @OrganizationBranchID
				END	
			ELSE if ( @AddressTypeMap = 'Person' )
				BEGIN
					SET @PrimaryAddressID = ( select addressID from [Customer].[Address] WHERE addressID = ( select addressID from [Map].[PersonAddress] where AddressID = @AddressID and IsPrimary = 1 ) ) 

					if(@PrimaryAddressID = @AddressID )
						BEGIN
						
							 RAISERROR (
									@Msg3, -- Message text.  
									14, -- Severity.  
									1 -- State.  
							);
						END
					else
						BEGIN
							DELETE FROM [Map].[PersonAddress]
								WHERE AddressID = @AddressID 
						END

				END
			ELSE if ( @AddressTypeMap = 'Trustee' )
				BEGIN

					SET @PrimaryAddressID = ( select addressID from [Customer].[Address] WHERE addressID = ( select addressID from [Map].[TrusteeAddressMap] where AddressID = @AddressID and IsPrimary = 1 ) ) 

					if(@PrimaryAddressID = @AddressID )
						BEGIN 
							 RAISERROR (
									@Msg3, -- Message text.  
									14, -- Severity.  
									1 -- State.  
							);
						END
					ELSE
						BEGIN
							DELETE FROM [Map].[TrusteeAddressMap]
								WHERE AddressID = @AddressID 
						END
					
				END
			ELSE
				BEGIN
					SET @Msg3 = 'Code:50000 Unable to identify the Address Type Map : ' + @AddressTypeMap
					RAISERROR (@Msg3, -- Message text.  
											16, -- Severity.  
											1 -- State.  
											);  
				END


			EXECUTE [Common].[uspDeleteAddress] @AddressID


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
