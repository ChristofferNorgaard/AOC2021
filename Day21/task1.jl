function move(pos, dice)
    c = (pos - 1 + dice) % 10
    return c + 1
end
mutable struct DeterMinisticStruct
    prev::Int64
    times::Int64
end
function Dice(diceStruct)
    d = (diceStruct.prev + 1) % 101
    if d == 0
        d = 1
    end
    diceStruct.prev = d
    diceStruct.times += 1
    return d
end
d = Dict()
function otherplayer(player)
    if player == 1
        return 2
    else
        return 1
    end
end
function recursiveDec(player, points, pos)
    if haskey(d, (player, points, pos))
        return d[(player, points, pos)]
    end
    if maximum(points) >= 21
        if points[1] >= 21
            return [1, 0]
        else
            return [0, 1]
        end
    end
    ret = []
    for i = 1:3
        for j = 1:3
            for k = 1:3
                pn = copy(pos)
                pn[player] = move(pos[player], i + j + k)
                pnts = copy(points)
                pnts[player] += pn[player]
                push!(ret, recursiveDec(otherplayer(player), pnts, pn))
            end
        end
    end
    f = sum(i[1] for i in ret)
    g = sum(i[2] for i in ret)
    d[(player, points, pos)] = [f, g]
    return [f, g]
end
function simulate(players, dice, dicestruct)
    did = 0
    exitFlag = false
    while !exitFlag
        for i = 1:length(players)
            players[i][2] = move(players[i][2], dice(dicestruct) + dice(dicestruct) + dice(dicestruct))
            players[i][3] += players[i][2]
            if players[i][3] >= 1000
                exitFlag = true
                break
            end
            did += 1
            #println(dicestruct.prev)
        end
        #println(players)
    end
    return minimum([i[3] for i in players])
end
function task1()
    inpreg = r"Player ([0-9]*) starting position: ([0-9]*)"
    players = []
    for line in readlines(ARGS[1])
        m = match(inpreg, line)
        push!(players, [parse(Int64, m[1]), parse(Int64, m[2]), 0])
    end
    #println(players)
    dic = DeterMinisticStruct(0, 0)
    #t = simulate(players, Dice, dic)
    #println(t * dic.times)
    println(maximum(recursiveDec(1, [0, 0], [players[1][2], players[2][2]])))
end
task1()