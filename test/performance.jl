
using Levenshtein

function randString(len)
    return string([Char(round(Int,rand() * 255 + 1)) for _ in 1:len]...)
end

function run_huge_string(l1, l2)
    # setup long string against short one to expose element copy performance
    s = randString(l1)
    t = randString(l2)
    ins, del, sub = rand() * 1000, rand() * 1000, rand() * 1000

    # run a long string against a not so long one
    println("\nRunning $l1-char String against $l2-char String")
    @time levenshtein(s, t, ins, del, sub)
end

function run_multiple_times(l1, l2, runs)
    # setup
    s = randString(l1)
    t = randString(l2)
    ins, del, sub = rand() * 1000, rand() * 1000, rand() * 1000
    costs = Array{Float64}(2, max(length(s), length(t)) + 1)

    # run without reusing cost matrix
    println("\nRunning $runs runs without reusing cost matrix for $l1-char String vs $l2-char String")
    @time for i in 1:runs
        levenshtein(s, t, ins, del, sub)
    end

    # run without allocating cost matrix everytime
    println("\nRunning $runs runs with resuable cost matrix for $l1-char String vs $l2-char String")
    @time for i in 1:runs
        levenshtein!(s, t, ins, del, sub, costs)
    end
end

run_huge_string(10^7, 10^2)
run_huge_string(10^6, 10^3)
run_huge_string(10^5, 10^4)
run_multiple_times(10^3, 10^3, 10^3)
run_multiple_times(10^2, 10^2, 10^5)
run_multiple_times(10^1, 10^1, 10^7)
