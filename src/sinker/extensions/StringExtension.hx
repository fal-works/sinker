package sinker.extensions;

import sinker.internal.Errors;

using sinker.extensions.StringExtension;

/**
	Static extension for `String`.
**/
class StringExtension {
	static final dot: String = ".";
	static final slash: String = "/";

	/**
		Similar to `indexOf()` but returns the index in `MaybeUInt` representation.
	**/
	public static extern inline function getIndexOf(
		s: String,
		searchString: String,
		?startIndex: Int
	): MaybeUInt {
		return MaybeUInt.fromInt(s.indexOf(searchString, startIndex));
	}

	/**
		Similar to `lastIndexOf()` but returns the index in `MaybeUInt` representation.
	**/
	public static extern inline function getLastIndexOf(
		s: String,
		searchString: String,
		?startIndex: Int
	): MaybeUInt {
		#if js
		// In JavaScript, s.lastIndexOf(searchString, null) returns -1
		return MaybeUInt.fromInt(if (startIndex != null) s.lastIndexOf(
			searchString,
			startIndex
		) else s.lastIndexOf(searchString));
		#else
		return MaybeUInt.fromInt(s.lastIndexOf(searchString, startIndex));
		#end
	}

	/**
		@return The first index of dot (`.`). `-1` if not found.
	**/
	public static extern inline function getIndexOfDot(
		s: String,
		?startIndex: Int
	): MaybeUInt
		return s.getIndexOf(dot, startIndex);

	/**
		@return The first index of slash (`/`). `-1` if not found.
	**/
	public static extern inline function getIndexOfSlash(
		s: String,
		?startIndex: Int
	): MaybeUInt
		return s.getIndexOf(slash, startIndex);

	/**
		@return The last index of dot (`.`). `-1` if not found.
	**/
	public static extern inline function getLastIndexOfDot(
		s: String,
		?startIndex: Int
	): MaybeUInt
		return s.getLastIndexOf(dot, startIndex);

	/**
		@return The last index of slash (`/`). `-1` if not found.
	**/
	public static extern inline function getLastIndexOfSlash(
		s: String,
		?startIndex: Int
	): MaybeUInt
		return s.getLastIndexOf(slash, startIndex);

	/**
		@return Sub-string after the last occurrence of dot (`.`).
	**/
	public static inline function sliceAfterLastDot(s: String): String
		return s.substr(s.getLastIndexOfDot().int() + 1);

	/**
		@return Sub-string after the last occurrence of slash (`/`).
	**/
	public static inline function sliceAfterLastSlash(s: String): String
		return s.substr(s.getLastIndexOfSlash().int() + 1);

	/**
		@return Sub-string before the last occurrence of dot (`.`).
	**/
	public static inline function sliceBeforeLastDot(s: String): String {
		final length = s.getLastIndexOfDot();
		return if (length.isSome()) s.substr(0, length.unwrap()); else s;
	}

	/**
		@return Sub-string before the last occurrence of slash (`/`).
	**/
	public static inline function sliceBeforeLastSlash(s: String): String {
		final length = s.getLastIndexOfSlash();
		return if (length.isSome()) s.substr(0, length.unwrap()); else s;
	}

	/**
		@return A string where the first character is changed to upper case.
	**/
	@:deprecated
	public static inline function camelToPascal(s: String): String {
		return switch (s.length) {
			case 0: s;
			case 1: s.toUpperCase();
			default: s.charAt(0).toUpperCase() + s.substr(1);
		}
	}

	/**
		@return A string where the first character is changed to lower case.
	**/
	@:deprecated
	public static inline function pascalToCamel(s: String): String {
		return switch (s.length) {
			case 0: s;
			case 1: s.toLowerCase();
			default: s.charAt(0).toLowerCase() + s.substr(1);
		}
	}

	/**
		@return Character code of the first character.
		@throws `Error` if the string is empty.
	**/
	@:deprecated
	public static inline function firstCharCode(s: String): Int {
		final charCode = s.charCodeAt(0);
		if (charCode == null) throw new Error(Errors.emptyString());
		else return charCode;
	}

	/**
		@return Character code of the last character.
		@throws `Error` if the string is empty.
	**/
	@:deprecated
	public static inline function lastCharCode(s: String): Int {
		final charCode = s.charCodeAt(s.length - 1);
		if (charCode == null) throw new Error(Errors.emptyString());
		else return charCode;
	}
}
