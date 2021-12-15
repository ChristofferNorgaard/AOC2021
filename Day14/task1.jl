count_char(s) = begin
    res = Dict{Char, Int}()
    for c in s
        if haskey(res, c)
           res[c] += 1
        else
           res[c] = 1
        end
     end
  end
function count_variChar(vari)
    res= Dict{Char, Int}()
    for k in keys(vari)
        for c in k
            if haskey(res, c)
                res[c] += vari[k]
            else
                res[c] = vari[k]
            end
        end
    end
    return res
end
function GrowPoly(ind, inserts, levels, mem)
    if  !haskey(mem, (levels, ind))
        if levels == 0
            return ind[1] * inserts[ind]
        end
        if length(ind) == 2
            ins = ind[1] * inserts[ind] * ind[2]
        else
            ins = ind
        end
        nins = ""
        for i in 2:length(ins)
            if haskey(inserts, ins[i-1:i])
                nins *= string(GrowPoly(ins[i-1:i], inserts, levels-1, mem))
            else
                nins *= string(ins[i-1])
            end
        end
        #nins *= ins[length(ins)]
        if levels < 10
            mem[(levels, ind)] = nins
        else
            return nins
        end
    end
    return mem[(levels, ind)]
end

function task1()
    file = readlines(ARGS[1])
    inserts = Dict()
    seq = file[1]
    for i in 3:length(file)
        key, val = split(file[i], " -> ")
        inserts[key] = val
    end
    println(seq)
    mem = Dict()
    seq = GrowPoly(seq, inserts, 30, mem) * seq[length(seq)]
    #println(seq)
    vls = [x for x in values(count_char(seq))]
    println(maximum(vls) - minimum(vls))
end
function task1()
    file = readlines(ARGS[1])
    inserts = Dict()
    seq = file[1]
    for i in 3:length(file)
        key, val = split(file[i], " -> ")
        inserts[key] = val
    end
    vari = Dict()
    for a in "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for b in "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            vari[string(a)*string(b)] = 0
        end
    end
    for i in 2:length(seq)
        vari[seq[i-1:i]] += 1
    end
    for s in 1:40
        nvari = copy(vari)
        for k in keys(vari)
            if haskey(inserts, k)
                nvari[k] = 0
            end
        end
        for k in keys(vari)
            if haskey(inserts, k)
                nvari[string(k[1])*inserts[k]] += vari[k]
                nvari[inserts[k]*string(k[2])] += vari[k]
            end
        end
        vari = nvari
    end
    #println(seq)
    vrls = count_variChar(vari)
    vrls[seq[1]] += 1
    vrls[seq[length(seq)]] += 1
    vls = [convert(Int64, x/2) for x in values(vrls)]
    vls = vls[vls .!= 0]
    println(vls)
    println(maximum(vls) - minimum(vls))
end
task1()