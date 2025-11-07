-- CARGA DE DATOS DE PRUEBA - ANDREANI

-- 1️ EMPRESAS CLIENTES, DESTINOS Y PRODUCTOS

USE Andreani;
GO

INSERT INTO Logistica.EmpresaCliente (Nombre, CUIT, Direccion, Contacto)
VALUES
('Laboratorios Roemmers', '30712345678', 'Av. Rivadavia 1234, CABA', 'Juan Pérez'),
('Droguería Central', '30698765432', 'Av. Belgrano 2345, CABA', 'Lucía Díaz'),
('Laboratorios Bagó', '30765432109', 'Calle Independencia 4500, CABA', 'Martín López'),
('Laboratorios Elea', '30734567891', 'Av. Corrientes 1122, CABA', 'Laura Fernández'),
('Pfizer Argentina', '30543210987', 'Av. Santa Fe 3344, CABA', 'Carlos Ramírez'),
('Roche Pharma', '30789123456', 'Av. Libertador 5050, Vicente López', 'Sofía Gómez'),
('Gador S.A.', '30876543210', 'Av. Córdoba 5500, CABA', 'Pablo Méndez'),
('Andrómaco', '30987654321', 'Ruta 8 km 45, Pilar', 'Andrea Suárez'),
('Droguería del Sud', '30711122334', 'Av. San Juan 1200, CABA', 'Emilia Torres'),
('Bayer Argentina', '30456789123', 'Panamericana km 30, Tigre', 'Federico Silva');
GO


INSERT INTO Logistica.ClienteDestino (Nombre, Tipo, Direccion, Provincia, Localidad)
VALUES
('Farmacia San Martín', 'Farmacia', 'Av. San Martín 555', 'Buenos Aires', 'Malvinas Argentinas'),
('Hospital Central', 'Hospital', 'Calle Salud 800', 'Buenos Aires', 'San Miguel'),
('Clínica del Norte', 'Clinica', 'Ruta 197 1200', 'Buenos Aires', 'Tigre'),
('Farmacia Los Andes', 'Farmacia', 'Calle Mitre 2300', 'Córdoba', 'Córdoba Capital'),
('Hospital Italiano', 'Hospital', 'Av. Italia 1000', 'Buenos Aires', 'La Plata'),
('Clínica San José', 'Clinica', 'Av. Roca 220', 'Santa Fe', 'Rosario'),
('Farmacia Esperanza', 'Farmacia', 'Calle Belgrano 45', 'Mendoza', 'Godoy Cruz'),
('Hospital de Niños', 'Hospital', 'Av. Libertad 700', 'Buenos Aires', 'San Isidro'),
('Farmacia del Sol', 'Farmacia', 'Calle Moreno 340', 'Buenos Aires', 'Escobar'),
('Clínica Santa María', 'Clinica', 'Av. Constitución 3200', 'Buenos Aires', 'Morón');
GO


INSERT INTO Logistica.Producto (Nombre, Descripcion, Condicion_Conservacion, Unidad_Medida)
VALUES
('Amoxicilina 500mg', 'Antibiótico oral', 'Ambiente', 'Caja'),
('Ibuprofeno 400mg', 'Analgésico y antiinflamatorio', 'Ambiente', 'Blíster'),
('Insulina NPH', 'Refrigerada entre 2 y 8°C', 'Refrigerado', 'Frasco'),
('Vacuna Antigripal', 'Mantener entre 2 y 8°C', 'Refrigerado', 'Ampolla'),
('Paracetamol 500mg', 'Analgésico y antipirético', 'Ambiente', 'Caja'),
('Omeprazol 20mg', 'Antiácido', 'Ambiente', 'Blíster'),
('Vitamina D3', 'Suplemento alimenticio', 'Ambiente', 'Frasco'),
('Vacuna COVID-19', 'Biológico sensible, mantener entre 2 y 8°C', 'Refrigerado', 'Ampolla'),
('Morfina 10mg', 'Analgesia hospitalaria', 'Refrigerado', 'Ampolla'),
('Cefalexina 500mg', 'Antibiótico oral', 'Ambiente', 'Caja');
GO


