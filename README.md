# Levenshtein

[![Build Status](https://travis-ci.org/rawrgrr/Levenshtein.jl.svg?branch=master)](https://travis-ci.org/rawrgrr/Levenshtein.jl)
[![Coverage Status](https://coveralls.io/repos/rawrgrr/Levenshtein.jl/badge.svg?branch=master)](https://coveralls.io/r/rawrgrr/Levenshtein.jl)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/rawrgrr/Levenshtein.jl/master/LICENSE.md)


Levenshtein distance between two strings in [julia](http://julialang.org/)

This module provides a simple, but generic implementation of the Levenshtein distance function.

## Installation
```julia
julia> Pkg.add("Levenshtein")
```

## Usage
Standard Levenshtein distance
```julia
julia> levenshtein("polynomial", "exponential")
6
```

Levenshtein distance with custom insertion, deletion, substitution costs
```julia
julia> ins, del, sub = 3, 2, 1
(3,2,1)

julia> levenshtein("polynomial", "exponential", ins, del, sub)
8
```
