--use xxxxxxxxxxxxxx
--go

declare @tables as table(
	TABLE_NAME sysname null
);

insert into @Tables values ('student');

with cols as (
	SELECT
		TABLE_NAME,
		COLUMN_NAME,
		DATA_TYPE,
		IS_NULLABLE,
		ORDINAL_POSITION,
		CASE 
			WHEN DATA_TYPE in ('varchar', 'nvarchar') THEN 'string'
			WHEN DATA_TYPE in ('datetime', 'date') AND IS_NULLABLE = 'NO' THEN 'DateTime'
			WHEN DATA_TYPE in ('datetime', 'date') AND IS_NULLABLE = 'YES' THEN 'DateTime?'
			WHEN DATA_TYPE = 'int' AND IS_NULLABLE = 'YES' THEN 'int?'
			WHEN DATA_TYPE = 'int' AND IS_NULLABLE = 'NO' THEN 'int'
			WHEN DATA_TYPE = 'smallint' AND IS_NULLABLE = 'NO' THEN 'Int16'
			WHEN DATA_TYPE = 'smallint' AND IS_NULLABLE = 'YES' THEN 'Int16?'
			WHEN DATA_TYPE = 'decimal' AND IS_NULLABLE = 'NO' THEN 'decimal'
			WHEN DATA_TYPE = 'decimal' AND IS_NULLABLE = 'YES' THEN 'decimal?'
			WHEN DATA_TYPE = 'numeric' AND IS_NULLABLE = 'NO' THEN 'decimal'
			WHEN DATA_TYPE = 'numeric' AND IS_NULLABLE = 'YES' THEN 'decimal?'
			WHEN DATA_TYPE = 'money' AND IS_NULLABLE = 'NO' THEN 'decimal'
			WHEN DATA_TYPE = 'money' AND IS_NULLABLE = 'YES' THEN 'decimal?'
			WHEN DATA_TYPE = 'bigint' AND IS_NULLABLE = 'NO' THEN 'long'
			WHEN DATA_TYPE = 'bigint' AND IS_NULLABLE = 'YES' THEN 'long?'
			WHEN DATA_TYPE = 'tinyint' AND IS_NULLABLE = 'NO' THEN 'byte'
			WHEN DATA_TYPE = 'tinyint' AND IS_NULLABLE = 'YES' THEN 'byte?'
			WHEN DATA_TYPE = 'char' THEN 'string'
			WHEN DATA_TYPE = 'timestamp' THEN 'byte[]'
			WHEN DATA_TYPE = 'varbinary' THEN 'byte[]'
			WHEN DATA_TYPE = 'bit' AND IS_NULLABLE = 'NO' THEN 'bool'
			WHEN DATA_TYPE = 'bit' AND IS_NULLABLE = 'YES' THEN 'bool?'
			WHEN DATA_TYPE = 'xml' THEN 'string'
		END AS NewType
	FROM INFORMATION_SCHEMA.COLUMNS
)

SELECT
	'public ' + cols.NewType + ' ' + cols.COLUMN_NAME + ' {get;set;}',
	*
from cols
where (select COUNT(*) from @Tables) = 0
or cols.TABLE_NAME in (select TABLE_NAME from @Tables)
order by cols.TABLE_NAME, cols.ORDINAL_POSITION
