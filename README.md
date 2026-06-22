# 📖 Enciclopedia Técnica Integral - AgroGo v0.2.5 Stable

Bienvenido al centro de conocimiento oficial de **ChopCode Solutions**. Este documento sirve como punto de entrada de alto nivel para comprender **AgroGo**, el ERP agrícola diseñado para revolucionar la productividad rural en la región de Natagá y el Huila.

---

## 🏗️ 1. Visión y Propósito Estratégico
AgroGo es una solución de **Gestión Transaccional Offline-First**. Su objetivo es integrar la administración total de la finca bajo un cerebro digital único:
1.  **Gestión GIS**: Zonificación de tierra y cálculo de áreas de precisión.
2.  **Automatización 360°**: Vínculo entre Agenda, Gastos e Inventarios.
3.  **Trazabilidad de Beneficio**: Control total del ciclo del café desde cereza hasta pergamino seco.

---

## 👥 2. Modelo de Actores y Permisos (RBAC)
El sistema opera bajo un modelo de **Aislamiento Multi-Finca**, permitiendo que un solo administrador gestione múltiples unidades productivas:

*   **Administrador / Productor**: Control total de lotes, nómina, finanzas y bodega.
*   **Operador de Campo**: (Fase 3) Visualiza tareas asignadas y reporta avances.
*   **Ecosistema Go**: (Integración) Identidad única para interoperar con RutaGo y CargoGo.

---

## 📦 3. Desglose de Motores y Módulos Core

| Módulo | Responsabilidad Técnica | Aplicación |
|:---|:---|:---|
| **GIS Engine** | Mapeo satelital, geocercas y cálculos de área. | Lotes |
| **Financial Engine** | Cálculo de costos COP, amortización y flujos. | Finanzas |
| **Inventory Engine** | Bodega triple categoría y alertas de stock. | Insumos |
| **Beneficio Engine** | Motor de transformación de estados del café. | Producción |
| **Payroll Engine** | Liquidación dinámica por jornal, kilo o arroba. | Nómina |
| **Offline Sync** | Persistencia Isar Database con transacciones ACID. | Core |

---

## 🛠️ 4. Ecosistema de Documentación (Nivel Senior)

### 📗 Dominio Técnico (Engineering)
*   [**Arquitectura Detallada**](./docs/technical/ARCHITECTURE_MODULES.md): Estructura Isar y Clean Architecture.
*   [**Estándares de Código**](./docs/technical/DEVELOPER_GUIDELINES.md): Reglas de oro (Dart/Flutter) y Clean Code.
*   [**Diccionario de Datos**](./docs/technical/DICCIONARIO_DATOS.md): Mapeo del esquema Isar NoSQL local.
*   [**Ficha Técnica**](./docs/technical/FICHA_TECNICA.md): Especificaciones de infraestructura y stack tecnológico.
*   [**Historial de Cambios**](./docs/technical/CHANGELOG.md): Registro de versiones y evoluciones.
*   [**Plan de Pruebas**](./docs/technical/QA_PLAN.md): Protocolos de certificación y QA.

### 📘 Dominio de Producto (Business)
*   [**Master Plan Ecosistema**](./docs/product/ECOSYSTEM_MASTER_PLAN.md): Visión estratégica de AgroGo en la suite Go.
*   [**Especificación de Requisitos**](./docs/product/REQUISITOS.md): RF, RNF y reglas de negocio.
*   [**Identidad Visual**](./docs/product/BRANDING.md): Guía de estilo Premium Emerald.
*   [**Hoja de Ruta (Roadmap)**](./docs/product/ROADMAP.md): Fases de expansión y AgroGo Network.

---
**© 2026 Chop Code Solutions - Ingeniería para la Productividad Rural**  
**Desarrollador Lead: Brandon Daza Cerquera**
