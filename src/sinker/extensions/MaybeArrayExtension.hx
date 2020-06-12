package sinker.extensions;

import sinker.*;

/**
	Functions for `Maybe<Array<T>>`.
**/
class MaybeArrayExtension {
	/**
		@return `this` if not null, otherwise a new empty array.
	**/
	public static extern inline function orNew<T>(_this: Maybe<Array<T>>): Array<T>
		return if (_this.isSome()) _this.unwrap() else [];
}
