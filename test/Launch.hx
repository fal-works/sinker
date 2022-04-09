final testHxmlDir = "hxml/test";

/**
	Invokes `haxe` command and runs test.
**/
function main() {
	final args = processArguments(Sys.args());
	Sys.println('haxe ${args.join(" ")}');
	Sys.command("haxe", args);
}

function processArguments(args: Array<String>):Array<String> {
	final target = sanitizeTarget(args[0]);
	return ['$testHxmlDir/$target.hxml'].concat(args.slice(1));
}

function sanitizeTarget(arg: Null<String>): String {
	return switch arg {
		case null | "": "eval";
		case "interp": "eval";
		case "hl": "hl-jit";
		case s: s;
	}
}
