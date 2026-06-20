# 📋 Documentación de Inicialización de Proyecto: AgroGo

Este documento detalla la estructura base, las tecnologías configuradas, las decisiones arquitectónicas y las pantallas del proyecto **AgroGo**.

---

## 🏢 Información General del Proyecto
*   **Nombre de la App:** AgroGo
*   **Organización:** `com.chopcode`
*   **Arquitectura:** Clean Architecture estructurada por módulos (`Domain`, `Data`, `Presentation`).
*   **Enfoque Offline-First**: Almacenamiento persistente local mediante base de datos Isar en todos los módulos.
*   **Enfoque de UX**: Diseño adaptado para condiciones de exterior (alto contraste, botones con objetivos de toque grandes).

---

## 🛠️ Stack Tecnológico Configurado

Las dependencias principales se han añadido y bloqueado en versiones estables y totalmente compatibles:

### Dependencias Principales (`dependencies`):
*   `flutter_riverpod` y `riverpod_annotation` (^2.6.1): Para la gestión de estados reactivos y asíncronos.
*   `isar` y `isar_flutter_libs` (^3.1.0+1): Base de datos local ultrarrápida (Offline-First).
*   `path_provider` (^2.1.6): Para localizar directorios de documentos para la BD Isar.
*   `google_maps_flutter` (^2.17.1): Renderizado de mapas de Google.
*   `maps_toolkit` (^3.1.0): Cálculos geográficos de áreas y polígonos.
*   `geolocator` (^14.0.3): Acceso a servicios de GPS nativos y geolocalización.
*   `dartz` (^0.10.1): Programación funcional (retorno de errores tipo `Either<Fallo, Success>`).
*   `go_router` (^17.3.0): Enrutamiento declarativo robusto basado en URLs.
*   `intl` (^0.20.2): Internacionalización y formateo de fechas y monedas locales.

### Dependencias de Desarrollo (`dev_dependencies`):
*   `build_runner` (^2.4.13): Generador de código.
*   `riverpod_generator` (^2.3.3): Generación de código seguro para Riverpod.
*   `isar_generator` (^3.1.0+1): Generador de esquemas para la BD Isar.
*   `custom_lint` (^0.5.11) y `riverpod_lint` (^2.1.1): Análisis estático avanzado para código limpio.

---

## 📐 Estructura de Directorios Creada

La estructura del código sigue el estándar **Feature-Driven Clean Architecture** completamente traducido al español:

```
lib/
 ├── core/                     # Código transversal compartido en la app
 │    ├── errors/              # Abstracción de fallos (fallos.dart)
 │    ├── theme/               # Paleta de colores e interfaces de alta visibilidad (tema_app.dart)
 │    ├── utils/               # Constantes globales (constantes.dart)
 │    ├── routing/             # Enrutamiento GoRouter y vistas de navegación
 │    │    ├── enrutador_app.dart              # Enrutador GoRouter principal
 │    │    └── pantalla_principal_shell.dart   # Esqueleto de navegación inferior (Solid Dock)
 │    └── persistence/         # Proveedores de base de datos Isar
 │
 ├── features/                 # Módulos o funcionalidades de negocio
 │    ├── home/                # Dashboard Ejecutivo (Centro de Mando)
 │    │    └── presentation/   # Interfaz de panel con métricas en tiempo real (pantalla_inicio.dart)
 │    │
 │    ├── farms/               # Gestión Multi-Finca y Tutor de Configuración
 │    │    ├── domain/         # Entidad de Finca (finca_model.dart)
 │    │    ├── data/           # Repositorio Isar (repositorio_fincas.dart)
 │    │    └── presentation/   # Listado de fincas y Tutor Interactivo (pantalla_onboarding.dart)
 │    │
 │    ├── inventory_management/ # Gestión de Bodega y Stock
 │    │    ├── domain/         # Entidad de Insumo (insumo_model.dart)
 │    │    ├── data/           # Repositorio Isar (repositorio_insumos.dart)
 │    │    └── presentation/   # Interfaz de bodega virtual (pantalla_bodega.dart)
 │    │
 │    ├── maps_and_lots/       # Gestión de Lotes y Zonificación GIS
 │    │    ├── domain/         # Modelo de Lote con Tipo de Uso (lote_model.dart)
 │    │    ├── data/           # Implementación Isar (repositorio_lotes.dart)
 │    │    └── presentation/   # Mapas e Inventario de Tierra (pantalla_panel_lotes.dart, pantalla_mapa_finca.dart)
 │    │
 │    ├── field_workers/       # Gestión de Trabajadores (Nómina)
 │    │    ├── domain/         # Entidad de Trabajador (trabajador_model.dart)
 │    │    ├── data/           # Implementación Isar (repositorio_trabajadores.dart)
 │    │    └── presentation/   # Interfaz de nómina (pantalla_lista_trabajadores.dart)
 │    │
 │    ├── inventory_costs/     # Control de Gastos e Insumos
 │    │    ├── domain/         # Entidad de Costo (item_costo_model.dart)
 │    │    ├── data/           # Implementación Isar (repositorio_costos.dart)
 │    │    └── presentation/   # Interfaz financiera y calculadora (pantalla_panel_costos.dart)
 │    │
 │    └── farm_calendar/       # Agenda de la Finca (Cronograma)
 │         ├── domain/         # Entidad de Tarea (tarea_model.dart)
 │         ├── data/           # Implementación Isar (repositorio_calendar.dart)
 │         └── presentation/   # Interfaz de agenda (pantalla_cronograma.dart)
 │
 │    └── livestock/           # Gestión Pecuaria (Animales)
 │         ├── domain/         # Entidades de Especie, Salud y Alimento
 │         ├── data/           # Repositorio Isar (repositorio_pecuario.dart)
 │         └── presentation/   # Detalle de salud y alimentación (pantalla_panel_pecuario.dart, pantalla_detalle_especie.dart)
 │
 └── main.dart                 # Inicializador con Isar, ProviderScope y GoRouter
```

