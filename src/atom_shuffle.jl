using Combinatorics
using Permutations
using Random
include("initialize.jl")
include("structs.jl")
"""
shuffle_atoms(Backpack::Backpack, perms::Int)

This function creates 'perms' permutations of a given supercell.
"""
function shuffle_atoms(Backpack::Backpack, perms::Int)
    seq = sequence(Backpack)
    unique_perms = Array{Any}(undef, perms, length(seq)[1])
    unique_perms[1, :] = seq
    i = 1
    while i < perms
        current_sequence = shuffle(seq)
        v = 0
        for j = 1:i
            if current_sequence == unique_perms[j]
                v += 1
                break
            end
        end
        if v == 0
            i += 1
            unique_perms[i, :] = current_sequence
        end
    end
    return unique_perms
end

"""
sequence(X::Backpack)

A simple help function for creating all permutations.
"""
function sequence(X::Backpack)
    seq = []
    for (idx, val) in enumerate(X.element_dict)
        for i = 1:val[2][2]
            push!(seq, val[2][1])
        end
    end
    return seq
end

"""
all_permutations(x::T, prefix=T())

Generates all permutations of a given vector.
"""
function all_permutations(x::T, prefix=T()) where T
    if length(x) == 1
        return [[prefix; x]]
    else
        t = T[]
        for i in eachindex(x)
            if i > firstindex(x) && x[i] == x[i-1]
                continue
            end
            append!(t, all_permutations([x[begin:i-1];x[i+1:end]], [prefix; x[i]]))
        end
        return t
    end
end
