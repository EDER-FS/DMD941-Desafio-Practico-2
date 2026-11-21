USE [AdventureWorksDW2022];
GO
/* Vista de analisis consolidada, sin alterar tablas originales.
   Rentabilidad aproximada (margen bruto) = SalesAmount - TotalProductCost.
   No descuenta gastos indirectos, impuestos ni costos no registrados en estos campos.
   Fuente: FactInternetSales (Internet) + FactResellerSales (Reseller).
*/
CREATE OR ALTER VIEW dbo.vw_Desafio2Ventas AS
SELECT
    f.OrderDateKey,
    d.CalendarYear AS Anio,
    d.CalendarQuarter AS Trimestre,
    p.ProductKey,
    p.EnglishProductName AS Producto,
    ISNULL(sc.EnglishProductSubcategoryName, 'Sin subcategoria') AS Subcategoria,
    ISNULL(c.EnglishProductCategoryName, 'Sin categoria') AS Categoria,
    f.SalesTerritoryKey,
    ISNULL(st.SalesTerritoryCountry,'Sin pais') AS Pais,
    ISNULL(st.SalesTerritoryRegion,'Sin region') AS Territorio,
    CONVERT(varchar(12),'Internet') AS Canal,
    CAST(f.OrderQuantity AS bigint) AS Unidades,
    CAST(f.SalesAmount AS decimal(19,4)) AS Ventas,
    CAST(f.TotalProductCost AS decimal(19,4)) AS Costo,
    CAST(f.SalesAmount - f.TotalProductCost AS decimal(19,4)) AS MargenBruto
FROM dbo.FactInternetSales AS f
JOIN dbo.DimDate AS d ON f.OrderDateKey = d.DateKey
JOIN dbo.DimProduct AS p ON f.ProductKey = p.ProductKey
LEFT JOIN dbo.DimProductSubcategory AS sc ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
LEFT JOIN dbo.DimProductCategory AS c ON sc.ProductCategoryKey = c.ProductCategoryKey
LEFT JOIN dbo.DimSalesTerritory AS st ON f.SalesTerritoryKey = st.SalesTerritoryKey
UNION ALL
SELECT
    f.OrderDateKey,
    d.CalendarYear,
    d.CalendarQuarter,
    p.ProductKey,
    p.EnglishProductName,
    ISNULL(sc.EnglishProductSubcategoryName,'Sin subcategoria'),
    ISNULL(c.EnglishProductCategoryName,'Sin categoria'),
    f.SalesTerritoryKey,
    ISNULL(st.SalesTerritoryCountry,'Sin pais'),
    ISNULL(st.SalesTerritoryRegion,'Sin region'),
    CONVERT(varchar(12),'Reseller'),
    CAST(f.OrderQuantity AS bigint),
    CAST(f.SalesAmount AS decimal(19,4)),
    CAST(f.TotalProductCost AS decimal(19,4)),
    CAST(f.SalesAmount - f.TotalProductCost AS decimal(19,4))
FROM dbo.FactResellerSales AS f
JOIN dbo.DimDate AS d ON f.OrderDateKey = d.DateKey
JOIN dbo.DimProduct AS p ON f.ProductKey = p.ProductKey
LEFT JOIN dbo.DimProductSubcategory AS sc ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
LEFT JOIN dbo.DimProductCategory AS c ON sc.ProductCategoryKey = c.ProductCategoryKey
LEFT JOIN dbo.DimSalesTerritory AS st ON f.SalesTerritoryKey = st.SalesTerritoryKey;
GO
SELECT Canal, COUNT_BIG(*) AS Registros, SUM(Ventas) AS Ventas,
       SUM(MargenBruto) AS MargenBruto
FROM dbo.vw_Desafio2Ventas
GROUP BY Canal;
