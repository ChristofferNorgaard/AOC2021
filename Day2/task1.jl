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
function task1()
    x = 0
    y = 0
    while true
        inp = readline()
        if inp == ""
            break
        end
        cs = split(inp, " ")
        command = cs[1]
        amount = parse(Int64, cs[2])
        x, y = command_handler(command, amount, x, y)
    end
    println(x, y)
    println(x*y)
end
task1()