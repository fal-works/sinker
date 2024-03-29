package sinker;

#if sinker_debug
import sinker.errors.RangeError;
import sinker.internal.ArrayErrorMsg;
#end

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
		final newArray: Array<T> = [];
		newArray.resize(size);
		return newArray;
		#end
	}

	/**
		Copies elements from `source` to `destination`.

		If `source` and `destination` are the same, use `blitInternal()` instead.
	**/
	public static inline function blit<T>(
		source: Array<T>,
		sourcePosition: UInt,
		destination: Array<T>,
		destinationPosition: UInt,
		rangeLength: UInt
	): Void {
		#if sinker_debug
		if (source == destination)
			throw new Error(ArrayErrorMsg.blitSame());
		if (sourcePosition + rangeLength > source.length
			|| destinationPosition + rangeLength > destination.length) {
			throw new RangeError(ArrayErrorMsg.blitBounds(
				source,
				sourcePosition,
				destination,
				destinationPosition,
				rangeLength
			));
		}
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
			throw new Error(ArrayErrorMsg.blitSame());
		if (rangeLength > source.length || rangeLength > destination.length) {
			throw new RangeError(ArrayErrorMsg.blitZeroBounds(
				source,
				destination,
				rangeLength
			));
		}
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