-- 2️ LOTE
INSERT INTO Logistica.Lote (ID_Producto, Fecha_Ingreso, Fecha_Vencimiento, Temperatura_Almacenamiento, Estado)
VALUES
(1, '2025-09-01', '2027-09-01', 22.0, 'Activo'),
(2, '2025-08-15', '2027-08-15', 20.0, 'Activo'),
(3, '2025-09-10', '2026-09-10', 5.0, 'Activo'),
(4, '2025-10-01', '2026-10-01', 4.0, 'Activo'),
(5, '2025-07-20', '2026-07-20', 23.0, 'Activo'),
(6, '2025-09-05', '2027-09-05', 21.0, 'Activo'),
(7, '2025-08-25', '2026-08-25', 20.0, 'Activo'),
(8, '2025-09-18', '2026-03-18', 3.5, 'Activo'),
(9, '2025-10-02', '2026-04-02', 6.0, 'Activo'),
(10, '2025-09-12', '2027-09-12', 20.0, 'Activo');
GO



-- 3️ PEDIDO
INSERT INTO Logistica.Pedido (ID_EmpresaCliente, ID_ClienteDestino, Fecha_Pedido, Fecha_Entrega_Sol, Estado)
VALUES
(1, 1, '2025-11-01', '2025-11-03', 'Pendiente'),
(2, 2, '2025-11-02', '2025-11-04', 'Pendiente'),
(3, 3, '2025-10-28', '2025-10-30', 'En Preparación'),
(4, 4, '2025-10-25', '2025-10-28', 'Despachado'),
(5, 5, '2025-10-20', '2025-10-23', 'Entregado'),
(6, 6, '2025-11-03', '2025-11-06', 'Pendiente'),
(7, 7, '2025-10-27', '2025-10-30', 'Entregado'),
(8, 8, '2025-11-04', '2025-11-07', 'Pendiente'),
(9, 9, '2025-10-29', '2025-11-01', 'En Preparación'),
(10, 10, '2025-11-05', '2025-11-08', 'Pendiente');
GO



-- 4️ DETALLE DE PEDIDO
INSERT INTO Logistica.DetallePedido (ID_Pedido, ID_Lote, Cantidad)
VALUES
(1, 1, 50),
(1, 3, 30),
(2, 2, 40),
(2, 4, 25),
(3, 5, 100),
(4, 6, 75),
(5, 7, 60),
(6, 8, 90),
(7, 9, 120),
(8, 10, 80);
GO



-- 5️ CAJA
INSERT INTO Logistica.Caja (Codigo_QR, Peso, Volumen, ID_ClienteDestino)
VALUES
('QR001', 15.5, 0.30, 1),
('QR002', 20.0, 0.45, 2),
('QR003', 12.3, 0.25, 3),
('QR004', 18.8, 0.40, 4),
('QR005', 22.1, 0.50, 5),
('QR006', 17.6, 0.35, 6),
('QR007', 19.9, 0.42, 7),
('QR008', 21.0, 0.48, 8),
('QR009', 16.7, 0.33, 9),
('QR010', 14.2, 0.28, 10);
GO


INSERT INTO Logistica.Consolidacion (ID_Caja, ID_DetallePedido, Cantidad)
VALUES
(1, 1, 50),
(2, 2, 40),
(3, 3, 25),
(4, 4, 25),
(5, 5, 100),
(6, 6, 75),
(7, 7, 60),
(8, 8, 90),
(9, 9, 120),
(10, 10, 80);
GO



-- 6️ VEHÍCULOS Y RUTAS
INSERT INTO Logistica.Vehiculo (Patente, Tipo, Capacidad, Refrigerado, Chofer)
VALUES
('AB123CD', 'Camión', 3500.00, 1, 'Carlos Gómez'),
('AC456EF', 'Furgón', 2000.00, 0, 'Sofía Ruiz'),
('AD789GH', 'Camión', 4000.00, 1, 'Juan Fernández'),
('AE012IJ', 'Camioneta', 1500.00, 0, 'María López'),
('AF345KL', 'Camión', 5000.00, 1, 'Diego Torres'),
('AG678MN', 'Furgón', 2200.00, 0, 'Lucía Herrera'),
('AH901OP', 'Camioneta', 1800.00, 0, 'Fernando Díaz'),
('AI234QR', 'Camión', 4500.00, 1, 'Natalia Suárez'),
('AJ567ST', 'Furgón', 2000.00, 0, 'Matías Romero'),
('AK890UV', 'Camión', 4800.00, 1, 'Valeria Gómez');
GO


