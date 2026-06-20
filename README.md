# 🚜 AgroGo: ERP Agrícola de Grado GIS y Multi-Finca

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Riverpod](https://img.shields.io/badge/Riverpod-2.x-teal)
![Isar](https://img.shields.io/badge/Isar_Database-Offline_First-orange)
![Clean Architecture](https://img.shields.io/badge/Clean-Architecture-success)
![ChopCode Solutions](https://img.shields.io/badge/By-ChopCode_Solutions-black)

**AgroGo** es un sistema de gestión integral (ERP) móvil diseñado para revolucionar la administración de múltiples fincas y proyectos agropecuarios. Transformamos el "cuaderno de la finca" en un asistente inteligente predictivo que funciona **100% Offline**, integrando tecnología de precisión geográfica (GIS) y automatización de procesos.

---

## 🎯 Pilares Estratégicos

1. **Arquitectura Multi-Finca (Multi-Tenant Local):** Administre múltiples propiedades de forma independiente. Los datos están blindados por finca, garantizando un aislamiento total de finanzas y operaciones.
2. **Motor GIS Profesional:** Mapeo satelital avanzado con cálculos de área reales, zonificación de suelo y portafolio global de propiedades.
3. **Integración 360° (Cerebro de Datos):** Los módulos se comunican automáticamente. Marcar una labor en la agenda afecta instantáneamente la contabilidad y descuenta insumos del inventario.
4. **UX de Sol Intenso:** Interfaz de alto contraste, botones gigantes y asistente de voz para operar en el campo con las manos ocupadas.

---

## 🚀 Módulos y Capacidades

### 🏘️ Gestión Multi-Finca y Portafolio
*   **Switch Maestro:** Conmute entre propiedades con un solo toque.
*   **Visor de Portafolio:** Mapa global con inteligencia de negocios (Agregación BI) que muestra centroides y áreas totales de todas sus tierras.

### 🗺️ Zonificación e Ingeniería de Suelo
*   **Mapeo Híbrido:** Capture linderos tocando la pantalla o caminando el lote (Modo GPS Campo).
*   **Guardián de Precisión:** Filtro satelital que bloquea capturas si el margen de error es > 5m.
*   **Pines Dinámicos:** Marcadores arrastrables para ajustes milimétricos y capas pasivas para evitar solapamiento de lotes.
*   **Clasificación de Suelo:** Categorización por usos (Agrícola, Pecuario, Forestal, Infraestructura).

### 🧠 Automatización 360 (Fase 2.5)
*   **Vínculo Financiero:** Registro de gastos "In Situ" al completar tareas de la agenda.
*   **Bodega Virtual:** Gestión de inventarios con alertas de bajo stock y descuento automático al reportar labores.
*   **Agenda Inteligente:** Generación automática de recordatorios de salud animal y ciclos de cosecha.

### 🐖 Módulo Pecuario Integral
*   Control de Cerdos, Aves y Peces.
*   Historial de sanidad y seguimiento de alimentación vinculado a costos.

### 🎙️ Asistente de Voz (IA Local)
*   Entrada de datos manos libres mediante procesamiento de lenguaje natural para registros rápidos.

---

## 🏗️ Stack Tecnológico

*   **Framework:** Flutter (3.12+).
*   **Gestión de Estado:** `riverpod` (Generator).
*   **Persistencia:** `isar` (NoSQL) con transacciones ACID atómicas.
*   **GIS:** `google_maps_flutter` + `maps_toolkit`.
*   **Voz:** `speech_to_text`.
*   **Arquitectura:** Clean Architecture estructurada por Features en español.

---

## ⚙️ Instalación y Compilación

1.  **Dependencias:**
    ```bash
    flutter pub get
    ```

2.  **Generación de Código:**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

3.  **Ejecutar:**
    ```bash
    flutter run
    ```

*(Nota: Requiere configuración de permisos de ubicación y micrófono, además de la API Key de Google Maps).*

---

**Desarrollado por ChopCode Solutions.**  
*Llevando la ingeniería civil y la inteligencia de datos al corazón del campo.*
