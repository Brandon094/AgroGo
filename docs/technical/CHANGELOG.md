# 📜 Historial de Cambios (Changelog) - AgroGo

Todos los cambios notables en este proyecto serán documentados en este archivo siguiendo el estándar [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [0.9.0] - 2024-06-24 (Gestión Patrimonial y Valoración)
### Añadido
- **Valoración de Inventario**: Capacidad de registrar el valor unitario de insumos y maquinaria en la Bodega Virtual.
- **Cálculo de Capital Automático**: El sistema calcula instantáneamente el valor total por ítem (Cantidad * Valor Unitario) para consolidar el capital inmovilizado.
- **Métrica de Capital en Dashboard**: Nueva visualización en el panel principal que muestra el "Capital Bodega" como parte del activo circulante y fijo de la finca.

---

## [0.8.0] - 2024-06-24 (Agroturismo y Recreación)
### Añadido
- **Infraestructura Recreativa**: Nuevas categorías de mapeo: 'Kiosco/Área Social', 'Piscina/Área Húmeda', 'Alojamiento/Casa en Árbol' y 'Mirador/Observatorio'.
- **Identidad Visual Turística**: Color Azul Claro e iconografía dedicada para diferenciar activos recreativos de la producción y vivienda.
- **Formularios Adaptativos**: Lógica simplificada para infraestructura recreativa, eliminando requerimientos técnicos agrícolas.

---

## [0.7.5] - 2024-06-24 (Gestión Ambiental y Ornamental)
### Añadido
- **Nuevas Categorías de Lote**: Incorporación de 'Forestal/Conservación' y 'Ornamental/Huerta' para un mapeo integral de la finca.
- **Flujo de Registro Simplificado**: Las zonas no comerciales cuentan con formularios minimalistas que omiten la configuración de cronogramas y datos técnicos productivos.
- **Identidad Visual Extendida**: Asignación de colores distintivos (Verde Bosque y Salmón/Floral) e iconografía dedicada para áreas de conservación y jardines.
- **Acceso Rápido**: Inclusión de atajos dedicados en el panel de gestión de zonas para la creación de áreas ambientales.

---

## [0.7.0] - 2024-06-24 (Contraste y Referencia Espacial)
### Añadido
- **Resaltado de Infraestructura Existente**: Los polígonos de estructuras ya guardadas ahora utilizan bordes blancos sólidos y mayor opacidad de relleno (40%) durante el proceso de mapeo, facilitando su uso como referencia espacial.
- **Jerarquía Visual de Dibujo**: Ajuste de grosores de línea para diferenciar claramente entre el perímetro maestro (4px), infraestructuras pasivas (2px) y el trazo activo del usuario.

---

## [0.6.5] - 2024-06-24 (Automatización UX)
### Añadido
- **Nomenclatura Secuencial Automática**: Al seleccionar una categoría de infraestructura (ej: Casa, Corral), el sistema sugiere automáticamente el siguiente nombre disponible (ej: "Casa 1", "Casa 2") consultando la base de datos local.
- **Auto-completado de Subcategoría**: El selector de infraestructura ahora inyecta automáticamente el valor técnico en el modelo, reduciendo la carga de teclado del usuario.

### Mejorado
- **Inteligencia de Formulario**: La sugerencia de nombre respeta las ediciones manuales previas si el usuario ya ingresó un nombre personalizado que no sigue el patrón secuencial.

---

## [0.6.0] - 2024-06-24 (Identidad Visual Pecuaria)
### Añadido
- **Diferenciación de Infraestructura**: Implementación de un nuevo esquema de colores para separar visualmente las estructuras pecuarias (Corrales, Galpones, etc.) de la infraestructura general.
- **Pines Ámbar/Naranja**: Asignación de color naranja a los marcadores y polígonos de zonas destinadas a animales para mejorar la lectura rápida del mapa.
- **Consistencia en Listas**: Actualización de la iconografía y colores en el panel de lotes para reflejar la vocación pecuaria de cada zona.

---

## [0.5.5] - 2024-06-24 (Validación Geométrica Estricta)
### Añadido
- **Motor de Intersección de Polígonos**: Integración de `turf_dart` para detectar superposiciones de lotes en tiempo real.
- **Validación de Exclusividad Espacial**: Bloqueo automático del botón "Continuar" si el nuevo lote se traslapa con uno existente.
- **Feedback Visual de Conflicto**: El polígono activo cambia a color rojo intenso y muestra un banner de advertencia cuando se detecta una superposición.

---

## [0.5.0] - 2024-06-21 (Inteligencia Contextual y BI Geográfica)
### Añadido
- **Misiones Integradas al Dashboard**: Eliminación del onboarding estático; ahora el panel principal guía al usuario con banners dinámicos (Perímetro, Infraestructura, Cultivos, Bodega, Nómina).
- **Pines Informativos (Rayos X)**: Los marcadores en el mapa de finca muestran ahora: censo de matas, etapa de cultivo, cantidad de animales por especie y procesos de beneficio activos.
- **BI Global de Portafolio**: El mapa global de fincas incluye un panel de resumen técnico con totales de animales, ítems de bodega y área total.
- **Ajuste Manual de Precisión**: Marcadores con cambio de color (Azure) al arrastrar y bloqueo automático de gestos del mapa para facilitar la edición milimétrica.
- **Especies Pecuarias Senior**: Soporte para Bovinos, Equinos, Ovinos, Caprinos y Mulas con iconografía y colores dedicados.
- **Seguridad en Cascada**: Lógica de borrado seguro que limpia sub-lotes e infraestructuras al eliminar el perímetro maestro, con advertencias de alto impacto.

### Mejorado
- **Zonificación UI**: Pantalla "Mis Zonas" dividida en pestañas **CULTIVOS** y **ESTRUCTURAS**.
- **Filtros de Ubicación**: El registro de animales ahora filtra infraestructuras por subcategoría (solo muestra cocheras, galpones, etc.).
- **Ergonomía de Mapeo**: Controles situados en zona de alcance del pulgar y badge de área flotante superior.

---

## [0.4.5] - 2024-06-21 (Minimalismo y Ergonomía)
### Añadido
- **Rediseño de Pantalla de Mapeo**: Reorganización total para facilitar el uso con una sola mano.
- **Badge de Área Flotante**: Visualización minimalista del área calculada en la parte superior del mapa.
- **Controles "Thumb-Reach"**: Selectores de modo y banners de instrucción movidos a la zona inferior.
- **Indicadores de Validación**: Check verde dinámico al alcanzar los puntos mínimos para el polígono.

### Mejorado
- **Formularios de Lote**: Agrupación de campos en secciones tipo Bento (Identificación, Datos Técnicos, Cronograma).
- **Consistencia Visual**: Unificación de radios de curvatura (32px) y sombras en todo el módulo de mapas.

---

## [0.4.0] - 2024-06-21 (Valla Eléctrica y Bento Pro)
### Añadido
- **Motor de Geofencing Estricto**: Validación técnica que prohíbe dibujar cualquier punto fuera del perímetro maestro de la finca.
- **Eliminación en Cascada**: Lógica de protección que limpia automáticamente todos los sub-lotes e infraestructuras al eliminar el perímetro maestro.
- **Advertencias Críticas**: Diálogos de confirmación de alto impacto visual para acciones que comprometen la integridad de los datos.
- **Onboarding Dinámico con Bifurcación**: Tutor secuencial que pregunta por la vocación pecuaria y ajusta las misiones automáticamente.
- **Dashboard Bento Pro**: Rediseño del panel principal con métricas agrupadas (Patrimonio, Producción, Recursos) y atajos clasificados.
- **Zonificación por Pestañas**: División del panel "Mis Zonas" en **CULTIVOS** y **ESTRUCTURAS** para una mejor organización.
- **Validación de Infraestructura**: Los animales ahora requieren obligatoriamente una ubicación válida (Cochera, Galpón, etc.) filtrada por subcategoría.
- **Especies Expandidas**: Soporte para Bovinos, Equinos, Ovinos, Caprinos y más, con iconografía y colores dedicados.
- **Auto-Ubicación GPS**: Integración de Reverse Geocoding para detectar municipio y departamento automáticamente.
- **Botón SALTAR**: Opción para omitir el onboarding para usuarios expertos.

### Mejorado
- **Cerebro de Mapeo**: Banner de instrucciones dinámicas y visualización del perímetro maestro como guía visual.
- **Navegación**: Implementación de guardas de seguridad y redirección automática al Login (Firebase Auth).

---

## [0.3.0] - 2024-06-21 (Identidad Unificada)
### Añadido
- **Módulo de Autenticación Unificada**: Integración con Firebase Auth y Google Sign-In.
- **Identidad Única (SSO)**: UID compartido con el Ecosistema "Go".
- **Soporte Multi-Plataforma**: Configuración oficial para Android e iOS.

---

## [0.2.5] - 2024-06-20 (Beneficio y Venta)
### Añadido
- **Motor de Venta Directa**: Opción de vender café mojado saltando el secado.
- **Integración Logística**: Preparación para CargaGo.

---

## [0.1.0] - 2024-06-01 (MVP)
### Añadido
- **Persistencia Isar**: Base de datos local Offline-First.
- **Clean Architecture**: Estructura modular por features.

---
**Chop Code Solutions - Ingeniería para el campo.**
