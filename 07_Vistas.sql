USE Andreani;
GO

--Permite ver la trazabilidad completa de un pedido 

CREATE VIEW Logistica.vw_TrazabilidadCompleta AS
SELECT 
    ec.Nombre AS EmpresaCliente,
    cd.Nombre AS ClienteDestino,
    p.ID_Pedido,
    pr.Nombre AS Producto,
    l.ID_Lote,
    l.Fecha_Vencimiento,
    e.Fecha_Entrega,
    e.Temp_Entrega,
    o.Nombre AS Operario,
    v.Resultado AS Resultado_Validacion
FROM Logistica.EmpresaCliente ec
JOIN Logistica.Pedido p ON ec.ID_EmpresaCliente = p.ID_EmpresaCliente
JOIN Logistica.ClienteDestino cd ON p.ID_ClienteDestino = cd.ID_ClienteDestino
JOIN Logistica.DetallePedido dp ON p.ID_Pedido = dp.ID_Pedido
JOIN Logistica.Lote l ON dp.ID_Lote = l.ID_Lote
JOIN Logistica.Producto pr ON l.ID_Producto = pr.ID_Producto
JOIN Logistica.Entrega e ON p.ID_Pedido = e.ID_Pedido
JOIN Logistica.Validacion v ON p.ID_Pedido = v.ID_Pedido
JOIN Logistica.Operario o ON v.ID_Operario = o.ID_Operario;
GO

--Permite ver si se realizo la entrega dentro del tiempo establecido

CREATE VIEW Logistica.vw_EntregasCumplimiento AS
SELECT 
    p.ID_Pedido,
    cd.Nombre AS ClienteDestino,
    p.Fecha_Entrega_Sol AS Fecha_Comprometida,
    e.Fecha_Entrega AS Fecha_Real,
    CASE 
        WHEN e.Fecha_Entrega <= p.Fecha_Entrega_Sol THEN 'Cumplido'
        ELSE 'Fuera de Plazo'
    END AS Estado_Entrega
FROM Logistica.Pedido p
JOIN Logistica.Entrega e ON p.ID_Pedido = e.ID_Pedido
JOIN Logistica.ClienteDestino cd ON p.ID_ClienteDestino = cd.ID_ClienteDestino;
GO


--Permite ver que se entrego dentro de cada caja + info del cleunte, producto, lote y cantidad 

CREATE VIEW Logistica.vw_ConsolidacionDetalle AS
SELECT 
    c.ID_Caja,
    c.Codigo_QR,
    cd.Nombre AS ClienteDestino,
    pr.Nombre AS Producto,
    dp.Cantidad,
    l.ID_Lote,
    l.Fecha_Vencimiento
FROM Logistica.Consolidacion co
JOIN Logistica.Caja c ON co.ID_Caja = c.ID_Caja
JOIN Logistica.DetallePedido dp ON co.ID_DetallePedido = dp.ID_DetallePedido
JOIN Logistica.Lote l ON dp.ID_Lote = l.ID_Lote
JOIN Logistica.Producto pr ON l.ID_Producto = pr.ID_Producto
JOIN Logistica.ClienteDestino cd ON c.ID_ClienteDestino = cd.ID_ClienteDestino;
GO
