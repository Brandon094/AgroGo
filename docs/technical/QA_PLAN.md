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
| 1.6 | Superposición | Intentar dibujar o mover un lote sobre otro ya existente. | El polígono se pone rojo, sale aviso de traslape y bloquea el botón 'ÁREA OCUPADA'. |
| 1.7 | Categorías Ambientales | Crear un 'Bosque' o 'Jardín'. | El formulario debe ser minimalista y el color en mapa debe ser Verde Bosque o Salmón. |
| 1.8 | Infraestructura Turística | Crear una 'Piscina' o 'Mirador'. | El pin debe ser Azul Claro y el formulario debe omitir datos agrícolas. |

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
| 3.5 | Lógica de Cultivo | Seleccionar 'Cacao' en el formulario. | Debe aparecer el switch de 'Sombra' y sugerir abono cada 6 meses. |

---

## 🟠 Fase 4: Bodega y Valoración
| ID | Caso de Prueba | Acción | Resultado Esperado |
|:---|:---|:---|:---|
| 4.1 | Valoración de Ítem | Registrar ítem con cantidad 10 y valor unitario 5000. | El valor total debe ser 50000 y mostrarse en la tarjeta. |
| 4.2 | Capital en Dashboard | Sumar varios ítems con valor en bodega. | El Dashboard debe mostrar el total exacto en "Capital Bodega". |
| 4.3 | Ajuste de Valor | Ajustar stock (+5) de un ítem valorado. | El valor total debe recalcularse automáticamente (15 * 5000 = 75000). |

---

## 🟣 Fase 5: Trazabilidad y Rentabilidad Pecuaria
| ID | Caso de Prueba | Acción | Resultado Esperado |
|:---|:---|:---|:---|
| 5.1 | Costo Acumulado | Registrar consumo de alimento para un grupo. | El 'Costo Total' en el detalle debe subir (Inversión + Alimento). |
| 5.2 | Sanidad con Insumo | Registrar vacuna descontando de bodega. | El stock baja, se crea el gasto y aumenta el costo acumulado del animal. |
| 5.3 | Cierre por Venta | Cerrar ciclo con 'Venta en Pie'. | El grupo pasa a la pestaña 'HISTORIAL' y muestra utilidad neta positiva/negativa. |
| 5.4 | Cierre por Beneficio | Cerrar ciclo con 'Sacrificio'. | Solicita kilos de carne y registra el ingreso total generado. |
| 5.5 | Balance Finca | Observar Dashboard tras una venta. | La métrica de 'Balance Finca' debe reflejar Ingresos - Gastos correctamente. |
| 5.6 | Pestañas Pecuarias | Cambiar entre 'ACTIVOS' e 'HISTORIAL'. | Se filtran correctamente los animales según su estado `estaActivo`. |

---
**Elaborado por: Chop Code Solutions - QA Team**
