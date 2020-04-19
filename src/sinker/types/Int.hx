package sinker.types;

import StdTypes.Int as StdInt;

/**
	Integer based on the standard `Int` with some additional methods.
	Cannot be implicitly cast to `Float`.
**/
@:notNull
abstract Int(StdInt) from StdInt {
	@:op(-A) function minus(): Int;

	@:op(A + B) function add(v: Int): Int;

	@:op(A + B) @:commutative
	static function addInt(a: Int, b: StdInt): Int;

	@:op(A - B) function subtract(v: Int): Int;

	@:op(A - B) @:commutative
	static function subtractInt(a: Int, b: StdInt): Int;

	@:op(A * B) function multiply(v: Int): Int;

	@:op(A * B) @:commutative
	static function multiplyInt(a: Int, b: StdInt): Int;

	@:op(A / B) function divideToFloat(v: Int): Float;

	@:op(A / B) function divideIntToFloat(v: StdInt): Float;

	@:op(++A) function preIncrement(): Int;

	@:op(--A) function preDecrement(): Int;

	@:op(A++) function postIncrement(): Int;

	@:op(A--) function postDecrement(): Int;

	@:op(A == B) function equal(v: Int): Bool;

	@:op(A == B) @:commutative
	static function equalInt(a: Int, b: StdInt): Bool;

	@:op(A != B) function notEqual(v: Int): Bool;

	@:op(A != B) @:commutative
	static function notEqual(a: Int, b: StdInt): Bool;

	@:op(A > B) function greaterThan(v: Int): Bool;

	@:op(A > B) static function greaterThanInt(a: Int, b: StdInt): Bool;

	@:op(A > B) static function greaterThanIntReversed(a: StdInt, b: Int): Bool;

	@:op(A >= B) function greaterThanOrEqual(v: Int): Bool;

	@:op(A >= B) static function greaterThanOrEqualInt(a: Int, b: StdInt): Bool;

	@:op(A >= B) static function greaterThanOrEqualIntReversed(a: StdInt, b: Int): Bool;

	@:op(A < B) function lessThan(v: Int): Bool;

	@:op(A < B) static function lessThanInt(a: Int, b: StdInt): Bool;

	@:op(A < B) static function lessThanIntReversed(a: StdInt, b: Int): Bool;

	@:op(A <= B) function lessThanOrEqual(v: Int): Bool;

	@:op(A <= B) static function lessThanOrEqualInt(a: Int, b: StdInt): Bool;

	@:op(A <= B) static function lessThanOrEqualIntReversed(a: StdInt, b: Int): Bool;

	@:op(A & B) function and(v: Int): Int;

	@:op(A & B) @:commutative
	static function andInt(a: Int, b: StdInt): Int;

	@:op(A | B) function or(v: Int): Int;

	@:op(A | B) @:commutative
	static function orInt(a: Int, b: StdInt): Int;

	@:op(A ^ B) function xor(v: Int): Int;

	@:op(A ^ B) @:commutative
	static function xorInt(a: Int, b: StdInt): Int;

	@:op(~A) function negate(): Int;

	@:op(A << B) function leftShift(shiftCount: UInt): Int;

	@:op(A >> B) function rightShift(shiftCount: UInt): Int;

	@:op(A >>> B) function unsignedRightShift(shiftCount: UInt): Int;

	@:op(A...B) function iterate(v: Int): IntIterator;

	/**
		Casts `this` to standard `Int`.
	**/
	public extern inline function std(): StdInt
		return this;

	/**
		Casts `Int` to `UInt`.
		`#if debug` throws error if negative.
	**/
	public extern inline function uint(): UInt
		return UInt.fromInt(this);

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

	extern inline function new(v: StdInt)
		this = v;
}
