package sinker.errors;

#if sinker_debug
class Errors {
	public static function uintFromInt(value: Int): String
		return 'Cannot cast to UInt. Invalid value: $value';

	public static function maybeUIntFromInt(value: Int): String
		return 'Cannot cast to MaybeUInt. Invalid value: $value';

	public static function maybeUIntUnwrap(): String
		return "Failed to unwrap. The value is not a valid UInt.";

	public static function maybeUnwrap(): String
		return "Failed to unwrap. Value is null.";

	public static function optionUnwrap(): String
		return "Failed to unwrap. Value is null.";
}
#end