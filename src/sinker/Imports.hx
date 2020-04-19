package sinker;

/**
	Integer based on the standard `Int` with some additional methods.
**/
@:dox(hide)
typedef Int = sinker.types.Int;

/**
	Unsigned integer based on `Int`.
	- `#if debug` checks against negative when casting from `Int`.
	- Does not check against overflow.
**/
@:dox(hide)
typedef UInt = sinker.types.UInt;

@:dox(hide)
typedef Array<T> = sinker.types.Array<T>;

/**
	Wrapper of `Null<T>` for:
	- avoiding implicit boxing of primitive values
	- avoiding implicit unwrapping
	- adding some utility methods
**/
@:dox(hide)
typedef Maybe<T> = sinker.types.Maybe<T>;

/**
	Wrapper of `haxe.ds.Option` with some additional methods.
**/
@:dox(hide)
typedef Option<T> = sinker.types.Option<T>;

/**
	Utility for `Int`.
**/
@:dox(hide)
typedef IntTools = sinker.tools.IntTools;
