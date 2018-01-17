
using Levenshtein
using Base.Test

function levenshtein_base(a::AbstractString, b::AbstractString, deletion_cost::Real, insertion_cost::Real, substitution_cost::Real)
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

# Testing base implementation
# Tests checked with http://www.kurzhals.info/static/samples/levenshtein_distance/
@test 4 == levenshtein_base("Hi, my name is", "my name is", 1, 1, 1)
@test 21 == levenshtein_base("%^@!^@#^@#!! Snoooooooop", "Dro!p it!!!! like it's hot", 1, 1, 1)
@test 7 == levenshtein_base("Alborgów", "amoniak", 1, 1, 1)

@test 3 == levenshtein_base("sitting", "kitten", 1, 1, 1)
@test 1 == levenshtein_base("sitting", "kitten", 1, 0, 0)
@test 0 == levenshtein_base("sitting", "kitten", 0, 1, 0)
@test 0 == levenshtein_base("sitting", "kitten", 0, 0, 1)
@test 5 == levenshtein_base("sitting", "kitten", 1, 1, Inf)
@test 12 == levenshtein_base("sitting", "kitten", 10, 1, 1)

# write your own tests here
@test 4 == levenshtein("Hi, my name is", "my name is")
@test 21 == levenshtein("%^@!^@#^@#!! Snoooooooop", "Dro!p it!!!! like it's hot")
@test 7 == levenshtein("Alborgów", "amoniak")

@test 3 == levenshtein("sitting", "kitten")
@test 1 == levenshtein("sitting", "kitten", 1, 0, 0)
@test 0 == levenshtein("sitting", "kitten", 0, 1, 0)
@test 0 == levenshtein("sitting", "kitten", 0, 0, 1)
@test 5 == levenshtein("sitting", "kitten", 1, 1, Inf)
@test 12 == levenshtein("sitting", "kitten", 10, 1, 1)

@test levenshtein("a", "ab", 1, 2, 0) == levenshtein("ab", "a", 2, 1, 0)

@test levenshtein("a", "", 10, 0, 0) == 10
@test levenshtein("", "a", 0, 10, 0) == 10

for i in 1:100
    s = randstring(floor(Int,rand() * 100))
    t = randstring(floor(Int,rand() * 100))
    ins, del, sub = rand() * 1000, rand() * 1000, rand() * 1000

    calculated, truth = levenshtein(s, t, del, ins, sub), levenshtein_base(s, t, del, ins, sub)

    if calculated != truth
        println("s = $s, t = $t, ins = $ins, del = $del, sub = $sub, calculated = $calculated, truth = $truth")
    end

    @test abs(calculated - truth) < 1e-9
end
