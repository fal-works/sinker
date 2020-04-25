package sinker;

/**
	Type that represents either success (`Ok`) or failure (`Failed`).
**/
@:using(sinker.Result.ResultExtension)
enum Result<T> {
	Ok(value: T);
	Failed(message: String);
}

class ResultExtension {
	/**
		@return `true` if `this` is `Ok`.
	**/
	public static extern inline function isOk<T>(_this: Result<T>): Bool {
		return switch _this {
			case Ok(_): true;
			case Failed(_): false;
		}
	}

	/**
		@return `true` if `this` is `Failed`.
	**/
	public static extern inline function isFailed<T>(_this: Result<T>): Bool
		return !isOk(_this);

	/**
		@return The value if `Ok`. Throws error message if `Failed`.
	**/
	public static extern inline function unwrap<T>(_this: Result<T>): T {
		return switch _this {
			case Ok(value): value;
			case Failed(message): throw message;
		}
	}
}
