package sinker.extensions;

import sinker.*;

using sinker.extensions.ArrayExtension;

class ArrayNullableExtension {
	/**
		@return `this` if not null, otherwise a new empty array.
	**/
	public static extern inline function orNew<T>(_this: Null<Array<T>>): Array<T>
		return if (_this != null) _this else [];

	/**
		@return Shallow copy of `this`, or `null` if `this` is `null`.
	**/
	public static inline function copyNullable<T>(_this: Null<Array<T>>): Null<Array<T>>
		return if (_this != null) _this.copy() else null;

	/**
		@return The first found element that is `element == value`.
		`defaultValue` if this array is `null` or the element is not found.
	**/
	public static inline function findIfNotNull<T>(
		_this: Null<Array<T>>,
		value: T,
		defaultValue: T
	): T {
		return if (_this != null) _this.find(value, defaultValue) else defaultValue;
	}
}
