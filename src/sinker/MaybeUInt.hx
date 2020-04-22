package sinker;

/**
	Represents either an `UInt` value or the absense of valid value.

	Unlike `Null<UInt>`, `MaybeUInt` does not require boxing.
**/
abstract MaybeUInt(UInt) from UInt {
	/**
		A special value that represents the absense of valid `UInt` value.
		Internaly this is an integer value `-1`.
	**/
	public static extern inline final none: MaybeUInt = cast -1;

	/**
		@return `value` in `MaybeUInt` representation.
	**/
	public static extern inline function from(value: UInt): MaybeUInt
		return value;

	/**
		@return `true` if `this` is not `MaybeUInt.none`.
	**/
	public extern inline function isSome(): Bool
		return from(this) != none;

	/**
		@return `true` if `this` is `MaybeUInt.none`.
	**/
	public extern inline function isNone(): Bool
		return from(this) == none;

	/**
		@return The value of `this`. Throws error if `this.isNone()`.
	**/
	public extern inline function unwrap(): UInt {
		#if sinker_debug
		if (isNone()) throw "Failed to unwrap. The value is not a valid UInt.";
		#end
		return this;
	}

	/**
		Casts `this` to `Int`.

		`MaybeUInt.none.int()` returns `-1`.
	**/
	public extern inline function int(): Int
		return this.int();

	/**
		@return `this` if it is not `MaybeUInt.none`, otherwise `defaultValue`.
	**/
	public extern inline function or(defaultValue: UInt): UInt
		return if (isSome()) this else defaultValue;

	/**
		@return `this` if it is not `MaybeUInt.none`, otherwise the result of `defaultValueFactory`.
	**/
	public extern inline function orElse(defaultValueFactory: () -> UInt): UInt
		return if (isSome()) this else defaultValueFactory();
}
