function command_handler(command::SubString, amount::Int64, x::Int64, y::Int64)
    if command == "forward"
        x += amount
    elseif command == "down"
        y += amount
    elseif command == "up"
        y -= amount
    end
    return x, y
end
function commandaim_handler(command::SubString, amount::Int64, x::Int64, y::Int64, aim::Int64)
    if command == "forward"
        x += amount
        y += amount*aim
    elseif command == "down"
        aim += amount
    elseif command == "up"
        aim -= amount
    end
    return x, y, aim
end
function task2()
    x = 0
    y = 0
    aim = 0
    while true
        inp = readline()
        if inp == ""
            break
        end
        cs = split(inp, " ")
        command = cs[1]
        amount = parse(Int64, cs[2])
        x, y, aim = commandaim_handler(command, amount, x, y, aim)
    end
    println(x, y)
    println(x*y)
end
task2()