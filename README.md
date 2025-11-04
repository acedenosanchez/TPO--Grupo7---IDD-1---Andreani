Poyecto académico desarrollado para la materia Ingeniería de Datos I (IDD I).
El objetivo es modelar y construir una base de datos relacional en SQL Server que represente el flujo logístico de la empresa Andreani, incluyendo clientes, productos, pedidos, entregas y validaciones.

🧱 Estructura del Proyecto

Andreani_Grupo7.sql → Script principal con:

Creación de la base de datos Andreani

Esquema Logistica

Tablas normalizadas con claves primarias, foráneas y restricciones (CHECK, UNIQUE)

Dos triggers automáticos:

trg_AfterInsert_Consolidacion: evita consolidar lotes vencidos o inactivos

trg_AfterInsert_Entrega: genera una validación automática al registrar una nueva entrega

Andreani_DatosPrueba.sql → Script de carga inicial con datos de ejemplo (empresas, clientes, productos, pedidos, etc.) para verificar la integridad y funcionamiento de los triggers.

⚙️ Instrucciones de uso

Ejecutar primero Andreani_Grupo7.sql en SQL Server Management Studio (SSMS).

Luego ejecutar Andreani_DatosPrueba.sql para insertar datos de prueba.

Probar los triggers realizando inserciones en las tablas Consolidacion y Entrega.

🧩 Integrantes

Grupo 7 – Ingeniería de Datos I

Barón Martone, Facundo LU 1181718
Cedeño Sanchez, Andrés LU 1191661
Cirielli, Martino LU 1190214
Kahan Rapoport, Matias LU 1184014

