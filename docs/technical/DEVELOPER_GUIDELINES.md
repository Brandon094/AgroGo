# 🤖 Manual de Ingeniería y Estándares de Código - AgroGo

Este documento establece las directrices técnicas obligatorias para mantener la excelencia en el desarrollo de **AgroGo**.

---

## 1. Estándares de Codificación (Spanish Clean Code)

### 1.1 Nomenclatura Profesional
*   **Idioma**: A diferencia de RutaGo, el código fuente de AgroGo se escribe en **Español** (Clases, variables, métodos) para facilitar la comunicación con el experto de dominio (caficultor/agrónomo).
*   **Variables**: CamelCase descriptivo (ej: `loteSeleccionado`).
*   **Constantes**: UPPER_SNAKE_CASE (ej: `VALOR_ALIMENTACION_DIA`).
*   **Paquetes**: Seguir la estructura `features/nombre_modulo/[domain|data|presentation]`.

### 1.2 Riverpod & Estado
*   **Generators**: Es obligatorio usar `@riverpod` annotation para la generación de código.
*   **AsyncValue**: No usar `setState` para datos asíncronos. Siempre usar `when()` o `maybeWhen()` para manejar estados de carga y error.

---

## 2. Gestión de Datos y Persistencia (Isar)

### 2.1 Transacciones Seguras
*   Toda escritura debe ir envuelta en `isar.writeTxn`.
*   **Aislamiento**: Siempre filtrar las consultas por `fincaId` para evitar el cruce de datos entre diferentes propiedades del mismo usuario.

### 2.2 Mapeo de Datos
*   Las clases de datos deben implementar `toEntity()` y `fromEntity()`. Prohibido usar modelos de base de datos directamente en la capa de UI.

---

## 3. UI/UX: Estándar de Campo

### 3.1 Accesibilidad Rural
*   **Regla del 200%**: Todos los layouts deben ser funcionales con un escalado de fuente del 200%. No usar `height` fijos en tarjetas de texto.
*   **Touch Targets**: Botones con un mínimo de **56dp** de altura para facilitar el toque en movimiento o con guantes.

### 3.2 Feedback Táctil
*   Uso obligatorio de `HapticFeedback.mediumImpact()` en acciones críticas (Captura GPS, Confirmación de Pago, Ajuste de Bodega).

---

## 4. Calidad y QA

### 4.1 Manejo de Excepciones
*   Usar la clase `Fallo` del core para capturar errores de base de datos o sensores.
*   Reportar errores de GPS persistentes mediante SnackBars informativas al usuario.

---
**Chop Code Solutions - Engineering Excellence 2026**
