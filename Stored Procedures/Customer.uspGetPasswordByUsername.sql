SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ================================================
-- Author:		<Hamlet Tamazian>
-- Create date: <10/17/2017>
-- Description:	<Get customer password given username>
-- ================================================
CREATE PROCEDURE [Customer].[uspGetPasswordByUsername] 
	@username varchar(50)
AS


BEGIN
	SELECT [PassCode]
	FROM [Customer].[Login]
	WHERE [UserName] = @username
END






GO