---

## 🎨 Decisiones de Diseño y Adaptaciones Técnicas

1.  **Idioma de Código e Interfaz**: Todo el proyecto está redactado en **Español** para facilitar el entendimiento local.
2.  **Parche de Compatibilidad Gradle**: Inyección dinámica en `build.gradle.kts` para soportar Android SDK 36 e Isar.
3.  **Botones Grandes e Interfaces de Alto Contraste**: Botones de altura `56.0` - `85.0` y textos de `18.0+` en `tema_app.dart`.
4.  **Diseño Adaptativo y Accesibilidad (Fuentes al 200%)**:
    *   Implementación de layouts dinámicos que detectan el factor de escala de texto del sistema (`MediaQuery.textScaler`).
    *   Ajuste automático de columnas en Grids: El Dashboard cambia de 2 a 1 columna en métricas y de 3 a 2 en atajos cuando se detectan fuentes extra grandes, evitando desbordamientos de UI.
    *   Uso de `FittedBox` y `Flexible` en componentes críticos para garantizar que los valores numéricos y títulos sean siempre legibles sin cortarse.
5.  **Dashboard de Inicio (Centro de Mando Ejecutivo)**:
    *   **Contexto de Finca**: Header con el nombre de la finca seleccionada actualmente y conmutador rápido de propiedad.
    *   **Métricas de Negocio en Tiempo Real**: Panel que resume los KPIs críticos de la finca:
        *   **Tierra**: Hectáreas totales y cantidad de lotes zonificados.
        *   **Finanzas**: Inversión acumulada en pesos.
        *   **Pecuario**: Censo total de cabezas de animales.
        *   **Bodega**: Cantidad de insumos registrados y alertas de stock.
        *   **Equipo**: Número de personas activas en nómina.
    *   **UX Predictiva Inmediata**: Banners de alerta condicionales y accionables. Al tocar la alerta de tareas, el sistema transporta al usuario directamente a la Agenda; al tocar la alerta de stock bajo, lo lleva a la Bodega Virtual.
    *   **Acceso Rápido Inteligente**: Grid de atajos (Bento Style) simplificado para evitar redundancias. Los módulos de Gastos, Nómina, Animales, Mapa y Bodega son accesibles con un toque, manteniendo la Calculadora Predictiva integrada dentro del módulo de Gastos para un flujo de trabajo más coherente.
