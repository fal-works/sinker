package sinker.extensions;

import sinker.Array;
import sinker.UInt;

using sinker.extensions.ArrayFunctionalExtension;
#if sinker_debug
import sinker.errors.RangeError;
import sinker.internal.ArrayErrorMsg;
#end

/**
	Statid extension for `Array`.
**/
class ArrayExtension {
	/**
		@return `true` if `this.length` is zero.
	**/
	public static extern inline function isEmpty<T>(_this: Array<T>): Bool
		return _this.length == UInt.zero;

	/**
		@return The first element without checking if `this` is empty.
	**/
	public static extern inline function getFirst<T>(_this: Array<T>): T
		return _this[UInt.zero];

	/**
		@return The first element, or `Maybe.none()` if empty.
	**/
	public static extern inline function getFirstSafe<T>(_this: Array<T>): Maybe<T>
		return if (_this.length != UInt.zero) Maybe.from(_this[UInt.zero]) else Maybe.none();

	/**
		@return The last element without checking if `this` is empty.
	**/
	public static extern inline function getLast<T>(_this: Array<T>): T
		return _this[_this.length - 1];

	/**
		@return The last element, or `Maybe.none()` if empty.
	**/
	public static extern inline function getLastSafe<T>(_this: Array<T>): Maybe<T> {
		final index = _this.length.minusOne();

		return if (index.isSome()) Maybe.from(_this[index.unwrap()]) else Maybe.none();
	}

	/**
		Alias for `getFirst()`.
	**/
	public static extern inline function peekFront<T>(_this: Array<T>): T
		return getFirst(_this);

	/**
		Alias for `getFirstSafe()`.
	**/
	public static extern inline function peekFrontSafe<T>(_this: Array<T>): Maybe<T>
		return getFirstSafe(_this);

	/**
		Alias for `getLast()`.
	**/
	public static extern inline function peek<T>(_this: Array<T>): T
		return getLast(_this);

	/**
		Alias for `getLastSafe()`.
	**/
	public static extern inline function peekSafe<T>(_this: Array<T>): Maybe<T>
		return getLastSafe(_this);

	/**
		Safely gets the element at `index`.
	**/
	public static inline function tryGet<T>(_this: Array<T>, index: UInt): Maybe<T>
		return Maybe.from(if (index < _this.length) _this[index] else null);

	/**
		Fills the array with `value` from `startIndex` to (but not including) `endIndex`.
		@return The filled array.
	**/
	public static inline function fillIn<T>(
		_this: Array<T>,
		value: T,
		startIndex: UInt,
		endIndex: UInt
	): Array<T> {
		#if sinker_debug
		if (endIndex > _this.length)
			throw new RangeError(ArrayErrorMsg.fillBounds(_this, startIndex, endIndex));
		#end

		var i = startIndex;
		while (i < endIndex) {
			_this[i] = value;
			++i;
		}

		return _this;
	}

	/**
		Fills the array with `value`.
		@return The filled array.
	**/
	public static extern inline function fill<T>(_this: Array<T>, value: T): Array<T> {
		return fillIn(_this, value, 0, _this.length);
	}

	/**
		Copies elements from source to destination index within a same array.
	**/
	public static inline function blitInternal<T>(
		_this: Array<T>,
		sourceIndex: UInt,
		destinationIndex: UInt,
		rangeLength: UInt
	): Void {
		#if sinker_debug
		if (sourceIndex + rangeLength > _this.length
			|| destinationIndex + rangeLength > _this.length) {
			throw new RangeError(ArrayErrorMsg.blitInternalBounds(
				_this,
				sourceIndex,
				destinationIndex,
				rangeLength
			));
		}
		#end

		#if cpp
		cpp.NativeArray.blit(
			_this,
			destinationIndex,
			_this,
			sourceIndex,
			rangeLength
		);
		#else
		if (sourceIndex < destinationIndex) {
			var i = sourceIndex + rangeLength;
			var k = destinationIndex + rangeLength;

			while (i > sourceIndex) {
				--i;
				--k;
				_this[k] = _this[i];
			}
		}
		else if (sourceIndex > destinationIndex) {
			var i = sourceIndex;
			var k = destinationIndex;
			final endI = sourceIndex + rangeLength;

			while (i < endI) {
				_this[k] = _this[i];
				++i;
				++k;
			}
		}
		#end
	}

	/**
		@return `true` if the array contains an element that is `element == value`.
	**/
	public static inline function has<T>(_this: Array<T>, value: T): Bool
		return _this.indexOf(value, 0).isSome();

	public static inline function hasIn<T>(
		_this: Array<T>,
		value: T,
		start: UInt,
		end: UInt
	): Bool {
		var found = false;

		for (i in start...end) {
			if (_this[u(i)] == value) {
				found = true;
				break;
			}
		}

		return found;
	}

	/**
		@return `true` if the array is not null and contains an element that is `element == value`.
	**/
	public static inline function existsAndHas<T>(_this: Null<Array<T>>, value: T): Bool
		return _this != null && has(_this, value);

	/**
		@return The first found element that is `element == value`.
	**/
	public static inline function find<T>(
		_this: Array<T>,
		value: T,
		defaultValue: T
	): T {
		final index = _this.indexOf(value, 0);
		return if (index.isSome()) _this[index.unwrap()] else defaultValue;
	}

