# 🗺️ Hoja de Ruta AgroGo: Estado del Desarrollo y Futuro

Este documento define la evolución de AgroGo, desde una herramienta local de gestión hasta un ecosistema conectado.

---

## ✅ Fase 1: Cimientos y Mapeo (COMPLETO)
*   **Clean Architecture:** Estructura modular y escalable.
*   **Multi-Finca:** Soporte para múltiples propiedades con aislamiento total.
*   **Zonificación:** Diferenciación entre lotes Agrícolas, Pecuario e Infraestructura.
*   **Portafolio Global:** Visor de inteligencia de negocios con agregación de hectáreas y centroides.
*   **Offline-First:** Persistencia atómica con Isar Database.

---

## ✅ Fase 2: Módulo Pecuario e Integración (COMPLETO)
El sistema ya soporta la gestión integral de la fauna de la finca.
*   **Especies Soportadas:** Cerdos, Aves y Peces.
*   **Gestión de Salud:** Registro de tratamientos con inyección automática en la Agenda Global.
*   **Gestión de Alimento:** Control de consumo de kilos por grupo animal.
*   **UX Satelital:** Polígonos naranjas y pines de colores para identificar zonas pecuarias.

---

## ✅ Fase 2.5: Integración 360°, Nómina y Logística (COMPLETO)
Se ha logrado que los módulos "hablen" entre sí, reduciendo drásticamente la carga administrativa.
*   **Vínculo Financiero Tarea-Gasto:** Registro de gastos "In Situ" al completar labores.
*   **Bodega e Inventarios:** Descuento automático de insumos y alertas de bajo stock en el Dashboard.
*   **Nómina Dinámica:** Motor de liquidación por jornal o por kilo (destajo) con asientos contables automáticos (Alimentación).
*   **Asistente de Voz:** Reconocimiento de comandos naturales para entrada de datos manos libres.
*   **Puente Logístico (Beta):** Integración preparada para el despacho de carga mediante ServiCarga.

---

## ☁️ Fase 3: AgroGo Network (Nube y Marketplace)
Transición a un modelo colaborativo y comunitario.

### 1. Sincronización en la Nube (BaaS)
*   **Tecnología:** Integración con Supabase o Firebase para respaldo automático.
*   **Colaboración:** Permite que el dueño y el administrador vean la misma información en tiempo real desde dos celulares diferentes.

### 2. Bolsa de Empleo Agrícola (Marketplace)
*   **Ofertas Geolocalizadas:** Los dueños publican vacantes que aparecen en el mapa para trabajadores cercanos.
*   **Perfil del Trabajador:** Historial digital de jornales, recolecta de café y calificaciones.
*   **Contratación Rápida:** Al aceptar una oferta, el trabajador se vincula automáticamente a la nómina de la finca.

### 3. Certificaciones Digitales
*   **Trazabilidad Exportable:** Generación de reportes en PDF con el historial de aplicaciones y manejos para certificaciones de calidad (ej. Global GAP, RainForest).
