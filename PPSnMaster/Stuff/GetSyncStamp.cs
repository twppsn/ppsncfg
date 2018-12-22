using System;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
	[SqlFunction]
	public static SqlInt64 GetSyncStamp(SqlDateTime syncStamp)
	{
		return syncStamp.IsNull ?
			new SqlInt64(DateTime.Now.ToFileTimeUtc()) :
			new SqlInt64(syncStamp.Value.ToFileTimeUtc());
	} // func GetSyncStamp
}
