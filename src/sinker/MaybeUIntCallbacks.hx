package sinker;

class MaybeUIntCallbacks {
	/**
		@see `MaybeUInt.isSome()`
	**/
	public static final isSome = (value: MaybeUInt) -> value.isSome();

	/**
		@see `MaybeUInt.isNone()`
	**/
	public static final isNone = (value: MaybeUInt) -> value.isNone();

	/**
		@see `MaybeUInt.unwrap()`
	**/
	public static final unwrap = (value: MaybeUInt) -> value.unwrap();

	/**
		@see `MaybeUInt.int()`
	**/
	public static final int = (value: MaybeUInt) -> value.int();
}
