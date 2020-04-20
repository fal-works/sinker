package sinker;

/**
	Unsigned integer based on `Int`.
	- `#if debug` checks against negative when casting from `Int`.
	- Does not check against overflow.
**/
@:dox(hide)
typedef UInt = sinker.types.UInt;

/**
	Wrapper of standard `Array`.
	- Uses `sinker.types.UInt` for indices.
	- Uses `unsafeGet()`/`unsafeSet()` on cpp target.
	- Does boundary check `#if debug`.
**/
@:dox(hide)
typedef StrictArray<T> = sinker.types.StrictArray<T>;

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

/**
	Utility for `UInt`.
**/
@:dox(hide)
typedef UIntTools = sinker.tools.UIntTools;

/**
	Utility for `Array<T>`.
**/
@:dox(hide)
typedef ArrayTools = sinker.tools.ArrayTools;
