# Levenshtein

[![Build Status](https://travis-ci.org/rawrgrr/Levenshtein.jl.svg?branch=master)](https://travis-ci.org/rawrgrr/Levenshtein.jl)
[![Coverage Status](https://coveralls.io/repos/rawrgrr/Levenshtein.jl/badge.svg)](https://coveralls.io/r/rawrgrr/Levenshtein.jl)


Levenshtein distance between two strings in [julia](http://julialang.org/)

This module provides a simple, but generic implementation of the Levenshtein distance function.

## Installation
```julia
Pkg.add("Levenshtein")
```

## Usage
Standard Levenshtein distance
```julia
levenshtein("polynomial", "exponential")
```

Levenshtein distance with custom insertion, deletion, substitution costs
```julia
ins = 3
del = 2
sub = 1
levenshtein("polynomial", "exponential", ins, del, sub)
```
