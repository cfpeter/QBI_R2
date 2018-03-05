SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <4/17/2017>
-- Description:	<get address information by addressID>
-- =============================================
CREATE PROCEDURE [Common].[uspGetPersonAddressByCustomerID]
	@customerID int

AS
BEGIN 

	SET NOCOUNT ON;
	
	DECLARE @personID int

	SET @personID = ( SELECT PersonID from [Customer].[Customer] WHERE CustomerID = @customerID )

	SELECT ad.*, pam.IsPrimary IsPrimaryAddress, st.Code StateCode , st.Name StateName, adt.Name AddressTypeName
	FROM [Map].[PersonAddress]  pam 
	INNER JOIN [Customer].[Address] ad on pam.AddressID = ad.AddressID
	INNER JOIN [Definition].[AddressType] adt ON ad.AddressTypeID = adt.AddressTypeID
	INNER JOIN [Definition].[State] st ON ad.StateID = st.StateID
	WHERE pam.PersonID = @personID	
END


GO
