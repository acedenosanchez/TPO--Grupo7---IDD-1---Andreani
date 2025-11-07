USE Andreani;
GO

--Operador: Carga , inserciones y actualización 
CREATE LOGIN operador01 WITH PASSWORD = 'Operador123!';
CREATE USER operador01 FOR LOGIN operador01;
GO

-- Supervisor
CREATE LOGIN supervisor01 WITH PASSWORD = 'Supervisor123!';
CREATE USER supervisor01 FOR LOGIN supervisor01;
GO

-- Auditor
CREATE LOGIN auditor01 WITH PASSWORD = 'Auditor123!';
CREATE USER auditor01 FOR LOGIN auditor01;
GO

--Roles
CREATE ROLE Rol_Operador;
CREATE ROLE Rol_Supervisor;
CREATE ROLE Rol_Auditor;
GO

--Asignación de permisos a cada Rol:

--Operador
GRANT INSERT, UPDATE ON SCHEMA::Logistica TO Rol_Operador;
DENY DELETE ON SCHEMA::Logistica TO Rol_Operador;
GO

--Supervisor
GRANT SELECT, EXECUTE ON SCHEMA::Logistica TO Rol_Supervisor;
GO

--Auditor
GRANT SELECT ON SCHEMA::Logistica TO Rol_Auditor;
DENY INSERT, UPDATE, DELETE ON SCHEMA::Logistica TO Rol_Auditor;
GO

--Asignación de usuarios a Roles
ALTER ROLE Rol_Operador ADD MEMBER operador01;
ALTER ROLE Rol_Supervisor ADD MEMBER supervisor01;
ALTER ROLE Rol_Auditor ADD MEMBER auditor01;
GO


