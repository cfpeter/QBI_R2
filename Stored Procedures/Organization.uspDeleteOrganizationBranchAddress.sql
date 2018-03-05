SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <2/24/2017>
-- Description:	<Delete organization branch address by given addressID and OrganizationBranchID>
-- =============================================
CREATE PROCEDURE [Organization].[uspDeleteOrganizationBranchAddress] 
	@AddressID int,
	@OrganizationBranchID bigint,
	@CustomerID bigint,
	@UserName varchar(50),
	@Note [Note] = 'Address Deleted'
AS
BEGIN

	BEGIN TRY
		BEGIN TRAN	
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP

			DELETE FROM [Map].[OrganizationBranchAddress]
			WHERE AddressID = @AddressID AND OrganizationBranchID = @OrganizationBranchID

			EXECUTE [Common].[uspDeleteAddress] @AddressID

			execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note

		COMMIT	
		RETURN	@AddressID
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
