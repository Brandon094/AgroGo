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

---

## 🟢 Fase 1: Mapeo GIS y Geovalla
| ID | Caso de Prueba | Acción | Resultado Esperado |
|:---|:---|:---|:---|
| 1.1 | Perímetro Maestro | Dibujar el borde total de la finca. | Se guarda como tipo `perimetro` y sirve de contención. |
| 1.2 | Geovalla Estricta | Intentar poner un punto fuera del perímetro. | El sistema bloquea el punto y muestra aviso rojo. |
| 1.3 | Pines Arrastrables | Mover un vértice dentro del perímetro. | El área se recalcula automáticamente en vivo. |
| 1.4 | Filtro Precisión | Capturar punto GPS con error > 5m. | El sistema debe mostrar advertencia y bloquear punto. |
| 1.5 | Borrado en Cascada | Eliminar el Perímetro Maestro. | El sistema debe advertir en rojo y borrar todos los lotes internos. |

---

## 🔵 Fase 2: Onboarding y Flujo Lógico
| ID | Caso de Prueba | Acción | Resultado Esperado |
|:---|:---|:---|:---|
| 2.1 | Vocación Dinámica | Elegir "NO TENGO" animales. | Los pasos de infraestructura pecuaria se ocultan. |
| 2.2 | Validación Pecuaria | Intentar crear un cerdo sin cochera previa. | El panel muestra aviso de "Misión Pendiente". |
| 2.3 | Atajo Post-Mapeo | Guardar un corral en el mapa. | Dispara diálogo: "¿Desea ingresar animales ahora?". |
| 2.4 | Auto-Ubicación | Presionar botón GPS en registro finca. | Detecta automáticamente Vereda/Municipio. |

---

## 🟡 Fase 3: Dashboard Bento y Navegación
| ID | Caso de Prueba | Acción | Resultado Esperado |
|:---|:---|:---|:---|
| 3.1 | Grupos Métricas | Observar el tablero principal. | Las métricas están agrupadas por Patrimonio, Café y Recursos. |
| 3.2 | Pestañas de Zonas | Entrar a "Mis Zonas". | Se ven dos pestañas claras: CULTIVOS y ESTRUCTURAS. |
| 3.3 | Bloqueo de Lotes | Intentar entrar a "Zonificar" sin perímetro. | Lanza SnackBar de aviso y botón para crear perímetro. |
| 3.4 | Feedback Mapeo | Alcanzar 3 puntos en el dibujo. | El contador cambia por un check verde de validación. |

---
**Elaborado por: Chop Code Solutions - QA Team**
