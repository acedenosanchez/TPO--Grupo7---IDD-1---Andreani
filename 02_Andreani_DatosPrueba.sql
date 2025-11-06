-- CARGA DE DATOS DE PRUEBA - ANDREANI

-- 1️ EMPRESAS CLIENTES, DESTINOS Y PRODUCTOS

USE Andreani;
GO

INSERT INTO Logistica.EmpresaCliente (Nombre, CUIT, Direccion, Contacto)
VALUES
('Laboratorios Roemmers', '30712345678', 'Av. Rivadavia 1234, CABA', 'Juan Pérez'),
('Droguería Central', '30698765432', 'Av. Belgrano 2345, CABA', 'Lucía Díaz');

INSERT INTO Logistica.ClienteDestino (Nombre, Tipo, Direccion, Provincia, Localidad)
VALUES
('Farmacia San Martín', 'Farmacia', 'Av. San Martín 555', 'Buenos Aires', 'Malvinas Argentinas'),
('Hospital Central', 'Hospital', 'Calle Salud 800', 'Buenos Aires', 'San Miguel');

INSERT INTO Logistica.Producto (Nombre, Descripcion, Condicion_Conservacion, Unidad_Medida)
VALUES
('Amoxicilina 500mg', 'Antibiótico en cápsulas', 'Ambiente', 'Caja'),
('Insulina NPH', 'Refrigerada entre 2 y 8°C', 'Refrigerado', 'Frasco'),
('Vacuna Antigripal', 'Mantener entre 2 y 8°C', 'Refrigerado', 'Ampolla');
GO


-- 2️ LOTES
INSERT INTO Logistica.Lote (ID_Producto, Fecha_Ingreso, Fecha_Vencimiento, Temperatura_Almacenamiento, Estado)
VALUES
(1, '2025-10-01', '2027-10-01', 20.0, 'Activo'),
(2, '2025-09-10', '2026-09-10', 5.0, 'Activo'),
(3, '2025-08-15', '2026-02-15', 4.0, 'Activo');
GO


-- 3️ PEDIDOS
INSERT INTO Logistica.Pedido (ID_EmpresaCliente, ID_ClienteDestino, Fecha_Pedido, Fecha_Entrega_Sol, Estado)
VALUES
(1, 1, '2025-11-01', '2025-11-03', 'Pendiente'),
(2, 2, '2025-11-02', '2025-11-04', 'Pendiente');
GO


-- 4️ DETALLES DE PEDIDO
INSERT INTO Logistica.DetallePedido (ID_Pedido, ID_Lote, Cantidad)
VALUES
(1, 1, 50),
(1, 2, 20),
(2, 3, 100);
GO


-- 5️ CAJAS Y CONSOLIDACIÓN
INSERT INTO Logistica.Caja (Codigo_QR, Peso, Volumen, ID_ClienteDestino)
VALUES
('QR001', 15.5, 0.30, 1),
('QR002', 20.0, 0.45, 2);
GO

INSERT INTO Logistica.Consolidacion (ID_Caja, ID_DetallePedido, Cantidad)
VALUES
(1, 1, 50),
(1, 2, 20),
(2, 3, 100);
GO


-- 6️ VEHÍCULOS Y RUTAS
INSERT INTO Logistica.Vehiculo (Patente, Tipo, Capacidad, Refrigerado, Chofer)
VALUES
('AB123CD', 'Camión', 3500.00, 1, 'Carlos Gómez'),
('AC456EF', 'Furgón', 2000.00, 0, 'Sofía Ruiz');
GO

INSERT INTO Logistica.Ruta (Descripcion, Zona, Kilometros)
VALUES
('Ruta Norte - Farmacias Zona Norte', 'GBA Norte', 120.5),
('Ruta Oeste - Hospitales', 'GBA Oeste', 98.3);
GO


-- 7️ ENTREGAS
INSERT INTO Logistica.Entrega (ID_Pedido, ID_Vehiculo, ID_Ruta, Fecha_Salida, Fecha_Entrega, Temp_Entrega, Conformidad)
VALUES
(1, 1, 1, '2025-11-03 08:00', '2025-11-03 12:30', 5.0, 1),
(2, 2, 2, '2025-11-04 09:00', '2025-11-04 13:00', 20.0, 1);
GO


-- 8️ OPERARIOS Y VALIDACIONES
INSERT INTO Logistica.Operario (Nombre, Rol, Turno)
VALUES
('Juan Torres', 'Operador', 'Mañana'),
('Ana López', 'Supervisor', 'Tarde'),
('Marcos Rivas', 'Auditor', 'Noche');
GO

INSERT INTO Logistica.Validacion (ID_Lote, ID_Pedido, ID_Operario, Tipo_Error, Resultado)
VALUES
(1, 1, 1, NULL, 'Aprobado'),
(2, 1, 2, 'Temperatura fuera de rango', 'Observado'),
(3, 2, 3, NULL, 'Aprobado');
GO
SELECT ID_EmpresaCliente, Nombre, CUIT, Contacto
FROM Logistica.EmpresaCliente;

SELECT Nombre, Tipo, Provincia, Localidad
FROM Logistica.ClienteDestino;
