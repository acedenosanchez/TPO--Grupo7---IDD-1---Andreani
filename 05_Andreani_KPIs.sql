USE Andreani;
GO

CREATE OR ALTER PROCEDURE Logistica.sp_KPI_CumplimientoEntregas
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        COUNT(*) AS TotalEntregas,
        SUM(CASE WHEN e.Fecha_Entrega <= p.Fecha_Entrega_Sol THEN 1 ELSE 0 END) AS EntregasATiempo,
        CAST(
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE SUM(CASE WHEN e.Fecha_Entrega <= p.Fecha_Entrega_Sol THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            END AS DECIMAL(5,2)
        ) AS PorcentajeCumplimiento
    FROM Logistica.Entrega e
    INNER JOIN Logistica.Pedido p ON e.ID_Pedido = p.ID_Pedido;

    PRINT 'KPI - Nivel de cumplimiento de entregas calculado correctamente.';
END;
GO

CREATE OR ALTER PROCEDURE Logistica.sp_KPI_TrazabilidadCompleta
    @ID_Lote INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
        l.ID_Lote,
        p.ID_Pedido,
        e.ID_Entrega,
        ec.Nombre AS EmpresaCliente,
        cd.Nombre AS ClienteDestino,
        e.Fecha_Salida,
        e.Fecha_Entrega,
        e.Temp_Entrega,
        e.Conformidad
    FROM Logistica.Lote l
    JOIN Logistica.DetallePedido dp ON l.ID_Lote = dp.ID_Lote
    JOIN Logistica.Pedido p ON dp.ID_Pedido = p.ID_Pedido
    JOIN Logistica.EmpresaCliente ec ON p.ID_EmpresaCliente = ec.ID_EmpresaCliente
    JOIN Logistica.ClienteDestino cd ON p.ID_ClienteDestino = cd.ID_ClienteDestino
    LEFT JOIN Logistica.Entrega e ON p.ID_Pedido = e.ID_Pedido
    WHERE l.ID_Lote = @ID_Lote;

    PRINT 'KPI - Trazabilidad completa del lote generada correctamente.';
END;
GO

CREATE OR ALTER PROCEDURE Logistica.sp_KPI_IndiceConsolidacion
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        COUNT(DISTINCT ID_DetallePedido) AS TotalDetallesConsolidados,
        COUNT(DISTINCT ID_Caja) AS TotalCajasUsadas,
        CAST(
            COUNT(DISTINCT ID_DetallePedido) * 1.0 / NULLIF(COUNT(DISTINCT ID_Caja), 0)
            AS DECIMAL(5,2)
        ) AS PromedioProductosPorCaja
    FROM Logistica.Consolidacion;

    PRINT 'KPI - Índice de consolidación calculado correctamente.';
END;
GO

CREATE OR ALTER PROCEDURE Logistica.sp_KPI_UtilizacionFlota
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        v.ID_Vehiculo,
        v.Patente,
        v.Capacidad,
        SUM(c.Peso) AS PesoTransportado,
        CAST(SUM(c.Peso) * 100.0 / v.Capacidad AS DECIMAL(5,2)) AS PorcentajeOcupacion
    FROM Logistica.Vehiculo v
    JOIN Logistica.Entrega e ON v.ID_Vehiculo = e.ID_Vehiculo
    JOIN Logistica.Pedido p ON e.ID_Pedido = p.ID_Pedido
    JOIN Logistica.DetallePedido dp ON p.ID_Pedido = dp.ID_Pedido
    JOIN Logistica.Consolidacion co ON dp.ID_DetallePedido = co.ID_DetallePedido
    JOIN Logistica.Caja c ON co.ID_Caja = c.ID_Caja
    GROUP BY v.ID_Vehiculo, v.Patente, v.Capacidad;

    PRINT 'KPI - Utilización de flota calculada correctamente.';
END;
GO

CREATE OR ALTER PROCEDURE Logistica.sp_KPI_IncidenciasPorErrorDeLote
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        v.Tipo_Error,
        COUNT(*) AS CantidadIncidencias,
        o.Nombre AS Operario,
        o.Rol,
        MAX(v.Fecha_Hora) AS UltimaIncidencia
    FROM Logistica.Validacion v
    JOIN Logistica.Operario o ON v.ID_Operario = o.ID_Operario
    GROUP BY v.Tipo_Error, o.Nombre, o.Rol
    ORDER BY CantidadIncidencias DESC;

    PRINT 'KPI - Incidencias por error de lote generadas correctamente.';
END;
GO
