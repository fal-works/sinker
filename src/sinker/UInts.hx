package sinker;

/**
	Utility for `UInt`.
**/
class UInts {
	/**
		@return `true` if `value` is not `UInt.none`.
	**/
	public static extern inline function isSome(value: UInt): Bool
		return value != UInt.none;

	/**
		@return `true` if `value` is `UInt.none`.
	**/
	public static extern inline function isNone(value: UInt): Bool
		return value == UInt.none;

	/**
		Divides `value` by `denominator`.
		- On cpp, uses `cpp.NativeMath.idiv()`.
		- Otherwise just `Std.int(value / denominator)`.
	**/
	public static extern inline function divide(value: UInt, denominator: UInt): UInt {
		return new UInt(Ints.divide(value.int(), denominator.int()));
	}

	/**
		Runs a modulo operation.
		- On cpp, uses `cpp.NativeMath.imod()`.
		- Otherwise just `value % denominator`.
	**/
	public static extern inline function modulo(value: UInt, denominator: UInt): UInt {
		return new UInt(Ints.modulo(value.int(), denominator.int()));
	}

	/**
		@return `pow(value, 2)`.
	**/
	public static extern inline function square(value: UInt): UInt {
		return new UInt(Ints.square(value));
	}

	/**
		@return `pow(2, value)`.
	**/
	public static extern inline function powerOf2(value: UInt): UInt {
		return new UInt(1 << value);
	}

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
