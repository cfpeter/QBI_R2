SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Shirak Avakian>
-- Create date: <07/28/2016>
-- Description:	<Update Customer status by given customerID and Status Name>
-- =============================================
CREATE PROCEDURE [Customer].[uspUpdateCustomerStatus] 
	@CustomerID int,
	@StatusID int,
	@StatusGroupID int,
	@UserName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @StatusGroupMapID int = ( SELECT sgm.StatusGroupMapID 
									  FROM [Map].[StatusGroupMap] sgm
									  INNER JOIN [Definition].[Status] s on sgm.StatusID = s.StatusID
									  INNER JOIN [Definition].[StatusGroup] sg on sgm.StatusGroupID = sg.StatusGroupID
									  WHERE s.StatusID = @StatusID 
									  AND sg.StatusGroupID = @StatusGroupID )
	

	UPDATE [Customer].[Customer]
	   SET [StatusGroupMapID] = @StatusGroupMapID
		  ,[UpdatedDateTime] = CURRENT_TIMESTAMP
		  ,[UpdatedBy] = @UserName
	 WHERE CustomerID = @CustomerID

END





GO
