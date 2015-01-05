##
# Simple module for measuring distance between 2 strings
##
module Levenshtein
export levenshtein

function levenshtein(a::String, b::String)
    return levenshtein(a, b, 1)
end

function levenshtein(a::String, b::String, cost::Real)
    return levenshtein(a, b, cost, cost, cost)
end

function levenshtein(a::String, b::String, deletion_cost::Real, insertion_cost::Real, substitution_cost::Real)
    local costs::Array{Real, 2} = zeros(Real, length(a) + 1, length(b) + 1)
    # Initialize the deletion costs
    for i in 1:length(a)
        costs[i + 1,1] = i * deletion_cost
    end
    # Initialize the insertion costs
    for i in 1:length(b)
        costs[1, i + 1] = i * insertion_cost
    end

    local row = 2
    for r in a
        local col = 2
        for c in b
            local deletion::Real = costs[row - 1, col] + deletion_cost
            local insertion::Real = costs[row, col - 1] + insertion_cost
            local substitution::Real = costs[row - 1, col - 1] + (r == c ? 0 : substitution_cost)
            costs[row, col] = min(deletion, insertion, substitution)
            col += 1
        end
        row += 1
    end

    return costs[length(a) + 1, length(b) + 1]
end

end # module
