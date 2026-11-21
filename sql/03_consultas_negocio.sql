USE [AdventureWorksDW2022];
GO
-- PREGUNTA 1: Categorias/subcategorias con mayor VOLUMEN de venta por ano y trimestre
-- Volumen aqui se mide en UNIDADES (OrderQuantity), no en ingresos.
SELECT Anio,Trimestre,Categoria,Subcategoria,
       SUM(Unidades) AS UnidadesVendidas,
       CAST(SUM(Ventas) AS decimal(19,2)) AS ImporteVentas
FROM dbo.vw_Desafio2Ventas
GROUP BY Anio,Trimestre,Categoria,Subcategoria
ORDER BY Anio,Trimestre,UnidadesVendidas DESC;
GO
-- PREGUNTA 2: Territorios con mayor rentabilidad y comparacion entre canales.
-- Margen bruto calculado como Ventas - Costo (sin otros gastos).
SELECT Pais,Territorio,
       CAST(SUM(CASE WHEN Canal='Internet' THEN Ventas ELSE 0 END) AS decimal(19,2)) AS VentasInternet,
       CAST(SUM(CASE WHEN Canal='Reseller' THEN Ventas ELSE 0 END) AS decimal(19,2)) AS VentasReseller,
       CAST(SUM(Ventas) AS decimal(19,2)) AS VentasTotales,
       CAST(SUM(MargenBruto) AS decimal(19,2)) AS MargenBrutoTotal,
       CAST(100.0 * SUM(MargenBruto) / NULLIF(SUM(Ventas),0) AS decimal(9,2)) AS PorcentajeMargenBruto
FROM dbo.vw_Desafio2Ventas
GROUP BY Pais,Territorio
ORDER BY MargenBrutoTotal DESC;
GO
-- PREGUNTA 3A: Top 10 productos mas rentables en TODO el periodo.
SELECT TOP (10) ProductKey,Producto,
       SUM(Unidades) AS UnidadesVendidas,
       CAST(SUM(Ventas) AS decimal(19,2)) AS VentasTotales,
       CAST(SUM(MargenBruto) AS decimal(19,2)) AS MargenBrutoTotal
FROM dbo.vw_Desafio2Ventas
GROUP BY ProductKey,Producto
ORDER BY MargenBrutoTotal DESC, ProductKey;
GO
-- PREGUNTA 3B: Evolucion anual y trimestral de esos mismos 10 productos.
WITH TopProductos AS
(
    SELECT TOP (10) ProductKey
    FROM dbo.vw_Desafio2Ventas
    GROUP BY ProductKey
    ORDER BY SUM(MargenBruto) DESC, ProductKey
)
SELECT v.Anio,v.Trimestre,v.ProductKey,v.Producto,
       SUM(v.Unidades) AS UnidadesVendidas,
       CAST(SUM(v.Ventas) AS decimal(19,2)) AS Ventas,
       CAST(SUM(v.MargenBruto) AS decimal(19,2)) AS MargenBruto
FROM dbo.vw_Desafio2Ventas AS v
JOIN TopProductos t ON t.ProductKey=v.ProductKey
GROUP BY v.Anio,v.Trimestre,v.ProductKey,v.Producto
ORDER BY v.Producto,v.Anio,v.Trimestre;
GO
