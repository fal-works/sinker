package sinker;

class ArrayTools {
	/**
		@return New array with length `size`.
	**/
	public static extern inline function allocate<T>(size: UInt): StrictArray<T> {
		#if cpp
		return cpp.NativeArray.create(size);
		#else
		final newArray: StrictArray<T> = [];
		newArray.resize(size);
		return newArray;
		#end
	}

	/**
		Copies elements from `source` to `destination`.

		If `source` and `destination` are the same, use `blitInternal()` instead.
	**/
	public inline static function blit<T>(
		source: StrictArray<T>,
		sourcePosition: UInt,
		destination: StrictArray<T>,
		destinationPosition: UInt,
		rangeLength: UInt
	): Void {
		#if debug
		if (source == destination)
			throw "Failed to blit because source and destination are the same.";
		if (sourcePosition + rangeLength > source.length) throw "Invalid values.";
		if (destinationPosition + rangeLength > destination.length) throw "Invalid values.";
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
		source: StrictArray<T>,
		destination: StrictArray<T>,
		rangeLength: UInt
	): Void {
		#if debug
		if (source == destination)
			throw "Failed to blit because source and destination are the same.";
		if (rangeLength > source.length) throw "Invalid values.";
		if (rangeLength > destination.length) throw "Invalid values.";
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
}
