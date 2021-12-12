function NmsPaths(l, past, current, visited, secondTime = false)
    ret = 0
    vis = copy(visited)
    if current == "end"
        return 1
    end
    if all(c -> islowercase(c), current)
        push!(vis, current)
    end
    for i in l[current]
        if !(i in visited)
            ret += NmsPaths(l, current, i, vis, secondTime)
        elseif (i in visited) && secondTime && i != "end" && i != "start"
            ret += NmsPaths(l, current, i, vis, false)
        end
    end
    return ret
end
function task1()
    l = Dict()
    for line in readlines(ARGS[1])
        a, b = split(line, "-")
        a = string(a)
        b = string(b)
        if !haskey(l, a)
            l[a] = Vector{String}()
        end
        if !haskey(l, b)
            l[b] = Vector{String}()
        end
        push!(l[a], b)
        push!(l[b], a)
    end
    println(NmsPaths(l, "", "start", Set()))
end
function task2()
    l = Dict()
    for line in readlines(ARGS[1])
        a, b = split(line, "-")
        a = string(a)
        b = string(b)
        if !haskey(l, a)
            l[a] = Vector{String}()
        end
        if !haskey(l, b)
            l[b] = Vector{String}()
        end
        push!(l[a], b)
        push!(l[b], a)
    end
    println(NmsPaths(l, "", "start", Set(), true))
end
task2()