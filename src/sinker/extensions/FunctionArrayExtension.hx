package sinker.extensions;

class FunctionArrayExtension {
	/**
		Runs all functions in `this` array.
	**/
	public static extern inline function runAll(_this: Array<() -> Void>): Void
		for (i in 0..._this.length) _this[i]();

	/**
		@return `true` if and only if one or more functions in `this` array returns `true` (short-circuit).
	**/
	public static extern inline function logicalOr(_this: Array<() -> Bool>): Bool {
		var result = false;
		for (i in 0..._this.length) {
			if (!_this[i]()) continue;
			result = true;
			break;
		}
		return result;
	}

	/**
		@return `true` if and only if all functions in `this` array return `true` (short-circuit).
	**/
	public static extern inline function logicalAnd(_this: Array<() -> Bool>): Bool {
		var result = true;
		for (i in 0..._this.length) {
			if (_this[i]()) continue;
			result = false;
			break;
		}
		return result;
	}
}
