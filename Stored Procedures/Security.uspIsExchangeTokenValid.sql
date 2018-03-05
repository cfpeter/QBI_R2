SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian	>
-- Create date: <05/09/2016>
-- Description:	<Validate given token to make sure is active and authorised>
-- =============================================
CREATE PROCEDURE [Security].[uspIsExchangeTokenValid] 
	@Token varchar(250),
	@SolutionName varchar(50),
	@CID bigint = null out

AS
BEGIN
	DECLARE @DomainGroupMapID int
	DECLARE @Result varchar(50) 
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		
			SET @DomainGroupMapID =( SELECT DomainGroupMapID 
				FROM [Security].[TokenManagement]
				WHERE Token = @Token
				AND IsActive = 1
				)

			
			SET @Result = ( SELECT [Name]
			FROM [Definition].[Solution]
			WHERE SolutionID in ( SELECT [SolutionID]
								  FROM [Map].[DomainRoleMap]
								  WHERE DomainGroupMapID = @DomainGroupMapID
								  )
			AND Name = @SolutionName )
			IF( @Result IS NOT NULL )
				SET @CID = ( SELECT CustomerID FROM [Security].[TokenManagement] WHERE [Token] = @Token and [IsActive] = 1 )
			ELSE
				SET @CID = null
			
		
	END TRY
	BEGIN CATCH
		IF( @@TRANCOUNT > 0 )
		BEGIN
			exec dbo.uspRethrowError
		END
	END CATCH
END






GO
