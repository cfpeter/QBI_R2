SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<insert trustee address>
-- =============================================
CREATE PROCEDURE [Business].[uspInsertTrusteeAddress]
	@addressTypeID [int],
	@directionTypeID [int],
	@streetTypeID [int],
	@countryID [int],
	@address1 [varchar](100),
	@address2 [varchar](100),
	@city [varchar](50),
	@stateID [int],
	@zipcode [varchar](10),
	@zipcodeExt [varchar](5),

	@notes [dbo].[NOTE] = 'inserted trustee address',
	--@name [varchar](50) = NULL,
	--@description [text] = NULL,
	@username [varchar](50),
	@addressID [int] out

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO [Customer].[Address] (
				AddressTypeID,
				DirectionTYpeID,
				StreetTypeID,
				CountryID,
				Address1,
				Address2,
				City,
				StateID,
				Zipcode,
				ZipcodeExt,
				Note,
				CreatedBy,
				CreatedDateTime,
				UpdatedBy,
				UpdatedDateTime
			)

			VALUES (
				@addressTypeID,
				@directionTYpeID,
				@streetTypeID,
				@countryID,
				@address1,
				@address2,
				@city,
				@stateID,
				@zipcode,
				@zipcodeExt,
				@notes,
				@username,
				CURRENT_TIMESTAMP,
				@userName,
				CURRENT_TIMESTAMP
			);
			
			SET @addressID = scope_identity();

			RETURN @addressID
END






GO
