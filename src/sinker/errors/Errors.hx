package sinker.errors;

/**
	Functions for generating error messages.
**/
class Errors {
	#if sinker_debug
	public static function uintFromInt(value: Int): String
		return 'Cannot cast to UInt. Invalid value: $value';

	public static function maybeUIntFromInt(value: Int): String
		return 'Cannot cast to MaybeUInt. Invalid value: $value';

	public static function maybeUIntUnwrap(): String
		return "Failed to unwrap. The value is not a valid UInt.";

	public static function maybeUnwrap(): String
		return "Failed to unwrap. Value is null.";
	#end

	public static function emptyString(): String
		return "Invalid operation. String is empty.";

	public static function optionUnwrap(): String
		return "Failed to unwrap. Value is null.";
}
