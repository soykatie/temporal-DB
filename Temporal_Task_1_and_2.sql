--Задание выполнила студентка 2 курса, 2 группы: Уклейко Екатерина

--Пункт 1. Созадание БД и темпоральных таблиц

--создаем бд TemporalFinancialAnalysis
USE master;
DROP DATABASE IF EXISTS TemporalFinancialAnalysis;
CREATE DATABASE TemporalFinancialAnalysis;
USE TemporalFinancialAnalysis;

--создаем таблицу "Курс валют"
DROP TABLE IF EXISTS dbo.ExchangeRate;
CREATE TABLE dbo.ExchangeRate (
	UnitOfMeasurement NVARCHAR(50),
	Dollar FLOAT,
	Euro FLOAT,
	BYN FLOAT,
	StartDate DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	EndDate DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate),
  CONSTRAINT [PK_EXCHANGE_RATE] PRIMARY KEY CLUSTERED ([UnitOfMeasurement] ASC) 
  WITH (IGNORE_DUP_KEY = OFF)
)
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ExchangeRateHistory));

--создаем таблицу "Показатели"
DROP TABLE IF EXISTS dbo.Indicators;
CREATE TABLE dbo.Indicators (
	IndicatorCode INT,
	UnitOfMeasurement NVARCHAR(50)
	CONSTRAINT [Indicators_fk0] FOREIGN KEY ([UnitOfMeasurement]) REFERENCES [ExchangeRate]([UnitOfMeasurement]),
	IndicatorName NVARCHAR(100),
	Importance INT,
	StartDate DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	EndDate DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate),
  CONSTRAINT [PK_INDICATORS] PRIMARY KEY CLUSTERED ([IndicatorCode] ASC) 
  WITH (IGNORE_DUP_KEY = OFF)
)
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.IndicatorsHistory));

--создаем таблицу "Предприятия"
DROP TABLE IF EXISTS dbo.Companies;
CREATE TABLE dbo.Companies (
	CompanyCode INT,
	CompanyName NVARCHAR(150),
	BankRequisites NVARCHAR(150),
	Telephone INT,
	ContactPerson NVARCHAR(150),
	StartDate DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	EndDate DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate),
  CONSTRAINT [PK_COMPANIES] PRIMARY KEY CLUSTERED ([CompanyCode] ASC) 
  WITH (IGNORE_DUP_KEY = OFF)
)
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.CompaniesHistory));

--создаем таблицу "Динамика показателей"
DROP TABLE IF EXISTS dbo.DynamicsOfIndicators;
CREATE TABLE dbo.DynamicsOfIndicators (
	DynamicsID INT PRIMARY KEY,
	IndicatorCode INT 
	CONSTRAINT [DynamicsOfIndicators_fk0] FOREIGN KEY ([IndicatorCode]) REFERENCES [Indicators]([IndicatorCode]),
	CompanyCode INT
	CONSTRAINT [DynamicsOfIndicators_fk1] FOREIGN KEY ([CompanyCode]) REFERENCES [Companies]([CompanyCode]),
	Date date,
	Value FLOAT,
	StartDate DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	EndDate DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate)
)
WITH(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.DynamicsOfIndicatorsHistory));

--Пункт 2. Заполнение таблиц БД на 15.01.2022

--заполняем таблицу "Курс валют" на 15.01.2022
INSERT INTO ExchangeRate(UnitOfMeasurement, Dollar, Euro, BYN)
VALUES
('Доллар', 1, 0.8384, 2.4345), ('Евро', 1.0257, 1, 3.0007),('Белорусский рубль', 0.2528, 0.131, 1)

