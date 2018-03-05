SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<peter garabedian>
-- Create date: <2/15/2017>
-- Description:	<get Status Group Map ID By Status Name And Status Group name>
-- =============================================
CREATE PROCEDURE [Customer].[uspGetStatusGroupMapIDByStatusNameAndStatusGroupname]
	
	 @status varchar(50)
	,@statusGroup varchar(50)
	,@StatusGroupMapID int out
	
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @statusID			int	= ( SELECT StatusID			from [Definition].[Status]		where name = @status)
	DECLARE @StatusGroupID		int	= ( SELECT StatusGroupID	from [Definition].[StatusGroup] where Name = @statusGroup)
	SET @StatusGroupMapID			= ( SELECT StatusGroupMapID from [Map].[StatusGroupMap]		where StatusID = @statusID AND StatusGroupID = @StatusGroupID )
	return @StatusGroupMapID
	/*SELECT 
		StatusGroupMapID 
	from  
		[Map].[StatusGroupMap]
	where 
		StatusGroupMapID = @StatusGroupMapID*/

END





GO
