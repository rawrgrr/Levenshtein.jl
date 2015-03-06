using Levenshtein
using Base.Test

# write your own tests here
# Tests checked with http://www.kurzhals.info/static/samples/levenshtein_distance/
@test 1 == 1
@test 4 == levenshtein("Hi, my name is", "my name is")
@test 21 == levenshtein("%^@!^@#^@#!! Snoooooooop", "Dro!p it!!!! like it's hot")
@test 7 == levenshtein("Alborgów", "amoniak")

@test 3 == levenshtein("sitting", "kitten")
@test 0 == levenshtein("sitting", "kitten", 1, 0, 0)
@test 0 == levenshtein("sitting", "kitten", 0, 1, 0)
@test 0 == levenshtein("sitting", "kitten", 0, 0, 1)
@test 5 == levenshtein("sitting", "kitten", 1, 1, Inf)
@test 5 == levenshtein("sitting", "kitten", 1, 1, Inf)
@test 6 == levenshtein("sitting", "kitten", 10, 1, 1)

@test levenshtein("a", "ab", 1, 2, 0) == levenshtein("ab", "a", 2, 1, 0)
