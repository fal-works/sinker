import sinker.Imports;
import sinker.Globals.*;

using sinker.Usings;

class Main {
	static function test(shouldBeTrue: Bool): Void {
		if (!shouldBeTrue) throw "Failed.";
	}

	static function main() {
		test((10: Int).divideBy(2) == 5);
		test((10: Int).modulo(3) == 1);
		test(uint(3).powerOf2() == 8);
		test((3: Int).square() == 9);
		test((-3: Int).absolute() == 3);

		test((1.5).toInt() == 1);

		test(Maybe.from(10).isSome());
		test(Option.some(1).isSome());

		final a: Array<Int> = [1];
		test(a.length == 1);

		trace('Passed all cases.');
	}
}
