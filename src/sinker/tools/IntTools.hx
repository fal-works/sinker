package sinker.tools;

/**
	Utility for `Int`.
**/
class IntTools {
	/**
		@return The smaller value of `a` and `b`.
	**/
	public static extern inline function min(a: Int, b: Int): Int
		return if (a < b) a else b;

	/**
		@return The larger value of `a` and `b`.
	**/
	public static extern inline function max(a: Int, b: Int): Int
		return if (a < b) b else a;
}
