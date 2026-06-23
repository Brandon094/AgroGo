# 📋 Especificación de Requisitos y Flujo Lógico - AgroGo

Este documento detalla la jerarquía operativa y las reglas de negocio que garantizan la integridad de los datos en AgroGo.

---

## 🏗️ 1. Jerarquía de Configuración (Setup Mandatorio)

El sistema aplica una secuencia lógica para evitar errores estructurales:

1.  **Misión: Sensores**: Acceso obligatorio a GPS/GNSS antes de cualquier registro geográfico.
2.  **Finca (Padre)**: Registro de identidad de la propiedad con auto-detección de ubicación.
3.  **Perímetro Obligatorio**: Bloqueo total de creación de lotes e infraestructura hasta que el **Perímetro Total** esté definido.
4.  **Geovalla (Geofencing)**: Restricción técnica que impide dibujar cualquier punto fuera del perímetro maestro.
5.  **Infraestructura Previa**: Los animales solo pueden registrarse si existe una estructura (Cochera, Galpón, etc.) apta para su alojamiento.

---

## ⚡ 2. Reglas de Negocio Críticas

*   **Integridad de Datos (Cascada)**: La eliminación del **Perímetro Maestro** conlleva la eliminación automática e irreversible de todos los lotes de cultivo, infraestructuras y tareas asociadas.
*   **Inteligencia Contextual (Misiones)**: El sistema debe presentar misiones de configuración prioritarias en el Dashboard hasta que la finca cuente con Perímetro, Infraestructura, Lotes, Stock y Equipo.
*   **Pecuario Inteligente**:
    *   Filtro estricto en el selector de ubicación: Solo muestra lotes tipo `infraestructura` o `pecuario` que sean compatibles con alojamiento animal (Cochera, Galpón, etc.).
    *   No se permiten animales en casas o bodegas generales.
*   **BI Geográfica**: Los marcadores del mapa deben servir como puntos de inspección, mostrando datos agregados de otros módulos (Animales, Beneficio).
    *   No se permiten animales en casas o bodegas generales.
*   **Gestión de Zonas**:
    *   Separación visual obligatoria en el panel "Mis Zonas": Pestaña de **CULTIVOS** (Producción) vs Pestaña de **ESTRUCTURAS** (Activos).
*   **Bodega Virtual**: Impedir el registro de labores si el stock del insumo requerido es cero.
*   **Nómina**: Liquidación admisible en Kilo, Arroba (12.5kg) y Jornal Diario con descuento de alimentación.

---

## 🎨 3. Estándares de Interfaz y UX

*   **RF-UI-01 (Bento Dashboard)**: Métricas agrupadas por dominios: **Patrimonio** (Ha/$), **Producción** (Lotes/Beneficio) y **Recursos** (Animales/Nómina).
*   **RF-UI-02 (Shortcuts Categorizados)**: División de atajos en: **Gestión Diaria**, **Ingeniería/Mapas** e **Inventarios**.
*   **RF-UI-03 (Tutor Dinámico)**: El Onboarding debe ofrecer bifurcación por vocación y opción de "SALTAR".
*   **RF-UI-04 (Instrucciones Dinámicas)**: El motor de mapas debe guiar al usuario con banners informativos minimalistas.
*   **RF-UI-05 (Ergonomía de Campo)**: Los controles críticos de dibujo y cambio de modo deben estar situados en el tercio inferior de la pantalla para permitir la operación con el pulgar.
*   **RF-UI-06 (Visibilidad de Área)**: El cálculo de hectáreas debe ser visible de forma persistente en la parte superior del mapa sin obstruir la vista satelital central.

---
**Chop Code Solutions - Product Management 2026**
