SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [Accounting].[uspUpdateBillingConfig]
 @UserName varchar(50),
 @CustomerID int,
 @BillingTypeID int,
 @BillingFrequencyID int,
 @StartDate date = null,
 @BaseFee int,
 @TakeoverFeeWaived bit,
 @TakeoverFee int = null,
 @DeferredParticipantFee int,
 @AnyNonDeferredParticipants bit,
 @NonDeferredParticipantFee int = null,
 @InitialRevenue int,
 @AnnualRevenue int,
 @BillingConfigID int
 

AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		 
			UPDATE [Accounting].[BillingConfig]
				SET		[BillingTypeID] = @BillingTypeID,
						[BillingFrequencyID] = @BillingFrequencyID,
						[StartDate] = @StartDate,
						[BaseFee] = @BaseFee,
						[TakeoverFeeWaived] = @TakeoverFeeWaived,
						[TakeoverFee] = @TakeoverFee,
						[DeferredParticipantFee] = @DeferredParticipantFee,
						[AnyNonDeferredParticipants] = @AnyNonDeferredParticipants,
						[NonDeferredParticipantFee] = @NonDeferredParticipantFee,
						[InitialRevenue] = @InitialRevenue,
						[AnnualRevenue] = @AnnualRevenue,
						[UpdatedBy] = @UserName,
						[UpdatedDateTime] = CURRENT_TIMESTAMP
				WHERE [BillingConfigID] = @BillingConfigID;

		COMMIT
		
		RETURN @BillingConfigID;
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
