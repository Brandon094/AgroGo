# 🚜 AgroGo: ERP Agrícola y Pecuario Offline-First

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Riverpod](https://img.shields.io/badge/Riverpod-2.x-teal)
![Isar](https://img.shields.io/badge/Isar_Database-Offline_First-orange)
![Clean Architecture](https://img.shields.io/badge/Clean-Architecture-success)
![ChopCode Solutions](https://img.shields.io/badge/By-ChopCode_Solutions-black)

**AgroGo** es un sistema de gestión integral (ERP) móvil diseñado específicamente para revolucionar la administración de fincas, cafetales y proyectos agropecuarios. Creado con un enfoque profundo en las necesidades reales del campo, elimina la dependencia de la conexión a internet y transforma el "cuaderno de la finca" en un asistente inteligente predictivo.

---

## 🎯 Objetivo del Proyecto

El objetivo principal de AgroGo es **democratizar la tecnología en el sector rural**, entregando una herramienta de grado empresarial que sea accesible, intuitiva y 100% funcional en zonas sin cobertura de red. 

Buscamos resolver los principales problemas del finquero y el administrador:
1. **Pérdida de datos:** Reemplazar el papel con persistencia local ultrarrápida (Isar).
2. **Cálculos a ciegas:** Calculadoras matemáticas para evitar el desperdicio en insumos.
3. **Desorden financiero:** Trazabilidad total de gastos por lote o especie animal.
4. **Brecha digital:** Interfaz de alta visibilidad para adultos mayores y condiciones de sol intenso.

---

## 🏗️ Arquitectura y Stack Tecnológico

Construido bajo principios de **Clean Architecture** (Feature-Driven), garantizando escalabilidad y mantenibilidad.

* **Framework:** Flutter (Android/iOS nativo).
* **Gestión de Estado:** `flutter_riverpod` con generación de código.
* **Base de Datos Local:** `isar_database`. Motor NoSQL con soporte geoespacial.
* **Enrutamiento:** `go_router` con navegación persistente entre ramas.
* **Geolocalización:** `google_maps_flutter` + `maps_toolkit` para cálculos geográficos de precisión.

---

## 🚀 Módulos Implementados

### 1. 🏠 Centro de Mando (Dashboard)
* UX Predictiva: Banner de alertas automáticas para tareas del día.
* Atajos rápidos tipo **Bento Box** para las operaciones más frecuentes.

### 2. 🗺️ Gestión de Tierra (Lotes y Mapas)
* Trazado de polígonos sobre mapas satelitales híbridos.
* Cálculo automático de hectáreas y censo de plantas (numero de matas).

### 3. 🐖 Módulo Pecuario (Fase 2)
* Control de especies menores: Cerdos, Aves (Gallinas/Pollos) y Peces.
* **Cerebro de Recordatorios:** El registro de una vacuna inyecta automáticamente una tarea en la Agenda Global.

### 4. 💰 Control Financiero e Insumos
* Registro de gastos operativos asociados a lotes o grupos animales.
* **Calculadora Predictiva:** Proyección exacta de bultos de abono y bombas de mezcla.

### 5. 📅 Agenda de la Finca
* Cronograma de actividades (Secado, Abonado, Fumigación, Sanidad).
* Diseño de alta visibilidad con sistema de completado por toques masivos.

---

## 📱 Experiencia de Usuario (UX) de Campo

AgroGo redefine la interacción en ambientes rurales:
* **Objetivos de Toque Masivos:** Botones de `56.0` - `64.0` dp.
* **Alto Contraste:** Tipografías de `18.0+` y paleta de colores optimizada para luz solar directa.
* **Feedback Sensorial:** Vibración háptica en registros exitosos para mayor seguridad del usuario.

---

## ⚙️ Instalación y Compilación

1. **Dependencias:**
   ```bash
   flutter pub get
    ```

2. **Generación de Código (Obligatorio):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Ejecutar:**
   ```bash
   flutter run
   ```

*(Nota: Requiere API Key de Google Maps configurada en `AndroidManifest.xml`).*

---

**Desarrollado por ChopCode Solutions.** 
*Creando tecnología real para problemas reales de nuestra comunidad.*
