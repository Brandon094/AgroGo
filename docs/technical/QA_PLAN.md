# 🏁 Plan de Pruebas y Aseguramiento de Calidad (QA)

Este documento detalla el protocolo para validar la estabilidad y precisión de AgroGo antes de su despliegue.

---

## 🏗️ 0. Preparación (Clean State)
1.  **Limpiar DB**: Borrar datos de la app para asegurar una base Isar vacía.
2.  **GPS**: Asegurar cielo abierto para pruebas de linderos.

---

## 🔴 Fase 0: Autenticación e Identidad (SSO)
| ID | Caso de Prueba | Acción | Resultado Esperado |
|:---|:---|:---|:---|
| 0.1 | Login Google | Tocar botón de Google y elegir cuenta. | Redirección automática al Dashboard/Onboarding. |
| 0.2 | Persistencia | Cerrar app y volver a abrir. | Debe entrar directo sin pedir login de nuevo. |
| 0.3 | Logout | Cerrar sesión desde el perfil. | Redirección inmediata a la Pantalla de Login. |
| 0.4 | Guardas de Ruta | Intentar entrar a `/lotes` sin estar logueado. | El sistema debe bloquear el acceso y mandar a `/login`. |

## 🟢 Fase 1: Mapeo GIS y Precisión
| ID | Caso de Prueba | Acción | Resultado Esperado |
|:---|:---|:---|:---|
| 1.1 | Captura Manual | Tocar 4 esquinas en el mapa. | Se forma el polígono y calcula hectáreas coherentes. |
| 1.2 | Filtro Precisión | Intentar capturar con mala señal. | El sistema debe mostrar advertencia y bloquear punto. |
| 1.3 | Pines Arrastrables | Mover un vértice del lote. | El área se recalcula automáticamente en vivo. |

---

## 🔵 Fase 2: Automatización 360°
| ID | Caso de Prueba | Acción | Resultado Esperado |
|:---|:---|:---|:---|
| 2.1 | Gasto de Tarea | Marcar abonada como "Completada". | Se abre diálogo de gasto y descuenta stock de bodega. |
| 2.2 | Calculadora Pro | Proyectar abono por matas. | El resultado de bultos debe redondear hacia arriba. |
| 2.3 | Inyección Stock | Guardar compra en calculadora. | Se crea ítem en bodega y registro en finanzas. |

---

## 🟡 Fase 3: Nómina y Beneficio
| ID | Caso de Prueba | Acción | Resultado Esperado |
|:---|:---|:---|:---|
| 3.1 | Liquidación Arroba | Registrar 25kg (2 arrobas). | El pago debe ser tarifa * 2. |
| 3.2 | Flujo Beneficio | Avanzar lote de Lavado a Secado. | El estado visual cambia de azul a naranja. |
| 3.3 | Cierre de Lote | Finalizar secado con peso final. | Se crea automáticamente registro de "Producción" en Bodega. |

---
**Elaborado por: Chop Code Solutions - QA Team**
