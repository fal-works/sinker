package sinker;

/**
	Utility for `Float`.
**/
class Floats {
	/**
		Casts `this` to `Int`.
		- On cpp, uses `cpp.NativeMath.fastInt()`.
		- Otherwise just `Std.int(this)`.
	**/
	public static extern inline function toInt(v: Float): Int {
		#if cpp
		return cpp.NativeMath.fastInt(v);
		#else
		return Std.int(v);
		#end
	}
}
