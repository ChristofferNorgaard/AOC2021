using Statistics
function firstIncorect(seq)
    stac = []
    vls = Dict("(" => ")", "[" => "]", "{" => "}", "<" => ">")
    for i in seq
        i = string(i)
        println(seq)
        println(keys(vls))
        if haskey(vls, i)
            push!(stac, i)
        else
            if length(stac) == 0
                return i
            elseif vls[pop!(stac)] != i
                return i
            end
        end
    end
    return ""
end
function completeScore(seq)
    stac = []
    vls = Dict("(" => ")", "[" => "]", "{" => "}", "<" => ">")
    vk = Dict(")" => 1, "]" => 2, "}" => 3, ">" => 4)
    for i in seq
        i = string(i)
        println(seq)
        println(keys(vls))
        if haskey(vls, i)
            push!(stac, i)
        else
            if length(stac) == 0
                return -1
            elseif vls[pop!(stac)] != i
                return -1
            end
        end
    end
    scr = 0
    while length(stac) > 0
        scr *= 5
        scr += vk[vls[pop!(stac)]]
    end
    return scr
end
function task1()
    values = Dict(")" => 3, "]" => 57, "}" => 1197, ">" => 25137, "" => 0)
    cnt = 0
    while true
        a = readline()
        if a == ""
            break
        end
        b = firstIncorect(a)
        println(b)
        cnt += values[b]
    end
    println(cnt)
end
function task2()
    values = Dict(")" => 3, "]" => 57, "}" => 1197, ">" => 25137, "" => 0)
    cnt = 0
    values = []
    while true
        a = readline()
        if a == ""
            break
        end
        scr = completeScore(a)
        println(scr)
        if scr != -1
            push!(values, scr)
        end
    end
    println(convert(Int64, median(values)))
end
task2()