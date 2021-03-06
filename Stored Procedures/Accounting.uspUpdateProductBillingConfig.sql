SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [Accounting].[uspUpdateProductBillingConfig]
 @UserName varchar(50),
 @CustomerID int,
 @ProductID int, 
 @BillingConfigID int,
 @BillingTypeID int,
 @BillingFrequencyID int,
 @StartDate date = null,
 @BaseFee int,
 @TakeoverFeeWaived bit,
 @TakeoverFee int = null,
 @DeferredParticipants int,
 @DeferredParticipantFee int,
 @AnyNonDeferredParticipants bit,
 @NonDeferredParticipants int = null,
 @NonDeferredParticipantFee int = null,
 @InitialRevenue int,
 @AnnualRevenue int,
 @Note [NOTE] = 'updated productBillingConfig'
 

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			UPDATE [Business].[Product]
				SET [NumberOfParticipant] = @DeferredParticipants,
					[AnyNonDeferredParticipants] = @AnyNonDeferredParticipants,
					[NumberOfNonDeferredParticipants] = @NonDeferredParticipants
				WHERE [ProductID] = @ProductID;


			EXEC [Accounting].[uspUpdateBillingConfig]
						@UserName = @UserName,
						@CustomerID = @CustomerID,
						@BillingTypeID = @BillingTypeID,
						@BillingFrequencyID = @BillingFrequencyID,
						@StartDate = @StartDate,
						@BaseFee = @BaseFee,
						@TakeoverFeeWaived = @TakeoverFeeWaived,
						@TakeoverFee = @TakeoverFee,
						@DeferredParticipantFee = @DeferredParticipantFee,
						@AnyNonDeferredParticipants = @AnyNonDeferredParticipants,
						@NonDeferredParticipantFee = @NonDeferredParticipantFee,
						@InitialRevenue = @InitialRevenue,
						@AnnualRevenue = @AnnualRevenue,
						@BillingConfigID = @BillingConfigID;

				


			/*UPDATE [Map].[ProductBillingConfigMap] 
				SET		ProductID = @ProductID,
						BillingConfigID = @BillingConfigID,  
						UpdatedBy = @UserName, 
						UpdatedDateTime = CURRENT_TIMESTAMP
				WHERE [ProductID] = @ProductID;*/

			SELECT c.BillingConfigID, c.BillingTypeID, c.BillingFrequencyID, 
					c.StartDate, c.BaseFee, c.TakeoverFeeWaived, c.TakeoverFee, 
					c.DeferredParticipantFee, c.AnyNonDeferredParticipants, c.NonDeferredParticipantFee,
					c.InitialRevenue, c.AnnualRevenue, c.UpdatedBy,
					p.NumberOfParticipant AS DeferredParticipants, p.NumberOfNonDeferredParticipants AS NonDeferredParticipants
				FROM [Map].[ProductBillingConfigMap] m
				INNER JOIN [Accounting].[BillingConfig] c ON m.BillingConfigID = c.BillingConfigID
				INNER JOIN [Business].[Product] p ON m.ProductID = p.ProductID
				WHERE m.BillingConfigID = @BillingConfigID;
			

			DECLARE @UpdatedDateTime datetime = CURRENT_TIMESTAMP
			execute [Customer].[uspUpdateCustomerDateAndUser] @CustomerID, @UserName, @UpdatedDateTime , @Note 

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
