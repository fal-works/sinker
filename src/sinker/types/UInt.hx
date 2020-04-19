package sinker.types;

import sinker.types.Int;

/**
	Unsigned integer based on `Int`.
	- `#if debug` checks against negative when casting from `Int`.
	- Does not check against overflow.
**/
@:notNull
@:forward(float)
abstract UInt(Int) to Int {
	/**
		A special `UInt` value that represents the absense of valid value.
		Internaly this is an integer value `-1`.
	**/
	public static var none(get, never): UInt;

	static extern inline function get_none() {
		return new UInt(-1);
	}

	/**
		Value `0` in `UInt` representation.
	**/
	public static var zero(get, never): UInt;

	static extern inline function get_zero() {
		return new UInt(0);
	}

	/**
		Value `1` in `UInt` representation.
	**/
	public static var one(get, never): UInt;

	static extern inline function get_one() {
		return new UInt(1);
	}

	/**
		Casts `Int` to `UInt`.
		`#if debug` throws error if negative.
	**/
	public static extern inline function fromInt(v: Int): UInt {
		#if debug
		if (v < 0) throw 'Failed to cast value to UInt: $v';
		#end
		return new UInt(v);
	}

	@:op(A + B) function add(v: UInt): UInt;

	@:op(A + B) static extern inline function addInt(a: UInt, b: Int): UInt
		return fromInt(a.int() + b);

	@:op(A - B) extern inline function subtract(v: UInt): UInt
		return fromInt(this - v);

	@:op(A - B) static extern inline function subtractInt(a: UInt, b: Int): UInt
		return fromInt(a.int() - b);

	@:op(A * B) function multiply(v: UInt): UInt;

	@:op(A / B) function divide(v: UInt): Float;

	@:op(++A) function preIncrement(): UInt;

	@:op(--A) function preDecrement(): UInt;

	@:op(A++) function postIncrement(): UInt;

	@:op(A--) function postDecrement(): UInt;

	@:op(A == B) function equal(v: UInt): Bool;

	@:op(A == B) function equalInt(v: Int): Bool;

	@:op(A != B) function notEqual(v: UInt): Bool;

	@:op(A != B) function notEqualInt(v: Int): Bool;

	@:op(A > B) function greaterThan(v: UInt): Bool;

	@:op(A > B) function greaterThanInt(v: Int): Bool;

	@:op(A >= B) function greaterThanOrEqual(v: UInt): Bool;

	@:op(A >= B) function greaterThanOrEqualInt(v: Int): Bool;

	@:op(A < B) function lessThan(v: UInt): Bool;

	@:op(A < B) function lessThanInt(v: Int): Bool;

	@:op(A <= B) function lessThanOrEqual(v: UInt): Bool;

	@:op(A <= B) function lessThanOrEqualInt(v: Int): Bool;

	@:op(A & B) function and(v: UInt): UInt;

	@:op(A | B) function or(v: UInt): UInt;

	@:op(A ^ B) function xor(v: UInt): UInt;

	@:op(~A) function negate(): UInt;

	@:op(A << B) function leftShift(shiftCount: UInt): UInt;

	@:op(A >> B) extern inline function rightShift(shiftCount: UInt): UInt {
		return new UInt(this >>> shiftCount);
	}

	@:op(A >>> B) function unsignedRightShift(shiftCount: UInt): UInt;

	@:op(A...B) function iterate(v: Int): IntIterator;

	/**
		Casts `this` to standard `Int`.
	**/
	public extern inline function std(): StdTypes.Int
		return this.std();

	/**
		Casts `this` to `Int`.
	**/
	public extern inline function int(): Int
		return this;

	/**
		Casts `this` to `Float`.
	**/
	public extern inline function float(): Float
		return this.std();

	/**
		Casts `this` to `String`.
	**/
	public extern inline function toString(): String
		return this.toString();

	@:allow(sinker)
	extern inline function new(v: Int)
		this = v;
}
