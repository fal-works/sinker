package sinker;

import sinker.Imports;

/**
	Functions for global use.
**/
class Globals {
	/**
		Casts any value to Maybe<T>.

		It may cause boxing if `value` is a non-nullable primitive type.
	**/
	public static extern inline function maybe<T>(value: T): Maybe<T> {
		return Maybe.from(value);
	}

	/**
		Explicitly casts `StdTypes.Int` to `sinker.types.Int`.
	**/
	public static extern inline function int(value: StdTypes.Int): Int
		return value;

	/**
		Casts `Int` to `UInt`.
		`#if debug` throws error if negative.
	**/
	public static extern inline function uint(value: StdTypes.Int): UInt
		return UInt.fromInt(value);
}
