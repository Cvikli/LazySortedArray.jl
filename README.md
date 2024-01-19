# LazySortedArray.jl

LazySortedArray for manage big sorted datasets with 100x speed. Optimizing on insertion and occasional read.

## Features

- **Lazy Sorting**: Delays sorting until necessary, reducing sorting overhead by around 10_000x.
- **Threshold Management**: Excludes elements below a certain threshold, to optimize the speed even further.
- **Optimized Merging**: Efficiently merges unsorted lazy data into the sorted array.
- **Standardization**: tries to follow the standardized [DataStructures.jl](https://juliacollections.github.io/DataStructures.jl/latest/)

## Installation

```julia
import Pkg; Pkg.add(url="https://github.com/Cvikli/LazySortedArray.jl")
using LazySortedArray
```

## Usage

### Creating a LazySortedArray

You can create a `LazySortedArray` instance in several ways:

```julia
# Specifying the type
lsa = LazySortedArray(Float64)

# With specified main and sub-array sizes
lsa = LazySortedArray(Float64, 1000000, 10000)
```

### Basic Operations

```julia
# Insert an element
push!(lsa, 10)

# Access an element (triggers sorting if necessary)
element = lsa[1]

# Sort and merge the data
evaluate(lsa)

# Display array information
println(lsa)
```

## License

`LazySortedArray` is released under the [MIT License](LICENSE).