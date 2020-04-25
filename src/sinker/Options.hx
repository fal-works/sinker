package sinker;

/**
	Utility for `Option<T>`.
**/
class Options {
	/**
		@return New `Option<T>` instance created from nullable `value`.
	**/
	public static extern inline function fromNullable<T>(value: Null<T>): Option<T>
		return if (value != null) Some(value) else None;

	/**
		@return New `Some(value: T)` instance created from `value`.
	**/
	public static extern inline function some<T>(value: T): Option<T>
		return Some(value);
}
