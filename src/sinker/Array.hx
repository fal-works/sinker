package sinker;

import Array as StdArray;

/**
	Wrapper of standard `Array`.
	- Uses `sinker.UInt` for length and indices.
	- Uses `unsafeGet()`/`unsafeSet()` on cpp target.
	- Does boundary check `#if debug`.
**/
@:forward(
	join,
	pop,
	reverse,
	shift,
	sort,
	toString,
	unShift,
	insert,
	remove,
	iterator
)
abstract Array<T>(StdArray<T>) from StdArray<T> to StdArray<T> {
	public var length(get, never): UInt;

	extern inline function get_length(): UInt {
		return new UInt(this.length);
	}

	/**
		@return New array with zero length.
	**/
	public extern inline function new()
		this = new StdArray();

	/**
		Casts `this` to standard `Array`.
	**/
	public extern inline function std(): StdArray<T>
		return this;

	@:op([]) extern inline function get(index: UInt): T {
		#if debug
		if (index >= length) throw "Out of bound.";
		#end

		#if cpp
		return cpp.NativeArray.unsafeGet(this, index.int());
		#else
		return this[index.int()];
		#end
	}

	@:op([]) extern inline function set(index: UInt, value: T): T {
		#if debug
		if (index >= length) throw "Out of bound.";
		#end

		#if cpp
		return cpp.NativeArray.unsafeSet(this, index.int(), value);
		#else
		return this[index.int()] = value;
		#end
	}

	public extern inline function concat(other: Array<T>): Array<T>
		return this.concat(other);

	public extern inline function push(element: T): UInt {
		return new UInt(this.push(element));
	}

	public extern inline function slice(position: Int, ?end: Int): Array<T>
		return this.slice(position, cast end);

	public extern inline function splice(position: Int, length: Int): Array<T>
		return this.splice(position, length);

	public extern inline function indexOf(value: T, fromIndex: Int): UInt {
		return new UInt(this.indexOf(value, fromIndex));
	}

	public extern inline function lastIndexOf(value: T, fromIndex: Int): UInt {
		return new UInt(this.lastIndexOf(value, fromIndex));
	}

	public extern inline function copy(): Array<T>
		return this.copy();

	public extern inline function map<S>(callback: T->S): Array<S> {
		#if (cpp && !cppia)
		return this.map(f);
		#else
		final len = length;
		final newArray: Array<S> = Arrays.allocate(len);
		var i = new UInt(0);
		while (i < len) {
			newArray[i] = callback(get(i));
			++i;
		}

		return newArray;
		#end
	}

	public extern inline function filter(predicate: T->Bool): Array<T> {
		final newArray: Array<T> = [];
		final len = length;
		var i = UInt.zero;
		while (i < len) {
			final element = get(i);
			if (predicate(element)) newArray.push(element);
			++i;
		}
		return newArray;
	}

	public extern inline function resize(len: UInt): Void
		this.resize(len.int());
}
