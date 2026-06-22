# 📋 Especificación de Requisitos - AgroGo

Detalle de las capacidades funcionales y estándares de calidad del ERP Agrícola.

### Identidad y Seguridad (SSO)
*   **RF-07:** El sistema debe integrarse con Firebase Auth para permitir el inicio de sesión con Google.
*   **RF-08:** Los datos del usuario deben estar vinculados a un UID único compartido con el Ecosistema Go.
*   **RF-09:** El acceso a las pantallas de gestión de finca debe estar restringido a usuarios autenticados.

---

## 🛠️ 1. Requisitos Funcionales (RF)

### Gestión de Tierra (GIS)
*   **RF-01:** El sistema debe permitir dibujar polígonos sobre mapas satelitales.
*   **RF-02:** El app debe calcular el área en hectáreas con precisión de dos decimales.

### Finanzas y Bodega
*   **RF-03:** El sistema debe alertar cuando el stock de un insumo esté por debajo del umbral mínimo.
*   **RF-04:** Todo registro de gasto debe permitir asociarse a un lote específico para medir rentabilidad.

### Nómina y Producción
*   **RF-05:** El sistema debe liquidar jornales y kilos de café recolectado.
*   **RF-06:** Se debe permitir el registro de alimentación diaria para descuento automático en nómina.

### Identidad y Seguridad (SSO)
*   **RF-07:** El sistema debe integrarse con Firebase Auth para permitir el inicio de sesión con Google.
*   **RF-08:** Los datos del usuario deben estar vinculados a un UID único compartido con el Ecosistema Go.
*   **RF-09:** El acceso a las pantallas de gestión de finca debe estar restringido a usuarios autenticados.

---

## ⚡ 2. Requisitos No Funcionales (RNF)

*   **RNF-01 (Offline):** El 100% de las funciones de registro deben operar sin conexión a internet.
*   **RNF-02 (Performance):** La carga del Dashboard con más de 10 lotes no debe superar los 500ms.
*   **RNF-03 (UI):** La interfaz debe usar la paleta Esmeralda/Bosque definida en el manual de Branding.
*   **RNF-04 (Seguridad):** Los datos de diferentes fincas deben estar aislados a nivel de consulta en la base de datos local.

### Identidad y Seguridad (SSO)
*   **RF-07:** El sistema debe integrarse con Firebase Auth para permitir el inicio de sesión con Google.
*   **RF-08:** Los datos del usuario deben estar vinculados a un UID único compartido con el Ecosistema Go.
*   **RF-09:** El acceso a las pantallas de gestión de finca debe estar restringido a usuarios autenticados.

---
**Chop Code Solutions - Product Management 2026**
