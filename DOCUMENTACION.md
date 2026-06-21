# 📋 Documentación de Inicialización de Proyecto: AgroGo

Este documento detalla la estructura base, las tecnologías configuradas, las decisiones arquitectónicas y las pantallas del proyecto **AgroGo**.

---

## 🏢 Información General del Proyecto
*   **Nombre de la App:** AgroGo
*   **Organización:** `com.chopcode`
*   **Arquitectura:** Clean Architecture estructurada por módulos (`Domain`, `Data`, `Presentation`).
*   **Enfoque Offline-First**: Almacenamiento persistente local mediante base de datos Isar en todos los módulos.
*   **Enfoque de UX**: Diseño adaptado para condiciones de campo (alto contraste, botones grandes, accesibilidad).

---

## 🛠️ Stack Tecnológico Configurado

Las dependencias principales se han añadido y bloqueado en versiones estables y totalmente compatibles:

### Dependencias Principales (`dependencies`):
*   `flutter_riverpod` y `riverpod_annotation` (^2.6.1): Gestión de estados reactivos.
*   `isar` y `isar_flutter_libs` (^3.1.0+1): Base de datos local Offline-First.
*   `google_maps_flutter` (^2.17.1): Renderizado de mapas.
*   `maps_toolkit` (^3.1.0): Cálculos geográficos (Áreas y polígonos).
*   `geolocator` (^14.0.3): Acceso a servicios de GPS nativos.
*   `speech_to_text` (^7.4.0): Asistente de voz para entrada de datos.
*   `intl` (^0.20.2): Internacionalización y formatos locales (`es_CO`).
*   `go_router` (^17.3.0): Enrutamiento declarativo robusto.

---

## 📐 Estructura de Directorios (Feature-Driven)

```
lib/
 ├── core/                     # Código transversal
 │    ├── persistence/         # Instancia global de Isar
 │    ├── routing/             # Enrutador App y Navigation Shell
 │    ├── theme/               # ADN Visual (Premium Emerald Theme)
 │    └── utils/               # Constantes y utilidades
 │
 ├── features/                 # Módulos de Negocio
 │    ├── home/                # Dashboard Ejecutivo (Centro de Mando)
 │    ├── farms/               # Gestión Multi-Finca y Onboarding Tutor
 │    ├── maps_and_lots/       # Zonificación GIS e Ingeniería de Tierra
 │    ├── inventory_management/ # Bodega Virtual y Stock
 │    ├── field_workers/       # Nómina Dinámica y Recolección
 │    ├── inventory_costs/     # Finanzas y Calculadora Predictiva
 │    ├── farm_calendar/       # Agenda de la Finca (Cronograma)
 │    └── livestock/           # Gestión Pecuaria (Salud y Alimento)
```

---

## 🎨 Decisiones de Diseño y Evolución Técnica

1.  **Idioma 100% Español**: Código, interfaces y mensajes adaptados al contexto local.
2.  **Parche de Compatibilidad**: Soporte para Android SDK 36 e Isar mediante inyección en Gradle.
3.  **Diseño Visual Unificado (Premium Emerald Theme)**:
    *   Paleta basada en **Verde Esmeralda Profundo** (`#00695C`) y **Verde Bosque**.
    *   Bordes Ultra-Redondeados (28px - 32px) para una estética moderna.
    *   Headers consistentes con estilo "Glassmorphism" y sombras sutiles.
4.  **Diseño Adaptativo y Accesibilidad (Fuentes al 200%)**:
    *   Layouts dinámicos que detectan el `textScaler` del sistema.
    *   Ajuste automático de columnas en Grids para evitar desbordamientos.
    *   Uso de `FittedBox` en métricas críticas para garantizar legibilidad.
5.  **Optimización de Rendimiento (High Performance)**:
    *   Implementación de `RepaintBoundary` para aislar el renderizado del Dashboard y listas.
    *   Eliminación de lag en la apertura de teclado mediante `resizeToAvoidBottomInset: false`.
    *   Scroll fluido con `BouncingScrollPhysics` y carga diferida con `ListView.builder`.
6.  **Dashboard de Inicio (Centro de Mando Ejecutivo)**:
    *   Métricas en tiempo real: Tierra (Ha), Finanzas ($), Beneficio (Café en proceso), Bodega (Stock), Pecuario y Equipo.
    *   Banners de alerta accionables: Atajos directos a la Agenda o Bodega según la urgencia.
    *   Conmutador de Finca rápido para administración Multi-Tenant.
7.  **Localización GPS y Mapeo de Precisión**:
    *   **Centrado Inteligente**: Prioriza la infraestructura (casa) sobre el GPS real al iniciar.
    *   **Mapeo Híbrido**: Modo Manual (dedo) vs Modo Campo (caminar el lindero).
    *   **Selector de Capas**: Botón para alternar entre Vista Satelital (Híbrida) y Vista Simple (Mapa Gris/Normal) para optimizar el rendimiento y ahorro de datos.
    *   **Filtro de Precisión**: Bloqueo de captura si el error del GPS es > 5.0 metros.
    *   **Pines Arrastrables**: Ajuste milimétrico de linderos con recálculo de área en vivo.
8.  **Persistencia Atómica (Isar)**:
    *   Transacciones `isar.writeTxn` para garantizar integridad en registros complejos.
    *   Aislamiento de datos Multi-Finca mediante llave foránea lógica `fincaId`.
