package sinker.types;

/**
	Unsigned integer based on `Int`.
	- `#if debug` checks against negative when casting from `Int`.
	- Does not check against overflow.
**/
@:notNull
abstract UInt(Int) to Int from std.UInt to std.UInt {
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
	@:from public static extern inline function fromInt(v: Int): UInt {
		#if debug
		if (v < 0) throw 'Failed to cast value to UInt: $v';
		#end
		return new UInt(v);
	}

	@:op(A + B) static extern inline function addInt(a: UInt, b: Int): UInt
		return fromInt(a.int() + b);

	@:op(A + B) function add(v: UInt): UInt;

	@:op(A - B) static extern inline function subtractInt(a: UInt, b: Int): UInt
		return fromInt(a.int() - b);

	@:op(A - B) extern inline function subtract(v: UInt): UInt
		return fromInt(this - v);

	@:op(A * B) function multiply(v: UInt): UInt;

	@:op(A / B) function divide(v: UInt): Float;

	@:op(++A) function preIncrement(): UInt;

	@:op(--A) extern inline function preDecrement(): UInt
		return fromInt(--this);

	@:op(A++) function postIncrement(): UInt;

	#if debug
	@:op(A--) extern inline function postDecrement(): UInt {
		fromInt(--this);
		return this;
	}
	#else
	@:op(A--) function postDecrement(): UInt;
	#end

	@:op(A == B) @:commutative
	static function equalInt(a: UInt, b: Int): Bool;

	@:op(A == B) function equal(v: Int): Bool;

	@:op(A != B) @:commutative
	static function notEqual(a: UInt, b: Int): Bool;

	@:op(A != B) function notEqual(v: Int): Bool;

	@:op(A > B) static function greaterThanInt(a: UInt, b: Int): Bool;

	@:op(A > B) static function greaterThanIntReversed(a: Int, b: UInt): Bool;

	@:op(A > B) function greaterThan(v: UInt): Bool;

	@:op(A >= B) static function greaterThanOrEqualInt(a: UInt, b: Int): Bool;

	@:op(A >= B) static function greaterThanOrEqualIntReversed(a: Int, b: UInt): Bool;

	@:op(A >= B) function greaterThanOrEqual(v: UInt): Bool;

	@:op(A < B) static function lessThanInt(a: UInt, b: Int): Bool;

	@:op(A < B) static function lessThanIntReversed(a: Int, b: UInt): Bool;

	@:op(A < B) function lessThan(v: UInt): Bool;

	@:op(A <= B) static function lessThanOrEqualInt(a: UInt, b: Int): Bool;

	@:op(A <= B) static function lessThanOrEqualIntReversed(a: Int, b: UInt): Bool;

	@:op(A <= B) function lessThanOrEqual(v: UInt): Bool;

	@:op(A & B) @:commutative
	static function andInt(a: UInt, b: Int): UInt;

	@:op(A & B) function and(v: UInt): UInt;

	@:op(A | B) @:commutative
	static function orInt(a: UInt, b: Int): Int;

	@:op(A | B) function or(v: UInt): Int;

	@:op(A ^ B) @:commutative
	static function xorInt(a: UInt, b: Int): Int;

	@:op(A ^ B) function xor(v: UInt): Int;

	@:op(~A) function negate(): Int;

	@:op(A << B) function leftShift(shiftCount: UInt): UInt;

	@:op(A >> B) extern inline function rightShift(shiftCount: UInt): UInt {
		return new UInt(this >>> shiftCount);
	}

	@:op(A >>> B) function unsignedRightShift(shiftCount: UInt): UInt;

	/**
		Casts `this` to standard `UInt`.
	**/
	public extern inline function std(): std.UInt
		return this;

	/**
		Casts `this` to `Int`.
	**/
	public extern inline function int(): Int
		return this;

	/**
		Casts `this` to `Float`.
	**/
	public extern inline function float(): Float
		return this;

	/**
		Casts `this` to `String`.
	**/
	public extern inline function toString(): String
		return Std.string(this);

	@:allow(sinker)
	extern inline function new(v: Int)
		this = v;
}
