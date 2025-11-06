/* CREATE DATABASE Andreani; 
GO */ -- CREAMOS LA BASE DE DATOS Andreani

USE Andreani;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Logistica')
	EXEC('CREATE SCHEMA Logistica AUTHORIZATION dbo;');
GO

CREATE TABLE Logistica.EmpresaCliente (
	ID_EmpresaCliente INT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL, 
	CUIT CHAR(11) NOT NULL, 
	Direccion NVARCHAR(150) NULL, 
	Contacto NVARCHAR(100) NULL,
	CONSTRAINT UQ_EmpresaCliente_CUIT UNIQUE (CUIT),
	CONSTRAINT CK_EmpresaCliente_CUITNumerico CHECK (CUIT NOT LIKE '%[^0-9]%')
);
GO

CREATE TABLE Logistica.ClienteDestino (
	ID_ClienteDestino INT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL,
	Tipo NVARCHAR(50) NOT NULL,
	Direccion NVARCHAR(150) NOT NULL,
	Provincia NVARCHAR(100) NOT NULL,
	Localidad NVARCHAR(100) NOT NULL,
	CONSTRAINT CK_ClienteDestino_Tipo CHECK (Tipo IN (N'Hospital', N'Farmacia', N'Clinica', N'Drogueria', N'Otro'))
);
GO

CREATE TABLE Logistica.Producto (
	ID_Producto INT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL,
	Descripcion NVARCHAR(250) NULL,
	Condicion_Conservacion NVARCHAR(100) NOT NULL,
	Unidad_Medida NVARCHAR(50) NOT NULL,
	CONSTRAINT CK_Producto_Cond CHECK (Condicion_Conservacion IN (N'Ambiente', N'Refrigerado', N'Congelado'))
);
GO

CREATE TABLE Logistica.Lote (
	ID_Lote INT IDENTITY(1,1) PRIMARY KEY,
	ID_Producto INT NOT NULL,
	Fecha_Ingreso DATE NOT NULL,
	Fecha_Vencimiento DATE NOT NULL,
	Temperatura_Almacenamiento DECIMAL (4,1) NOT NULL,
	Estado NVARCHAR(50) NOT NULL DEFAULT 'Activo',

	CONSTRAINT FK_Lote_Producto FOREIGN KEY (ID_Producto)
		REFERENCES Logistica.Producto(ID_Producto),
	CONSTRAINT CK_Lote_Fechas CHECK (Fecha_Vencimiento > Fecha_Ingreso),
	CONSTRAINT CK_Lote_Temp CHECK (Temperatura_Almacenamiento BETWEEN -30 AND 30)
);
GO

CREATE TABLE Logistica.Pedido (
	ID_Pedido INT IDENTITY(1,1) PRIMARY KEY,
	ID_EmpresaCliente INT NOT NULL,
	ID_ClienteDestino INT NOT NULL,
	Fecha_Pedido DATE NOT NULL, 
	Fecha_Entrega_Sol DATE NOT NULL,
	Estado NVARCHAR(50) NOT NULL DEFAULT 'Pendiente',

	CONSTRAINT FK_Pedido_EmpresaCliente FOREIGN KEY (ID_EmpresaCliente)
		REFERENCES Logistica.EmpresaCliente(ID_EmpresaCliente),
	CONSTRAINT FK_Pedido_ClienteDestino FOREIGN KEY (ID_ClienteDestino)
		REFERENCES Logistica.ClienteDestino(ID_ClienteDestino),

	CONSTRAINT CK_Pedido_Fechas CHECK (Fecha_Entrega_Sol >= Fecha_Pedido),
	CONSTRAINT CK_Pedido_Estado CHECK (Estado IN (N'Pendiente', N'En Preparación', N'Despachado', N'Entregado', N'Cancelado'))
);
GO

CREATE TABLE Logistica.DetallePedido (
	ID_DetallePedido INT IDENTITY (1,1) PRIMARY KEY,
	ID_Pedido INT NOT NULL,
	ID_Lote INT NOT NULL, 
	Cantidad INT NOT NULL CHECK (Cantidad > 0), 

	CONSTRAINT FK_DetallePedido_Pedido FOREIGN KEY (ID_Pedido)
		REFERENCES Logistica.Pedido(ID_Pedido),
	CONSTRAINT FK_DetallePedido_Lote FOREIGN KEY (ID_Lote)
		REFERENCES Logistica.Lote(ID_Lote),

	CONSTRAINT UQ_DetallePedido_PedidoLote UNIQUE (ID_Pedido, ID_Lote)
);
GO

CREATE TABLE Logistica.Caja (
	ID_Caja INT IDENTITY(1,1) PRIMARY KEY,
	Codigo_QR NVARCHAR(50) NOT NULL,
	Peso DECIMAL(6,2) NOT NULL,
	Volumen DECIMAL(6,2) NOT NULL,
	ID_ClienteDestino INT NOT NULL,

	CONSTRAINT FK_Caja_ClienteDestino FOREIGN KEY (ID_ClienteDestino)
		REFERENCES Logistica.ClienteDestino(ID_ClienteDestino),
	CONSTRAINT UQ_Caja_CodigoQR UNIQUE (Codigo_QR)
);
GO

