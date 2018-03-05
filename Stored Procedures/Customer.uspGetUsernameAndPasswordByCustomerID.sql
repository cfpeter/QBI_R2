SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ================================================
-- Author:		<Hamlet Tamazian>
-- Create date: <10/17/2017>
-- Description:	<Get customer username and password by ID>
-- ================================================
CREATE PROCEDURE [Customer].[uspGetUsernameAndPasswordByCustomerID] 
	@customerID bigint
AS


BEGIN
	SELECT [UserName],[PassCode]
	FROM [Customer].[Login]
	WHERE [CustomerID] = @customerID
END






GO
