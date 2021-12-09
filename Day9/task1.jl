
function getNbrs(map, x, y)
    moves = [(1, 0), (-1, 0), (0, -1), (0, 1)]
    ret = []
    for m in moves
        if 0 < (y + m[1]) && (y + m[1]) <= length(map)
            if 0 < (x + m[2]) && (x + m[2]) <= length(map[y])
                push!(ret, map[(y+m[1])][(x+m[2])])
            end
        end
    end
    return ret
end
function getNbrsPlcs(map, x, y)
    moves = [(1, 0), (-1, 0), (0, -1), (0, 1)]
    ret = []
    for m in moves
        if 0 < (y + m[1]) && (y + m[1]) <= length(map)
            if 0 < (x + m[2]) && (x + m[2]) <= length(map[y])
                push!(ret, (map[(y+m[1])][(x+m[2])], ((x + m[2]), (y + m[1]))))
            end
        end
    end
    return ret
end
function CoutBasin(map, x, y)
    q = Vector()
    done = Vector()
    push!(q, (x, y))
    while length(q) > 0
        ele = popfirst!(q)
        if !(ele in done)
            push!(done, ele)
            for i in getNbrsPlcs(map, ele[1], ele[2])
                if i[1] != 9 && i[1] > map[ele[2]][ele[1]]
                    push!(q, i[2])
                end
            end
        end
    end
    return length(done)
end
function task1()
    map = []
    while true
        a = readline()
        if a == ""
            break
        end
        b = Vector{Int64}()
        for i in a
            push!(b, parse(Int64, i))
        end
        push!(map, b)
    end
    cnt = 0
    for y = 1:length(map)
        for x = 1:length(map[y])
            if all(getNbrs(map, x, y) .> map[y][x])
                cnt += map[y][x] + 1
                #println(map[y][x])
                #println(getNbrs(map, x, y))
            end
        end
    end
    println(cnt)
end
function task2()
    map = []
    while true
        a = readline()
        if a == ""
            break
        end
        b = Vector{Int64}()
        for i in a
            push!(b, parse(Int64, i))
        end
        push!(map, b)
    end
    lowPoints = []
    for y = 1:length(map)
        for x = 1:length(map[y])
            if all(getNbrs(map, x, y) .> map[y][x])
                push!(lowPoints, (x, y))
            end
        end
    end
    sizes = []
    for i in lowPoints
        push!(sizes, CoutBasin(map, i[1], i[2]))
    end
    sort!(sizes, rev = true)
    println(sizes[1] * sizes[2] * sizes[3])
end
task2()