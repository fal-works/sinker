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
	public static var none(get, never): MaybeUInt;

	/**
		@return `value` in `MaybeUInt` representation.
	**/
	public extern inline function from(value: UInt): MaybeUInt
		return value;

	/**
		@return `true` if `this` is not `MaybeUInt.none`.
	**/
	public extern inline function isSome(): Bool
		return this != noneValue();

	/**
		@return `true` if `this` is `MaybeUInt.none`.
	**/
	public extern inline function isNone(): Bool
		return this == noneValue();

	/**
		@return The value of `this`. Throws error if `this.isNone()`.
	**/
	public extern inline function unwrap(): UInt {
		#if debug
		if (isNone()) throw "Failed to unwrap. The value is not a valid UInt.";
		#end
		return this;
	}

	/**
		@return The value of `this` without checking.
	**/
	public extern inline function unwrapUnsafe(): UInt
		return this;

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

	static extern inline function get_none()
		return noneValue();

	static extern inline function noneValue(): UInt {
		return new UInt(-1);
	}
}
