package sinker;

/**
	Utility for `UInt`.
**/
class UInts {
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

	/**
		@return `pow(base, exponent)`
	**/
	public static extern inline function pow(base: UInt, exponent: UInt): UInt {
		return new UInt(Floats.toInt(Math.pow(base, exponent)));
	}
}
