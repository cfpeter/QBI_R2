SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <02/22/2017>
-- Description:	<Switch on and off primary address>
-- =============================================
CREATE PROCEDURE [Customer].[uspUpdatePersonPrimaryAddress]
	@CustomerID bigint,
	@AddressID int, 
	@IsPrimary bit,
	@UserName varchar(50),
	@Note [dbo].[Note] = 'Primary address updated'

AS
BEGIN
 
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN			
			DECLARE @UpdateDateTime datetime =  CURRENT_TIMESTAMP , @personID bigint

			SET @personID = ( select personID from [Customer].[Customer] where CustomerID = @CustomerID )

			BEGIN
				UPDATE [Map].[PersonAddress]
				   SET 
					   [IsPrimary] = 0
					  ,[UpdatedDateTime] = @UpdateDateTime
					  ,[UpdatedBy] = @UserName
					  ,[Note] = @Note
				 WHERE [PersonID] = @personID
				 

				UPDATE [Map].[PersonAddress]
				   SET 
					   [IsPrimary] = @IsPrimary
					  ,[UpdatedDateTime] = @UpdateDateTime
					  ,[UpdatedBy] = @UserName
					  ,[Note] = @Note
				 WHERE [PersonID] = @personID
				 AND [AddressID] = @AddressID

			
				execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID,@UserName, @UpdateDateTime , @Note  

				SELECT ad.*, pa.IsPrimary, st.Code, st.Name StateName, adt.Name AddressTypeName
				FROM [Customer].[Address]  ad 
					INNER JOIN [Map].[PersonAddress] pa on ad.AddressID = pa.AddressID
					INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
					INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
				WHERE pa.PersonID = @PersonID AND pa.AddressID = @addressID
				
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
