# LazySortedArray.jl

LazySortedArray for manage big sorted datasets with 100x speed. Optimizing on insertion and occasional read.

## Features

- **Lazy Sorting**: Delays sorting until necessary, reducing sorting overhead by around 10_000x (but increasing that one time operation time a little bit).
- **Threshold Management**: Excludes elements below a certain threshold, to optimize the speed even further.
- **Optimized Merging**: Efficiently merges unsorted lazy data into the sorted array.
- **Standardization**: tries to follow the standardized [DataStructures.jl](https://juliacollections.github.io/DataStructures.jl/latest/)

## Installation

```julia
import Pkg; Pkg.add(url="https://github.com/Cvikli/LazySortedArray.jl")
using LazySortedArray
```

## Usage

### Basic Operations

You can create a `LazySortedArray` instance in several ways:

```julia
lsa = LazySortedArray(Float64)                  # Specifying the type
lsa = LazySortedArray(Float64, 1000000, 10000)  # With specified main and sub-array sizes

push!(lsa, 10)     

element = lsa[1]   # Access an element (triggers sorting if necessary)
ensure_sorted(lsa) # unnecessary function as it will be always sorted when used!

println(lsa)
```

## Very simple package 
- [LazySortedArray.jl](https://github.com/Cvikli/LazySortedArrays.jl/blob/main/src/LazySortedArray.jl) is a ONE file pkg.

## License

`LazySortedArray` is released under the [MIT License](LICENSE).