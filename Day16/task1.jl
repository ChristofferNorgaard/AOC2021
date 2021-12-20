function literalValue(raw)
    version = parse(Int64, raw[1:3])
    type = parse(Int64, raw[4:6])
    i = 7
    nmstr = ""
    while true
        nmstr *= raw[i+1:i+4]
        if raw[i] == '1'
            i += 5
        else
            break
        end
    end
    i += 5
    return ((version, type, parse(Int, nmstr), base=2), i)
end
function packageParse(raw)
    version = parse(Int64, raw[1:3], base=2)
    type = parse(Int64, raw[4:6], base=2)
    println(type)
    if type == 4
        return literalValue
    end
end
function task1()
    a = readlines(ARGS[1])
    b = ""
    conv = Dict(
        "0" => "0000",
        "1" => "0001",
        "2" => "0010",
        "3" => "0011",
        "4" => "0100",
        "5" => "0101",
        "6" => "0110",
        "7" => "0111",
        "8" => "1000",
        "9" => "1001",
        "A" => "1010",
        "B" => "1011",
        "C" => "1100",
        "D" => "1101",
        "E" => "1110",
        "F" => "1111"
    )
    for i in a[1]
        b *= conv[string(i)]
    end
    println(packageParse(b))
end
task1()