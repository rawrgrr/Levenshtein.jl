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

    if length(a) < length(b)
        # Space complexity of function = O(length(b))
        return levenshtein(b, a, deletion_cost, insertion_cost, substitution_cost)
    else
        if length(a) == 0
            return length(b)
        elseif length(b) == 0
            return length(a)
        else
            local oldRow::Array{Real, 1} = zeros(Real, length(b) + 1)
            local newRow::Array{Real, 1} = zeros(Real, length(b) + 1)

            # Initialize the old row for empty a and i characters in b
            oldRow[1] = 0
            for i in 1:length(b)
                oldRow[i + 1] = i * deletion_cost
            end

            i = 0
            for r in a
                i += 1

                # Delete i characters from a to get empty b
                newRow[1] = i * deletion_cost

                j = 0
                for c in b
                    j += 1

                    local deletion::Real = oldRow[j + 1] + deletion_cost
                    local insertion::Real = newRow[j] + insertion_cost
                    local substitution::Real = oldRow[j] + (r == c ? 0 : substitution_cost)

                    newRow[j + 1] = min(deletion, insertion, substitution)
                end

                for k in 1:(length(b) + 1)
                    oldRow[k] = newRow[k]
                end
            end

            return newRow[length(b) + 1]
        end
    end
end

end # module
