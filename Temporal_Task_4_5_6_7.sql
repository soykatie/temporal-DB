--Задание выполнила студентка 2 курса, 2 группы: Уклейко Екатерина

--Пункт 4. Вывести состояние всех таблиц базы данных по состоянию на последний день каждого квартала 2022 года в 23:59:59.9999999

--1 квартал. Состояние на 31.03.2022

--Таблица "Курс валют"
SELECT '31 марта 2022 года' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999'

--Таблица "Показатели"
SELECT '31 марта 2022 года' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate 
FROM dbo.Indicators
FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999'

--Таблица "Предприятия"
SELECT '31 марта 2022 года' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999'

--Таблица "Динамика показателей"
SELECT '31 марта 2022 года' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999'

--2 квартал. Состояние на 30.06.2022

--Таблица "Курс валют"
SELECT '30 июня 2022 года' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999'

--Таблица "Показатели"
SELECT '30 июня 2022 года' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate 
FROM dbo.Indicators
FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999'

--Таблица "Предприятия"
SELECT '30 июня 2022 года' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999'

--Таблица "Динамика показателей"
SELECT '30 июня 2022 года' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999'

--3 квартал. Состояние на 30.09.2022

--Таблица "Курс валют"
SELECT '30 сентября 2022 года' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999'

--Таблица "Показатели"
SELECT '30 сентября 2022 года' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate 
FROM dbo.Indicators
FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999'

--Таблица "Предприятия"
SELECT '30 сентября 2022 года' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999'

--Таблица "Динамика показателей"
SELECT '30 сентября 2022 года' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999'

--4 квартал. Состояние на 31.12.2022

--Таблица "Курс валют"
SELECT '31 декабря 2022 года' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999'

--Таблица "Показатели"
SELECT '31 декабря 2022 года' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate 
FROM dbo.Indicators
FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999'

--Таблица "Предприятия"
SELECT '31 декабря 2022 года' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999'

--Таблица "Динамика показателей"
SELECT '31 декабря 2022 года' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999'

--Пункт 5. Вывести состояние всех таблиц базы данных за лето 2022 года.

--Таблица "Курс валют"
SELECT 'лето 2022' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'

--Таблица "Показатели"
SELECT 'лето 2022' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate 
FROM dbo.Indicators
FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'

--Таблица "Предприятия"
SELECT 'лето 2022' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'

--Таблица "Динамика показателей"
SELECT 'лето 2022' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'

--Пункт 6. Вывести строки, которые были вставлены и удалены за третий квартал 2022 года.

--3 квартал: с 01.07.2022 по 30.09.2022

--Таблица "Курс валют"
SELECT 'Вставлены и удалены за 3-ий квартал 2022' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME CONTAINED IN ('2022-07-01', '2022-09-30 23:59:59.9999999')

--Таблица "Показатели"
SELECT 'Вставлены и удалены за 3-ий квартал 2022' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators
FOR SYSTEM_TIME CONTAINED IN ('2022-07-01', '2022-09-30 23:59:59.9999999')

--Таблица "Предприятия"
SELECT 'Вставлены и удалены за 3-ий квартал 2022' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME CONTAINED IN ('2022-07-01', '2022-09-30 23:59:59.9999999')

--Таблица "Динамика показателей"
SELECT 'Вставлены и удалены за 3-ий квартал 2022' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME CONTAINED IN ('2022-07-01', '2022-09-30 23:59:59.9999999')

--Пункт 7. Создать любой запрос с несколькими темпоральными таблицами, используя JOIN.

--Запрос "Показателей" и их "Динамики"
CREATE VIEW [dbo].[TemporalFinancialAnalysis1]
AS
SELECT [Indicators].IndicatorCode, [Indicators].IndicatorName, [Indicators].Importance, [DynamicsOfIndicators].DynamicsID, [DynamicsOfIndicators].CompanyCode
FROM dbo.Indicators
JOIN
dbo.DynamicsOfIndicators
ON Indicators.IndicatorCode = DynamicsOfIndicators.IndicatorCode
GO

SELECT * FROM [TemporalFinancialAnalysis1]
FOR SYSTEM_TIME AS OF'2022-10-01 T10:00:00.7230011';

--Запрос "Показателей" относительно "Курса валют"
CREATE VIEW [dbo].[TemporalFinancialAnalysis2]
AS
SELECT [Indicators].IndicatorCode, [Indicators].IndicatorName,  [ExchangeRate].UnitOfMeasurement, [ExchangeRate].BYN
FROM dbo.Indicators
LEFT JOIN
dbo.ExchangeRate
ON Indicators.UnitOfMeasurement = ExchangeRate.UnitOfMeasurement
GO

DECLARE @LocalTime DATETIMEOFFSET = '2022-05-05 12:00:00.7230011 -07:00';
SELECT * FROM [TemporalFinancialAnalysis2]
FOR SYSTEM_TIME AS OF @LocalTime ;

SELECT *, CONVERT(DATETIME2(0), '2022-05-05T07:00:00', 126)
AT TIME ZONE 'Central European Standard Time'  AS [Time Zone]
FROM [TemporalFinancialAnalysis2]