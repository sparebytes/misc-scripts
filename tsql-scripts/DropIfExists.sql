-- http://dattatreysindol.com/2012/05/29/tips-n-tricks-t-sql-an-elegant-way-to-create-or-alter-stored-procedures-in-one-go-for-easy-maintenance/

--
-- Create Dummy Objects if not exists and then ALTER
--

-- PROCEDURES
IF OBJECT_ID('xxxxxxxxxxxxxxxxxxxxxxxxx') IS NULL
EXEC('CREATE PROCEDURE xxxxxxxxxxxxxxxxxxxxxxxxx AS SET NOCOUNT ON;');
GO



--
-- Drop Objects
--

-- TABLES
IF OBJECT_ID('xxxxxxxxxxxxxxxxxxxxxxxxx') IS NOT NULL
DROP TABLE xxxxxxxxxxxxxxxxxxxxxxxxx;
GO

-- VIEWS 
IF OBJECT_ID('xxxxxxxxxxxxxxxxxxxxxxxxx') IS NOT NULL
DROP VIEW xxxxxxxxxxxxxxxxxxxxxxxxx;
GO

-- FUNCTIONS
IF OBJECT_ID('xxxxxxxxxxxxxxxxxxxxxxxxx') IS NOT NULL
DROP FUNCTION xxxxxxxxxxxxxxxxxxxxxxxxx;
GO

-- PROCEDURES
IF OBJECT_ID('xxxxxxxxxxxxxxxxxxxxxxxxx') IS NOT NULL
DROP PROCEDURE xxxxxxxxxxxxxxxxxxxxxxxxx;
GO



--
-- Old way that may have issues with schemas besides DBO
--

-- TABLES
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'U' AND name = 'xxxxxxxxxxxxxxxxxxxxxxxxx')
DROP TABLE xxxxxxxxxxxxxxxxxxxxxxxxx;
GO

-- VIEWS 
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'V' AND name = 'xxxxxxxxxxxxxxxxxxxxxxxxx')
DROP VIEW xxxxxxxxxxxxxxxxxxxxxxxxx;
GO

-- FUNCTIONS
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'xxxxxxxxxxxxxxxxxxxxxxxxx')
DROP FUNCTION xxxxxxxxxxxxxxxxxxxxxxxxx;
GO

-- PROCEDURES
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'xxxxxxxxxxxxxxxxxxxxxxxxx')
DROP PROCEDURE xxxxxxxxxxxxxxxxxxxxxxxxx;
GO

