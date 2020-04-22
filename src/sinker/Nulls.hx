package sinker;

/**
	Utility for `Null<T>`.
**/
class Nulls {
	/**
		Casts `value` to `Maybe<T>`.
	**/
	public static extern inline function toMaybe<T>(value: Null<T>): Maybe<T>
		return Maybe.from(value);

	/**
		Creates a new `Option<T>` instance from nullable `value`.
	**/
	public static extern inline function toOption<T>(value: Null<T>): Option<T>
		return sinker.Option.fromNullable(value);
}
