package sinker;

import sinker.*;
import sinker.globals.Globals.*;

using sinker.extensions.Index;

function run() {
	#if sinker_debug
	trace("Found compilation flag: sinker_debug");
	#end

	test(Ints.divide(10, 2) == 5);
	test(Ints.modulo(10, 3) == 1);
	test(UInts.powerOf2(uint(3)) == 8);
	test(Ints.square(3) == 9);
	test(Ints.absolute(-3) == 3);

	test(Floats.toInt(1.5) == 1);

	test(Maybe.from(10).isSome());
	test(Maybe.from(42) == 42);

	test(Options.some(1).isSome());

	final array: Array<Int> = [
		1,
		2,
		3
	];
	test(array.length == 3);
	var arraySum = 0;
	array.forEach(value -> arraySum += value);
	test(arraySum == 6);

	test("abc".getIndexOf("c") == 2);
	test("aaa.bbb".getIndexOfDot() == 3);
	test("aaa.bbb".sliceAfterLastDot() == "bbb");

	trace('Passed all cases.');
}

function test(shouldBeTrue: Bool): Void {
	if (!shouldBeTrue) throw "Test failed.";
}
