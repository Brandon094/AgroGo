# 🗺️ Hoja de Ruta AgroGo: Estado del Desarrollo y Futuro

Este documento define la evolución de AgroGo, desde una herramienta local de gestión hasta un ecosistema conectado.

---

## ✅ Fase 1: Cimientos y Mapeo (COMPLETO)
*   **Clean Architecture:** Estructura modular y escalable.
*   **Multi-Finca:** Soporte para múltiples propiedades con aislamiento total.
*   **Zonificación:** Diferenciación entre lotes Agrícolas, Pecuarios e Infraestructura.
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

## 🧠 Fase 2.5: Integración 360° y Automatización (PRÓXIMAMENTE)
El objetivo es que los módulos "hablen" entre sí para reducir el trabajo administrativo.

### 1. Vínculo Financiero Tarea-Gasto
*   **Gasto In Situ:** Al marcar una tarea (ej. Abonar) como "Completada", se abrirá un popup para registrar el dinero gastado en ese instante, vinculándolo automáticamente al módulo de Gastos y al lote correspondiente.

### 2. Gestión de Inventarios Real
*   **Bodega Virtual:** Descontar automáticamente bultos de purina o fertilizante cuando se registre una alimentación animal o un abono de lote.
*   **Alertas de Reabastecimiento:** Notificación naranja si el inventario de un insumo cae por debajo del umbral mínimo.

### 3. Asistente de Voz (IA Local)
*   **Entrada Manos Libres:** Permitir al usuario dictar registros ("Anotar 2 kilos de purina a los cerdos") mientras tiene las manos ocupadas en la labor.

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
