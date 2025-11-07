Andreani – Ingeniería de Datos I (UADE)

Grupo 7 – Integrantes

Barón Martone, Facundo LU 1181718
Cedeño Sanchez, Andrés LU 1191661
Cirielli, Martino LU 1190214
Kahan Rapoport, Matias LU 1184014

Proyecto académico desarrollado para la materia **Ingeniería de Datos I (2° Cuatrimestre 2025)** en la **Universidad Argentina de la Empresa (UADE)**.  
El caso implementa un sistema de **logística farmacéutica inteligente** basado en la empresa **Andreani**, utilizando **SQL Server** para modelar, estructurar y analizar datos logísticos con un enfoque de trazabilidad y eficiencia operativa.

## Descripción del proyecto

Este repositorio contiene los **scripts SQL** necesarios para construir una base de datos relacional que centraliza la información logística de Andreani.  
El sistema permite gestionar y analizar procesos clave:

- Recepción de pedidos de laboratorios y droguerías.
- Validación y control de lotes de medicamentos.
- Consolidación de cajas y trazabilidad completa de entregas.
- Control de vehículos, rutas y condiciones de transporte.
- Registro de validaciones, incidencias y resultados de control.
- Cálculo de **KPIs logísticos** (cumplimiento de entregas, trazabilidad, consolidación, utilización de flota, incidencias).

---

## Estructura del repositorio

| Archivo | Descripción |
|----------|-------------|
| `01_Andreani_Tablas.sql` | Creación de la base de datos y todas las tablas con claves, constraints y relaciones. |
| `02_Andreani_CargaDatos.sql` | Inserción de datos de prueba (clientes, productos, lotes, pedidos, entregas, etc.). |
| `03_Andreani_Triggers.sql` | Triggers para control automático de consolidaciones y validaciones. |
| `04_Andreani_Procedimientos.sql` | Procedimientos almacenados para registrar pedidos, entregas e incidencias. |
| `05_Andreani_KPIs.sql` | Consultas de indicadores clave (cumplimiento, trazabilidad, consolidación, utilización, incidencias). |
| `06_Funciones.sql` | Funciones definidas por el usuario (validación de temperatura y cálculo de días entre fechas). |
| `07_Vistas.sql` | Vistas analíticas de trazabilidad, cumplimiento y consolidación. |
| `08_Roles.sql` | Creación de usuarios ficticios y asignación de roles y permisos (Operador, Supervisor, Auditor). |