CREATE TABLE Logistica.Consolidacion (
	ID_Consolidacion INT IDENTITY(1,1) PRIMARY KEY,
	ID_Caja INT NOT NULL,
	ID_DetallePedido INT NOT NULL,
	Fecha_Consolidacion DATE NOT NULL DEFAULT GETDATE(),
	Cantidad INT NOT NULL,

	CONSTRAINT FK_Consolidacion_Caja FOREIGN KEY (ID_Caja)
		REFERENCES Logistica.Caja(ID_Caja),
	CONSTRAINT FK_Consolidacion_DetallePedido FOREIGN KEY (ID_DetallePedido)
		REFERENCES Logistica.DetallePedido(ID_DetallePedido),
	CONSTRAINT UQ_Consolidacion_CajaDetalle UNIQUE (ID_Caja, ID_DetallePedido)
);
GO

CREATE TABLE Logistica.Vehiculo (
	ID_Vehiculo INT IDENTITY(1,1) PRIMARY KEY,           
	Patente CHAR(7) NOT NULL,                           
	Tipo NVARCHAR(50) NOT NULL,                          
	Capacidad DECIMAL(6,2) NOT NULL,                     
	Refrigerado BIT NOT NULL DEFAULT 0,                  
	Chofer NVARCHAR(100) NOT NULL,                      
	
	CONSTRAINT UQ_Vehiculo_Patente UNIQUE (Patente),     
	CONSTRAINT CK_Vehiculo_Capacidad CHECK (Capacidad > 0) 
);
GO

CREATE TABLE Logistica.Ruta (
	ID_Ruta INT IDENTITY(1,1) PRIMARY KEY,            
	Descripcion NVARCHAR(150) NOT NULL,      
	Zona NVARCHAR(100) NOT NULL,
	Kilometros DECIMAL(6,2) NOT NULL,
	
	CONSTRAINT CK_Ruta_Km CHECK (Kilometros > 0)
);
GO

CREATE TABLE Logistica.Entrega (
	ID_Entrega INT IDENTITY(1,1) PRIMARY KEY,               
	ID_Pedido INT NOT NULL,                                 
	ID_Vehiculo INT NOT NULL,                               
	ID_Ruta INT NOT NULL,                                   
	Fecha_Salida DATETIME NOT NULL,                         
	Fecha_Entrega DATETIME NULL,                            
	Temp_Entrega DECIMAL(4,1) NULL,                         
	Conformidad BIT NOT NULL DEFAULT 0,                     
	
	CONSTRAINT FK_Entrega_Pedido FOREIGN KEY (ID_Pedido)
		REFERENCES Logistica.Pedido(ID_Pedido),
	CONSTRAINT FK_Entrega_Vehiculo FOREIGN KEY (ID_Vehiculo)
		REFERENCES Logistica.Vehiculo(ID_Vehiculo),
	CONSTRAINT FK_Entrega_Ruta FOREIGN KEY (ID_Ruta)
		REFERENCES Logistica.Ruta(ID_Ruta),

	CONSTRAINT CK_Entrega_Fechas CHECK (Fecha_Entrega IS NULL OR Fecha_Entrega >= Fecha_Salida),
	CONSTRAINT CK_Entrega_Temp CHECK (Temp_Entrega BETWEEN -30 AND 50)
);
GO

CREATE TABLE Logistica.Operario (
	ID_Operario INT IDENTITY(1,1) PRIMARY KEY,           
	Nombre NVARCHAR(100) NOT NULL,                       
	Rol NVARCHAR(50) NOT NULL,                          
	Turno NVARCHAR(20) NOT NULL,                     

	CONSTRAINT CK_Operario_Rol CHECK (Rol IN (N'Operador', N'Supervisor', N'Auditor')),
	CONSTRAINT CK_Operario_Turno CHECK (Turno IN (N'Mañana', N'Tarde', N'Noche'))
);
GO

CREATE TABLE Logistica.Validacion (
	ID_Validacion INT IDENTITY(1,1) PRIMARY KEY,
	ID_Lote INT NOT NULL,                          
	ID_Pedido INT NOT NULL,                              
	ID_Operario INT NOT NULL,                      
	Tipo_Error NVARCHAR(100) NULL,                    
	Fecha_Hora DATETIME NOT NULL DEFAULT GETDATE(),        
	Resultado NVARCHAR(50) NOT NULL,                      
	
	CONSTRAINT FK_Validacion_Lote FOREIGN KEY (ID_Lote)
		REFERENCES Logistica.Lote(ID_Lote),
	CONSTRAINT FK_Validacion_Pedido FOREIGN KEY (ID_Pedido)
		REFERENCES Logistica.Pedido(ID_Pedido),
	CONSTRAINT FK_Validacion_Operario FOREIGN KEY (ID_Operario)
		REFERENCES Logistica.Operario(ID_Operario),
	CONSTRAINT CK_Validacion_Resultado CHECK (Resultado IN (N'Aprobado', N'Rechazado', N'Observado'))
);
GO
