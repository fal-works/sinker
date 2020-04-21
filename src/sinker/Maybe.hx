package sinker;

import haxe.Constraints.Function;

/**
	Wrapper of `Null<T>` for:
	- avoiding implicit boxing of primitive values
	- avoiding implicit unwrapping
	- adding some utility methods
**/
@:notNull
abstract Maybe<T>(Null<T>) {
	/**
		Casts any object to `Maybe<T>`.
	**/
	@:from static extern inline function fromObject<T: {}>(object: T): Maybe<T>
		return new Maybe(object);

	/**
		Casts any function to `Maybe<T>`.
	**/
	@:from static extern inline function fromFunction<T: Function>(func: T): Maybe<T>
		return new Maybe(func);

	/**
		@return `null` in `Maybe<T>` representation.
	**/
	public static extern inline function none<T>(): Maybe<T>
		return new Maybe(null);

	/**
		Casts any value to `Maybe<T>`.

		It may cause boxing if `value` is a non-nullable primitive type.
	**/
	public static extern inline function from<T>(value: Null<T>): Maybe<T>
		return new Maybe(value);

	/**
		Casts `this` to `Null<T>`.
	**/
	public extern inline function toNullable(): Null<T>
		return this;

	/**
		@return New `Option` instance.
	**/
	public extern inline function createOption(): Option<T>
		return if (this != null) Some(this) else None;

	/**
		@return `true` if not null.
	**/
	public extern inline function isSome(): Bool
		return this != null;

	/**
		@return `true` if null.
	**/
	public extern inline function isNone(): Bool
		return this == null;

	/**
		Unwraps `this` if not null. Otherwise returns `defaultValue`.
	**/
	public extern inline function or(defaultValue: T): T
		return if (this != null) this else defaultValue;

	/**
		Unwraps `this` if not null. Otherwise returns the result of `defaultFactory()`.
	**/
	public extern inline function orElse(defaultFactory: () -> T): T
		return if (this != null) this else defaultFactory();

	/**
		Runs `callback` only if `this` is not null.
	**/
	public extern inline function may(callback: T->Void): Void
		if (this != null) callback(this);

	/**
		Applies `callback` to `this` and returns another `Maybe` value.
	**/
	public extern inline function map<U>(callback: T->U): Maybe<U>
		return Maybe.from(if (this != null) callback(this) else null);

	/**
		Casts `this` to a non-null type.
	**/
	public extern inline function unwrap(): T {
		#if sinker_debug if (this == null) throw "Failed to unwrap. Value is null."; #end
		@:nullSafety(Off) return this;
	}

	extern inline function new(data: Null<T>)
		this = data;
}
