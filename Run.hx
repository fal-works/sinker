class Run {
	static function main() {
		#if (sys || hxnodejs)
		final libraryName: String = "sinker";
		final version = haxe.macro.Compiler.getDefine("sinker");

		final url = 'https://lib.haxe.org/p/${libraryName}/';

		Sys.println('\n${libraryName} ${version}\n${url}\n');
		#end
	}
}
