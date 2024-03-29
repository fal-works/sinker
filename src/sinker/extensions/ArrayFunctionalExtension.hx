package sinker.extensions;

import sinker.Array;
import sinker.UInt;

using sinker.extensions.ArrayExtension;
using sinker.extensions.ArrayFunctionalExtension;

/**
	Functions for `Array` that take any other function as argument.
**/
class ArrayFunctionalExtension {
	/**
		Runs a given function for each element.
	**/
	public static inline function forEach<T>(_this: Array<T>, callback: T -> Void): Void {
		final len = _this.length;
		var i = UInt.zero;
		while (i < len) {
			callback(_this[i]);
			++i;
		}
	}

	/**
		Fills the entire array with values created from `factory`.
		@return `this`
	**/
	public static inline function populate<T>(
		_this: Array<T>,
		factory: Void -> T
	): Array<T> {
		final len = _this.length;
		var i = UInt.zero;
		while (i < len) {
			_this[i] = factory();
			++i;
		}

		return _this;
	}

	/**
		@return The index of the first found element that is `element == value`.
	**/
	public static inline function indexOfFirstIn<T>(
		_this: Array<T>,
		predicate: (element: T) -> Bool,
		start: UInt,
		end: UInt
	): MaybeUInt {
		var index = MaybeUInt.none;
		var i = start;
		while (i < end) {
			if (predicate(_this[i])) {
				index = i;
				break;
			}
			++i;
		}

		return index;
	}

	/**
		@return The index of the first found element that is `element == value`.
	**/
	public static inline function indexOfFirst<T>(
		_this: Array<T>,
		predicate: (element: T) -> Bool
	): MaybeUInt {
		return indexOfFirstIn(_this, predicate, UInt.zero, _this.length);
	}

	/**
		Checks if the array contains one or more elements that match to `predicate`.
		@param predicate Function that returns `true` if a given element meets the condition.
		@return `true` if found.
	**/
	public static inline function hasAny<T>(_this: Array<T>, predicate: T -> Bool): Bool {
		final len = _this.length;
		var found = false;
		var i = UInt.zero;
		while (i < len) {
			if (predicate(_this[i])) {
				found = true;
				break;
			}
			++i;
		}

		return found;
	}

	/**
		Checks if the array contains one or more elements that is equal to `value`,
		@param equalityPredicate Function that returns `true` if two given elements
			should be considered as equal.
		@return `true` if found.
	**/
	public static inline function hasEqualIn<T>(
		_this: Array<T>,
		value: T,
		equalityPredicate: T -> T -> Bool,
		start: UInt,
		end: UInt
	): Bool {
		var found = false;
		var i = start;
		while (i < end) {
			if (equalityPredicate(_this[i], value)) {
				found = true;
				break;
			}
			++i;
		}

		return found;
	}

	/**
		Checks if the array contains one or more elements that is equal to `value`,
		@param equalityPredicate Function that returns `true` if two given elements
			should be considered as equal.
		@return `true` if found.
	**/
	public static inline function hasEqual<T>(
		_this: Array<T>,
		value: T,
		equalityPredicate: T -> T -> Bool
	): Bool {
		return hasEqualIn(_this, value, equalityPredicate, UInt.zero, _this.length);
	}

	/**
		Finds the first occurrence of the element.
		@param predicate Function that returns `true` if a given element meets the condition.
		@return First element that matches to `predicate`. `defaultValue` if not found.
	**/
	public static inline function findFirst<T>(
		_this: Array<T>,
		predicate: T -> Bool,
		defaultValue: T
	): T {
		var found = defaultValue;

		final len = _this.length;
		var i = UInt.zero;
		var element: T;
		while (i < len) {
			element = _this[i];
			if (predicate(element)) {
				found = element;
				break;
			}
			++i;
		}

		return found;
	}

	/**
		Runs `processCallback` for the first occurrence of the element.
		@param predicate Function that returns `true` if a given element meets the condition.
		@param processCallback Function to run for the found element.
		@return `true` if found.
	**/
	public static inline function forFirst<T>(
		_this: Array<T>,
		predicate: T -> Bool,
		processCallback: T -> Void
	): Bool {
		var element: T;
		var found = false;

		final len = _this.length;
		var i = UInt.zero;
		while (i < len) {
			element = _this[i];
			if (predicate(element)) {
				processCallback(element);
				found = true;
				break;
			}

			++i;
		}

		return found;
	}

