SELECT
		s.[name] AS [Schema]
		, o.[name] AS [ObjName]
		, o.[type] AS [ObjType]
		, i.[name] AS [IdxName]
		, avg_fragmentation_in_percent AS AvgFrag
		, fragment_count AS FragCount
	FROM sys.dm_db_index_physical_stats(DB_ID(N'OSM'), OBJECT_ID(N'HumanResources.Employee'), NULL, NULL, NULL) AS f
		INNER JOIN sys.indexes AS i ON (f.object_id = i.object_id AND f.index_id = i.index_id)
		INNER JOIN sys.objects AS o ON (i.object_id = o.object_id)
		INNER JOIN sys.schemas s on (o.schema_id = s.schema_id)
