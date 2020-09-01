# sinker

Core utility library for Haxe.

**Requires Haxe 4** (developed with v4.1.1).


## Caveats

- Basically platform-independent, however the main target is Eval and HashLink.
- Not yet very well tested.
- Quite unstable!


## Usage

The below enables you to use all features of sinker.

```haxe
import sinker.*;
import sinker.globals.Globals.*;

using sinker.extensions.Index;
```

Note that some standard types (such as `Array`, `UInt`) will be shadowed with sinker types, which are not completely compatible (however you can still cast to the original types with casting methods).


## Types

### UInt

Unsigned integer based on `Int`.  
`#if sinker_debug` checks against negative, otherwise no runtime overhead.

### MaybeUInt

Represents either an `UInt` value or the absense of valid value.

### Array<T>

Abstract over standard `Array<T>` with several additional methods.  
Uses `UInt` for length/indices.  
`#if sinker_debug` does boundary checks when accessing elements.

### Maybe<T>

Abstract over standard `Null<T>` with stricter type cast control and some additional methods.  
`#if sinker_debug` checks against null when unwrapping.

### Option<T>

Abstract over standard `haxe.ds.Option<T>` with some additional methods.

### Result<T>

Enum, either `Ok(value: T)` or `Failed(message: String)`. Also has some additional methods.

## Utility classes

The classes below have static utility methods for each type.

- `Ints`
- `UInts`
- `Floats`
- `Arrays`
- `Nulls`


## Static extension classes

Methods for static extension on:

- `String`
- `Array<T>`

And some more additional methods for specific array types:

- `Null<Array<T>>`
- `Maybe<Array<T>>`
- `Array<() -> Void>`
- `Array<() -> Bool>`


## Compiler flags

|flag|description|
|---|---|
|sinker_debug|Enables bound checks for `UInt` values and `Array` indices, and `null` checks in `Maybe.unwrap()`. Automatically set if `--debug`.|


## Link

[FAL Haxe libraries](https://github.com/fal-works/fal-haxe-libraries)
