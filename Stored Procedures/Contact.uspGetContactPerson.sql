SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Kenneth Leon>
-- Create date: <03/16/2017>
-- Description:	<Get existing contact person>
-- =============================================
CREATE PROCEDURE [Contact].[uspGetContactPerson]
	@CustomerID bigint

AS
BEGIN
	BEGIN TRY
		SELECT	p.*
				,cust.IsPrimary
				,cust.MainClient
				,ph.PhoneID AS PhoneNumberID, ph.Number as PhoneNumber, ph.PhoneTypeID
		FROM	[Customer].[Customer] cust 
		INNER JOIN [Customer].[Person] p ON cust.PersonID = p.PersonID
		LEFT JOIN [Map].[PersonPhoneMap] ppm on p.PersonID = ppm.PersonID
		LEFT JOIN [Customer].[Phone] ph	ON ppm.PhoneID = ph.PhoneID
		WHERE	cust.CustomerID = @CustomerID

	END TRY
	BEGIN CATCH
		IF(@@TRANCOUNT > 0 )
		BEGIN
			EXEC dbo.uspRethrowError
		END
	END CATCH
END




GO
