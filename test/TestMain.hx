function main() {
	printRuntimeInfo();
	sinker.Test.run();
}

function printRuntimeInfo() {
	#if (sys || hxnodejs)
	final now = Date.now();
	final target = #if interp "Eval" #elseif hl "HashLink" #elseif js "JavaScript" #else "unknown" #end;
	Sys.println('datetime: $now');
	Sys.println('target:   $target');
	#end
}
