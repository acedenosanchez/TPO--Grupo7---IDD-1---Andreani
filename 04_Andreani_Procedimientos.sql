USE Andreani;
GO

CREATE OR ALTER PROCEDURE Logistica.sp_RegistrarPedido
	@ID_EmpresaCliente INT,
	@ID_ClienteDestino INT,
	@Fecha_Entrega_Solicitada DATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID_Pedido INT;

	-- Validación de empresa y cliente
	IF NOT EXISTS (
		SELECT 1
		FROM Logistica.EmpresaCliente
		WHERE ID_EmpresaCliente = @ID_EmpresaCliente)
	BEGIN
		PRINT 'Error: La empresa cliente no existe.'
		RETURN
	END

	IF NOT EXISTS (
			SELECT 1
			FROM Logistica.ClienteDestino
			WHERE ID_ClienteDestino = @ID_ClienteDestino)
	BEGIN
		PRINT  'Error: El cliente destino no existe.'
		RETURN;
	END

	INSERT INTO Logistica.Pedido (ID_EmpresaCliente, ID_ClienteDestino, Fecha_Pedido, Fecha_Entrega_Sol, Estado)
	VALUES (@ID_EmpresaCliente, @ID_ClienteDestino, GETDATE(), @Fecha_Entrega_Solicitada, 'Pendiente');
	SET @ID_Pedido = SCOPE_IDENTITY();
	PRINT CONCAT('Pedido registrado correctamente con ID: ', @ID_Pedido)
END;
GO

CREATE OR ALTER PROCEDURE Logistica.sp_RegistrarConsolidacion
	@ID_Caja INT,
	@ID_DetallePedido INT,
	@Cantidad INT
AS
BEGIN
	SET NOCOUNT ON;

	--Validar existencia de caja y detalle
	IF NOT EXISTS (
		SELECT 1
		FROM Logistica.Caja
		WHERE ID_Caja = @ID_Caja
	)
	BEGIN
		PRINT 'Error: El detalle de pedido no existe.';
		RETURN;
	END
	IF NOT EXISTS (
		SELECT 1
		FROM Logistica.DetallePedido
		WHERE ID_DetallePedido = @ID_DetallePedido
	)
	BEGIN
		PRINT 'Error: El detalle de pedido no existe.';
		RETURN;
	END

	--Insertar consolidacion
	INSERT INTO Logistica.Consolidacion (ID_Caja, ID_DetallePedido, Cantidad)
	VALUES (@ID_Caja, @ID_DetallePedido, @Cantidad)

	PRINT 'Consolidación registrada exitosamente.';
END;
GO

CREATE OR ALTER PROCEDURE Logistica.sp_RegistrarEntrega
	@ID_Pedido INT,
	@ID_Vehiculo INT,
	@ID_Ruta INT,
	@Temp_Entrega DECIMAL(4,1)
AS
BEGIN
	SET NOCOUNT ON;

	--Validar existencia de pedido, vehiculo y ruta
	IF NOT EXISTS (
		SELECT 1
		FROM Logistica.Pedido
		WHERE ID_Pedido = @ID_Pedido
	)
	BEGIN
		PRINT 'Error: El pedido no existe.';
		RETURN;
	END
	
	IF NOT EXISTS (
		SELECT 1
		FROM Logistica.Vehiculo
		WHERE ID_Vehiculo = @ID_Vehiculo
	)
	BEGIN
		PRINT 'Error: El vehiculo no existe.';
		RETURN;
	END

	IF NOT EXISTS (
		SELECT 1
		FROM Logistica.Ruta
		WHERE ID_Ruta = @ID_Ruta
	)
	BEGIN
		PRINT 'Error: La ruta no existe.';
		RETURN;
	END

	-- Insertar entrega
	INSERT INTO Logistica.Entrega (ID_Pedido, ID_Vehiculo, ID_Ruta, Fecha_Salida, Fecha_Entrega, Temp_Entrega,Conformidad)
	VALUES (@ID_Pedido, @ID_Vehiculo, @ID_Ruta, GETDATE(), NULL, @Temp_Entrega, 0)

	-- Actualizar estado del pedido
	UPDATE Logistica.Pedido
	SET Estado = 'Despachado'
	WHERE ID_Pedido = @ID_Pedido;

	PRINT 'Entrega registrada correctamente. Validacion automatica generada.';
END;
GO

CREATE OR ALTER PROCEDURE Logistica.sp_RegistrarIncidencia
	@ID_Lote INT,
	@ID_Pedido INT,
	@ID_Operario INT,
	@Tipo_Error NVARCHAR(100),
	@Resultado NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	-- Validacion de existencia de operario, lote y pedido
	IF NOT EXISTS (
		SELECT 1
		FROM Logistica.Operario
		WHERE ID_Operario = @ID_Operario
	)
	BEGIN
		PRINT 'Error: El operario no existe.';
		RETURN;
	END

	IF NOT EXISTS (
		SELECT 1
		FROM Logistica.Lote
		WHERE ID_Lote = @ID_Lote
	)
	BEGIN
		PRINT 'Error: El lote no existe.';
		RETURN;
	END

	IF NOT EXISTS (
		SELECT 1
		FROM Logistica.Pedido
		WHERE ID_Pedido = @ID_Pedido
	)
	BEGIN
		PRINT 'Error: El pedido no existe.';
		RETURN;
	END

	-- Insert incidencia en validacion
	INSERT INTO Logistica.Validacion (ID_Lote, ID_Pedido, ID_Operario, Tipo_Error, Resultado)
	VALUES (@ID_Lote, @ID_Pedido, @ID_Operario, @Tipo_Error, @Resultado);

	PRINT 'Incidencia registrada correctamente.';
END;
GO

EXEC Logistica.sp_RegistrarPedido 1, 2, '2025-11-15';
EXEC Logistica.sp_RegistrarConsolidacion 1, 3, 50;
EXEC Logistica.sp_RegistrarEntrega 1, 1, 2, 5.0;
EXEC Logistica.sp_RegistrarIncidencia 2, 1, 3, 'Temperatura fuera de rango', 'Observado';
GO