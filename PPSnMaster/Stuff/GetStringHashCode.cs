using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [SqlFunction(IsDeterministic = true, IsPrecise = true)]
    public static SqlInt32 GetStringHashCode(SqlString value)
    {
		return value.IsNull
			? SqlInt32.Null
			: new SqlInt32(value.Value.GetHashCode());
	} // func GetStringHashCode
}
