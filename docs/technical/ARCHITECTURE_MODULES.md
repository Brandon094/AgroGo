# 🏗️ Arquitectura Técnica Detallada - AgroGo

Este documento proporciona una visión profunda de la ingeniería detrás de **AgroGo**, diseñada bajo el paradigma de **Clean Architecture** y un enfoque **Offline-First**.

---

## 🏗️ 1. Arquitectura de Datos e Identidad
AgroGo combina la potencia de la nube para identidad con la resiliencia local para datos:

### 1.1 Motor de Identidad Unificada (SSO)
*   **Tecnología**: Firebase Auth + Google Sign-In.
*   **Propósito**: Garantizar que el usuario tenga una única cuenta para todo el Ecosistema "Go" (RutaGo, AgroGo, CargoGo).
*   **Seguridad**: Enrutador protegido mediante guardas de Riverpod que impiden el acceso a datos sensibles sin una sesión activa.

### 1.2 Isar Database (Motor Local Offline-First)
*   **Propósito**: Almacenamiento de alta velocidad para registros financieros, lotes y nómina.
*   **Justificación**: El caficultor no puede depender de una conexión para anotar sus gastos. Isar ofrece transacciones ACID atómicas.
*   **Patrón**: Colecciones NoSQL con mappers automáticos a Entidades.

### 1.3 Transaccionalidad 360°
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
*   **BaseRepository (Master)**: Clase genérica que envuelve las transacciones Isar (`writeTxn`) y el manejo de excepciones, garantizando el cumplimiento del patrón Result.
*   **IsarModels**: Esquemas optimizados para la persistencia local.

### 2.3 Presentation (Riverpod Reactivo)
*   **Notifiers**: Gestores de estado que escuchan cambios en Isar. Utilizan el **Patrón de Resultado** (`Either<Fallo, T>`) para comunicar el éxito o error de las acciones a la UI.
*   **Widgets**: Componentes de UI optimizados con `RepaintBoundary` y diseño **Bento Dashboard**.
*   **AgroUI Kit (Shared)**: Librería central de componentes atómicos que garantizan la coherencia visual y el principio DRY (Don't Repeat Yourself).

---

## 📍 3. Motores de Inteligencia Geográfica y Lógica
*   **Cálculo Esférico**: Uso de `SphericalUtil` para cálculo de áreas reales (Ha).
*   **Geofencing Engine (Valla Eléctrica)**: Validador de puntos `containsLocation` que impide la creación de lotes o infraestructuras fuera del perímetro `perimetro`.
*   **Vocación Mapper**: Lógica de bifurcación de UI que adapta el Stepper del Onboarding según el perfil productivo del usuario (SÍ/NO animales).
*   **Reverse Geocoding**: Conversión de coordenadas lat/lng a direcciones humanas (Vereda, Municipio) mediante el paquete `geocoding`.

---

## 📊 4. Flujo de Integración del Café
1.  **Nómina**: Registro de kilos recolectados (Cereza).
2.  **Transformación**: El motor de beneficio mueve el lote por estados (Lavado/Secado).
3.  **Conversión**: El peso final seco se inyecta como activo vendible en la Bodega de Producción.

---
**Documentación de Ingeniería - ChopCode Solutions - Agro Division**
