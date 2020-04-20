package sinker.extensions;

import sinker.*;

using sinker.extensions.ArrayExtension;
using sinker.extensions.ArrayFunctionalExtension;

/**
	Functions for `Array` that take any other function as argument.
**/
class ArrayFunctionalExtension {
	/**
		Runs a given function for each element.
	**/
	public static inline function forEach<T>(
		_this: Array<T>,
		callback: T->Void
	): Void {
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
		factory: Void->T
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
	public static inline function indexOfFirst<T>(
		_this: Array<T>,
		predicate: (element: T) -> Bool
	): Int {
		final len = _this.length;
		var index = UInt.none;
		var i = UInt.zero;
		while (i < len) {
			if (predicate(_this[i])) {
				index = i;
				break;
			}
			++i;
		}

		return index;
	}

	/**
		Checks if the array contains one or more elements that match to `predicate`.
		@param predicate Function that returns `true` if a given element meets the condition.
		@return `true` if found.
	**/
	public static inline function hasAny<T>(
		_this: Array<T>,
		predicate: T->Bool
	): Bool {
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
		equalityPredicate: T->T->Bool,
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
		equalityPredicate: T->T->Bool
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
		predicate: T->Bool,
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
		predicate: T->Bool,
		processCallback: T->Void
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
		Removes the first occurrence of the element.
		@param predicate Function that returns `true` if a given element meets the condition.
		@return First element that matches to `predicate`. `defaultValue` if not found.
	**/
	public static inline function removeFirst<T>(
		_this: Array<T>,
		predicate: T->Bool,
		defaultValue: T
	): T {
		var foundIndex = UInt.none;

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

		return if (foundIndex >= 0) _this.removeAt(foundIndex) else defaultValue;
	}

	/**
		Runs `processCallback` for each occurrence of the matching element.
		@param predicate Function that returns `true` if a given element meets the condition.
		@param processCallback Function to run for the found elements.
		@return `true` if any found.
	**/
	public static inline function filterForEach<T>(
		_this: Array<T>,
		predicate: T->Bool,
		processCallback: T->Void
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
		Deduplicates values of `this`.
		Elements with smaller indices have more priority.
		O(n^2) complexity (which is not very good).
		@param equalityPredicate Function that returns `true` if two given elements
			should be considered as equal.
	**/
	public static inline function deduplicateWith<T>(
		_this: Array<T>,
		equalityPredicate: T->T->Bool
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
		equalityPredicate: T->T->Bool
	): Array<T> {
		final length = _this.length;

		return if (length == 0) _this.copy() else {
			final newArray = ArrayTools.allocate(length);

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
