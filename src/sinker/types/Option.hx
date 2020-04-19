package sinker.types;

import haxe.ds.Option as StdOption;

/**
	Wrapper of `haxe.ds.Option` with some additional methods.
**/
@:notNull
abstract Option<T>(StdOption<T>) from StdOption<T> to StdOption<T> {
	public static extern inline function some<T>(value: T): Option<T>
		return Some(value);

	/**
		Casts `this` to `haxe.ds.Option`.
	**/
	public extern inline function std(): StdOption<T>
		return this;

	/**
		@return `true` if `this` is `Some`.
	**/
	public extern inline function isSome(): Bool {
		return switch this {
			case Some(_): true;
			case None: false;
		}
	}

	/**
		@return `true` if `this` is `None`.
	**/
	public extern inline function isNone(): Bool {
		return switch this {
			case Some(_): false;
			case None: true;
		}
	}

	/**
		Casts `this` to `Null<T>`.
	**/
	public extern inline function toNullable(): Null<T> {
		return switch this {
			case Some(value): value;
			case None: null;
		}
	}

	/**
		Casts `this` to `Maybe<T>`.
		Note that it requires boxing if `T` is a primitive type.
	**/
	public extern inline function maybe(): Maybe<T> {
		return switch this {
			case Some(value): Maybe.from(value);
			case None: Maybe.none();
		}
	}

	/**
		Unwraps `this` if not `None`. Otherwise returns `defaultValue`.
	**/
	public extern inline function or(defaultValue: T): T {
		return switch this {
			case Some(value): value;
			case None: defaultValue;
		}
	}

	/**
		Unwraps `this` if not `None`. Otherwise returns the result of `defaultFactory()`.
	**/
	public extern inline function orElse(defaultFactory: () -> T): T {
		return switch this {
			case Some(value): value;
			case None: defaultFactory();
		}
	}

	/**
		Runs `callback` only if `this` is not `None`.
	**/
	public extern inline function may(callback: T->Void): Void {
		switch this {
			case Some(value): callback(value);
			case None:
		}
	}

	/**
		Applies `callback` to `this` and returns another `Option` value.
	**/
	public extern inline function map<U>(callback: T->U): Option<U> {
		return switch this {
			case Some(value): Some(callback(value));
			case None: None;
		}
	}

	/**
		@return The value if `Some`. Throws error if `None`.
	**/
	public extern inline function unwrap(): T {
		return switch this {
			case Some(value): value;
			case None: throw "Failed to unwrap. Value is None.";
		}
	}
}
