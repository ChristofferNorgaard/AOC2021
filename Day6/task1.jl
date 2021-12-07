function minFuel(Crabs)
    rres = 1000000000
    for j in minimum(Crabs):maximum(Crabs)
        res = 0
        for i in Crabs
            for i in 1:abs(j - i)
                res += i
            end
        end
        rres = min(rres, res)
    end
    return rres
end
function task1()
    a = readline()
    strs = split(a, ",")
    crabs = Vector{Int64}()
    for s in strs
        push!(crabs, parse(Int64, s))
    end
    println(minFuel(crabs))
end
task1()