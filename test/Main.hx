function main() {
	printRuntimeInfo();
	sinker.Main.main();
}

function printRuntimeInfo() {
	#if sys
	final now = Date.now();
	final target = #if interp "Eval" #elseif hl "HashLink" #elseif js "JavaScript" #else "unknown" #end;
	Sys.println('time:   $now');
	Sys.println('target: $target');
	#end
}
