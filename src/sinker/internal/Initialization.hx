package sinker.internal;

#if macro
import haxe.macro.Compiler;

class Initialization {
	/**
		Initialization macro for sinker.

		Sets compilation flag `sinker_debug` if it is not set and `debug` is set.
	**/
	public static function run() {
		#if (debug && !sinker_debug)
		Compiler.define("sinker_debug", "1");
		#end
	}
}
#end
