SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian>
-- Create date: <06/14/2016>
-- Description:	< get sales name by the person title >
-- =============================================
CREATE PROCEDURE  [Customer].[uspListSalesPerson]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select 
		  c.CustomerID
		, p.PersonID
		, p.FirstName + ' ' + p.LastName As fullName	-- branch listSalesPerson added by peter 6/16/16
		, p.DepartmentID
		, dept.Name departmentName
		, ptt.Name personTitleName
	from customer.person p 

	inner join [Customer].[Customer] c on p.PersonID = c.PersonID
	inner join [Definition].Department dept on p.DepartmentID = dept.DepartmentID
	inner join [Definition].[PersonTitleType] ptt on p.PersonTitleTypeID = ptt.PersonTitleTypeID
	
	where dept.Name = 'Sales'
	order by fullName
END









GO
