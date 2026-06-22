# 📜 Historial de Cambios (Changelog) - AgroGo

Todos los cambios notables en este proyecto serán documentados en este archivo siguiendo el estándar [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [0.3.0] - 2024-06-21
### Añadido
- **Módulo de Autenticación Unificada**: Integración con Firebase Auth y Google Sign-In para el Ecosistema "Go".
- **Enrutador Inteligente**: Redirección automática al Login basada en el estado de autenticación de Riverpod.
- **Identidad Única (SSO)**: Preparado para interoperar con RutaGo y CargoGo mediante el mismo UID.
- **Soporte Multi-Plataforma**: Configuración oficial para Android (llaves SHA) e iOS (Info.plist).

### Cambiado
- **Estructura de Documentación**: Migración a estándar "Senior" con carpetas `/technical` y `/product`.
- **Priorización de Plataformas**: Decisión estratégica de enfocar el desarrollo en Android e iOS para optimizar la experiencia GIS y Offline, posponiendo Web debido a compatibilidad de Isar con JavaScript.

---

## [0.2.5] - 2024-06-20 (Beneficio y Venta)
### Añadido
- **Motor de Venta Directa**: Opción de vender café mojado o en cereza saltando el secado.
- **Integración Logística**: Banner de ServiCarga en diálogos de venta.
- **Auditoría Senior**: Reestructuración total de la documentación al estándar "Go Ecosystem".
- **Estado Púrpura**: Nuevo identificador visual para lotes de producción vendidos.

### Cambiado
- **Refactor de Tema**: Conexión de todos los módulos al `Theme.of(context).primaryColor` para evitar colores quemados.
- **Nómina Inteligente**: El cálculo de pago ahora es reactivo desde la apertura del formulario.

---

## [0.2.0] - 2024-06-15 (Premium Emerald)
### Añadido
- **Identidad Visual**: Implementación del tema Emerald Premium con Glassmorphism.
- **Bento Dashboard**: Rediseño del inicio con tarjetas de métricas 3x2.
- **Mapeo Híbrido**: Soporte para capas satelitales y normales en tiempo real.

---

## [0.1.0] - 2024-06-01 (MVP)
### Añadido
- **Persistencia Isar**: Implementación de base de datos local Offline-First.
- **Clean Architecture**: Estructura de carpetas por features.
- **Módulo GIS**: Creación y cálculo de áreas de lotes.

---
**Chop Code Solutions - Ingeniería para el campo.**
