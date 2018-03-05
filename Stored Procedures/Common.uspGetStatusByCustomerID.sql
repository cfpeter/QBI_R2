SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <04/4/2017>
-- Description:	<get the staus name by given customerid>
-- =============================================
CREATE PROCEDURE  [Common].[uspGetStatusByCustomerID]
@CustomerID bigint
AS
BEGIN
	
	 

	select 
		sg.StatusGroupID
		,sg.name StatusGroupName
		,s.StatusID
		,s.name  StatusName

		from [Customer].[Customer] c
			inner join [Map].[StatusGroupMap] sgm on c.StatusGroupMapID = sgm.StatusGroupMapID
			inner join [Definition].[Status] s on sgm.StatusID = s.StatusID
			inner join [Definition].[StatusGroup] sg on sgm.StatusGroupID = sg.StatusGroupID
		where c.CustomerID = @CustomerID 


END


GO
