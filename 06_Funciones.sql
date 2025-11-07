USE Andreani;
GO

--Calcular días entre pedido y entrega 
--Devuelve la cantidad de días transcurridos entre la fecha del pedido y la fecha de entrega efectiva.

CREATE FUNCTION Logistica.fn_DiasEntrePedidoYEntrega (@ID_Pedido INT)
RETURNS INT
AS
BEGIN
    DECLARE @Dias INT;
    SELECT @Dias = DATEDIFF(DAY, p.Fecha_Pedido, e.Fecha_Entrega)
    FROM Logistica.Pedido p
    JOIN Logistica.Entrega e ON p.ID_Pedido = e.ID_Pedido
    WHERE p.ID_Pedido = @ID_Pedido;
    RETURN @Dias;
END;
GO


--Validar temperatura media de un lote
--Calcula la temperatura promedio registrada en las entregas asociadas a un lote determinado, y devuelve un texto con la evaluación del rango de conservación.

CREATE FUNCTION Logistica.fn_ValidarTemperaturaMedia (@ID_Lote INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Promedio DECIMAL(4,1);

    -- Promedio de temperatura de entrega por lote
    SELECT @Promedio = AVG(e.Temp_Entrega)
    FROM Logistica.Entrega e
    JOIN Logistica.Pedido p ON e.ID_Pedido = p.ID_Pedido
    JOIN Logistica.DetallePedido dp ON p.ID_Pedido = dp.ID_Pedido
    WHERE dp.ID_Lote = @ID_Lote;

    -- Evaluación de rango
    IF @Promedio IS NULL RETURN 'Sin entregas registradas';
    IF @Promedio BETWEEN 2 AND 8 RETURN 'Correcto (Refrigerado)';
    IF @Promedio BETWEEN 15 AND 25 RETURN 'Correcto (Ambiente)';
    RETURN 'Fuera de rango';
END;
GO