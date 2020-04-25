package sinker;

/**
	Utility for `Null<T>`.
**/
@:nullSafety(Off)
class Nulls {
	/**
		@return `value` if not null. Otherwise `defaultValue`.
	**/
	public static extern inline function coalesce<T>(value: Null<T>, defaultValue: T): T
		return if (value != null) value else defaultValue;

	/**
		Casts `value` to `Maybe<T>`.
	**/
	public static extern inline function maybe<T>(value: Null<T>): Maybe<T>
		return Maybe.from(value);

	/**
		Creates a new `Option<T>` instance from nullable `value`.
	**/
	public static extern inline function toOption<T>(value: Null<T>): Option<T>
		return Options.fromNullable(value);

	/**
		Converts `value` to `String`.
		Same as `Std.string()`, but can also be used in `nullSafety` mode.
	**/
	public static extern inline function toString<T>(value: Null<T>): String
		return Std.string(value);

	/**
		Converts `value` to `Maybe<String>`.
	**/
	public static inline function toMaybeString<T>(value: Null<T>): Maybe<String>
		return Maybe.from(if (value != null) Std.string(value) else null);

	/**
		Converts `value` to `Option<String>`.
	**/
	public static inline function toOptionalString<T>(value: Null<T>): Option<String>
		return toMaybeString(value).toOption();

	/**
		Parses `value` and converts it to `Maybe<Int>`.
	**/
	public static inline function parseInt<T>(value: Null<T>): Maybe<Int>
		return Maybe.from(Std.parseInt(Std.string(value)));

	/**
		Parses `value` and converts it to `Option<Int>`.
	**/
	public static inline function parseIntOptional<T>(value: Null<T>): Option<Int>
		return parseInt(value).toOption();

	/**
		Prases `value` and converts it to `Float`.
		The result is `NaN` if `value` cannot be parsed as `Float`.
	**/
	public static inline function parseFloat<T>(value: Null<T>): Float
		return Std.parseFloat(Std.string(value));
}
