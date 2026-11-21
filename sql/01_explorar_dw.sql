-- Ajusta el nombre si restauraste la base con otro nombre.
USE [AdventureWorksDW2022];
GO
SELECT DB_NAME() AS BaseActual;
SELECT t.name AS Tabla, SUM(p.rows) AS FilasAproximadas
FROM sys.tables t
INNER JOIN sys.partitions p ON p.object_id=t.object_id AND p.index_id IN (0,1)
WHERE t.name IN ('FactInternetSales','FactResellerSales','DimProduct','DimDate',
                 'DimSalesTerritory','DimProductCategory','DimProductSubcategory')
GROUP BY t.name
ORDER BY t.name;

SELECT TOP (10) d.CalendarYear, d.CalendarQuarter, d.EnglishMonthName
FROM dbo.DimDate d
ORDER BY d.FullDateAlternateKey DESC;

-- Identificar las columnas utilizadas por los scripts:
SELECT TABLE_NAME,COLUMN_NAME,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('FactInternetSales','FactResellerSales','DimProduct','DimDate',
  'DimSalesTerritory','DimProductCategory','DimProductSubcategory')
AND COLUMN_NAME IN ('OrderDateKey','ProductKey','SalesTerritoryKey','OrderQuantity',
  'SalesAmount','TotalProductCost','CalendarYear','CalendarQuarter','EnglishProductName',
  'EnglishProductCategoryName','EnglishProductSubcategoryName','SalesTerritoryCountry',
  'SalesTerritoryRegion')
ORDER BY TABLE_NAME,ORDINAL_POSITION;
