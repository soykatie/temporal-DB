--������� ��������� ��������� 2 �����, 2 ������: ������� ���������

--����� 1. ��������� �� � ������������ ������

--������� �� TemporalFinancialAnalysis
USE master;
DROP DATABASE IF EXISTS TemporalFinancialAnalysis;
CREATE DATABASE TemporalFinancialAnalysis;
USE TemporalFinancialAnalysis;

--������� ������� "���� �����"
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

--������� ������� "����������"
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

--������� ������� "�����������"
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

--������� ������� "�������� �����������"
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

--����� 2. ���������� ������ �� �� 15.01.2022

--��������� ������� "���� �����" �� 15.01.2022
INSERT INTO ExchangeRate(UnitOfMeasurement, Dollar, Euro, BYN)
VALUES
('������', 1, 0.8384, 2.4345), ('����', 1.0257, 1, 3.0007),('����������� �����', 0.2528, 0.131, 1)

--��������� ���������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ������� "����������" �� 15.01.2022
INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(123457, '�������', 8, '������'), 
(213455, '������������� ������', 10, '����'),
(213457, '������� �� ������ �����', 6, '����������� �����'),
(123456, '������������������ �����', 10, '������'), 
(213456, '������� �� ������', 8, '����'),
(903456, '������� �����', 7, '����������� �����'),
(123455, '�������', 8, '������'), 
(213454, '������������� ������', 10, '����'),
(213453, '������� �� ������ �����', 6, '����������� �����'),
(123452, '������������������ �����', 10, '������'), 
(213451, '������� �� ������', 8, '����'),
(213450, '������� �����', 7, '����������� �����'),
(123458, '�������', 8, '������')

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ������� "�����������" �� 15.01.2022
INSERT INTO Companies(CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES
(95699, '���', 40817810099910004312, 2345678, '������� ������� �����������'),
(99998, '������', 52817160067810004312, 4326578, '������ ������� ��������'),
(99997, '�����', 23098110099910003333, 3333333, '��������� �������� ���������'),
(99996, '�������', 33161560099910004312, 5678432, '����� ����� ���������'),
(88883, '������', 23098110099910005555, 9991234, '���������� �������� �������������'),
(12396, '���', 33161560665810004312, 5678432, '������ ���� ���������'),
(56789, '���', 40817810011110004312, 2345677, '�������� ����� �������'),
(67890, '����', 52817160056810004312, 4326571, '����� ����� ����������'),
(98753, '�����', 23098110088810003333, 3333343, '������� ��� ����������'),
(45631, '���', 33161560099910874312, 5678435, '��������� ������ ����������'),
(46833, '������', 23098110099660005555, 9991232, '����� ���� ��������'),
(57338, '�������', 33161560666910044310, 5671432, '����� ���� �������'),
(74284, '���', 40817810099910004390, 2341678, '������� ���� �������')

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ������� "�������� �����������" �� 15.01.2022
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

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3. ������������� �������� ������������ ��������� ������ �� �� ������ � ������� �� ������� 2022

--����� 3.1. ������� 2022. ������� ��������� ���� �� 19.02.2022

--������� ����� ����������� � ������� Companies
INSERT INTO Companies (CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES (68490, '������', 52817160067810089312, 1326578, '������� ����� ���������'),
(92145, '�����', 23098110099910000033, 3633333, '������� ���� �����'),
(53853, '���', 33161560099910004399, 5679432, '������� Ը��� ����������'),
(47348, '������', 23098110099910021555, 8991234, '�������� ���� ���������'),
(53472, '���', 33161560666910004378, 5671432, '�������� ������ ����������'),
(64372, '���', 40817810099910004378, 2346678, '�������� ���� ���������')

--������� ����� ���������� � ������� Indicators
INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(213466, '������������� ������', 10, '����'),
(213477, '������� �� ������ �����', 6, '����������� �����'),
(123488, '������������������ �����', 8, '������'), 
(993455, '������� �� ������', 10, '����'),
(223457, '������� �����', 6, '����������� �����'),
(763457, '�������', 8, '������')

--������� ���� ����� � ������� ExchangeRate
UPDATE ExchangeRate
SET Dollar = 2.2345, EURO = 3.1000
GO

--������� �������� ����������� � ������� DynamicsOfIndicators
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

--������ ��������� ���������� �� ������� Indicators � ��������������� ����� ������ � ������� DynamicsOfIndicators
DELETE FROM dbo.DynamicsOfIndicators
WHERE IndicatorCode = 123457

DELETE FROM dbo.Indicators
WHERE IndicatorCode = 123457

DELETE FROM dbo.DynamicsOfIndicators
WHERE IndicatorCode = 903456

DELETE FROM dbo.Indicators
WHERE IndicatorCode = 903456

--��������� ���������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3.2. ���� 2022. ������� ��������� ���� �� 14.03.2022

--������ ��������� ����������� �� ������� Companies � ��������������� ����� ������ � ������� DynamicsOfIndicators
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

--������� ��������� ���������� � ������� Indicators
UPDATE Indicators
SET UnitOfMeasurement = '����������� �����'
WHERE IndicatorCode = 993455
GO

UPDATE Indicators
SET IndicatorName = '�������', Importance = 8
WHERE IndicatorCode = 123456
GO

--������� ���� ����� � ������� ExchangeRate �� 14.03.2022
UPDATE ExchangeRate
SET Dollar = 2.3000, EURO = 2.9990
GO

--������� ���� ����� � ������� ExchangeRate �� 21.03.2022
UPDATE ExchangeRate
SET Dollar = 2.3132, EURO = 3.0100
GO

--������� ���� ����� � ������� ExchangeRate �� 28.03.2022
UPDATE ExchangeRate
SET Dollar = 2.2111, EURO = 3.0111
GO

--������� ����� ���������� � ������� Companies
INSERT INTO Companies(CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES
(75933, '���', 33161560099910004311, 5678232, '������� ������ �������������'),
(23712, '����', 23098110099910001555, 9191234, '�������� ����� ���������'),
(57832, '����', 33161560666910004311, 5678752, '������� ����� ����������'),
(17141, '������', 11111110099910021555, 1111234, '����� ������ ����������'),
(23222, '���', 33333360666910004378, 5671999, '����� ������ ���������')

--��������� ���������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3.3. ������ 2022. ������� ��������� ���� �� 16.04.2022

--������� ���� ����� � ������� ExchangeRate �� 16.04.2022
UPDATE ExchangeRate
SET Dollar = 2.4500, EURO = 3.2000
GO

--������� ������ � ������� DynamicsOfIndicators
UPDATE DynamicsOfIndicators
SET Date = '2022-04-16', Value = 10.99
WHERE DynamicsID = 4
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-04-16', Value = 3.45
WHERE DynamicsID = 5
GO

--������� ������ � ������� Indicators
UPDATE Indicators
SET UnitOfMeasurement = '������'
WHERE IndicatorCode = 213456
GO

UPDATE Indicators
SET Importance = 10
WHERE IndicatorCode = 213451
GO

--������� ������ � ������� DynamicsOfIndicators
INSERT INTO DynamicsOfIndicators(DynamicsID, IndicatorCode, CompanyCode, Date, Value)
VALUES
(9, 123452, 12396, '2021-07-19', 4.5), 
(16, 213451, 17141, '2021-01-26', 8.88),
(17, 213450, 46833, '2021-06-27', 5),
(18, 123458, 47348, '2021-12-28', 4), 
(13, 213466, 53472, '2021-12-01', -6),
(14, 213477, 64372, '2021-10-02', -2),
(15, 123488, 67890, '2021-09-03', -10)

--������ � ������� ����� ������ ������� Companies
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
(77777, '���', 40817812199910004390, 2341678, '������� ���� �������'),
(94337, '����', 40817777799910004378, 2222228, '���������� ����� ��������'),
(78786, '������', 52817166667810056312, 7777578, '�������� ������ ����������'),
(65453, '�������', 23098222299910001555, 9991234, '���������� ������� ����������'),
(34792, '�������', 52817160067810056312, 4326578, '����������� ����� ����������')


--��������� ���������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3.4. ��� 2022. ������� ��������� ���� �� 15.05.2022

--������� ���� ����� � ������� ExchangeRate �� 15.05.2022
UPDATE ExchangeRate
SET Dollar = 2.5111, EURO = 3.0007
GO

--������� ������ � ������� DynamicsOfIndicators
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

--������ ��������� ������ �� ������ DynamicsOfIndicators � Companies
DELETE FROM dbo.DynamicsOfIndicators
WHERE DynamicsID = 10

DELETE FROM dbo.DynamicsOfIndicators
WHERE DynamicsID = 5

DELETE FROM dbo.DynamicsOfIndicators
WHERE DynamicsID = 3

DELETE FROM dbo.Companies
WHERE CompanyName = '����'

--������� ������ � ������� Indicators
INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(898989, '������� �� ������ �����', 6, '����������� �����'),
(900000, '������������������ �����', 10, '������'), 
(113415, '������� �� ������', 8, '����'),
(210450, '������� �����', 7, '����������� �����'),
(103419, '�������', 8, '������'), 
(991455, '������������� ������', 10, '����'),
(128456, '������� �� ������ �����', 6, '����������� �����'),
(120000, '������������������ �����', 10, '������')

--��������� ���������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3.5. ���� 2022. ������� ��������� ���� �� 19.06.2022

--������� ������ ������� DynamicsOfIndicators
UPDATE DynamicsOfIndicators
SET Date = '2022-06-19'
WHERE DynamicsID = 12
GO

UPDATE DynamicsOfIndicators
SET Value = 4.9
WHERE DynamicsID = 16
GO

--������ ������ �� ������ DynamicsOfIndicators, Indicators, Companies
DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 64372

DELETE FROM dbo.Companies
WHERE ContactPerson = '�������� ���� ���������'

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

--������� ������ � ������� DynamicOfIndicators � Indicators
INSERT INTO DynamicsOfIndicators(DynamicsID, IndicatorCode, CompanyCode, Date, Value)
VALUES
(16, 103419, 46833, '2021-10-21', 10)

INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(211450, '������� �����', 7, '����������� �����'),
(103519, '�������', 8, '������')

--��������� ���������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3.6. ���� 2022. ������� ��������� ���� �� 11.07.2022

--������� ����� ����������� � ������� Companies
INSERT INTO Companies (CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES (68891, '������', 52999160067810089312, 2126578, '������� ����� ���������'),
(10011, '�����', 23098110000000000033, 3683292, '������� ���� �����'),
(10019, '���', 13361560099910004399, 5689432, '������� Ը��� ����������'),
(10020, '������', 32098110099910021010, 8101234, '�������� ���� ���������'),
(10219, '���', 33161560666910004783, 5671400, '�������� ������ ����������'),
(90010, '���', 40817810099910043078, 2349978, '�������� ���� ���������')

--������� ����� ���������� � ������� Indicators
INSERT INTO Indicators(IndicatorCode, IndicatorName, Importance, UnitOfMeasurement)
VALUES
(124366, '������������� ������', 10, '����'),
(124377, '������� �� ������ �����', 6, '����������� �����'),
(124388, '������������������ �����', 8, '������'), 
(994355, '������� �� ������', 10, '����'),
(224357, '������� �����', 6, '����������� �����'),
(764357, '�������', 8, '������')

--������� ���� ����� � ������� ExchangeRate
UPDATE ExchangeRate
SET Dollar = 2.2345, EURO = 3.1000
GO

--������� �������� ����������� � ������� DynamicsOfIndicators
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

--������ ��������� ���������� �� ������� Indicators � ��������������� ����� ������ � ������� DynamicsOfIndicators
DELETE FROM dbo.DynamicsOfIndicators
WHERE IndicatorCode = 898989

DELETE FROM dbo.Indicators
WHERE IndicatorCode = 898989

DELETE FROM dbo.DynamicsOfIndicators
WHERE IndicatorCode = 113415

DELETE FROM dbo.Indicators
WHERE IndicatorCode = 113415

--��������� ���������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3.7. ������ 2022. ������� ��������� ���� �� 10.08.2022

--������ ��������� ����������� �� ������� Companies � ��������������� ����� ������ � ������� DynamicsOfIndicators
DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 99996

DELETE FROM dbo.Companies
WHERE CompanyCode = 99996

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 46833

DELETE FROM dbo.Companies
WHERE CompanyCode = 46833

--������� ��������� ���������� � ������� Indicators
UPDATE Indicators
SET UnitOfMeasurement = '����������� �����'
WHERE IndicatorCode = 993455
GO

UPDATE Indicators
SET IndicatorName = '�������', Importance = 8
WHERE IndicatorCode = 123456
GO

--������� ���� ����� � ������� ExchangeRate �� 10.08.2022
UPDATE ExchangeRate
SET Dollar = 2.3000, EURO = 2.9990
GO

--������� ����� ���������� � ������� Companies
INSERT INTO Companies(CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES
(75033, '���', 33001560099910004311, 5678230, '������� ������ �������������'),
(23012, '����', 23098110090910001555, 9191230, '�������� ����� ���������'),
(57032, '����', 33161560660910004311, 5678750, '������� ����� ����������'),
(17041, '������', 11100110099910021555, 1110234, '����� ������ ����������'),
(23002, '���', 33333360606910004378, 5071999, '����� ������ ���������')

--��������� ���������� �� ������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3.8. �������� 2022. ������� ��������� ���� �� 19.09.2022

--������� ���� ����� � ������� ExchangeRate �� 19.09.2022
UPDATE ExchangeRate
SET Dollar = 3.0000, EURO = 2.9000
GO

--������� ������ � ������� DynamicsOfIndicators
UPDATE DynamicsOfIndicators
SET Date = '2022-09-19', Value = 10.88
WHERE DynamicsID = 18
GO

UPDATE DynamicsOfIndicators
SET Date = '2022-09-19', Value = -3.45
WHERE DynamicsID = 13
GO

--������� ������ � ������� Indicators
UPDATE Indicators
SET UnitOfMeasurement = '����'
WHERE IndicatorCode = 213456
GO

UPDATE Indicators
SET Importance = 6
WHERE IndicatorCode = 213451
GO

--������� ������ � ������� DynamicsOfIndicators
INSERT INTO DynamicsOfIndicators(DynamicsID, IndicatorCode, CompanyCode, Date, Value)
VALUES
(40, 211450, 75033, '2022-07-19', 5.5), 
(41, 213450, 47348, '2022-01-26', 9.88),
(42, 219955, 57032, '2022-06-27', -5),
(43, 223457, 88883, '2021-12-28', 13), 
(50, 991455, 99997, '2022-12-01', 16),
(51, 764357, 23002, '2022-10-02', 18),
(53, 211450, 68891, '2021-09-03', 9)

--��������� ���������� �� ������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3.9. ������� 2022. ������� ��������� ���� �� 19.10.2022

--������ ��������� ����������� �� ������� Companies � ��������������� ����� ������ � ������� DynamicsOfIndicators
DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 99998

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 57032

DELETE FROM dbo.Companies
WHERE CompanyCode = 57032

--������� ��������� ���������� � ������� Indicators
UPDATE Indicators
SET UnitOfMeasurement = '����������� �����'
WHERE IndicatorCode = 120000
GO

UPDATE Indicators
SET UnitOfMeasurement = '����������� �����'
WHERE IndicatorCode = 123488
GO

--������� ���� ����� � ������� ExchangeRate �� 19.10.2022
UPDATE ExchangeRate
SET Dollar = 2.6666, EURO = 3.2222
GO

--������� ����� ���������� � ������� DynamicOfIndicators
INSERT INTO DynamicsOfIndicators(DynamicsID, IndicatorCode, CompanyCode, Date, Value)
VALUES
(101, 128456, 10020, '2022-10-02', -2),
(103, 213453, 17041, '2021-09-04', 7),
(104, 213451, 23002, '2021-01-05', 9),
(105, 994355, 23222, '2020-02-06', 2.66), 
(223, 764357, 75033, '2023-04-12', 2.1),
(189, 991455, 99998, '2023-06-13', -8.09)

--��������� ���������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3.10. ������ 2022. ������� ��������� ���� �� 18.11.2022

UPDATE dbo.ExchangeRate
SET Dollar = 2.9102
GO

UPDATE dbo.Companies
SET CompanyName = '����'
WHERE CompanyName = '���'
GO

DELETE FROM dbo.DynamicsOfIndicators
WHERE CompanyCode = 57338

DELETE FROM dbo.Companies
WHERE CompanyName = '�������'

INSERT INTO Companies(CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson)
VALUES
(75003, '�������', 33001560099910004311, 5678230, '������� ������ �������������'),
(20002, '�������', 23098110090910001555, 9191230, '�������� ����� ���������'),
(57002, '�������', 33161560660910004311, 5678750, '������� ����� ����������'),
(17001, '�������', 11100110099910021555, 1110234, '����� ������ ����������'),
(20012, '�������', 33333360606910004378, 5071999, '����� ������ ���������')

--��������� ���������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory

--����� 3.11. ������� 2022. ������� ��������� ���� �� 25.12.2022

UPDATE dbo.ExchangeRate
SET Dollar = 2.7895, Euro = 3.0000
GO

UPDATE dbo.Companies
SET CompanyName = '���'
WHERE CompanyName = '����'
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
(124300, '������������� ������', 10, '����'),
(124007, '������� �� ������ �����', 6, '����������� �����'),
(124008, '������������������ �����', 8, '������'), 
(994005, '������� �� ������', 10, '����'),
(224007, '������� �����', 6, '����������� �����'),
(764007, '�������', 8, '������')

--��������� ���������� ��� ������� ExchangeRate
SELECT *
FROM dbo.ExchangeRate

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRate;

SELECT UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate
FROM dbo.ExchangeRateHistory;

--��������� ���������� ��� ������� Indicators
SELECT *
FROM dbo.Indicators

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators;

SELECT IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.IndicatorsHistory;

--��������� ���������� ��� ������� Companies
SELECT *
FROM dbo.Companies

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.Companies;

SELECT CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate
FROM dbo.CompaniesHistory;

--��������� ���������� ��� ������� DynamicsOfIndicators
SELECT *
FROM dbo.DynamicsOfIndicators

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicators;

SELECT DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate
FROM dbo.DynamicsOfIndicatorsHistory