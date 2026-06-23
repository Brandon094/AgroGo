# 📜 Historial de Cambios (Changelog) - AgroGo

Todos los cambios notables en este proyecto serán documentados en este archivo siguiendo el estándar [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [0.4.0] - 2024-06-21 (Valla Eléctrica y Bento Pro)
### Añadido
- **Motor de Geofencing Estricto**: Validación técnica que prohíbe dibujar cualquier punto fuera del perímetro maestro de la finca.
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
