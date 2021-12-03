
function sOne(num::Int64, pos::Int64)
    return (num & (2^(pos))) != (2^(pos))
end
function mostCoommon(ele,pos, bias)
    c = 0
    for i in ele
        c += sOne(i, pos)
    end
    println(c)
    if (convert(Int64, length(ele)) - c) == c
        return bias
    else 
        return (convert(Int64, length(ele))-c) < c
    end    
end
function getMost(vec, nmlen, bias)
    for i in (nmlen-1):-1:0
        println(vec)
        vec2 = Vector{Int64}()
        mst = mostCoommon(vec, i, false)
        if !bias
            mst = !mst
        end
        println(mst)
        for j in vec
            if sOne(j, i) == mst
                push!(vec2, j)
            end
        end
        vec = copy(vec2)
        if length(vec2) == 1
            return vec2[1]
        end
    end
end
function task2()
    vec = Vector{Int64}()
    nmlen::Int64 = 0
    while true
        a = readline()
        if a == ""
            break
        end
        a = parse(Int64, a, base=2)
        if ceil(log2(a)) > nmlen
            nmlen = ceil(log2(a))
        end
        push!(vec, a)
    end
    println(nmlen)
    veca = copy(vec)
    a = getMost(veca, nmlen, true)
    veca = copy(vec)
    b = getMost(veca, nmlen, false)
    println(a*b)
end




function task1()
    commonBits = zeros(Int64,20)
    println(commonBits)
    println(commonBits[1])
    println(typeof(commonBits[1]))
    all = 0
    while true
        a = readline()
        if a == ""
            break
        end
        a = parse(Int64, a)
        all += 1
        for i in 1:20
            b = a % 10
            a = floor(a/10)
            commonBits[i] = commonBits[i] + b
        end
    end
    gamma = 0
    epsilon = 0
    for i in 1:20
        ad = convert(Int64, (all-commonBits[i]) < (commonBits[i]))
        println(ad)
        gamma += ad*2^(i-1)
    end
    one = false
    for i in 20:-1:1
        if commonBits[i] > 0
            one = true
        end
        if one
            ad = convert(Int64, !((all-commonBits[i]) < (commonBits[i])))
            epsilon += ad*2^(i-1)
        end
    end 
    println(gamma) 
    println(epsilon)
    println(gamma*epsilon)
end
#task1()
task2()