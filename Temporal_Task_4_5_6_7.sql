--������� ��������� ��������� 2 �����, 2 ������: ������� ���������

--����� 4. ������� ��������� ���� ������ ���� ������ �� ��������� �� ��������� ���� ������� �������� 2022 ���� � 23:59:59.9999999

--1 �������. ��������� �� 31.03.2022

--������� "���� �����"
SELECT '31 ����� 2022 ����' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999'

--������� "����������"
SELECT '31 ����� 2022 ����' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate 
FROM dbo.Indicators
FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999'

--������� "�����������"
SELECT '31 ����� 2022 ����' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999'

--������� "�������� �����������"
SELECT '31 ����� 2022 ����' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME AS OF '2022-03-31 23:59:59.9999999'

--2 �������. ��������� �� 30.06.2022

--������� "���� �����"
SELECT '30 ���� 2022 ����' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999'

--������� "����������"
SELECT '30 ���� 2022 ����' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate 
FROM dbo.Indicators
FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999'

--������� "�����������"
SELECT '30 ���� 2022 ����' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999'

--������� "�������� �����������"
SELECT '30 ���� 2022 ����' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME AS OF '2022-06-30 23:59:59.9999999'

--3 �������. ��������� �� 30.09.2022

--������� "���� �����"
SELECT '30 �������� 2022 ����' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999'

--������� "����������"
SELECT '30 �������� 2022 ����' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate 
FROM dbo.Indicators
FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999'

--������� "�����������"
SELECT '30 �������� 2022 ����' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999'

--������� "�������� �����������"
SELECT '30 �������� 2022 ����' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME AS OF '2022-09-30 23:59:59.9999999'

--4 �������. ��������� �� 31.12.2022

--������� "���� �����"
SELECT '31 ������� 2022 ����' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999'

--������� "����������"
SELECT '31 ������� 2022 ����' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate 
FROM dbo.Indicators
FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999'

--������� "�����������"
SELECT '31 ������� 2022 ����' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999'

--������� "�������� �����������"
SELECT '31 ������� 2022 ����' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME AS OF '2022-12-31 23:59:59.9999999'

--����� 5. ������� ��������� ���� ������ ���� ������ �� ���� 2022 ����.

--������� "���� �����"
SELECT '���� 2022' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'

--������� "����������"
SELECT '���� 2022' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate 
FROM dbo.Indicators
FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'

--������� "�����������"
SELECT '���� 2022' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'

--������� "�������� �����������"
SELECT '���� 2022' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME BETWEEN '2022-06-01' AND '2022-08-31 23:59:59.9999999'

--����� 6. ������� ������, ������� ���� ��������� � ������� �� ������ ������� 2022 ����.

--3 �������: � 01.07.2022 �� 30.09.2022

--������� "���� �����"
SELECT '��������� � ������� �� 3-�� ������� 2022' AS Date, UnitOfMeasurement, Dollar, Euro, BYN, StartDate, EndDate 
FROM dbo.ExchangeRate
FOR SYSTEM_TIME CONTAINED IN ('2022-07-01', '2022-09-30 23:59:59.9999999')

--������� "����������"
SELECT '��������� � ������� �� 3-�� ������� 2022' AS Date, IndicatorCode, IndicatorName, Importance, UnitOfMeasurement, StartDate, EndDate
FROM dbo.Indicators
FOR SYSTEM_TIME CONTAINED IN ('2022-07-01', '2022-09-30 23:59:59.9999999')

--������� "�����������"
SELECT '��������� � ������� �� 3-�� ������� 2022' AS Date, CompanyCode, CompanyName, BankRequisites, Telephone, ContactPerson, StartDate, EndDate 
FROM dbo.Companies
FOR SYSTEM_TIME CONTAINED IN ('2022-07-01', '2022-09-30 23:59:59.9999999')

--������� "�������� �����������"
SELECT '��������� � ������� �� 3-�� ������� 2022' AS Date, DynamicsID, IndicatorCode, CompanyCode, Date, Value, StartDate, EndDate 
FROM dbo.DynamicsOfIndicators
FOR SYSTEM_TIME CONTAINED IN ('2022-07-01', '2022-09-30 23:59:59.9999999')

--����� 7. ������� ����� ������ � ����������� ������������� ���������, ��������� JOIN.

--������ "�����������" � �� "��������"
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

--������ "�����������" ������������ "����� �����"
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