# 🚜 AgroGo: ERP Agrícola de Grado Senior y Multi-Finca

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Riverpod](https://img.shields.io/badge/Riverpod-2.x-teal)
![Firebase](https://img.shields.io/badge/Firebase-Auth_&_Firestore-orange?logo=firebase)
![Clean Architecture](https://img.shields.io/badge/Clean-Architecture-success)
![ChopCode Solutions](https://img.shields.io/badge/By-ChopCode_Solutions-black)

**AgroGo** es un sistema de gestión integral (ERP) móvil de grado profesional diseñado para revolucionar la administración de fincas cafeteras y ganaderas. Transformamos la gestión tradicional en un proceso inteligente, geográfico y **100% Offline-First**, integrado en el **Ecosistema "Go"**.

---

## 🎯 Pilares Estratégicos

1.  **Identidad Unificada (SSO)**: Acceso mediante cuenta única de Google compartida con RutaGo y CargoGo.
2.  **Ingeniería de Tierra (GIS)**: Mapeo de precisión con **Geovallas (Geofencing)** que prohíben el dibujo fuera del perímetro real de la finca.
3.  **Flujo Lógico Secuencial**: Sistema guiado que obliga a definir el Perímetro -> Infraestructura -> Cultivos -> Animales.
4.  **Dashboard Bento Pro**: Interfaz ejecutiva con métricas agrupadas por dominios de negocio (Patrimonio, Producción, Recursos).
5.  **Offline-First Rural**: Operación total sin señal celular mediante base de datos Isar con sincronización selectiva a la nube.

---

## 🚀 Módulos y Capacidades

### 🏘️ Gestión Estructural y GIS
*   **Perímetro Maestro**: Definición del límite total de la propiedad como marco de contención.
*   **Zonificación por Tabs**: Separación clara entre **Lotes de Cultivo** y **Estructuras Físicas** (Casas, Bodegas, Corrales).
*   **Mapeo Híbrido**: Captura manual o vía GPS Campo con filtro de precisión de 5 metros.

### 🐖 Motor Pecuario Integral
*   **Validación de Alojamiento**: No se permiten animales sin infraestructura previa.
*   **Especies Soportadas**: Cerdos, Vacas, Caballos, Ovejas, Cabras, Peces, Aves y Mulas.
*   **Asistente de Carga**: Diálogos de acción rápida tras crear un corral.

### 🧠 Automatización y Operación
*   **Bodega Virtual**: Gestión de stock categorizada vinculada a bodegas físicas.
*   **Nómina Dinámica**: Liquidación por Kilo, Arroba o Jornal con descuentos automáticos.
*   **Trazabilidad de Café**: Control del proceso desde Cereza hasta Venta Directa o Secado.

---

## ⚙️ Instalación y Compilación

Para detalles técnicos y guías, consulte la carpeta `/docs`:
- [🏗️ Arquitectura y Stack](./docs/technical/ARCHITECTURE_MODULES.md)
- [🎨 Diseño y UX](./docs/product/BRANDING.md)
- [🚀 Módulos y Funcionalidades](./docs/product/REQUISITOS.md)
- [🗺️ Hoja de Ruta](./docs/product/ROADMAP.md)
- [🛠️ Guía de Desarrollo](./docs/technical/DEVELOPER_GUIDELINES.md)
- [📝 Changelog](./docs/technical/CHANGELOG.md)

1.  **Dependencias:**
    ```bash
    flutter pub get
    ```

2.  **Generación de Código:**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

3.  **Configuración de Firebase:**
    ```bash
    flutterfire configure
    ```

---
**Desarrollado por ChopCode Solutions.**  
*Ingeniería para la productividad rural.*
