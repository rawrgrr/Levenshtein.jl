
##
# Simple module for measuring distance between 2 strings
##
module Levenshtein
export levenshtein
function levenshtein(a::String, b::String)
return levenshtein(a, b, 1)
end
function levenshtein(a::String, b::String, cost::Real)
return levenshtein(a, b, 1, 1, 1)
end
function levenshtein(a::String, b::String, deletion_cost::Real, insertion_cost::Real, substitution_cost::Real)
local costs::Array{Real, 2} = zeros(Real, sizeof(a) + 1, sizeof(b) + 1)
# Initialize the deletion costs
for i in 1:sizeof(a)
costs[i + 1,1] = i * deletion_cost
end
# Initialize the insertion costs
for i in 1:sizeof(b)
costs[1, i + 1] = i * insertion_cost
end
for row in 2:sizeof(a) + 1
for col in 2:sizeof(b) + 1
local deletion::Real = costs[row - 1, col] + deletion_cost
local insertion::Real = costs[row, col - 1] + insertion_cost
local substitution::Real = costs[row - 1, col - 1] + (a[row - 1] == b[col - 1] ? 0 : substitution_cost)
costs[row, col] = min(deletion, insertion, substitution)
end
end
return costs[sizeof(a) + 1, sizeof(b) + 1]
end

end # module