--посмотрим результаты для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--заполняем таблицу "Показатели" на 15.01.2022
INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(123457, 'Выручка', 8, 'Доллар'), 
(213455, 'Себестоимость продаж', 10, 'Евро'),
(213457, 'Расходы на оплату труда', 6, 'Белорусский рубль'),
(123456, 'Производительность труда', 10, 'Доллар'), 
(213456, 'Прибыль от продаж', 8, 'Евро'),
(903456, 'Текущий налог', 7, 'Белорусский рубль'),
(123455, 'Выручка', 8, 'Доллар'), 
(213454, 'Себестоимость продаж', 10, 'Евро'),
(213453, 'Расходы на оплату труда', 6, 'Белорусский рубль'),
(123452, 'Производительность труда', 10, 'Доллар'), 
(213451, 'Прибыль от продаж', 8, 'Евро'),
(213450, 'Текущий налог', 7, 'Белорусский рубль'),
(123458, 'Выручка', 8, 'Доллар')

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--заполняем таблицу "Предприятия" на 15.01.2022
INSERT INTO Companies(CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES
(95699, 'МАЗ', 40817810099910004312, 2345678, 'Тиманюк Татьяна Геннадьевна'),
(99998, 'БелДжи', 52817160067810004312, 4326578, 'Юркина Татьяна Ивановна'),
(99997, 'БелАз', 23098110099910003333, 3333333, 'Богданова Виктория Лукинична'),
(99996, 'Белшина', 33161560099910004312, 5678432, 'Мурог Тарас Андреевич'),
(88883, 'БелДжи', 23098110099910005555, 9991234, 'Свидерский Геннадий Брониславович'),
(12396, 'МТЗ', 33161560665810004312, 5678432, 'Зимина Алия Матвеевна'),
(56789, 'МАЗ', 40817810011110004312, 2345677, 'Полякова Мария Львовна'),
(67890, 'БАТЭ', 52817160056810004312, 4326571, 'Дубов Павел Богданович'),
(98753, 'БелАз', 23098110088810003333, 3333343, 'Ефимова Ева Филипповна'),
(45631, 'МТЗ', 33161560099910874312, 5678435, 'Плотников Виктор Дмитриевич'),
(46833, 'БелДжи', 23098110099660005555, 9991232, 'Гусев Иван Игоревич'),
(57338, 'Белшина', 33161560666910044310, 5671432, 'Левин Илья Никитич'),
(74284, 'МАЗ', 40817810099910004390, 2341678, 'Смирнов Егор Никитич')

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--заполняем таблицу "Динамика показателей" на 15.01.2022
INSERT INTO DynamicsOfIndicators(DynamicsID, IndicatorCode, CompanyCode, Date, Value)
VALUES
(1, 123457, 95699, '2021-07-25', 1.11), 
(2, 213455, 99998, '2022-05-11', -1.12),
(3, 213457, 99997, '2023-04-12', 2.13),
(4, 123456, 99996, '2020-03-13', -6), 
(5, 213456, 88883, '2020-02-14', 9),
(6, 903456, 12396, '2020-01-15', 3.45),
(7, 123455, 56789, '2021-12-16', 8.9), 
(8, 213454, 67890, '2021-11-17', 2.15),
(9, 213453, 98753, '2021-07-18', 7.88),
(10, 123452, 45631, '2021-07-19', 4.5), 
(11, 213451, 46833, '2023-06-26', 8.88),
(12, 213450, 57338, '2022-06-27', 5),
(13, 123458, 74284, '2022-12-28', 4)

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3. Осуществление имитации ежемесячного изменения таблиц БД за период с февраля по декабрь 2022

--Пункт 3.1. Февраль 2022. Изменим системную дату на 19.02.2022

--Добавим новые предприятия в таблицу Companies
INSERT INTO Companies (CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES (68490, 'БелДжи', 52817160067810089312, 1326578, 'Алешина София Матвеевна'),
(92145, 'БелАз', 23098110099910000033, 3633333, 'Сергеев Артём Лукич'),
(53853, 'МТЗ', 33161560099910004399, 5679432, 'Ковалев Фёдор Витальевич'),
(47348, 'БелДжи', 23098110099910021555, 8991234, 'Сергеева Анна Ильинична'),
(53472, 'МТЗ', 33161560666910004378, 5671432, 'Соколова Полина Алексеевна'),
(64372, 'МАЗ', 40817810099910004378, 2346678, 'Агафонов Иван Сергеевич')

--Добавим новые показатели в таблицу Indicators
INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(213466, 'Себестоимость продаж', 10, 'Евро'),
(213477, 'Расходы на оплату труда', 6, 'Белорусский рубль'),
(123488, 'Производительность труда', 8, 'Доллар'), 
(993455, 'Прибыль от продаж', 10, 'Евро'),
(223457, 'Текущий налог', 6, 'Белорусский рубль'),
(763457, 'Выручка', 8, 'Доллар')

--Изменим курс валют в таблице ExchangeRate
UPDATE ExchangeRate
SET Dollar = 2.2345, EURO = 3.1000
GO

--Изменим динамику показателей в таблице DynamicsOfIndicators
UPDATE DynamicsOfIndicators
SET Date = '2022-02-19', Value = -0.06
WHERE DynamicsID = 2
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-02-19', Value = -10.00
WHERE DynamicsID = 4
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-02-19', Value = 12.98
WHERE DynamicsID = 5
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-02-19', Value = 8.8
WHERE DynamicsID = 7
GO

--Удалим некоторые показатели из таблицы Indicators и соответствующие ключу данные в таблице DynamicsOfIndicators
DELETE FROM dbo.DynamicsOfIndicators
WHERE IndicatorCode = 123457

DELETE FROM dbo.Indicators
WHERE IndicatorCode = 123457

DELETE FROM dbo.DynamicsOfIndicators
WHERE IndicatorCode = 903456

DELETE FROM dbo.Indicators
WHERE IndicatorCode = 903456

--посмотрим результаты для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3.2. Март 2022. Изменим системную дату на 14.03.2022

--Удалим некоторые предприятия из таблицы Companies и соответствующие ключу данные в таблице DynamicsOfIndicators
DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 56789

DELETE FROM dbo.Companies
WHERE CompanyCode = 56789

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 98753

DELETE FROM dbo.Companies
WHERE CompanyCode = 98753

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 74284

DELETE FROM dbo.Companies
WHERE CompanyCode = 74284

--Изменим некоторые показатели в таблице Indicators
UPDATE Indicators
SET UnitOfMeasurement = 'Белорусский рубль'
WHERE IndicatorCode = 993455
GO

UPDATE Indicators
SET IndicatorName = 'Выручка', Importance = 8
WHERE IndicatorCode = 123456
GO

--Изменим курс валют в таблице ExchangeRate на 14.03.2022
UPDATE ExchangeRate
SET Dollar = 2.3000, EURO = 2.9990
GO

--Изменим курс валют в таблице ExchangeRate на 21.03.2022
UPDATE ExchangeRate
SET Dollar = 2.3132, EURO = 3.0100
GO

--Изменим курс валют в таблице ExchangeRate на 28.03.2022
UPDATE ExchangeRate
SET Dollar = 2.2111, EURO = 3.0111
GO

--Добавим новые показатели в таблицу Companies
INSERT INTO Companies(CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES
(75933, 'МТЗ', 33161560099910004311, 5678232, 'Дроздов Руслан Александрович'),
(23712, 'БАТЭ', 23098110099910001555, 9191234, 'Архипова Мария Макаровна'),
(57832, 'БАТЭ', 33161560666910004311, 5678752, 'Фролова Мария Максимовна'),
(17141, 'БелДжи', 11111110099910021555, 1111234, 'Жуков Максим Даниилович'),
(23222, 'МТЗ', 33333360666910004378, 5671999, 'Сизов Михаил Борисович')

--посмотрим результаты для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3.3. Апрель 2022. Изменим системную дату на 16.04.2022

--Изменим курс валют в таблице ExchangeRate на 16.04.2022
UPDATE ExchangeRate
SET Dollar = 2.4500, EURO = 3.2000
GO

--Изменим данные в таблице DynamicsOfIndicators
UPDATE DynamicsOfIndicators
SET Date = '2022-04-16', Value = 10.99
WHERE DynamicsID = 4
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-04-16', Value = 3.45
WHERE DynamicsID = 5
GO

--Изменим данные в таблице Indicators
UPDATE Indicators
SET UnitOfMeasurement = 'Доллар'
WHERE IndicatorCode = 213456
GO

UPDATE Indicators
SET Importance = 10
WHERE IndicatorCode = 213451
GO

--Добавим данные в таблицу DynamicsOfIndicators
INSERT INTO DynamicsOfIndicators(DynamicsID, IndicatorCode, CompanyCode, Date, Value)
VALUES
(9, 123452, 12396, '2021-07-19', 4.5), 
(16, 213451, 17141, '2021-01-26', 8.88),
(17, 213450, 46833, '2021-06-27', 5),
(18, 123458, 47348, '2021-12-28', 4), 
(13, 213466, 53472, '2021-12-01', -6),
(14, 213477, 64372, '2021-10-02', -2),
(15, 123488, 67890, '2021-09-03', -10)

--Удалим и добавим новые данные таблицы Companies
DELETE FROM dbo.Companies
WHERE CompanyCode = 92145

DELETE FROM dbo.Companies
WHERE CompanyCode = 75933

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 67890

DELETE FROM dbo.Companies
WHERE CompanyCode = 67890

INSERT INTO Companies(CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES
(77777, 'МАЗ', 40817812199910004390, 2341678, 'Смирнов Егор Никитич'),
(94337, 'БАТЭ', 40817777799910004378, 2222228, 'Никольский Роман Глебович'),
(78786, 'БелДжи', 52817166667810056312, 7777578, 'Логинова Ясмина Степановна'),
(65453, 'Белшина', 23098222299910001555, 9991234, 'Дементьева Варвара Николаевна'),
(34792, 'Белшина', 52817160067810056312, 4326578, 'Колесникова Диана Алексеевна')


--посмотрим результаты для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3.4. Май 2022. Изменим системную дату на 15.05.2022

--Изменим курс валют в таблице ExchangeRate на 15.05.2022
UPDATE ExchangeRate
SET Dollar = 2.5111, EURO = 3.0007
GO

--Изменим данные в таблице DynamicsOfIndicators
UPDATE DynamicsOfIndicators
SET Date = '2022-05-15', Value = 6.77
WHERE DynamicsID = 17
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-05-15', Value = -3.41
WHERE DynamicsID = 18
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-05-15', Value = 2.00
WHERE DynamicsID = 14
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-05-15', Value = 3.00
WHERE DynamicsID = 13
GO

--Удалим некоторые данные из таблиц DynamicsOfIndicators и Companies
DELETE FROM dbo.DynamicsOfIndicators
WHERE DynamicsID = 10

DELETE FROM dbo.DynamicsOfIndicators
WHERE DynamicsID = 5

DELETE FROM dbo.DynamicsOfIndicators
WHERE DynamicsID = 3

DELETE FROM dbo.Companies
WHERE CompanyName = 'БАТЭ'

--Добавим данные в таблицу Indicators
INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(898989, 'Расходы на оплату труда', 6, 'Белорусский рубль'),
(900000, 'Производительность труда', 10, 'Доллар'), 
(113415, 'Прибыль от продаж', 8, 'Евро'),
(210450, 'Текущий налог', 7, 'Белорусский рубль'),
(103419, 'Выручка', 8, 'Доллар'), 
(991455, 'Себестоимость продаж', 10, 'Евро'),
(128456, 'Расходы на оплату труда', 6, 'Белорусский рубль'),
(120000, 'Производительность труда', 10, 'Доллар')

--посмотрим результаты для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3.5. Июнь 2022. Изменим системную дату на 19.06.2022

--Изменим данные таблицы DynamicsOfIndicators
UPDATE DynamicsOfIndicators
SET Date = '2022-06-19'
WHERE DynamicsID = 12
GO

UPDATE DynamicsOfIndicators
SET Value = 4.9
WHERE DynamicsID = 16
GO

--Удалим данные из таблиц DynamicsOfIndicators, Indicators, Companies
DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 64372

DELETE FROM dbo.Companies
WHERE ContactPerson = 'Агафонов Иван Сергеевич'

DELETE FROM dbo.Companies
WHERE CompanyCode = 77777

DELETE FROM dbo.Companies
WHERE CompanyCode = 78786

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 17141

DELETE FROM dbo.DynamicsOfIndicators
WHERE IndicatorCode = 900000

DELETE FROM dbo.Companies
WHERE CompanyCode = 17141

DELETE FROM dbo.Indicators
WHERE IndicatorCode = 900000

--Добавим данные в таблицу DynamicOfIndicators и Indicators
INSERT INTO DynamicsOfIndicators(DynamicsID, IndicatorCode, CompanyCode, Date, Value)
VALUES
(16, 103419, 46833, '2021-10-21', 10)

INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(211450, 'Текущий налог', 7, 'Белорусский рубль'),
(103519, 'Выручка', 8, 'Доллар')

--посмотрим результаты для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3.6. Июль 2022. Изменим системную дату на 11.07.2022

--Добавим новые предприятия в таблицу Companies
INSERT INTO Companies (CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES (68891, 'БелДжи', 52999160067810089312, 2126578, 'Алешина София Матвеевна'),
(10011, 'БелАз', 23098110000000000033, 3683292, 'Сергеев Артём Лукич'),
(10019, 'МТЗ', 13361560099910004399, 5689432, 'Ковалев Фёдор Витальевич'),
(10020, 'БелДжи', 32098110099910021010, 8101234, 'Сергеева Анна Ильинична'),
(10219, 'МТЗ', 33161560666910004783, 5671400, 'Соколова Полина Алексеевна'),
(90010, 'МАЗ', 40817810099910043078, 2349978, 'Агафонов Иван Сергеевич')

--Добавим новые показатели в таблицу Indicators
INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(124366, 'Себестоимость продаж', 10, 'Евро'),
(124377, 'Расходы на оплату труда', 6, 'Белорусский рубль'),
(124388, 'Производительность труда', 8, 'Доллар'), 
(994355, 'Прибыль от продаж', 10, 'Евро'),
(224357, 'Текущий налог', 6, 'Белорусский рубль'),
(764357, 'Выручка', 8, 'Доллар')

--Изменим курс валют в таблице ExchangeRate
UPDATE ExchangeRate
SET Dollar = 2.2345, EURO = 3.1000
GO

--Изменим динамику показателей в таблице DynamicsOfIndicators
UPDATE DynamicsOfIndicators
SET Date = '2022-02-19', Value = -0.06
WHERE DynamicsID = 2
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-02-19', Value = -10.00
WHERE DynamicsID = 4
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-02-19', Value = 12.98
WHERE DynamicsID = 21
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-02-19', Value = 8.8
WHERE DynamicsID = 16
GO

--Удалим некоторые показатели из таблицы Indicators и соответствующие ключу данные в таблице DynamicsOfIndicators
DELETE FROM dbo.DynamicsOfIndicators
WHERE IndicatorCode = 898989

DELETE FROM dbo.Indicators
WHERE IndicatorCode = 898989

DELETE FROM dbo.DynamicsOfIndicators
WHERE IndicatorCode = 113415

DELETE FROM dbo.Indicators
WHERE IndicatorCode = 113415

--посмотрим результаты для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3.7. Август 2022. Изменим системную дату на 10.08.2022

--Удалим некоторые предприятия из таблицы Companies и соответствующие ключу данные в таблице DynamicsOfIndicators
DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 99996

DELETE FROM dbo.Companies
WHERE CompanyCode = 99996

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 46833

DELETE FROM dbo.Companies
WHERE CompanyCode = 46833

--Изменим некоторые показатели в таблице Indicators
UPDATE Indicators
SET UnitOfMeasurement = 'Белорусский рубль'
WHERE IndicatorCode = 993455
GO

UPDATE Indicators
SET IndicatorName = 'Выручка', Importance = 8
WHERE IndicatorCode = 123456
GO

--Изменим курс валют в таблице ExchangeRate на 10.08.2022
UPDATE ExchangeRate
SET Dollar = 2.3000, EURO = 2.9990
GO

--Добавим новые показатели в таблицу Companies
INSERT INTO Companies(CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES
(75033, 'МТЗ', 33001560099910004311, 5678230, 'Дроздов Руслан Александрович'),
(23012, 'БАТЭ', 23098110090910001555, 9191230, 'Архипова Мария Макаровна'),
(57032, 'БАТЭ', 33161560660910004311, 5678750, 'Фролова Мария Максимовна'),
(17041, 'БелДжи', 11100110099910021555, 1110234, 'Жуков Максим Даниилович'),
(23002, 'МТЗ', 33333360606910004378, 5071999, 'Сизов Михаил Борисович')

--посмотрим результаты за февраль для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3.8. Сентябрь 2022. Изменим системную дату на 19.09.2022

--Изменим курс валют в таблице ExchangeRate на 19.09.2022
UPDATE ExchangeRate
SET Dollar = 3.0000, EURO = 2.9000
GO

--Изменим данные в таблице DynamicsOfIndicators
UPDATE DynamicsOfIndicators
SET Date = '2022-09-19', Value = 10.88
WHERE DynamicsID = 18
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-09-19', Value = -3.45
WHERE DynamicsID = 13
GO

--Изменим данные в таблице Indicators
UPDATE Indicators
SET UnitOfMeasurement = 'Евро'
WHERE IndicatorCode = 213456
GO

UPDATE Indicators
SET Importance = 6
WHERE IndicatorCode = 213451
GO

--Добавим данные в таблицу DynamicsOfIndicators
INSERT INTO DynamicsOfIndicators(DynamicsID, IndicatorCode, CompanyCode, Date, Value)
VALUES
(40, 211450, 75033, '2022-07-19', 5.5), 
(41, 213450, 47348, '2022-01-26', 9.88),
(42, 219955, 57032, '2022-06-27', -5),
(43, 223457, 88883, '2021-12-28', 13), 
(50, 991455, 99997, '2022-12-01', 16),
(51, 764357, 23002, '2022-10-02', 18),
(53, 211450, 68891, '2021-09-03', 9)

--посмотрим результаты за февраль для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3.9. Октябрь 2022. Изменим системную дату на 19.10.2022

--Удалим некоторые предприятия из таблицы Companies и соответствующие ключу данные в таблице DynamicsOfIndicators
DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 99998

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 57032

DELETE FROM dbo.Companies
WHERE CompanyCode = 57032

--Изменим некоторые показатели в таблице Indicators
UPDATE Indicators
SET UnitOfMeasurement = 'Белорусский рубль'
WHERE IndicatorCode = 120000
GO

UPDATE Indicators
SET UnitOfMeasurement = 'Белорусский рубль'
WHERE IndicatorCode = 123488
GO

--Изменим курс валют в таблице ExchangeRate на 19.10.2022
UPDATE ExchangeRate
SET Dollar = 2.6666, EURO = 3.2222
GO

--Добавим новые показатели в таблицу DynamicOfIndicators
INSERT INTO DynamicsOfIndicators(DynamicsID, IndicatorCode, CompanyCode, Date, Value)
VALUES
(101, 128456, 10020, '2022-10-02', -2),
(103, 213453, 17041, '2021-09-04', 7),
(104, 213451, 23002, '2021-01-05', 9),
(105, 994355, 23222, '2020-02-06', 2.66), 
(223, 764357, 75033, '2023-04-12', 2.1),
(189, 991455, 99998, '2023-06-13', -8.09)

--посмотрим результаты для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3.10. Ноябрь 2022. Изменим системную дату на 18.11.2022

UPDATE dbo.ExchangeRate
SET Dollar = 2.9102
GO

UPDATE dbo.Companies
SET CompanyName = 'БАТЭ'
WHERE CompanyName = 'МТЗ'
GO

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 57338

DELETE FROM dbo.Companies
WHERE CompanyName = 'Белшина'

INSERT INTO Companies(CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES
(75003, 'Белшина', 33001560099910004311, 5678230, 'Дроздов Руслан Александрович'),
(20002, 'Белшина', 23098110090910001555, 9191230, 'Архипова Мария Макаровна'),
(57002, 'Белшина', 33161560660910004311, 5678750, 'Фролова Мария Максимовна'),
(17001, 'Белшина', 11100110099910021555, 1110234, 'Жуков Максим Даниилович'),
(20012, 'Белшина', 33333360606910004378, 5071999, 'Сизов Михаил Борисович')

--посмотрим результаты для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--Пункт 3.11. Декабрь 2022. Изменим системную дату на 25.12.2022

UPDATE dbo.ExchangeRate
SET Dollar = 2.7895, Euro = 3.0000
GO

UPDATE dbo.Companies
SET CompanyName = 'МТЗ'
WHERE CompanyName = 'БАТЭ'
GO

DELETE FROM dbo.Companies
WHERE CompanyCode = 90010

DELETE FROM dbo.Companies
WHERE CompanyCode = 17001

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 88883

DELETE FROM dbo.Companies
WHERE CompanyCode = 88883

INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(124300, 'Себестоимость продаж', 10, 'Евро'),
(124007, 'Расходы на оплату труда', 6, 'Белорусский рубль'),
(124008, 'Производительность труда', 8, 'Доллар'), 
(994005, 'Прибыль от продаж', 10, 'Евро'),
(224007, 'Текущий налог', 6, 'Белорусский рубль'),
(764007, 'Выручка', 8, 'Доллар')

--посмотрим результаты для таблицы ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--посмотрим результаты для таблицы Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--посмотрим результаты для таблицы Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--посмотрим результаты для таблицы DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory