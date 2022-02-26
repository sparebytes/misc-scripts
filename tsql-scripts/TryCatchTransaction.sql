BEGIN TRY
    BEGIN TRANSACTION ___xxxx___;

	-- ...

    COMMIT TRANSACTION ___xxxx___;
END TRY
BEGIN CATCH
    IF(@@TRANCOUNT > 0)
        ROLLBACK TRAN ___xxxx___;

    DECLARE 
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (
        @ErrorMessage,
        @ErrorSeverity,
        @ErrorState    
    );
END CATCH
