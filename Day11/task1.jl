function Naigbors(map, y, x)
    moves = [(1, 0), (-1, 0), (0, -1), (0, 1), (1, 1), (-1, 1), (1, -1), (-1, -1)]
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
function NofFlash(oct::Vector{Vector{Int64}}, steps::Int64)
    cnt = 0
    for d = 1:steps
        for i = 1:length(oct)
            for j = 1:length(oct[i])
                oct[i][j] = oct[i][j] + 1
            end
        end
        flsh = Vector{Vector{Bool}}()
        for i in oct
            push!(flsh, zeros(Bool, length(i)))
        end
        for i = 1:length(oct)
            for j = 1:length(oct[i])
                if oct[i][j] > 9 && !flsh[i][j]
                    q = Vector{}()
                    push!(q, (i, j))
                    while length(q) > 0
                        ele = popfirst!(q)
                        if !flsh[ele[1]][ele[2]] && oct[ele[1]][ele[2]] > 9
                            flsh[ele[1]][ele[2]] = true
                            oct[ele[1]][ele[2]] = 0
                            cnt += 1
                            for nbr in Naigbors(oct, ele[1], ele[2])
                                if !flsh[nbr[1]][nbr[2]]
                                    oct[nbr[1]][nbr[2]] += 1
                                    push!(q, nbr)
                                end
                            end
                        end
                    end
                end
            end
        end
        println(oct)
    end
    return cnt
end
function AllFlash(oct::Vector{Vector{Int64}}, steps::Int64)
    cnt = 0
    for d = 1:steps
        for i = 1:length(oct)
            for j = 1:length(oct[i])
                oct[i][j] = oct[i][j] + 1
            end
        end
        flsh = Vector{Vector{Bool}}()
        for i in oct
            push!(flsh, zeros(Bool, length(i)))
        end
        for i = 1:length(oct)
            for j = 1:length(oct[i])
                if oct[i][j] > 9 && !flsh[i][j]
                    q = Vector{}()
                    push!(q, (i, j))
                    while length(q) > 0
                        ele = popfirst!(q)
                        if !flsh[ele[1]][ele[2]] && oct[ele[1]][ele[2]] > 9
                            flsh[ele[1]][ele[2]] = true
                            oct[ele[1]][ele[2]] = 0
                            cnt += 1
                            for nbr in Naigbors(oct, ele[1], ele[2])
                                if !flsh[nbr[1]][nbr[2]]
                                    oct[nbr[1]][nbr[2]] += 1
                                    push!(q, nbr)
                                end
                            end
                        end
                    end
                end
            end
        end
        if all(x -> all(x), flsh)
            return d
        end
    end
    return cnt
end
function task1()
    oct = Vector{Vector{Int64}}()
    for line in readlines(ARGS[1])
        l = Vector{Int64}()
        for i in line
            push!(l, parse(Int64, i))
        end
        push!(oct, l)
    end
    println(NofFlash(oct, 100))
end
function task2()
    oct = Vector{Vector{Int64}}()
    for line in readlines(ARGS[1])
        l = Vector{Int64}()
        for i in line
            push!(l, parse(Int64, i))
        end
        push!(oct, l)
    end
    println(AllFlash(oct, 10000))
end
task2()