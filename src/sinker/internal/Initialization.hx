package sinker.internal;

#if macro
import haxe.macro.Context;
import haxe.macro.Compiler;

class Initialization {
	/**
		Initialization macro for sinker.

		Sets compilation flag `sinker_debug` if it is not set and `debug` is set.
	**/
	public static function run() {
		final sinkerDebug: Null<String> = Context.definedValue("sinker_debug");

		if (sinkerDebug == null) {
			final debug: Null<String> = Context.definedValue("debug");

			if (debug != null && debug != "false" && Std.parseFloat(debug) != 0.0)
				Compiler.define("sinker_debug", "1");
		}
	}
}
#end