	/**
		Returns the first element that is successfully mapped by `tryMapCallback`.
		@param tryMapCallback Function that maps a given element and returns the result
		only if the element or the mapping result meets the condition.
	**/
	public static inline function mapFirst<T, S>(
		_this: Array<T>,
		tryMapCallback: T -> Maybe<S>
	): Maybe<S> {
		var found: Maybe<S> = Maybe.none();

		final len = _this.length;
		var i = UInt.zero;
		while (i < len) {
			final mapped = tryMapCallback(_this[i]);
			if (mapped.isSome()) {
				found = mapped;
				break;
			}

			++i;
		}

		return found;
	}

	/**
		Removes all elements that match `predicate`.
		@param predicate Function that returns `true` if a given element meets the condition.
		@return `true` if any removed.
	**/
	public static inline function removeAll<T>(
		_this: Array<T>,
		predicate: T -> Bool
	): Bool {
		final len = _this.length;
		var readIndex = UInt.zero;
		var writeIndex = UInt.zero;
		var found = false;
		while (readIndex < len) {
			final element = _this[readIndex];
			++readIndex;
			if (predicate(element)) {
				found = true;
				continue;
			}
			_this[writeIndex] = element;
			++writeIndex;
		}

		_this.resize(writeIndex);

		return found;
	}

	/**
		Removes the first occurrence of the element.
		@param predicate Function that returns `true` if a given element meets the condition.
		@return First element that matches to `predicate`. `defaultValue` if not found.
	**/
	public static inline function removeFirst<T>(
		_this: Array<T>,
		predicate: T -> Bool,
		defaultValue: T
	): T {
		var foundIndex = MaybeUInt.none;

		final len = _this.length;
		var i = UInt.zero;
		var element: T;
		while (i < len) {
			element = _this[i];
			if (predicate(element)) {
				foundIndex = i;
				break;
			}
			++i;
		}

		return if (foundIndex.isSome()) _this.removeAt(foundIndex.unwrap()) else defaultValue;
	}

	/**
		Runs `processCallback` for each occurrence of the matching element.
		@param predicate Function that returns `true` if a given element meets the condition.
		@param processCallback Function to run for the found elements.
		@return `true` if any found.
	**/
	public static inline function filterForEach<T>(
		_this: Array<T>,
		predicate: T -> Bool,
		processCallback: T -> Void
	): Bool {
		var element: T;
		var found = false;

		final len = _this.length;
		var i = UInt.zero;
		while (i < len) {
			element = _this[i];
			if (predicate(element)) {
				processCallback(element);
				found = true;
			}
			++i;
		}

		return found;
	}

	/**
		Filters and maps `this` array at once.
		@param predicate Function that returns `true` if a given element meets the condition.
		@param tryMapCallback Function that maps a given element and returns the result
		only if the element or the mapping result meets the condition.
		@return New array of elements that have been successfully mapped.
	**/
	public static inline function filterMap<T, S>(
		_this: Array<T>,
		tryMapCallback: T -> Maybe<S>
	): Array<S> {
		var newArray: Array<S> = [];

		final len = _this.length;
		var i = UInt.zero;
		while (i < len) {
			final mapped = tryMapCallback(_this[i]);
			if (mapped.isSome()) newArray.push(mapped.unwrap());
			++i;
		}

		return newArray;
	}

	/**
		Deduplicates values of `this`.
		Elements with smaller indices have more priority.
		O(n^2) complexity (which is not very good).
		@param equalityPredicate Function that returns `true` if two given elements
			should be considered as equal.
	**/
	public static inline function deduplicateWith<T>(
		_this: Array<T>,
		equalityPredicate: T -> T -> Bool
	): Void {
		final length = _this.length;

		if (length > 0) {
			var writeIndex = 1;

			for (readIndex in 1...length) {
				final value = _this[readIndex];
				var found = false;
				for (k in 0...writeIndex) {
					if (!equalityPredicate(_this[k], value)) continue;
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
		@param equalityPredicate Function that returns `true` if two given elements
			should be considered as equal.
		@return New array with deduplicated values from `this`.
	**/
	public static inline function copyDeduplicatedWith<T>(
		_this: Array<T>,
		equalityPredicate: T -> T -> Bool
	): Array<T> {
		final length = _this.length;

		return if (length == 0) _this.copy() else {
			final newArray = Arrays.allocate(length);

			newArray[0] = _this[0];
			var writeIndex = 1;

			for (readIndex in 1...length) {
				final value = _this[readIndex];
				if (newArray.hasEqualIn(
					value,
					equalityPredicate,
					0,
					writeIndex
				)) continue;

				newArray[writeIndex] = value;
				++writeIndex;
			}

			newArray.resize(writeIndex);
			newArray;
		}
	}
}
