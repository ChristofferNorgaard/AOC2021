function move(pos, dice)
    return (pos + dice) % 11
end
mutable struct DeterMinisticStruct
    prev::Int64
end
function Dice(diceStruct)
    d = (diceStruct.prev + 1) % 101
    if d == 0
        d = 1
    end
    diceStruct.prev = d
    return d
end
function simulate(players, dice, dicestruct)
    did = 0
    exitFlag = false
    while !exitFlag
        for i in 1:length(players)
            players[i][2] = move(players[i][2], dice(dicestruct)+dice(dicestruct)+dice(dicestruct))
            players[i][3] += players[i][2]
            if players[i][3] >= 1000
                exitFlag = true
                break
            end
            did += 1
        end
        println(players)
    end
    println(players)
end
function task1()
    inpreg = r"Player ([0-9]*) starting position: ([0-9]*)"
    players = []
    for line in readlines(ARGS[1])
        m = match(inpreg, line)
        push!(players, [parse(Int64, m[1]), parse(Int64, m[2]), 0])
    end
    println(players)
    dic = DeterMinisticStruct(0)
    simulate(players, Dice, dic)
end
task1()