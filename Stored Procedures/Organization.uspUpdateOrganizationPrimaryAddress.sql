SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <02/22/2017>
-- Description:	<Switch on and off primary address>
-- =============================================
CREATE PROCEDURE [Organization].[uspUpdateOrganizationPrimaryAddress]
	@CustomerID bigint,
	@AddressID int,
	@OrganizationBranchID bigint,
	@IsPrimary bit,
	@UserName varchar(50),
	@Note [dbo].[Note] = 'Primary address updated'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN			
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP
			BEGIN
				UPDATE [Map].[OrganizationBranchAddress]
				   SET 
					   [IsPrimary] = 0
					  ,[UpdatedDateTime] = @UpdateDateTime
					  ,[UpdatedBy] = @UserName
					  ,[Note] = @Note
				 WHERE [OrganizationBranchID] = @OrganizationBranchID
				 

				UPDATE [Map].[OrganizationBranchAddress]
				   SET 
					   [IsPrimary] = @IsPrimary
					  ,[UpdatedDateTime] = @UpdateDateTime
					  ,[UpdatedBy] = @UserName
					  ,[Note] = @Note
				 WHERE [OrganizationBranchID] = @OrganizationBranchID
				 AND [AddressID] = @AddressID

				execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note
							
				execute [Organization].[uspGetOrganizationBranchAddress] @AddressID, @OrganizationBranchID
				
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
