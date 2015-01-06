using Levenshtein
using Base.Test

# write your own tests here
# Tests checked with http://www.kurzhals.info/static/samples/levenshtein_distance/
@test 1 == 1
@test 4 == levenshtein("Hi, my name is", "my name is")
@test 21 == levenshtein("%^@!^@#^@#!! Snoooooooop", "Dro!p it!!!! like it's hot")
@test 7 == levenshtein("Alborgów", "amoniak")

