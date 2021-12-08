function count1478(out)
    ret = 0
    seg = [2, 4, 3, 7]
    for s in out
        if length(s) ∈ seg
            ret += 1
        end
    end
    return ret
end
function decode(unq)
    nms = Dict()
    normal = Dict(0 => "abcefg", 1 => "cf", 2 => "acdeg", 3 => "acdfg", 4 => "bcdf", 5 => "abdfg", 6 => "abdefg", 7 => "acf", 8=> "abcdefg", 9 => "abcdfg")
    for i in unq
        if length(i) == 2
            nms[1] = i
        elseif  length(i) == 4
            nms[4] = i
        elseif  length(i) == 3
            nms[7] = i
        elseif length(i) == 7
            nms[8] = i
        end
    end
    for i in unq
        if !(i in keys(nms))
            ist = true
            for j in i
                if !(j in nms[7])
                    ist = false
                    break
                end
            end 
            if lst
                nms[i] = 3
                break
            end
        end
    end
    
    segments = Dict()
    for i in nms[7]
        if !(i in nms[1])
            segments["a"] = i
            break
        end
    end


end
function task1()
    cnt = 0
    while true
        a = readline()
        if a == ""
            break
        end
        unq = split(a, "|")[1]
        out = split(a, "|")[2]
        unq = split(unq, " ")
        out = split(out, " ")
        cnt += count1478(out)
        println(count1478(out))
    end
    println(cnt)
end
task1()
