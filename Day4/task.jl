function BoardWon(brd, xsize, ysize)
    #vrstice
    for x = 0:(xsize-1)
        won = true
        for y = 1:ysize
            won = (won && (brd[(x*ysize+y)]))
        end
        if won
            return won
        end
    end
    #stolpci
    for x = 1:(xsize)
        won = true
        for y = 0:(ysize-1)
            won = (won && brd[y*ysize+x])
        end
        if won
            return won
        end
    end
    return false
end
function winScore(dct, brd, lst)
    res = 0
    for i in keys(dct)
        if !brd[dct[i]]
            res += i
        end
    end
    return res * lst
end
function task1()
    numstr = readline()
    numstr = split(numstr, ",")
    chs = Vector{Int64}()
    for i in numstr
        push!(chs, parse(Int64, i))
    end
    boards = Vector()
    marks = Vector{Vector{Bool}}()
    while true
        n = ""
        j = 1
        pos = Dict()
        while true
            a = readline()
            if a == ""
                break
            elseif a == "end"
                n = a
                break
            end
            #join(map(x -> isspace(a[x]) ? "" : a[x], 1:length(a)))
            a = split(a, " ")
            for i in a
                if i != ""
                    inum = parse(Int64, i)
                    pos[inum] = j
                    j += 1
                end
            end
        end
        push!(boards, pos)
        push!(marks, zeros(Bool, j))
        if n == "end"
            break
        end
    end
    for chosen in chs
        for i = 1:(length(boards))
            ind = get(boards[i], chosen, -1)
            if ind != -1
                marks[i][ind] = true
                if BoardWon(marks[i], 5, 5)
                    println(winScore(boards[i], marks[i], chosen))
                    return
                end
            end
        end
    end
end

function task2()
    numstr = readline()
    numstr = split(numstr, ",")
    chs = Vector{Int64}()
    for i in numstr
        push!(chs, parse(Int64, i))
    end
    boards = Vector()
    marks = Vector{Vector{Bool}}()
    while true
        n = ""
        j = 1
        pos = Dict()
        while true
            a = readline()
            if a == ""
                break
            elseif a == "end"
                n = a
                break
            end
            #join(map(x -> isspace(a[x]) ? "" : a[x], 1:length(a)))
            a = split(a, " ")
            for i in a
                if i != ""
                    inum = parse(Int64, i)
                    pos[inum] = j
                    j += 1
                end
            end
        end
        if n == "end"
            break
        else
            if j != 1
                push!(boards, pos)
                push!(marks, zeros(Bool, j))
            end
        end
    end
    won = convert(Int64, length(marks)[1])
    println(won)
    winscore = zeros(Bool, won)
    for chosen in chs
        for i = 1:(length(boards))
            ind = get(boards[i], chosen, -1)
            if ind != -1
                marks[i][ind] = true
                if BoardWon(marks[i], 5, 5) && !winscore[i]
                    won -= 1
                    winscore[i] = true
                    if won == 0
                        println(winScore(boards[i], marks[i], chosen))
                        return
                    end
                end
            end
        end
    end
end
task2()