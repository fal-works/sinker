package sinker;

class NullCallbacks {
	/**
		@see `Nulls.isNull()`
	**/
	public static final isNull = isNullFunction;

	/**
		@see `Nulls.exists()`
	**/
	public static final exists = existsFunction;

	/**
		@see `Nulls.maybe()`
	**/
	public static final maybe = maybeFunction;

	/**
		@see `Nulls.toOption()`
	**/
	public static final toOption = toOptionFunction;

	/**
		@see `Nulls.toString()`
	**/
	public static final toString = toStringFunction;

	/**
		@see `Nulls.toMaybeString()`
	**/
	public static final toMaybeString = Nulls.toMaybeString;

	/**
		@see `Nulls.toOptionalString()`
	**/
	public static final toOptionalString = Nulls.toOptionalString;

	/**
		@see `Nulls.parseInt()`
	**/
	public static final parseInt = Nulls.parseInt;

	/**
		@see `Nulls.parseIntOptional()`
	**/
	public static final parseIntOptional = Nulls.parseIntOptional;

	/** Internal function for disabling inlining. **/
	static function isNullFunction<T>(value: Null<T>)
		return Nulls.isNull(value);

	/** Internal function for disabling inlining. **/
	static function existsFunction<T>(value: Null<T>)
		return Nulls.exists(value);

	/** Internal function for disabling inlining. **/
	static function maybeFunction<T>(value: Null<T>)
		return Nulls.maybe(value);

	/** Internal function for disabling inlining. **/
	static function toOptionFunction<T>(value: Null<T>)
		return Nulls.toOption(value);

	/** Internal function for disabling inlining. **/
	static function toStringFunction<T>(value: Null<T>)
		return Nulls.toString(value);
}
