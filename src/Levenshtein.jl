##
# Simple module for measuring distance between 2 strings
##
module Levenshtein
export levenshtein

function levenshtein(source::String, target::String)
    return levenshtein(source, target, 1)
end

function levenshtein(source::String, target::String, cost::Real)
    return levenshtein(source, target, cost, cost, cost)
end

function levenshtein(source::String, target::String, deletion_cost::Real, insertion_cost::Real, substitution_cost::Real)
    if length(source) < length(target)
        # Space complexity of function = O(length(target))
        return levenshtein(target, source, insertion_cost, deletion_cost, substitution_cost)
    else
        if length(source) == 0
            return length(target) * insertion_cost
        elseif length(target) == 0
            return length(source) * deletion_cost
        else
            local oldRow::Array{Real, 1} = zeros(Real, length(target) + 1)
            local newRow::Array{Real, 1} = zeros(Real, length(target) + 1)

            # Initialize the old row for empty source and i characters in target
            oldRow[1] = 0
            for i in 1:length(target)
                oldRow[i + 1] = i * insertion_cost
            end

            i = 0
            for r in source 
                i += 1

                # Delete i characters from source to get empty target
                newRow[1] = i * deletion_cost

                j = 0
                for c in target 
                    j += 1

                    local deletion::Real = oldRow[j + 1] + deletion_cost
                    local insertion::Real = newRow[j] + insertion_cost
                    local substitution::Real = oldRow[j] + (r == c ? 0 : substitution_cost)

                    newRow[j + 1] = min(deletion, insertion, substitution)
                end

                for k in 1:(length(target) + 1)
                    oldRow[k] = newRow[k]
                end
            end

            return newRow[length(target) + 1]
        end
    end
end

end # module
