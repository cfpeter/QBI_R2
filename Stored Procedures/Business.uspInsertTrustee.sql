SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<insert trustee>
-- =============================================
CREATE PROCEDURE [Business].[uspInsertTrustee]
	@trusteeTypeID [int],
	@prefixID [int] = NULL,
	@firstName [varchar](50) = NULL,
	@middleName [varchar](50) = NULL,
	@lastName [varchar](50) = NULL,
	@suffix [int] = NULL,
	@personTitleTypeID [int] = NULL,
	@companyName [varchar](150) = NULL,
	@companyAlias [varchar](50) = NULL,
	@email [varchar](50) = NULL,

	@notes [dbo].[NOTE] = 'inserted trustee',
	@name [varchar](50) = NULL,
	@description [text] = NULL,

	@UserName [varchar](50),
	
	@trusteeID [int] out

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO [Business].[Trustee] (
				trusteeTypeID,
				firstName,
				middleName,
				lastName,
				personTitleTypeID,
				companyName,
				companyAlias,
				email,
						
				note,
				name,
				description,
				CreatedBy,
				CreatedDateTime,
				UpdatedBy,
				UpdatedDateTime
		) VALUES (
				@trusteeTypeID,
				@firstName,
				@middleName,
				@lastName,
				@personTitleTypeID,
				@companyName,
				@companyAlias,
				@email,
						
				@notes,
				@name,
				@description,
				@Username,
				CURRENT_TIMESTAMP,
				@UserName,
				CURRENT_TIMESTAMP
		)

	SET  @trusteeID = scope_identity();

	RETURN @trusteeID
END



GO
