SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<update trustee>
-- =============================================
CREATE PROCEDURE [Business].[uspUpdateTrustee]
	@trusteeID [bigint],
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

	@notes [dbo].[NOTE] = 'updated Trustee',
	@name [varchar](50) = NULL,
	@description [text] = NULL,

 	@UserName [varchar](50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE [Business].[Trustee] SET
				trusteeTypeID = @trusteeTypeID,
				firstName = @firstName,
				middleName = @middleName,
				lastName = @lastName,
				personTitleTypeID = @personTitleTypeID,
				companyName = @companyName,
				companyAlias = @companyAlias,
 		
				email = @email,
						 	
				note = @notes,
				name = @name,
				description = @description,
				CreatedBy = @Username,
				CreatedDateTime = CURRENT_TIMESTAMP,
				UpdatedBy = @UserName,
				UpdatedDateTime = CURRENT_TIMESTAMP
	WHERE TrusteeId = @TrusteeID


END



GO
