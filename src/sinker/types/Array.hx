package sinker.types;

import Array as StdArray;
import sinker.types.Int;
import sinker.types.UInt;
import sinker.tools.ArrayTools;

/**
	Wrapper of standard `Array`.
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
		@return New array with length `size`.
	**/
	public extern inline function new<T>(size: UInt) {
		#if cpp
		this = cpp.NativeArray.create(size);
		#else
		final newArray: Array<T> = [];
		newArray.resize(size);
		this = newArray;
		#end
	}

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
		return cpp.NativeArray.unsafeGet(this, index.std());
		#else
		return this[index.std()];
		#end
	}

	@:op([]) extern inline function set(index: UInt, value: T): T {
		#if debug
		if (index >= length) throw "Out of bound.";
		#end

		#if cpp
		return cpp.NativeArray.unsafeSet(this, index.std(), value);
		#else
		return this[index.std()] = value;
		#end
	}

	public extern inline function concat(other: Array<T>): Array<T>
		return this.concat(other);

	public extern inline function push(element: T): UInt {
		return new UInt(this.push(element));
	}

	public extern inline function slice(position: Int, ?end: Int): Array<T>
		return this.slice(position.std(), cast end);

	public extern inline function splice(position: Int, length: Int): Array<T>
		return this.splice(position.std(), length.std());

	public extern inline function indexOf(value: T, fromIndex: Int): UInt {
		return new UInt(this.indexOf(value, fromIndex.std()));
	}

	public extern inline function lastIndexOf(value: T, fromIndex: Int): UInt {
		return new UInt(this.lastIndexOf(value, fromIndex.std()));
	}

	public extern inline function copy(): Array<T>
		return this.copy();

	public extern inline function map<S>(callback: T->S): Array<S> {
		#if (cpp && !cppia)
		return this.map(f);
		#else
		final len = length;
		final newArray: Array<S> = new Array(len);
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

	public extern inline function resize(len:UInt):Void
		this.resize(len.std());
}
