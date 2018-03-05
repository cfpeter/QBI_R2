SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<update trustee address>
-- =============================================
CREATE PROCEDURE [Business].[uspUpdateTrusteeAddress]
	@trusteeID [int],
	@addressTypeID [int],
	@directionTypeID [int] = NULL,
	@streetTypeID [int] = NULL,
	@countryID [int],
	@address1 [varchar](100),
	@address2 [varchar](100),
	@city [varchar](50),
	@stateID [int] = NULL,
	@zipcode [varchar](10),
	@zipcodeExt [varchar](5) = NULL,

	@notes [dbo].[NOTE] = 'updated trustee address',

 	@userName [varchar](50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [Customer].[Address] SET
				AddressTypeID = @addressTypeID,
				DirectionTYpeID = @directionTYpeID,
				StreetTypeID = @streetTypeID,
				CountryID = @countryID,
				Address1 = @address1,
				Address2 = @address2,
				City = @city,
				StateID = @stateID,
				Zipcode = @zipcode,
				ZipcodeExt = @zipcodeExt,
				Note = @notes,
				CreatedBy = @username,
				CreatedDateTime = CURRENT_TIMESTAMP,
				UpdatedBy = @userName,
				UpdatedDateTime = CURRENT_TIMESTAMP
	WHERE AddressID = (SELECT AddressID FROM [Map].[TrusteeAddressMap] WHERE TrusteeID = @trusteeID)


END



GO
