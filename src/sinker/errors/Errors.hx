package sinker.errors;

#if sinker_debug
class Errors {
	public static function uintFromInt(value: Int): String
		return 'Failed to cast value to UInt: $value';
}
#end
