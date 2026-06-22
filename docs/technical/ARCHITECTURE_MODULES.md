# 🏗️ Arquitectura Técnica Detallada - AgroGo

Este documento proporciona una visión profunda de la ingeniería detrás de **AgroGo**, diseñada bajo el paradigma de **Clean Architecture** y un enfoque **Offline-First**.

---

## 🏗️ 1. Arquitectura de Datos Offline-First
A diferencia de RutaGo que usa RTDB para tiempo real, AgroGo prioriza la supervivencia de los datos en zonas sin señal:

### 1.1 Isar Database (Motor Local)
*   **Propósito**: Almacenamiento de alta velocidad para registros financieros, lotes y nómina.
*   **Justificación**: El caficultor no puede depender de una conexión para anotar sus gastos. Isar ofrece transacciones ACID atómicas.
*   **Patrón**: Colecciones NoSQL con mappers automáticos a Entidades.

### 1.2 Transaccionalidad 360°
Hemos implementado un flujo de datos reactivo:
1.  **Activación**: Se completa una tarea en la agenda.
2.  **Transacción**: Una única transacción Isar descuenta stock de la colección `Insumo` y crea un registro en `ItemCosto`.
3.  **Reactividad**: Riverpod notifica a la UI del Dashboard para actualizar las tarjetas financieras en milisegundos.

---

## 🌿 2. Estructura de Módulos (Clean Architecture)
El proyecto se divide en capas estrictas para garantizar mantenibilidad:

### 2.1 Domain (Capa de Negocio)
*   **Entities**: Modelos puros en español (`Lote`, `Trabajador`, `Insumo`).
*   **Use Cases**: Lógica de cálculo (ej: `CalculadoraInsumosUseCase`).

### 2.2 Data (Capa de Infraestructura)
*   **Repositories**: Implementaciones que hablan con Isar y el GPS.
*   **IsarModels**: Esquemas optimizados para la persistencia local.

### 2.3 Presentation (Riverpod Reactivo)
*   **Notifiers**: Gestores de estado que escuchan cambios en Isar.
*   **Widgets**: Componentes de UI optimizados con `RepaintBoundary`.

---

## 📍 3. Motor GIS e Ingeniería de Tierra
*   **Cálculo Esférico**: Uso de `SphericalUtil` para calcular áreas sobre la curvatura terrestre.
*   **Filtro de Precisión**: Algoritmo que bloquea capturas GPS con precisión menor a 5 metros para garantizar hectáreas reales.

---

## 📊 4. Flujo de Integración del Café
1.  **Nómina**: Registro de kilos recolectados (Cereza).
2.  **Transformación**: El motor de beneficio mueve el lote por estados (Lavado/Secado).
3.  **Conversión**: El peso final seco se inyecta como activo vendible en la Bodega de Producción.

---
**Documentación de Ingeniería - ChopCode Solutions - Agro Division**
