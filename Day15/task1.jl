function Naigbors(map, y, x)
    moves = [(1, 0), (-1, 0), (0, -1), (0, 1)]
    ret = []
    for m in moves
        if 0 < (y + m[1]) && (y + m[1]) <= length(map)
            if 0 < (x + m[2]) && (x + m[2]) <= length(map[y])
                push!(ret, ((y + m[1]), (x + m[2])))
            end
        end
    end
    return ret
end
function task1()
    m = Vector{Vector{Int64}}()
    w = Vector{Vector{Int64}}()
    for l in readlines(ARGS[1])
        push!(m, Vector{Int64}([parse(Int64, x) for x in split(l, "")]))
        push!(w, Vector{Int64}([typemax(Int64) for x in split(l, "")]))
    end
    w[1][1] = 0
    m[1][1] = 0
    q = []
    d = Set()
    push!(q, (1, 1))
    while length(q) > 0
        e = popfirst!(q)
        for i in Naigbors(w, e[1], e[2])
            #println(i)
            if (w[e[1]][e[2]] + m[e[1]][e[2]]) < w[i[1]][i[2]]
                w[i[1]][i[2]] = w[e[1]][e[2]] + m[e[1]][e[2]]
                push!(q, i)
            end
        end
    end
    w[length(w)][length(w[1])] += m[length(w)][length(w[1])]
    #display(w)
    println(w[length(w)][length(w[1])])
end
function task2()
    m = Vector{Vector{Int64}}()
    mi = Vector{Vector{Int64}}()
    w = Vector{Vector{Int64}}()
    wi = Vector{Vector{Int64}}()
    for l in readlines(ARGS[1])
        push!(m, Vector{Int64}([parse(Int64, x) for x in split(l, "")]))
        push!(w, Vector{Int64}([typemax(Int64) for x in split(l, "")]))
    end
    for l in 1:length(m)*5
        push!(mi, Vector{Int64}([0 for x in 1:length(m[1])*5]))
        push!(wi, Vector{Int64}([typemax(Int64) for x in 1:length(m[1])*5]))
    end
    for x in 1:length(m)
        for y in 1:length(m[1])
            mi[x][y] = m[x][y]
        end
    end
    for i in 1:4
        for x in 1:length(m)
            for y in 1:length(m[1])
                mi[i*length(m) + x][y] = mi[(i-1)*length(m) + x][y] + 1
                if mi[i*length(m) + x][y] > 9
                    mi[i*length(m) + x][y] = 1
                end
            end
        end
    end
    for i in 1:4
        for x in 1:length(mi)
            for y in 1:length(m[1])
                mi[x][(i)*length(m[1]) + y] = mi[x][y + (i-1)*length(m[1])] + 1
                if mi[x][(i)*length(m[1])+y] > 9
                    mi[x][(i)*length(m[1])+y] = 1
                end
            end
        end
    end
    m = mi
    #display(mi)
    w =wi
    w[1][1] = 0
    m[1][1] = 0
    q = []
    d = Set()
    push!(q, (1, 1))
    while length(q) > 0
        e = popfirst!(q)
        for i in Naigbors(w, e[1], e[2])
            #println(i)
            
            if (w[e[1]][e[2]] + m[e[1]][e[2]]) < w[i[1]][i[2]]
                w[i[1]][i[2]] = w[e[1]][e[2]] + m[e[1]][e[2]]
                push!(q, i)
            end
        end
    end
    w[length(w)][length(w[1])] += m[length(w)][length(w[1])]
    #display(w)
    println(w[length(w)][length(w[1])])
end
task2()