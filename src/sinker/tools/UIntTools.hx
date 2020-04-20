package sinker.tools;

import sinker.types.UInt;

/**
	Utility for `UInt`.
**/
class UIntTools {
	/**
		@return The smaller value of `a` and `b`.
	**/
	public static extern inline function min(a: UInt, b: UInt): UInt
		return if (a < b) a else b;

	/**
		@return The larger value of `a` and `b`.
	**/
	public static extern inline function max(a: UInt, b: UInt): UInt
		return if (a < b) b else a;
}
