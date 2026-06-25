# 📋 Especificación de Requisitos y Flujo Lógico - AgroGo

Este documento detalla la jerarquía operativa y las reglas de negocio que garantizan la integridad de los datos en AgroGo.

---

## 🏗️ 1. Jerarquía de Configuración (Setup Mandatorio)

El sistema aplica una secuencia lógica para evitar errores estructurales:

1.  **Misión: Sensores**: Acceso obligatorio a GPS/GNSS antes de cualquier registro geográfico.
2.  **Finca (Padre)**: Registro de identidad de la propiedad con auto-detección de ubicación.
3.  **Perímetro Obligatorio**: Bloqueo total de creación de lotes e infraestructura hasta que el **Perímetro Total** esté definido.
4.  **Geovalla (Geofencing)**: Restricción técnica que impide dibujar cualquier punto fuera del perímetro maestro.
5.  **Exclusividad Espacial (Intersección)**: Se prohíbe la superposición de polígonos. El sistema bloquea el guardado si el área intercepta total o parcialmente con un lote ya existente, garantizando la precisión del área total.
6.  **Infraestructura Previa**: Los animales solo pueden registrarse si existe una estructura (Cochera, Galpón, etc.) apta para su alojamiento.

---

## ⚡ 2. Reglas de Negocio Críticas

*   **Integridad de Datos (Cascada)**: La eliminación del **Perímetro Maestro** conlleva la eliminación automática e irreversible de todos los lotes de cultivo, infraestructuras y tareas asociadas.
*   **Inteligencia Contextual (Misiones)**: El sistema debe presentar misiones de configuración prioritarias en el Dashboard hasta que la finca cuente con Perímetro, Infraestructura, Lotes, Stock y Equipo.
*   **Pecuario Inteligente**:
    *   Filtro estricto en el selector de ubicación: Solo muestra lotes tipo `infraestructura` o `pecuario` que sean compatibles con alojamiento animal (Cochera, Galpón, etc.).
    *   No se permiten animales en casas o bodegas generales.
    *   **Valoración de Capital**: El sistema debe permitir registrar el valor unitario por animal para calcular la inversión viva total.
*   **BI Geográfica**: Los marcadores del mapa deben servir como puntos de inspección, mostrando datos agregados de otros módulos (Animales, Beneficio).
    *   No se permiten animales en casas o bodegas generales.
*   **Gestión de Zonas**:
    *   Separación visual obligatoria en el panel "Mis Zonas": Pestaña de **CULTIVOS** (Producción) vs Pestaña de **ESTRUCTURAS** (Activos).
*   **Bodega Virtual**: 
    *   Impedir el registro de labores si el stock del insumo requerido es cero.
    *   **Valoración Patrimonial**: El sistema debe permitir registrar el costo unitario de adquisición para calcular el valor total del inventario (Insumos + Maquinaria).
*   **Nómina**: Liquidación admisible en Kilo, Arroba (12.5kg) y Jornal Diario con descuento de alimentación.

---

## 🎨 3. Estándares de Interfaz y UX

*   **RF-UI-01 (Bento Dashboard)**: Métricas agrupadas por dominios: **Patrimonio** (Ha/$), **Producción** (Lotes/Beneficio) y **Recursos** (Animales/Nómina).
*   **RF-UI-02 (Shortcuts Categorizados)**: División de atajos en: **Gestión Diaria**, **Ingeniería/Mapas** e **Inventarios**.
*   **RF-UI-03 (Tutor Dinámico)**: El Onboarding debe ofrecer bifurcación por vocación y opción de "SALTAR".
*   **RF-UI-04 (Instrucciones Dinámicas)**: El motor de mapas debe guiar al usuario con banners informativos minimalistas.
*   **RF-UI-07 (Nomenclatura Inteligente)**: Al seleccionar una categoría predefinida de infraestructura, el sistema debe sugerir un nombre secuencial correlativo a los registros existentes (Categoría + N).
*   **RF-UI-05 (Ergonomía de Campo)**: Los controles críticos de dibujo y cambio de modo deben estar situados en el tercio inferior de la pantalla para permitir la operación con el pulgar.
*   **RF-UI-06 (Visibilidad de Área)**: El cálculo de hectáreas debe ser visible de forma persistente en la parte superior del mapa sin obstruir la vista satelital central.
*   **RF-UI-08 (Automatización de Ciclos)**: El sistema debe sugerir automáticamente las frecuencias de mantenimiento (abono/fumigación) basándose en la especie de cultivo y su etapa fenológica.
*   **RF-UI-09 (Formularios Dinámicos)**: La interfaz de registro de lotes debe adaptar sus campos según el cultivo seleccionado (ej: ocultar sombra para café, mostrarla para cacao).
*   **RF-GIS-06 (Zonificación No Comercial)**: El sistema debe permitir el mapeo de áreas de conservación (bosques) y uso doméstico (huertas), utilizando formularios minimalistas sin ciclos productivos.
*   **RF-GIS-07 (Infraestructura Recreativa)**: Inclusión de categorías de agroturismo (piscinas, miradores, áreas sociales) con visualización diferenciada y formularios simplificados.

---
**Chop Code Solutions - Product Management 2026**
