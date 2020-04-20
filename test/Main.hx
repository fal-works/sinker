import sinker.*;
import sinker.globals.Globals.*;

using sinker.extensions.Index;

class Main {
	static function test(shouldBeTrue: Bool): Void {
		if (!shouldBeTrue) throw "Test failed.";
	}

	static function main() {
		test((10 : Int).divideBy(2) == 5);
		test((10 : Int).modulo(3) == 1);
		test(uint(3).powerOf2() == 8);
		test((3 : Int).square() == 9);
		test((-3 : Int).absolute() == 3);

		test(Floats.toInt(1.5) == 1);

		test(Maybe.from(10).isSome());
		test(Option.some(1).isSome());

		final a: Array<Int> = [
			1,
			2,
			3
		];
		test(a.length == 3);
		var sum = 0;
		a.forEach(value -> sum += value);
		test(sum == 6);

		trace('Passed all cases.');
	}
}
