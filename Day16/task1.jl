function literalValue(raw)
    if length(raw) < (7 + 4)
        return -1
    end
    version = parse(Int64, raw[1:3], base = 2)
    type = parse(Int64, raw[4:6], base = 2)
    i = 7
    nmstr = ""
    while true
        if length(raw) < i + 4
            return -1
        end
        nmstr *= raw[i+1:i+4]
        if raw[i] == '1'
            i += 5
        else
            break
        end
    end
    i += 5
    return ((version, type, parse(Int64, nmstr, base = 2)), i)
end
function Operators(raw)
    version = parse(Int64, raw[1:3], base = 2)
    type = parse(Int64, raw[4:6], base = 2)
    id = parse(Int64, raw[7], base = 2)
    res = []
    ind = 0
    if id == 0
        len = parse(Int64, raw[8:(8+14)], base = 2)
        #println(raw[8:(8+14)])
        #println(raw)
        #println(len)
        subpacks = raw[(8+15):(8+15+len)]
        ind = (8 + 15)
        println(subpacks)
        while true
            r = packageParse(subpacks)
            if r == -1
                break
            end
            println(r)
            push!(res, r[1])
            println(res)
            println(length(subpacks))
            subpacks = subpacks[(r[2]):length(subpacks)]
            println(length(subpacks))
            println(subpacks)
            ind += r[2] - 1
        end
        println("out")
    else
        amount = parse(Int64, raw[8:(8+10)], base = 2)
        subpacks = raw[(8+11):length(raw)]
        ind = (8 + 11)
        println(subpacks)
        println(amount)
        for i = 1:(amount)
            r = packageParse(subpacks)
            push!(res, r[1])
            println(i)
            subpacks = subpacks[(r[2]):length(subpacks)]
            println(subpacks)
            ind += r[2] - 1
        end
    end
    return ((version, type, res, id), ind)
end
function packageParse(raw)
    if length(raw) < (7)
        return -1
    end
    version = parse(Int64, raw[1:3], base = 2)
    type = parse(Int64, raw[4:6], base = 2)
    println("type ", type)
    println("version ", version)
    if type == 4
        return literalValue(raw)
    else
        return Operators(raw)
    end
end
function sumPackage(packg)
    s = packg[1]
    if packg[2] == 4
        return s
    else
        for i in packg[3]
            s += sumPackage(i)
        end
    end
    return s
end
function RunPackage(packg)
    if packg[2] == 4
        return packg[3]
    else
        o = packg[2]
        if o == 0
            s = 0
            for i in packg[3]
                s += RunPackage(i)
            end
            return s
        elseif o == 1
            s = 1
            for i in packg[3]
                s *= RunPackage(i)
            end
            return s
        elseif o == 2
            s = typemax(Int64)
            for i in packg[3]
                s = min(s, RunPackage(i))
            end
            return s
        elseif o == 3
            s = typemin(Int64)
            for i in packg[3]
                s = max(s, RunPackage(i))
            end
            return s
        elseif o == 5
            return convert(Int64, RunPackage(packg[3][1]) > RunPackage(packg[3][2]))
        elseif o == 6
            return convert(Int64, RunPackage(packg[3][1]) < RunPackage(packg[3][2]))
        elseif o == 7
            return convert(Int64, RunPackage(packg[3][1]) == RunPackage(packg[3][2]))
        end
    end
    return -10
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
    println(b)
    packg = packageParse(b)[1]
    println(sumPackage(packg))
    println(RunPackage(packg))
end
task1()