5.  **Localización GPS y Mapeo Satelital de Precisión**:
    *   **Modo Pantalla Completa**: El mapa se extiende bajo el AppBar transparente para máxima visibilidad.
    *   **Dock Lateral**: Controles flotantes circulares para centrar ubicación y limpiar dibujo.
    *   **Guía de Usuario**: Banner superior dinámico que indica cuántos puntos faltan para cerrar un polígono.
    *   **Pines Arrastrables**: Los marcadores de dibujo son `draggable`, permitiendo al usuario ajustar milimétricamente los linderos después de marcarlos, recalculando el área automáticamente.
    *   **Centrado Inteligente (Smart Landing - Estricto)**: Al abrir el mapa de creación, el sistema prioriza la infraestructura existente o el centroide de la finca. Se implementó una lógica de bloqueo asíncrono que evita que el GPS del celular "robe" el foco de la cámara una vez centrado en la propiedad, garantizando una navegación estable.
    *   **Mapeo Híbrido (Manual vs Campo)**: Sistema dual que permite dibujar tocando la pantalla (Modo Manual) o capturando coordenadas caminando el lindero (Modo GPS Campo).
    *   **Filtro de Precisión Satelital**: En el modo GPS Campo, se implementó un guardián de calidad que solo permite capturar esquinas si el margen de error del GPS es inferior a 5.0 metros, asegurando la validez de los cálculos de hectáreas.
6.  **Persistencia Centralizada con Isar**:
    *   Inicialización global en `main.dart` con esquemas para `Finca`, `Lote`, `Trabajador`, `Costo`, `Tarea`, `Especie`, `Salud` y `Alimento`.
    *   Todas las colecciones incluyen `fincaId` para aislamiento de datos.
7.  **Navegación Global (Solid Dock)**:
    *   Uso de `NavigationBar` de Material 3 con altura aumentada (`85.0`) y etiquetas siempre visibles para máxima estabilidad.
    *   3 pestañas estratégicas en el Shell: **Inicio**, **Mis Lotes** y **Agenda**.
8.  **Módulo Agenda de la Finca**:
    *   **Cerebro Central**: Registro de actividades con diseño tipo checklist.
    *   **Integración Cruzada**: Recibe tareas automáticas desde el módulo pecuario y agrícola.
9.  **Módulo Pecuario Detallado**:
    *   **Gestión de Salud**: Registro de tratamientos (vacunas, purgas, vitaminas) con creación automática de recordatorios en la Agenda Global (color púrpura).
    *   **Alimentación Inteligente**: Seguimiento de consumo de kilos por grupo animal con integración a la Bodega Virtual para descuento automático de stock.
    *   **UX Inmersiva**: Pantalla de detalle con pestañas independientes, indicadores de cantidad y tipo de especie en el header, y feedback háptico en registros.
10. **Calculadora Predictiva de Insumos**: Lógica que cruza el censo de plantas de un lote con dosis recomendadas para proyectar compras de bultos de abono.
11. **Flujo de Registro Unificado (Lote + Agenda)**: 
    *   Integración transaccional (`isar.writeTxn`) que permite guardar un lote y agendar su cronograma inicial (Abonado, Cosecha, Fumigación) en un solo paso.
12. **Mapa Global de la Finca**: 
    *   Visualización satelital completa de la propiedad con polígonos coloreados por **Tipo de Uso**.
    *   Cálculo dinámico de límites (`LatLngBounds`) para encuadre automático de todos los lotes guardados.
    *   **Codificación por Colores**: Los pines centrales usan códigos de color estándar (Verde: Agrícola, Naranja: Pecuario, Azul: Forestal, Violeta: Infraestructura).
13. **Portafolio Global de Propiedades (Agregación BI)**:
    *   **Visualización Consolidada**: Vista de alto nivel que muestra todas las propiedades en un solo mapa interactivo.
    *   **Inteligencia de Datos**: Implementación de algoritmos GIS para calcular el **Centroide Geométrico**, el **Área Total Agregada** y el conteo de lotes por cada finca.
    *   **Optimización Visual (Anti-Cluttering)**: En lugar de saturar el mapa con cientos de polígonos, se muestra un único marcador maestro por finca con toda su información consolidada.
    *   **Zoom Semántico (Drill-down)**: Al tocar una finca, el mapa desciende (zoom) para revelar sus polígonos específicos coloreados por uso.
    *   **Panel de Inteligencia Terrenal**: Despliegue de un panel inferior que resume la distribución de la tierra (ej: cuántas Ha son de café vs ganado) antes de entrar a la gestión detallada.
    *   **Inmersión Táctil**: Al tocar "Administrar esta Finca", la app cambia automáticamente el contexto global y transporta al usuario directamente al Dashboard de esa propiedad.
