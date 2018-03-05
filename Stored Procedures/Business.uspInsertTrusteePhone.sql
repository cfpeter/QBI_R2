SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Hamlet Tamazian>
-- Create date: <08/16/2017>
-- Description:	<insert trustee phone>
-- =============================================
CREATE PROCEDURE [Business].[uspInsertTrusteePhone]
	@phoneTypeID [int],
	@number [varchar](25),
	@numberExt [varchar](10) = NULL,

	@notes [dbo].[NOTE] = 'inserted trustee phone',
	@username [varchar](50),
	@phoneID [int] out

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO [Customer].[Phone] (
				PhoneTypeID,
				Number,
				NumberExt,
				Note,
				CreatedBy,
				CreatedDateTime,
				UpdatedBy,
				UpdatedDateTime
			)

			VALUES (
				@phoneTypeID,
				@number,
				@numberExt,
				@notes,
				@username,
				CURRENT_TIMESTAMP,
				@userName,
				CURRENT_TIMESTAMP
			);
			
		SET @phoneID = scope_identity();

		RETURN @phoneID
END











GO
