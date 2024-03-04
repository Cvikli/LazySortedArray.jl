module LazySortedArray

# chatgpt: 
#####
# 1. 
# Not enough good. Create the LazySortedArrayStruct with two separate array: "sorted_data" and "lazy_data", to have a "limit" of data they keep track of. Also please exclude the newly inserted data if the data is not above certain threshold. Also please don't forget to merge. Also please add comments on how could you optimize it more.
# 
# # It answered pretty well... so It spared some time for me.
#
#####
# 2. 
# Then, optimize it further as you described:
#
# Further Optimization Potential:
#
# Concurrent Processing: For large datasets, the sorting and merging processes could be parallelized to improve performance.
# Efficient Merging Algorithm: Currently, the merge function resorts the entire data set after merging. An optimized merging algorithm could be implemented to merge two sorted arrays more efficiently.
# Caching Mechanism: Implementing a caching mechanism for read operations could improve performance, especially if read operations are frequent and the array isn't modified between reads.
# 
# # The concurrent process was all about concurrent sorting, which isn't good as each thread has to sort its own sorted array.
# # The merging was a basic merge... The Caching was an unnecessary variable where he kept the values... 
# 
######

abstract type LazySortedContainer end

@kwdef  mutable struct LazySortedArrayStruct{T} <: LazySortedContainer
	sorted_arr::Vector{T}
	sptr::Int
	threshold::T
	lazy_arr::Vector{T}
	lptr::Int
end

LazySortedArrayStruct(data::Vector{T}) where T    = LazySortedArrayStruct{T}(data, length(data), minimum(data, init=nextfloat(typemin(T))), Vector{T}(undef,max(10,optimal_subsize(length(data)))), 0)
LazySortedArrayStruct(T::Type)                    = LazySortedArrayStruct{T}(zeros(T,1_000_000), 0, nextfloat(typemin(T)), Vector{T}(undef,10_000), 0)
LazySortedArrayStruct(T::Type, mainsize::Int)          = LazySortedArrayStruct{T}(zeros(T,mainsize),  0, nextfloat(typemin(T)), Vector{T}(undef,optimal_subsize(mainsize)), 0)
LazySortedArrayStruct(T::Type, mainsize::Int, subsize::Int) = LazySortedArrayStruct{T}(zeros(T,mainsize),  0, nextfloat(typemin(T)), Vector{T}(undef,subsize), 0)
optimal_subsize(mainsize) = cld(mainsize,10)

laziness_factor(lsa) = (length(lsa.sorted_arr)/length(lsa.lazy_arr))
is_sorted(lsa::LazySortedContainer)                         = lsa.lptr==0
whole_length(lsa::LazySortedArrayStruct{T}) where T               = length(lsa.sorted_arr)
Base.length(lsa::LazySortedArrayStruct{T})  where T               = (ensure_sorted(lsa); return lsa.sptr)
Base.getindex(lsa::LazySortedArrayStruct{T}, index::Int) where T  = (ensure_sorted(lsa); return lsa.sorted_arr[index])
Base.empty!(lsa::LazySortedContainer)           = (lsa.sptr=0;lsa.lptr=0)
Base.pop!(lsa::LazySortedContainer)             = (ensure_sorted(lsa); lsa.sptr -= 1)
Base.delete!(lsa::LazySortedContainer, st)      = throw(ArgumentError("Delete operation not supported yet... you can implement and send a PR"))
Base.push!(lsa::LazySortedContainer, st)        = insert!(lsa, st) 
Base.insert!(lsa::LazySortedArrayStruct{T}, st::T; threshold=lsa.threshold) where T = if st >= threshold 
	lsa.lptr >= length(lsa.lazy_arr) && ensure_sorted(lsa)
 	lsa.lazy_arr[lsa.lptr+=1] = st
end
evaluate(lsa) = ensure_sorted(lsa)
ensure_sorted(lsa::LazySortedContainer) = if !is_sorted(lsa)
	if lsa.lptr<length(lsa.lazy_arr)
		lsort=sort!(lsa.lazy_arr[1:lsa.lptr], rev=true)
		merge!(lsa, lsort)
	else
		sort!(lsa.lazy_arr, rev=true)
		merge!(lsa)
	end
	lsa.lptr=0 # empty!(lsa.lazy_data)
end
Base.merge!(lsa::LazySortedArrayStruct{T}, lsort=lsa.lazy_arr) where T = begin
	N = whole_length(lsa)
	s, l, m = lsa.sorted_arr, lsort, Vector{T}(undef,N)
	i, j, k = 1, 1, 0
	while k < N && i <= lsa.sptr && j <= lsa.lptr
			if s[i] > l[j]
				m[k += 1] = s[i] 
				i += 1
			else
				m[k += 1] = l[j] 
				j += 1
			end
	end
	while k < N && j <= lsa.lptr
		m[k += 1] = l[j]
		j+=1 
	end
	lsa.sorted_arr = m
	lsa.sptr       = k
	lsa.threshold  = m[lsa.sptr]
end
Base.show(io::IO, lsa::LazySortedArrayStruct{T}) where T = (evaluate(lsa); println(io,"min=$(lsa.threshold) arr=$(lsa.sorted_arr[1:min(50,length(lsa))])$(length(lsa)>50 ? "..." : "")"))





end # module LazySortedArrayStruct