14. **Internacionalización Local**: Configuración `es_CO` para nombres de días, meses y formatos de moneda.
15. **Arquitectura Multi-Finca (Multi-Tenant Local)**:
    *   **Aislamiento de Datos**: Todas las consultas filtran obligatoriamente por el ID de la finca seleccionada (`fincaSeleccionadaProvider`).
    *   **Entrada Segura**: La app inicia en `PantallaMisFincas` obligando a seleccionar una propiedad antes de entrar al Dashboard.
    *   **Conmutador de Finca (Switch Workspace)**: Botón de salida rápida en el Dashboard que limpia el estado global y permite regresar a la selección de propiedades.
16. **Zonificación de Finca Integral**:
    *   **Clasificación de Uso**: Implementación del `TipoUsoLote` (Agrícola, Pecuario, Forestal, Infraestructura).
    *   **Lógica de Negocio**: Campos condicionales en el formulario (ej: "Capacidad de animales" para Pecuario vs "Número de matas" para Agrícola).
    *   **Visualización Inteligente**: Colores automáticos en mapas (Verde, Naranja, Azul, Gris) según la clasificación de la tierra.
    *   **Capas de Dibujo (UX Avanzada)**: Durante la creación de nuevos lotes, se visualizan los polígonos existentes como una "capa pasiva" de fondo. Esto evita solapamientos accidentales y proporciona contexto espacial inmediato al administrador.
17. **Integración 360° y Automatización (Fase 2.5)**:
    *   **Vínculo Financiero (Gasto In Situ)**: Al completar tareas críticas en la Agenda (Abonado, Fumigación), el sistema activa automáticamente un flujo de registro de gastos, eliminando la doble entrada de datos.
    *   **Bodega Virtual e Inventarios**: Módulo dedicado para la gestión de insumos (bultos de urea, purina, etc.) con alertas visuales de bajo stock en el Dashboard.
    *   **Descuento Automático de Stock**: Integración entre la Agenda y la Bodega que permite descontar insumos directamente al momento de reportar la ejecución de una labor.
    *   **Asistente de Voz (IA Local)**: Implementación de reconocimiento de voz en el Dashboard para facilitar la entrada de datos "manos libres" mediante comandos naturales.
18. **Nómina Dinámica y Recolección**:
    *   **Liquidación Transaccional**: Motor de cálculo para pagar a trabajadores por jornal fijo o por kilo recolectado (destajo).
    *   **Asientos Contables Automáticos**: El sistema deduce costos de alimentación de la nómina neta e inyecta automáticamente el gasto correspondiente en la contabilidad de la finca.
    *   **Trazabilidad de Cosecha**: Registro histórico de quién recolectó, en qué fecha y en qué lote, amarrado al ID de la finca.
19. **Puente Logístico (Interoperabilidad)**:
    *   **Módulo ServiCarga**: Implementación de un botón de solicitud de transporte de carga pesada integrado en la Bodega Virtual.
    *   **Integración mediante Deep Links**: Preparado para conectar con la plataforma externa de ServiCarga pasando parámetros de origen, carga y cantidad de forma automática.
20. **Tutor Interactivo de Configuración (Onboarding de Misiones)**:
    *   **Aprendizaje Práctico**: Sistema de guía paso a paso que lleva al usuario a través de las interfaces reales de la aplicación en lugar de formularios estáticos.
    *   **Centro de Misiones**: El usuario debe completar 5 misiones críticas (Crear Finca con Nombre y Ubicación, Dibujar Lote, Cargar Bodega, Agendar Tarea, Configurar Equipo) antes de aterrizar en el Dashboard.
    *   **Validación de Estado**: El tutor detecta automáticamente cuando se han guardado los datos reales en Isar para marcar la misión como cumplida.

---

## 🌟 Lineamientos de UX/UI para el Campo

1.  **Feedback Háptico**: Vibraciones de confirmación al guardar datos.
2.  **Modo Sol Intenso**: Diseño de ultra-contraste para legibilidad extrema.
3.  **Entrada de Voz**: Integración futura de dictado para formularios.
4.  **Micro-interacciones**: Swipe-to-complete en listas.
5.  **Capas de Visibilidad**: Estilo de mapa personalizado resaltando polígonos sobre el satélite.

---

## 🚀 Cómo correr y continuar el Desarrollo

### En un celular Android conectado:
1.  Activa la depuración USB.
2.  Corre: `flutter run -d E6FACI5XU8O7AIXK`
3.  **Generación de código**: `flutter pub run build_runner build --delete-conflicting-outputs`

---

## 🗺️ Hoja de Ruta y Próximas Fases
Consulte el archivo [FUTURAS_VERSIONES.md](FUTURAS_VERSIONES.md).
