package sinker;

class MaybeCallbacks {
	/**
		@see `Maybe.nullable()`
	**/
	public static final nullable = nullableFunction;

	/**
		@see `Maybe.toOption()`
	**/
	public static final toOption = toOptionFunction;

	/**
		@see `Maybe.unwrap()`
	**/
	public static final unwrap = unwrapFunction;

	/**
		@see `Maybe.isSome()`
	**/
	public static final isSome = (value: Maybe<Dynamic>) -> value.isSome();

	/**
		@see `Maybe.isNone()`
	**/
	public static final isNone = (value: Maybe<Dynamic>) -> value.isNone();

	/** Internal function for disabling inlining. **/
	static function nullableFunction<T>(value: Maybe<T>)
		return value.nullable();

	/** Internal function for disabling inlining. **/
	static function toOptionFunction<T>(value: Maybe<T>)
		return value.toOption();

	/** Internal function for disabling inlining. **/
	static function unwrapFunction<T>(value: Maybe<T>)
		return value.unwrap();
}
