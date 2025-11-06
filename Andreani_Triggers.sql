USE Andreani;
GO

CREATE TRIGGER Logistica.trg_AfterInsert_Consolidacion -- evita consolidar lotes vencidos o inactivos
ON Logistica.Consolidacion
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Logistica.DetallePedido dp ON i.ID_DetallePedido = dp.ID_DetallePedido
        JOIN Logistica.Lote l ON dp.ID_Lote = l.ID_Lote
        WHERE l.Estado <> 'Activo' OR l.Fecha_Vencimiento < GETDATE()
    )
    BEGIN
        PRINT 'Error: No se puede consolidar un lote vencido o inactivo.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    PRINT 'Consolidación registrada correctamente.';
END;
GO

CREATE TRIGGER Logistica.trg_AfterInsert_Entrega -- genera una validación automática al registrar una nueva entrega
ON Logistica.Entrega
AFTER INSERT
AS
BEGIN
    INSERT INTO Logistica.Validacion (ID_Lote, ID_Pedido, ID_Operario, Tipo_Error, Resultado)
    SELECT 
        dp.ID_Lote, 
        p.ID_Pedido,
        1 AS ID_Operario,
        NULL AS Tipo_Error,
        'Aprobado' AS Resultado
    FROM inserted i
    JOIN Logistica.Pedido p ON i.ID_Pedido = p.ID_Pedido
    JOIN Logistica.DetallePedido dp ON p.ID_Pedido = dp.ID_Pedido;

    PRINT 'Validación automática registrada por nueva entrega.';
END;
GO