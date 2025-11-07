USE Andreani;
GO

--Operador: Carga , inserciones y actualización 
CREATE LOGIN operador01 WITH PASSWORD = 'Operador123!';
CREATE USER operador01 FOR LOGIN operador01;
GO



--Supervisor: revision de procesos y consultas analíticas
CREATE LOGIN supervisor01 WITH PASSWORD = 'Supervisor123!';
CREATE USER supervisor01 FOR LOGIN supervisor01;
GO

--Auditor: acceso de solo lectura y validación de trazabilidad
CREATE LOGIN auditor01 WITH PASSWORD = 'Auditor123!';
CREATE USER auditor01 FOR LOGIN auditor01;
GO


--Permisos para el user operador
GRANT INSERT, UPDATE ON SCHEMA::Logistica TO operador01;
DENY DELETE ON SCHEMA::Logistica TO operador01;
GO

--Permisos para el user supervisor 
GRANT SELECT, EXECUTE ON SCHEMA::Logistica TO supervisor01;
GO

--Permisos para el user auditor 
GRANT SELECT ON SCHEMA::Logistica TO auditor01;
DENY INSERT, UPDATE, DELETE ON SCHEMA::Logistica TO auditor01;
GO