INSERT INTO Logistica.Ruta (Descripcion, Zona, Kilometros)
VALUES
('Ruta Norte - Farmacias Zona Norte', 'GBA Norte', 120.5),
('Ruta Oeste - Hospitales', 'GBA Oeste', 98.3),
('Ruta Sur - Clínicas y Farmacias', 'GBA Sur', 110.7),
('Ruta Cuyo - Distribución Regional', 'Cuyo', 850.0),
('Ruta Córdoba - Capital e Interior', 'Centro', 680.4),
('Ruta Litoral - Rosario y Paraná', 'Litoral', 430.2),
('Ruta Patagonia - Neuquén y Río Negro', 'Sur', 1250.8),
('Ruta NOA - Tucumán y Salta', 'Noroeste', 950.5),
('Ruta GBA Express', 'Gran Buenos Aires', 75.0),
('Ruta AMBA - Farmacias Capital', 'CABA', 60.3);
GO



-- 7️ ENTREGAS
INSERT INTO Logistica.Entrega (ID_Pedido, ID_Vehiculo, ID_Ruta, Fecha_Salida, Fecha_Entrega, Temp_Entrega, Conformidad)
VALUES
(1, 1, 1, '2025-11-03 08:00', '2025-11-03 12:30', 5.0, 1),
(2, 2, 2, '2025-11-04 09:00', '2025-11-04 13:00', 20.0, 1),
(3, 3, 3, '2025-10-29 07:30', '2025-10-29 14:00', 22.0, 1),
(4, 4, 4, '2025-10-27 06:00', '2025-10-27 19:00', 4.0, 1),
(5, 5, 5, '2025-10-23 08:00', '2025-10-23 16:30', 21.5, 1),
(6, 6, 6, '2025-11-06 09:00', '2025-11-06 18:00', 19.8, 0),
(7, 7, 7, '2025-10-30 05:30', '2025-10-30 20:15', 6.0, 1),
(8, 8, 8, '2025-11-07 07:00', '2025-11-07 22:00', 4.5, 1),
(9, 9, 9, '2025-11-01 10:00', '2025-11-01 15:30', 23.0, 1),
(10, 10, 10, '2025-11-08 08:30', '2025-11-08 13:00', 18.0, 1);
GO



-- 8️ OPERARIOS Y VALIDACIONES
INSERT INTO Logistica.Operario (Nombre, Rol, Turno)
VALUES
('Juan Torres', 'Operador', 'Mañana'),
('Ana López', 'Supervisor', 'Tarde'),
('Marcos Rivas', 'Auditor', 'Noche'),
('Laura Pérez', 'Operador', 'Mañana'),
('Diego Fernández', 'Supervisor', 'Tarde'),
('Carolina Gómez', 'Operador', 'Noche'),
('Federico Silva', 'Auditor', 'Tarde'),
('Valeria Morales', 'Operador', 'Mañana'),
('Martín Herrera', 'Supervisor', 'Noche'),
('Sofía Ruiz', 'Auditor', 'Mañana');
GO


INSERT INTO Logistica.Validacion (ID_Lote, ID_Pedido, ID_Operario, Tipo_Error, Resultado)
VALUES
(1, 1, 1, NULL, 'Aprobado'),
(2, 2, 2, NULL, 'Aprobado'),
(3, 3, 3, 'Temperatura fuera de rango', 'Observado'),
(4, 4, 4, NULL, 'Aprobado'),
(5, 5, 5, NULL, 'Aprobado'),
(6, 6, 6, 'Lote incorrecto', 'Rechazado'),
(7, 7, 7, NULL, 'Aprobado'),
(8, 8, 8, 'Cantidad inconsistente', 'Observado'),
(9, 9, 9, NULL, 'Aprobado'),
(10, 10, 10, NULL, 'Aprobado');
GO

SELECT ID_EmpresaCliente, Nombre, CUIT, Contacto
FROM Logistica.EmpresaCliente;

SELECT Nombre, Tipo, Provincia, Localidad
FROM Logistica.ClienteDestino;
