SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Customer].[uspTerminateProspect]

@isActive int ,
@customerID int ,
@StatusName varchar(45) OUT

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN

		 DECLARE @StatusGroupMap int

		if ( @isActive = 0 )
			BEGIN
				SET @StatusGroupMap = (SELECT TOP 1 sgm.StatusGroupMapID 
										FROM [Map].[StatusGroupMap] sgm 
								INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
				WHERE st.Name = 'Terminated' and sgm.StatusGroupID = 2 )
			END

		else if( @isActive = 1 )
			BEGIN
				SET @StatusGroupMap = (SELECT TOP 1 sgm.StatusGroupMapID 
										FROM [Map].[StatusGroupMap] sgm 
								INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
				WHERE st.Name = 'Pending' and sgm.StatusGroupID = 2 )
			END

	

	 UPDATE [Customer].[Customer] 
			SET  
				isActive = @isActive,
				StatusGroupMapID = @StatusGroupMap

		WHERE CustomerID = @customerID	

		set @StatusName = (SELECT TOP 1 st.Name 
			FROM [Map].[StatusGroupMap] sgm 
			INNER JOIN [Definition].[Status] st ON sgm.StatusID = st.StatusID
		where sgm.StatusGroupMapID = @StatusGroupMap)

		
		  
		COMMIT
	
	 END TRY
	 BEGIN CATCH
		if(@@TRANCOUNT > 0 )
		BEGIN
			ROLLBACK
			exec dbo.uspRethrowError
		END
	 END CATCH
END











GO
