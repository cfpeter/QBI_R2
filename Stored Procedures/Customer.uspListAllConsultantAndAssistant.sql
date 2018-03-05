SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Peter Garabedian> 
-- Description:	<List All Consultant And Assistant>
-- =============================================
CREATE PROCEDURE  [Customer].[uspListAllConsultantAndAssistant]
 
AS
BEGIN
 
	SET NOCOUNT ON;

SELECT 
		c.customerID
		,p.PersonID 
		,p.firstName
		,p.lastName
		,p.Email

			FROM  [Customer].[customer] c 
			INNER JOIN [customer].[person] p on c.personID = p.personID 
			INNER join [Definition].[PersonTitleType] pt on p.PersonTitleTypeID = pt.PersonTitleTypeID
			WHERE pt.Name in (
								'Retirement Plan Associate',
								'Pension Plans Consultant',
								'Pension Plans Associate',
								'Junior Retirement Plans Consultant',
								'Administrative Assistant' ,
								'Retirement Plan Consultant',
								'Sr. Retirement Plan Consultant'
							) 
		
			
END










GO
