SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <06/05/2017>
-- Description:	<Get Customer Table with keys only By ID>
-- =============================================
CREATE PROCEDURE [Customer].[uspGetByID]
	@CustomerID BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT c.*
		   ,ct.Name CustomerTypeName
		   ,st.StatusID
		   ,st.Name StatusName
	FROM [Customer].[Customer] c
	INNER JOIN [Definition].[CustomerType] ct ON c.CustomerTypeID = ct.CustomerTypeID
	INNER JOIN [Map].[StatusGroupMap] sgm  ON sgm.StatusGroupMapID = c.StatusGroupMapID
	INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
	WHERE CustomerID = @CustomerID
END



GO
