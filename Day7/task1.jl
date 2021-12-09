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
    normal = Dict(0 => "abcefg", 1 => "cf", 2 => "acdeg", 3 => "acdfg", 4 => "bcdf", 5 => "abdfg", 6 => "abdefg", 7 => "acf", 8 => "abcdefg", 9 => "abcdfg")
    for i in unq
        if length(i) == 2
            nms[1] = string(sort([u for u in i])...)
            nms[string(sort([u for u in i])...)] = 1
        elseif length(i) == 4
            nms[4] = string(sort([u for u in i])...)
            nms[string(sort([u for u in i])...)] = 4
        elseif length(i) == 3
            nms[7] = string(sort([u for u in i])...)
            nms[string(sort([u for u in i])...)] = 7
        elseif length(i) == 7
            nms[8] = string(sort([u for u in i])...)
            nms[string(sort([u for u in i])...)] = 8
        end
    end
    for i in unq
        if !(string(sort([u for u in i])...) in keys(nms)) && length(i) == 5
            lst = true
            println(i)
            for j in nms[7]
                if !(j in i)
                    lst = false
                    break
                end
            end
            if lst
                nms[string(sort([u for u in i])...)] = 3
                nms[3] = string(sort([u for u in i])...)
                break
            end
        end
    end
    for i in unq
        if !(string(sort([u for u in i])...) in keys(nms)) && length(i) == 6
            lst = true
            for j in nms[3]
                if !(j in i)
                    lst = false
                    break
                end
            end
            for j in nms[4]
                if !(j in i)
                    lst = false
                    break
                end
            end
            if lst
                nms[string(sort([u for u in i])...)] = 9
                nms[9] = string(sort([u for u in i])...)
                break
            end
        end
    end
    println(nms)
    segments = Dict()
    for i in nms[7]
        if !(i in nms[1])
            segments["a"] = i
            break
        end
    end
    for i in nms[8]
        if !(i in nms[9])
            segments["e"] = i
            break
        end
    end
    for i in unq
        if !(string(sort([u for u in i])...) in keys(nms)) && length(i) == 5
            if segments["e"] in i
                nms[string(sort([u for u in i])...)] = 2
                nms[2] = string(sort([u for u in i])...)
            else
                nms[string(sort([u for u in i])...)] = 5
                nms[5] = string(sort([u for u in i])...)
            end
        end
    end
    for i in unq
        if !(string(sort([u for u in i])...) in keys(nms)) && length(i) == 6
            lst = true
            for j in i
                if !(j in nms[5])
                    lst = false
                    break
                end
            end
            if !lst
                nms[string(sort([u for u in i])...)] = 6
                nms[6] = string(sort([u for u in i])...)
            else
                nms[string(sort([u for u in i])...)] = 0
                nms[0] = string(sort([u for u in i])...)
            end
        end
    end
    return nms
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
        unq = filter((i) -> i != " ", split(unq, " "))
        out = filter((i) -> i != " ", split(out, " "))
        cnt += count1478(out)
        println(count1478(out))
    end
    println(cnt)
end
function task2()
    cnt = 0
    while true
        a = readline()
        if a == ""
            break
        end
        unq = split(a, "|")[1]
        out = split(a, "|")[2]
        unq = filter((i) -> i != "", split(unq, " "))
        out = filter((i) -> i != "", split(out, " "))
        nms = decode(unq)
        #println(nms)
        outx = 0
        for i in out
            outx *= 10
            outx += nms[string(sort([u for u in i])...)]
        end
        println(outx)
        cnt += outx
    end
    println(cnt)
end
task2()
