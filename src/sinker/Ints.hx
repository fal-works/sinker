package sinker;

/**
	Utility for `Int`.
**/
class Ints {
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
