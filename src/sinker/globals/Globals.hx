package sinker.globals;

import sinker.Maybe;
import sinker.UInt;

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
		Casts `Int` to `UInt`.
		`#if sinker_debug` throws error if negative.
	**/
	public static extern inline function uint(value: Int): UInt
		return UInt.fromInt(value);
}
