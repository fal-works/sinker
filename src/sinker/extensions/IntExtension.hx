package sinker.extensions;

import sinker.types.Int;
import sinker.types.UInt;

class IntExtension {
	/**
		Divides `this` integer by `denominator`.
		- On cpp, uses `cpp.NativeMath.idiv()`.
		- Otherwise just `Std.int(this / denominator)`.
	**/
	public static extern inline function divideBy(_this: Int, denominator: Int): Int {
		#if cpp
		return cpp.NativeMath.idiv(_this, denominator);
		#else
		return Std.int(_this / denominator);
		#end
	}

	/**
		Runs a modulo operation.
		- On cpp, uses `cpp.NativeMath.imod()`.
		- Otherwise just `this % denominator`.
	**/
	public static extern inline function modulo(_this: Int, denominator: Int): Int {
		#if cpp
		return cpp.NativeMath.imod(_this, denominator);
		#else
		return _this.std() % denominator.std();
		#end
	}

	/**
		@return `pow(this, 2)`.
	**/
	public static extern inline function square(_this: Int): Int
		return _this * _this;

	/**
		@return The absolute value of `this`.
	**/
	@:access(sinker.types.UInt)
	public static extern inline function absolute(_this: Int): UInt {
		return new UInt(if (0 <= _this) _this else -_this);
	}
}
