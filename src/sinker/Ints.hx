package sinker;

/**
	Utility for `Int`.
**/
class Ints {
	/**
		Divides `value` by `denominator`.
		- On cpp, uses `cpp.NativeMath.idiv()`.
		- Otherwise just `Std.int(value / denominator)`.
	**/
	public static extern inline function divide(value: Int, denominator: Int): Int {
		#if cpp
		return cpp.NativeMath.idiv(value, denominator);
		#else
		return Std.int(value / denominator);
		#end
	}

	/**
		Runs a modulo operation.
		- On cpp, uses `cpp.NativeMath.imod()`.
		- Otherwise just `value % denominator`.
	**/
	public static extern inline function modulo(value: Int, denominator: Int): Int {
		#if cpp
		return cpp.NativeMath.imod(value, denominator);
		#else
		return value % denominator;
		#end
	}

	/**
		@return `pow(value, 2)`.
	**/
	public static extern inline function square(value: Int): Int
		return value * value;

	/**
		@return The absolute value of `value`.
	**/
	@:access(sinker.UInt)
	public static extern inline function absolute(value: Int): UInt {
		return new UInt(if (0 <= value) value else -value);
	}

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
