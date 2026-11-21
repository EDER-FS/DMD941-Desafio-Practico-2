# Desafío Práctico 2 — Datawarehouse y Minería de Datos (DMD 941)

**Proyecto:** `DMD941_Desafio2_CuboOLAP`  
**Caso de estudio:** AdventureWorksDW2022  
**Repositorio de destino:** https://github.com/EDER-FS/DMD941-Desafio-Practico-2  
**Estado del proyecto:** Implementado, procesado y validado funcionalmente en SQL Server Analysis Services 2022. El repositorio contiene la documentación académica, los scripts SQL, las evidencias, el proyecto multidimensional SSAS y el archivo original de Power BI.

## Resumen

Se restauró `AdventureWorksDW2022` en SQL Server 2022 Express y se construyó `dbo.vw_Desafio2Ventas` para consultas de negocio y un dashboard Power BI. Por separado, se implementó una solución OLAP multidimensional en **Analysis Services 2022**. El proyecto fue procesado correctamente y se comprobó la exploración de importes y cantidades por categoría y año.

| Elemento | Resultado documentado |
|---|---|
| Motor relacional | `LAPTOP-P4LPLMEJ\SQLEXPRESS` — `AdventureWorksDW2022` |
| SSAS | `LAPTOP-P4LPLMEJ\SSAS2022` |
| Cubo | `Cubo Ventas AdventureWorks` |
| Hechos | `FactInternetSales` y `FactResellerSales` |
| Dimensiones de base de datos | `Dim Productos`, `Dim Fecha`, `Dim Customer`, `Dim Reseller`, `Dim Sales Territory` |
| Medidas validadas | Importe y cantidad para Internet y Reseller (4 medidas) |
| Navegación | Productos por categoría y fecha de pedido (Año) |
| Estado del procesamiento | Implementación exitosa, 0 errores en la salida final |
| Power BI | 6 visualizaciones / 2 páginas; origen relacional `dbo.vw_Desafio2Ventas` |

## Contenido

- [`docs/Informe_DMD941_Desafio_2_Actualizado_OLAP.docx`](docs/Informe_DMD941_Desafio_2_Actualizado_OLAP.docx): informe académico editable con evidencias SQL, Power BI y SSAS.
- [`docs/Informe_DMD941_Desafio_2_Actualizado_OLAP.pdf`](docs/Informe_DMD941_Desafio_2_Actualizado_OLAP.pdf): versión de lectura y presentación.
- [`docs/04_configuracion_y_pruebas_ssas.md`](docs/04_configuracion_y_pruebas_ssas.md): arquitectura, solución de incidencias, pasos reproducibles y resultados.
- [`docs/05_consultas_mdx_referencia.mdx`](docs/05_consultas_mdx_referencia.mdx): consultas MDX propuestas para una ejecución manual adicional; **no constituyen evidencia de ejecución**.
- [`docs/06_checklist_publicacion.md`](docs/06_checklist_publicacion.md): verificación de entregables y publicación.
- `proyecto_ssas/`: contiene la solución nativa de Visual Studio y el proyecto multidimensional de SQL Server Analysis Services 2022, incluyendo dimensiones, cubo, particiones y definiciones del origen de datos.
- `powerbi/`: contiene el archivo original `Desafio2_AdventureWorks.pbix`, correspondiente al dashboard de análisis de ventas.
- `proyecto_ssas/`: espacio para copiar la **solución nativa de Visual Studio** desde la computadora de desarrollo.
- `powerbi/`: espacio para añadir el archivo nativo `.pbix` desde la computadora de desarrollo.

## Reproducir el escenario

1. Restaurar `AdventureWorksDW2022.bak` en la instancia SQL Server relacional; **no** añadir el `.bak` al repositorio.
2. Ejecutar los scripts de `sql/` en orden desde SSMS conectado al Motor de base de datos.
3. Abrir `proyecto_ssas/DMD941_Desafio2_CuboOLAP/DMD941_Desafio2_CuboOLAP.slnx` en Visual Studio con la extensión de proyectos de Analysis Services instalada.
4. Ajustar `Data Source` al nombre de la instancia SQL local y `Deployment` al servidor SSAS propio.
5. Verificar la cuenta de suplantación y los permisos de lectura a la base relacional; implementar y procesar.
6. Abrir el cubo en el Explorador, agregar `Sales Amount`, `Sales Amount - Fact Reseller Sales`, `Order Quantity` y `Order Quantity - Fact Reseller Sales` y cruzarlas por Categoría y Año.
7. Abrir `powerbi/Desafio2_AdventureWorks.pbix` en Power BI Desktop, configurar la conexión al origen SQL Server cuando sea necesario y comprobar las seis visualizaciones distribuidas en dos páginas.

## Alcance exacto de las pruebas

El Explorador de Visual Studio ejecutó consultas MDX y devolvió datos de ambos canales por categoría y año. **No se ha documentado ejecución manual** de scripts `.mdx` en SSMS ni conexión de Power BI al cubo. Tampoco se documentaron en el cubo medidas de costo, margen bruto o porcentaje de margen: estos indicadores pertenecen al análisis SQL/Power BI de la vista relacional. La comprobación cuantitativa completa OLAP-versus-SQL queda como validación adicional.

## Precauciones para GitHub

No subir respaldos `.bak`, claves, contraseñas, archivos de configuración con credenciales ni carpetas `bin/`, `obj/` o `.vs/`. Los nombres de servidores son locales y deberán adaptarse en otro equipo. El repositorio público debe contener los **archivos fuente** de SSAS y de Power BI para que el trabajo sea reproducible; las capturas no reemplazan esos archivos.

## Referencia de datos

[AdventureWorks — SQL Server Samples (Microsoft)](https://github.com/microsoft/sql-server-samples/releases/tag/adventureworks)
