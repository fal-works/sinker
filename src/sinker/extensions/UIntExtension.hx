package sinker.extensions;

import sinker.UInt;

using sinker.extensions.IntExtension;

class UIntExtension {
	/**
		@return `true` if `this` is not `UInt.none`.
	**/
	public static extern inline function isSome(_this: UInt): Bool
		return _this != UInt.none;

	/**
		@return `true` if `this` is `UInt.none`.
	**/
	public static extern inline function isNone(_this: UInt): Bool
		return _this == UInt.none;

	/**
		Divides `this` integer by `denominator`.
		- On cpp, uses `cpp.NativeMath.idiv()`.
		- Otherwise just `Std.int(this / denominator)`.
	**/
	public static extern inline function divideBy(_this: UInt, denominator: UInt): UInt {
		#if cpp
		return cpp.NativeMath.idiv(_this, denominator);
		#else
		return new UInt(Std.int(_this / denominator));
		#end
	}

	/**
		Runs a modulo operation.
		- On cpp, uses `cpp.NativeMath.imod()`.
		- Otherwise just `this % denominator`.
	**/
	public static extern inline function modulo(_this: UInt, denominator: UInt): UInt {
		return new UInt(_this.int().modulo(denominator));
	}

	/**
		@return `pow(this, 2)`.
	**/
	public static extern inline function square(_this: UInt): UInt {
		return _this * _this;
	}

	/**
		@return `pow(2, this)`.
	**/
	public static extern inline function powerOf2(_this: UInt): UInt {
		return new UInt(1 << _this);
	}
}