9.  **Navegación Global (Solid Dock)**:
    *   Barra inferior de 3 pestañas estratégicas (**Inicio**, **Mis Lotes**, **Agenda**).
    *   Flujos de gestión como rutas superpuestas para reducir fatiga cognitiva.
10. **Automatización 360° (Cerebro de Datos)**:
    *   **Gasto In Situ**: Registro de costos al completar tareas de la agenda.
    *   **Descuento de Inventario**: La ejecución de labores resta automáticamente stock de la Bodega.
    *   **Agenda Sanitaria**: Las vacunas pecuarias agendan automáticamente el próximo refuerzo.
    *   **Programación Recurrente Inteligente**: Al crear un lote, el sistema permite definir frecuencias de **Abonado** y **Fumigación** (ej: cada 3 meses) basadas en estándares de **Cenicafé**, generando automáticamente el cronograma de tareas para todo el año.
11. **Registro de Cosechas Personalizado**:
    *   **Flexibilidad por Región**: Selección de rangos de meses para la **Cosecha Principal** y la **Mitaca** (Travesía), adaptándose a los ciclos específicos de zonas como Nátaga o cualquier región cafetera.
    *   **Cálculo de Anualidad**: El sistema proyecta automáticamente el año (actual o siguiente) según el mes seleccionado para evitar tareas vencidas en la agenda.
12. **Nómina Dinámica y Recolección**:
    *   Liquidación por Jornal, Kilo o **Arroba (12.5 kg)**.
    *   Descuento automático por alimentación y registro de asiento contable.
    *   **Liquidación Semanal**: Pantalla de resumen que agrupa todas las labores por trabajador desde el inicio de la semana para pagos rápidos.
13. **Beneficio y Transformación del Café (Trazabilidad)**:
    *   **Recolección Automática**: El sistema suma los kilos de cereza entregados por todos los recolectores en la semana para iniciar el beneficio.
    *   **Gestión de Estados**: Seguimiento del lote desde **Cereza -> Lavado -> Secado -> Listo (Venta)**.
    *   **Conversión a Producción**: Al finalizar el secado, el sistema solicita el peso seco final e inyecta automáticamente el stock en la categoría de "Producción" de la Bodega.
14. **Bodega Virtual Triple Categoría**:
    *   **Operación**: Insumos consumibles (Abono, purina, venenos).
    *   **Maquinaria**: Gestión de gasolina, aceite, cuchillas y equipos (Guadañas, motosierras).
    *   **Producción**: Control de productos cosechados para venta (Café, Cacao, Plátano).
    *   **Inteligencia de Café**: Detector de nombre que habilita la marca de **"EN SECADO"** para trazabilidad de beneficio.
15. **Calculadora Predictiva e Integración Financiera**:
    *   Proyección de bultos de abono, alimento animal y bombas de fumigación basada en censo de plantas y cabezas.
    *   **Costo Estimado**: Cálculo de inversión antes de comprar.
    *   **Inyección Automática**: Al confirmar una proyección, el sistema registra el gasto en finanzas y carga el stock automáticamente en la Bodega.
16. **Portafolio Global de Propiedades (Agregación BI)**:
    *   Mapa consolidado de todas las fincas con cálculo de Centroides y Áreas Agregadas.
    *   Zoom Semántico (Drill-down) para revelar polígonos al seleccionar una finca.
17. **Tutor Interactivo (Onboarding de Misiones)**:
    *   Sistema de guía práctica que obliga a configurar la Finca, el Lote y el Equipo usando la interfaz real antes de empezar.
18. **Sistema de Feedback y UX Comunicativa**:
    *   **Notificaciones In-App**: SnackBars flotantes en cada operación de éxito (Guardado de finca, registro de labor, ajuste de bodega).
    *   **Feedback Háptico**: Vibraciones táctiles en momentos clave (captura GPS, errores de validación) para mejorar la usabilidad en campo.
    *   **Unidades de Medida**: Indicación visual clara (kg, plantas, bultos) en todos los campos de entrada de datos.
19. **Gestión Pecuaria con Trazabilidad Geográfica**:
    *   **Asociación de Lotes**: Capacidad de vincular grupos de animales (cerdos, aves, peces) a infraestructuras específicas mapeadas en el sistema (ej: cocheras, galpones).
    *   **Visualización en Tarjeta**: Identificación inmediata de la ubicación física de cada grupo animal directamente desde el panel pecuario.
    *   **Edición Dinámica**: Posibilidad de reasignar grupos animales a diferentes lotes o actualizar su información directamente desde el panel de control.
20. **Gestión Ágil de Recursos y Equipo**:
    *   **Acciones Directas**: Implementación de funciones de eliminación y edición rápida directamente en las listas de Lotes, Trabajadores y Animales.
21. **Formateo Financiero Profesional**:
    *   **Estándar Bancario**: Implementación de separadores de miles (puntos) y sufijo oficial `COP` en todos los valores monetarios.
    *   **Manejo de Millones**: Visualización inteligente que escala a millones (ej: $1.5M) o miles (ej: $10k) en el Dashboard para mantener la limpieza visual.
    *   **FittedBox Adaptativo**: Los valores grandes se auto-ajustan al ancho de la tarjeta para evitar cortes o desbordamientos.

---

## 🚀 Cómo correr y continuar el Desarrollo
1.  `flutter pub get`
2.  `flutter pub run build_runner build --delete-conflicting-outputs`
3.  `flutter run -d <ID_DISPOSITIVO>`

---

**Desarrollado por ChopCode Solutions.**