	/**
		Swaps elements at `indexA` and `indexB`.
	**/
	public static inline function swap<T>(
		_this: Array<T>,
		indexA: UInt,
		indexB: UInt
	): Void {
		#if sinker_debug
		if (indexA >= _this.length || indexB >= _this.length)
			throw new RangeError(ArrayErrorMsg.swapBounds(_this, indexA, indexB));
		#end

		var tmp = _this[indexA];
		_this[indexA] = _this[indexB];
		_this[indexB] = tmp;
	}

	/**
		Compares elements of two arrays with `==` operator.
		@return `true` if all elements are equal (including the order).
	**/
	public static inline function equals<T>(_this: Array<T>, other: Array<T>): Bool {
		final len = _this.length;

		return if (other.length != len) false; else {
			var equal = true;

			var i = 0;
			while (i < len) {
				if (_this[i] == other[i]) {
					++i;
					continue;
				}

				equal = false;
				break;
			}

			equal;
		}
	}

	/**
		Compares two arrays with `compare` callback.
		@return `true` if all elements are equal (including the order).
	**/
	public static inline function compare<T>(
		_this: Array<T>,
		other: Array<T>,
		comparator: (a: T, b: T) -> Bool
	): Bool {
		final len = _this.length;

		return if (other.length != len) false; else {
			var foundDifference = false;

			var i = 0;
			while (i < len) {
				if (comparator(_this[i], other[i])) {
					++i;
					continue;
				}

				foundDifference = true;
				break;
			}

			!foundDifference;
		}
	}

	/**
		Pushes all elements in `other` to `this` array.
	**/
	public static inline function pushFromArray<T>(
		_this: Array<T>,
		other: Array<T>
	): Void {
		var writeIndex = _this.length;
		var readIndex = 0;

		final otherLength = other.length;
		_this.resize(writeIndex + otherLength);

		while (readIndex < otherLength) {
			_this[writeIndex] = other[readIndex];
			++writeIndex;
			++readIndex;
		}
	}

	/**
		Removes an element at `index`.
		@return Removed element.
	**/
	public static inline function removeAt<T>(_this: Array<T>, index: UInt): T {
		final arrayLength = _this.length;
		final rangeLength = arrayLength - index - 1;
		final removed = _this[index];

		blitInternal(_this, index + 1, index, rangeLength);
		_this.resize(arrayLength - 1);

		return removed;
	}

	/**
		Concatenates all arrays.
		@return New array.
	**/
	public static inline function flatten<T>(arrays: Array<Array<T>>): Array<T> {
		final arrayCount = arrays.length;
		var elementCount = 0;

		for (i in 0...arrayCount)
			elementCount += arrays[u(i)].length;

		final newArray = Arrays.allocate(elementCount);
		var i = 0;

		for (k in 0...arrayCount) {
			final array = arrays[u(k)];

			for (m in 0...array.length) {
				newArray[i] = array[u(m)];
				++i;
			}
		}

		return newArray;
	}

	/**
		Pushes `value` to `this` only if `this` does not have any element equal to `value`.
		@return `true` if pushed.
	**/
	public static inline function pushIfAbsent<T>(_this: Array<T>, value: T): Bool {
		if (has(_this, value)) return false;

		_this.push(value);
		return true;
	}

	/**
		Pushes `value` to `this` only if `this` does not have any element equal to `value`.
		@param equalityPredicate Function that returns `true` if two given elements
			should be considered as equal.
		@return `true` if pushed.
	**/
	public static inline function pushIfNotFound<T>(
		_this: Array<T>,
		value: T,
		equalityPredicate: (a: T, b: T) -> Bool
	): Bool {
		if (_this.hasEqual(value, equalityPredicate)) return false;

		_this.push(value);
		return true;
	}

	/**
		Deduplicates values of `this`.
		Elements with smaller indices have more priority.
		O(n^2) complexity (which is not very good).
		@param equalityPredicate Function that returns `true` if two given elements
			should be considered as equal.
	**/
	public static inline function deduplicate<T>(_this: Array<T>): Void {
		final length = _this.length;

		if (length > 0) {
			var writeIndex = 1;

			for (readIndex in 1...length) {
				final value = _this[u(readIndex)];
				var found = false;
				for (k in 0...writeIndex) {
					if (_this[u(k)] != value) continue;
					found = true;
					break;
				}
				if (found) continue;

				_this[writeIndex] = value;
				++writeIndex;
			}

			_this.resize(writeIndex);
		}
	}

	/**
		Copies `this` and also deduplicates values.
		Elements with smaller indices have more priority.
		O(n^2) complexity (which is not very good).
		@return New array with deduplicated values from `this`.
	**/
	public static inline function copyDeduplicated<T>(_this: Array<T>): Array<T> {
		final length = _this.length;

		return if (length == 0) _this.copy() else {
			final newArray = Arrays.allocate(length);

			newArray[0] = _this[0];
			var writeIndex = 1;

			for (readIndex in 1...length) {
				final value = _this[u(readIndex)];
				if (hasIn(newArray, value, 0, writeIndex)) continue;

				newArray[writeIndex] = value;
				++writeIndex;
			}

			newArray.resize(writeIndex);
			newArray;
		}
	}

	/**
		@return `this` in `Zero`/`One`/`More` representation.
	**/
	public static inline function cardinality<T>(_this: Array<T>) {
		return switch _this.length {
			case UInt.zero: Zero;
			case UInt.one: One(_this[UInt.zero]);
			default: More(_this);
		};
	}

	static extern inline function u(v: Int): UInt
		return new UInt(v);
}

/**
	`Zero`/`One`/`More` representation of values.
**/
enum Cardinality<T> {
	Zero;
	One(value: T);
	More(values: Array<T>);
}
