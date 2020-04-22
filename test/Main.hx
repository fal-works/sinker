import sinker.*;
import sinker.globals.Globals.*;

using sinker.extensions.Index;

class Main {
	static function test(shouldBeTrue: Bool): Void {
		if (!shouldBeTrue) throw "Test failed.";
	}

	static function main() {
		test(Ints.divide(10, 2) == 5);
		test(Ints.modulo(10, 3) == 1);
		test(UInts.powerOf2(uint(3)) == 8);
		test(Ints.square(3) == 9);
		test(Ints.absolute(-3) == 3);

		test(Floats.toInt(1.5) == 1);

		test(Maybe.from(10).isSome());
		test(Option.some(1).isSome());

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
}
