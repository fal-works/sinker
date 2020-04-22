package sinker;

/**
	Utility for `Array`.
**/
class Arrays {
	/**
		@return New array with length `size`.
	**/
	public static extern inline function allocate<T>(size: UInt): Array<T> {
		#if cpp
		return cpp.NativeArray.create(size);
		#else
		final newArray = new Array<T>();
		newArray.resize(size);
		return newArray;
		#end
	}

	/**
		Copies elements from `source` to `destination`.

		If `source` and `destination` are the same, use `blitInternal()` instead.
	**/
	public inline static function blit<T>(
		source: Array<T>,
		sourcePosition: UInt,
		destination: Array<T>,
		destinationPosition: UInt,
		rangeLength: UInt
	): Void {
		#if sinker_debug
		if (source == destination)
			throw "Failed to blit. Source and destination cannot be the same.";
		if (sourcePosition + rangeLength > source.length
			|| destinationPosition + rangeLength > destination.length)
			throw blitBoundsError(source, sourcePosition, destination, destinationPosition, rangeLength);
		#end

		#if cpp
		cpp.NativeArray.blit(
			destination,
			destinationPosition,
			source,
			sourcePosition,
			rangeLength
		);
		#else
		for (i in UInt.zero...rangeLength)
			destination[destinationPosition + i] = source[sourcePosition + i];
		#end
	}

	/**
		Copies elements from source to destination beginning at index zero.
	**/
	public static inline function blitZero<T>(
		source: Array<T>,
		destination: Array<T>,
		rangeLength: UInt
	): Void {
		#if sinker_debug
		if (source == destination)
			throw "Failed to blit. Source and destination cannot be the same.";
		if (rangeLength > source.length || rangeLength > destination.length)
			throw blitZeroBoundsError(source, destination, rangeLength);
		#end

		#if cpp
		cpp.NativeArray.blit(destination, 0, source, 0, rangeLength);
		#else
		var i = UInt.zero;
		while (i < rangeLength) {
			destination[i] = source[i];
			++i;
		}
		#end
	}

	#if sinker_debug
	static function blitBoundsError(
		source: Array<Dynamic>,
		sourcePosition: UInt,
		destination: Array<Dynamic>,
		destinationPosition: UInt,
		rangeLength: UInt
	): String {
		final message = new StringBuf();
		message.add('Failed to blit. Out of bounds.');
		message.add('\nSource length: ');
		message.add(source.length);
		message.add(', position: ');
		message.add(sourcePosition);
		message.add('\nDestination length: ');
		message.add(destination.length);
		message.add(', position: ');
		message.add(destinationPosition);
		message.add('\nRange length: ');
		message.add(rangeLength);

		return message.toString();
	}

	static function blitZeroBoundsError(
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
	#end
}
