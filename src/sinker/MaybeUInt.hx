package sinker;

#if sinker_debug
import sinker.errors.CastError;
import sinker.errors.UnwrapError;
import sinker.internal.ErrorMsg;
#end

/**
	Represents either an `UInt` value or the absense of valid value.

	Unlike `Null<UInt>`and `Maybe<UInt>`, `MaybeUInt` does not require boxing.
**/
@:notNull @:transitive
abstract MaybeUInt(UInt) from UInt {
	/**
		A special value that represents the absense of valid `UInt` value.
		Internaly this is an integer value `-1`.
	**/
	public static extern inline final none: MaybeUInt = cast -1;

	/**
		Casts `value` to `MaybeUInt.
	**/
	public static extern inline function from(value: UInt): MaybeUInt
		return value;

	/**
		Casts `value` to `MaybeUInt`.
		Value `-1` corresponds to `MaybeUInt.none`.

		`#if sinker_debug` throws `CastError` if `value` is less than `-1`.

		@param value Any integer that is `-1` or greater.
	**/
	@:from public static extern inline function fromInt(value: Int): MaybeUInt {
		#if sinker_debug
		if (-1 <= value) return cast value;
		else throw new CastError(ErrorMsg.maybeUIntFromInt(value));
		#else
		return cast value;
		#end
	}

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
		@return The value of `this`.
		@throws `UnwrapError` if `this.isNone()`.
	**/
	public extern inline function unwrap(): UInt {
		#if sinker_debug
		if (isNone()) throw new UnwrapError(ErrorMsg.maybeUIntUnwrap());
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
