package sinker.tools;

/**
	Utility for `Int`.
**/
class IntTools {
	/**
		@return The smaller value of `a` and `b`.
	**/
	public static extern inline function minInt(a: Int, b: Int): Int
		return if (a < b) a else b;

	/**
		@return The larger value of `a` and `b`.
	**/
	public static extern inline function maxInt(a: Int, b: Int): Int
		return if (a < b) b else a;
}
