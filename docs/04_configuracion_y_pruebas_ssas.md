# Implementación y pruebas de SSAS 2022

Fecha de comprobación: 20 de noviembre de 2026 (hora local de El Salvador).

## Arquitectura

- Base de origen `AdventureWorksDW2022` en `LAPTOP-P4LPLMEJ\SQLEXPRESS` (Motor de base de datos SQL Server 2022 Express).
- Base multidimensional `DMD941_Desafio2_CuboOLAP` en `LAPTOP-P4LPLMEJ\SSAS2022` (Analysis Services 2022).
- Proyecto de Visual Studio `DMD941_Desafio2_CuboOLAP`.
- Origen `Adventure Works DW2022.ds`; vista de origen `DSV_Ventas_AdventureWorksDW2022.dsv`.
- Cubo `Cubo Ventas AdventureWorks.cube`.

## Tablas y relaciones

FactInternetSales y FactResellerSales son las tablas de hechos. Se incorporaron DimProduct, DimProductSubcategory, DimProductCategory, DimDate, DimSalesTerritory, DimReseller, DimCustomer y DimGeography en la DSV, con sus relaciones de claves.

## Dimensiones

| Dimensión | Descripción |
|---|---|
| Dim Productos | `DimProduct` + subcategoría + categoría; jerarquía `Clasificación de Productos` (`Categoría > Subcategoría > Producto`) |
| Dim Fecha | `DimDate`; jerarquía `Calendario` (`Año > Trimestre > Mes > Fecha`) |
| Dim Customer | Dimensión creada por asistente; vinculada a cliente/geografía |
| Dim Reseller | Dimensión creada por asistente; vinculada a distribuidor/geografía |
| Dim Sales Territory | Dimensión comercial territorial creada por asistente |

La dimensión Fecha se configuró con `DateKey`, nombre `FullDateAlternateKey`, y claves compuestas `CalendarYear + CalendarQuarter` para el trimestre y `CalendarYear + MonthNumberOfYear` para el mes, ambas de `DimDate`. Se observaron relaciones `Fecha > Mes > Trimestre > Año`. Dentro del cubo se usaron también dimensiones de fecha por rol: Order Date, Due Date y Ship Date.

## Medidas verificadas

| Grupo de medidas | Medida | Comprobada |
|---|---|---|
| Fact Internet Sales | Sales Amount | Sí |
| Fact Internet Sales | Order Quantity | Sí |
| Fact Reseller Sales | Sales Amount - Fact Reseller Sales | Sí |
| Fact Reseller Sales | Order Quantity - Fact Reseller Sales | Sí |

## Historial de incidencias y resolución

1. La primera implementación falló por falta de autorización de la cuenta Windows para crear objetos en SSAS. En el entorno local se concedieron privilegios de administrador de Analysis Services a la cuenta de laboratorio.
2. Después, durante el procesamiento, se reportó `A connection could not be made to the data source` y errores OLE DB/ODBC.
3. En el diseñador de origen se verificó `Impersonation Information > Use the service account`.
4. En el motor SQL relacional `SQLEXPRESS` se creó/verificó el inicio de sesión `NT SERVICE\MSOLAP$SSAS2022` y se asignó exclusivamente el rol `db_datareader` sobre `AdventureWorksDW2022`.
5. La implementación final se completó satisfactoriamente y las dimensiones se procesaron. En el registro de Visual Studio se visualizó `Implementación: 1 correcta, 0 con errores`.

**Seguridad:** el rol administrativo SSAS es apropiado solo para laboratorio autorizado; en producción debe aplicarse mínimo privilegio. No publicar credenciales en el repositorio.

## Evidencias verificadas

- `OLAP_03_Implementacion_Exitosa.png`: mensaje de implementación correcta y procesamiento de dimensiones.
- `OLAP_04_Resultado_Medida_Internet.png`: medida Sales Amount recuperada.
- `OLAP_05_Ventas_Categoria_Anio.png`: ventas por Internet segmentadas por Categoría/Año.
- `OLAP_06_Comparacion_Cuatro_Medidas.png`: las cuatro medidas de los canales Internet/Reseller por Categoría/Año.

Se observan categorías `Bikes`, `Components`, `Clothing` y `Accessories`; algunos cruces muestran `(NULL)`, compatibles con combinaciones sin medidas disponibles. Las cifras truncadas visualmente no se utilizan aquí como importes exactos.

## Pendientes de reproducibilidad y alcance

- Copiar el proyecto nativo de Visual Studio desde la computadora del estudiante (solución `.sln`, proyecto `.dwproj`, fuentes `.ds`, `.dsv`, `.dim` y `.cube`).
- Copiar el archivo de Power BI `.pbix`; el dashboard actual se alimenta de una vista relacional, no del cubo SSAS.
- Las consultas del Explorador constituyen evidencia MDX generada por el diseñador. El archivo `05_consultas_mdx_referencia.mdx` es referencia de ejecución pendiente; no declarar que fue ejecutado manualmente.
- La conciliación matemática detallada SQL/MDX por período/categoría es una validación adicional no acreditada con las capturas disponibles.
