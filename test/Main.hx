import sinker.*;
import sinker.globals.Globals.*;

using sinker.extensions.Index;

class Main {
	static function test(shouldBeTrue: Bool): Void {
		if (!shouldBeTrue) throw "Test failed.";
	}

	static function main() {
		test(10.divideBy(2) == 5);
		test(10.modulo(3) == 1);
		test(uint(3).powerOf2() == 8);
		test(3.square() == 9);
		test((-3).absolute() == 3);

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

		trace('Passed all cases.');
	}
}
