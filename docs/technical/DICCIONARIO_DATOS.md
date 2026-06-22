# 📖 Diccionario de Datos - AgroGo v0.2.5

Este documento detalla la estructura del esquema NoSQL en Isar Database, especificando las colecciones y sus atributos clave.

---

## 🏗️ Colección 1: `LoteIsarModel` (Linderos)
Almacena la zonificación geográfica de la finca.

| Campo (Isar) | Tipo | Descripción |
|:---|:---|:---|
| `id` | Id | Autoincremento local. |
| `fincaId` | int | ID de la finca propietaria (Aislamiento). |
| `nombre` | String | Nombre del lote (ej: El Cafetal). |
| `uso` | Enum | `agricola`, `pecuario`, `forestal`, `infraestructura`. |
| `coordenadas` | List<Coord> | Lista de puntos lat/lng para el polígono. |
| `areaEnHectareas` | double | Área calculada mediante Motor GIS. |
| `numeroMatas` | int | Censo de plantas para la calculadora de abono. |

---

## 👥 Colección 2: `TrabajadorIsarModel` (Nómina)
Perfiles del equipo humano de la finca.

| Campo (Isar) | Tipo | Descripción |
|:---|:---|:---|
| `id` | Id | Autoincremento. |
| `nombreCompleto` | String | Identificación del trabajador. |
| `tipoTrabajador` | String | `Recolector` o `Jornalero`. |
| `tarifaBase` | double | Valor por Kilo o por Día en COP. |

---

## 📦 Colección 3: `InsumoIsarModel` (Bodega)
Control de existencias e inventario triple.

| Campo (Isar) | Tipo | Descripción |
|:---|:---|:---|
| `nombre` | String | Nombre del producto (ej: Urea, Gasolina). |
| `categoria` | Enum | `operativo`, `maquinaria`, `cosecha`. |
| `cantidadActual` | double | Stock disponible en tiempo real. |
| `umbralMinimo` | double | Punto de re-orden para alerta en Dashboard. |

---

## ☕ Colección 4: `BeneficioIsarModel` (Transformación)
Trazabilidad del proceso del café.

| Campo (Isar) | Tipo | Descripción |
|:---|:---|:---|
| `kilosCereza` | double | Peso inicial de recolección. |
| `estado` | Enum | `cereza`, `lavado`, `secado`, `listo`, `vendido`. |
| `kilosFinales` | double | Peso seco final para venta. |

---

## 💰 Colección 5: `ItemCostoIsarModel` (Finanzas)
Asientos contables de gastos e inversiones.

| Campo (Isar) | Tipo | Descripción |
|:---|:---|:---|
| `nombreItem` | String | Descripción del gasto. |
| `precioTotal` | double | Valor monetario en COP. |
| `loteId` | int? | Lote asociado para cálculo de rentabilidad por área. |

---
**Chop Code Solutions - Data Architecture 2026**
