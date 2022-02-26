-- xxxxxxxxxxxxxxxxxxx table
-- yyyyyyyyyyyyyyyyyyy column


--
-- Create Table
--
CREATE TABLE dbo.xxxxxxxxxxxxxxxxxxx (
	xxxxxxxxxxxxxxxxxxxId int NOT NULL IDENTITY (1, 1),
	ccccccccccccccccccc char(10) NOT NULL,
	ddddddddddddddddddd datetime NOT NULL
);

--
-- Add Primary Key
--
ALTER TABLE dbo.xxxxxxxxxxxxxxxxxxx
	ADD CONSTRAINT PK_xxxxxxxxxxxxxxxxxxx PRIMARY KEY CLUSTERED (
		xxxxxxxxxxxxxxxxxxxId
	)
;

--
-- Add Unique Non-Clustered Index
--
CREATE UNIQUE NONCLUSTERED INDEX IX_NC_xxxxxxxxxxxxxxxxxxx_yyyyyyyyyyyyyyyyyyy_yyyyyyyyyyyyyyyyyyy
    ON dbo.xxxxxxxxxxxxxxxxxxx (yyyyyyyyyyyyyyyyyyy, yyyyyyyyyyyyyyyyyyy)

--
-- Add Unique Clustered Index
--
CREATE UNIQUE CLUSTERED INDEX IX_C_xxxxxxxxxxxxxxxxxxx
    ON dbo.xxxxxxxxxxxxxxxxxxx (yyyyyyyyyyyyyyyyyyy, yyyyyyyyyyyyyyyyyyy)


--
-- Add Column
--
ALTER TABLE dbo.xxxxxxxxxxxxxxxxxxx
	ADD yyyyyyyyyyyyyyyyyyy int NOT NULL default 0;

--
-- AlterColumn
--
ALTER TABLE dbo.xxxxxxxxxxxxxxxxxxx
	ALTER COLUMN yyyyyyyyyyyyyyyyyyy tttttt NOT NULL;

--
-- Add Foriegn Key
--
ALTER TABLE dbo.xxxxxxxxxxxxxxxxxxx
	ADD CONSTRAINT fk_XxxxYyyy
		FOREIGN KEY (yyyyyyyyyyyyyyyyyyyId)
		REFERENCES yyyyyyyyyyyyyyyyyyyId(yyyyyyyyyyyyyyyyyyyId);
