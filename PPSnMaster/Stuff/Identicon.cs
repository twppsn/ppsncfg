using System.Data.SqlTypes;
using System.Text;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
	/// <summary>
	/// Creates an Identicon. The incoming int is supposed to have the following definition
	/// bits            0       7  8      15  16     23  24     31
	/// int32 identity  0000 0000  0000 0000  0000 0000  0000 0000
	///                         |----------------v---------------|
	///                 HHHH HHL                 |
	///                  color           image data array
	///                        (first bit is first row first column
	///                         6th bit is second row first column)
	/// color in hsl (h = H / 64, s = 0.5, l = L(0.25/0.5))
	/// </summary>
	/// <param name="hashCode">bitmask for icon (the int value is only for transporting the 4 bytes)</param>
	/// <returns>Colored monochrome bitmap.</returns>
	[SqlFunction(IsDeterministic = true, IsPrecise = true)]
    public static SqlInt32 GetIdenticonFromHash(SqlInt32 hashCode)
    {
		if (hashCode.IsNull)
			return SqlInt32.Null;

		var uhash = (uint)hashCode.Value;
		var color = uhash & 127;

		var y0 = 0u;
		var y1 = 0u;
		var y2 = 0u;
		// every second bit of the 32 bit hash is used to draw the dots.
		// draw down the middle first, then mirrored outwards
		for (var i = 0; i < 15; i++)
		{
			if (i < 5)
				y2 = y2 | ((uhash & 1) << i);
			else if (i < 10)
				y1 = y1 | ((uhash & 1) << (i - 5));
			else
				y0 = y0 | ((uhash & 1) << (i - 10));
			uhash >>= 2;
		}

		var m = 0u;
		for (var y = 0; y < 5; y++)
		{
			var x0 = y0 & 1;
			var x1 = y1 & 1;
			var x2 = y2 & 1;

			m = (m << 1) | x0;
			m = (m << 1) | x1;
			m = (m << 1) | x2;
			m = (m << 1) | x1;
			m = (m << 1) | x0;

			y0 >>= 1;
			y1 >>= 1;
			y2 >>= 1;
		}

		m <<= 7;
		m |= color;

		return new SqlInt32(unchecked((int)m));
	} // func GetIdenticonFromHash

	[SqlFunction(IsDeterministic = true, IsPrecise = true)]
	public static SqlString GetAsciiIdenticon(SqlInt32 identicon)
	{
		if (identicon.IsNull)
			return SqlString.Null;

		var m = (uint)identicon.Value;
		var sb = new StringBuilder();

		// take  color
		var color = m & 127;
		m >>= 7;

		// take first row
		for (var y = 0; y < 5; y++)
		{
			for (var x = 0; x < 5; x++)
			{
				sb.Append((m & 1) != 0 ? 'X' : ' ');
				m >>= 1;
			}
			sb.AppendLine();
		}

		return new SqlString(sb.ToString());
	} // GetAsciiIdenticon
}
