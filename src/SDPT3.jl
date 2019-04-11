module SDPT3

using SparseArrays
using MATLAB

export sdpt3

#function dim(c::Char, n::Float64)
#    if c == 's'
#        return div(n * (n + 1), 2)
#    else
#        return n
#    end
#end

# TODO log in objective, OPTION, initial iterates X0, y0, Z0
# Solve the primal/dual pair
# min c'x,      max b'y
# s.t. Ax = b,   c - A'x ∈ K
#       x ∈ K
function sdpt3(blk::Matrix,
               At::Vector{<:Union{Matrix{Float64}, SparseMatrixCSC{Float64}}},
               C::Vector{Vector{Float64}}, b::Vector{Float64})
    @assert all(i -> size(At[i], 2) == length(b), 1:length(At))
    #@assert all(i -> size(A[i], 1) == dim(blk[i, 1], blk[i, 2]), 1:length(A))
    #@assert all(i -> length(C[i], 1) == dim(blk[i, 1], blk[i, 2]), 1:length(A))
    # There are 6 output arguments so we use `6` below
    obj, X, y, Z, info, runhist = mxcall(:sdpt3, 6, blk, At, C, b)
    return obj, X, y, Z, info, runhist
end

end # module
