package sinker.internal;

#if sinker_debug
/**
	Functions for generating error messages related to `Array`.
**/
class ArrayErrors {
	public static function index(array: Array<Dynamic>, index: UInt): String
		return 'Index $index is out of bounds. Array length: ${array.length}';

	public static function blitSame(): String
		return "Failed to blit. Source and destination cannot be the same.";

	public static function blitBounds(
		source: Array<Dynamic>,
		sourceIndex: UInt,
		destination: Array<Dynamic>,
		destinationIndex: UInt,
		rangeLength: UInt
	): String {
		final message = new StringBuf();
		message.add('Failed to blit. Out of bounds.');
		message.add('\nSource length: ');
		message.add(source.length);
		message.add(', index: ');
		message.add(sourceIndex);
		message.add('\nDestination length: ');
		message.add(destination.length);
		message.add(', index: ');
		message.add(destinationIndex);
		message.add('\nRange length: ');
		message.add(rangeLength);

		return message.toString();
	}

	public static function blitZeroBounds(
		source: Array<Dynamic>,
		destination: Array<Dynamic>,
		rangeLength: UInt
	): String {
		final message = new StringBuf();
		message.add('Failed to blit. Out of bounds.');
		message.add('\nSource length: ');
		message.add(source.length);
		message.add('\nDestination length: ');
		message.add(destination.length);
		message.add('\nRange length: ');
		message.add(rangeLength);

		return message.toString();
	}

	public static function fillBounds(
		array: Array<Dynamic>,
		startIndex: UInt,
		endIndex: UInt
	): String {
		final message = new StringBuf();
		message.add('Failed to fill. Out of bounds.');
		message.add('\nArray length: ');
		message.add(array.length);
		message.add('\nStart index: ');
		message.add(startIndex);
		message.add('\nEnd index: ');
		message.add(endIndex);

		return message.toString();
	}

	public static function blitInternalBounds(
		array: Array<Dynamic>,
		sourceIndex: UInt,
		destinationIndex: UInt,
		rangeLength: UInt
	): String {
		final message = new StringBuf();
		message.add('Failed to blit. Out of bounds.');
		message.add('\nArray length: ');
		message.add(array.length);
		message.add('\nSource index: ');
		message.add(sourceIndex);
		message.add('\nDestination index: ');
		message.add(destinationIndex);
		message.add('\nRange length: ');
		message.add(rangeLength);

		return message.toString();
	}

	public static function swapBounds(
		array: Array<Dynamic>,
		indexA: UInt,
		indexB: UInt
	): String {
		final message = new StringBuf();
		message.add('Failed to swap. Out of bounds.');
		message.add('\nArray length: ');
		message.add(array.length);
		message.add('\nIndex A: ');
		message.add(indexA);
		message.add('\nIndex B: ');
		message.add(indexB);

		return message.toString();
	}
}
#end
