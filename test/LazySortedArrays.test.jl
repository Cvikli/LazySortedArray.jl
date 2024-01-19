
lsa=LazySortedArray(Float32)

push!(lsa, 10)
push!(lsa, 7)
push!(lsa, 7)
push!(lsa, 7)

# Accessing elements (this will trigger sorting and merging)
println(lsa.sorted_arr[1:6]) 
println(lsa.lazy_arr[1:4]) 
println(lsa.threshold) 
println(length(lsa)) 
println(lsa) 


