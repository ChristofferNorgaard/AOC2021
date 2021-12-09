struct Point
    x::Int64
    y::Int64
end
struct Line
    start::Point
    ending::Point
end
function ParsePoint(substr)
    x = parse(Int64, split(substr, ",")[1])
    y = parse(Int64, split(substr, ",")[2])
    return Point(x, y)
end
function ParseLine(str)
    start = ParsePoint(split(str, "->")[1])
    ending = ParsePoint(split(str, "->")[2])
    return Line(start, ending)
end
function horizontal(line)
    return line.start.x == line.ending.x
end
function vertical(line)
    return line.start.y == line.ending.y
end
function commonPoints(line1, line2)
    if horizontal(line1) && horizontal(line2)
        return abs(line1.x)
    end
end
function countPoints(lines)
    mark = Dict()
    for line in lines
        if vertical(line)
            for i = min(line.start.x, line.ending.x):max(line.start.x, line.ending.x)
                if haskey(mark, (i, line.start.y))
                    mark[(i, line.start.y)] += 1
                else
                    mark[(i, line.start.y)] = 1
                end
            end
        end
        if horizontal(line)
            for i = min(line.start.y, line.ending.y):max(line.start.y, line.ending.y)
                if haskey(mark, (line.start.x, i))
                    mark[(line.start.x, i)] += 1
                else
                    mark[(line.start.x, i)] = 1
                end
            end
        end
    end
    rs = 0
    for key in keys(mark)
        if mark[key] > 1
            rs += 1
        end
    end
    return rs
end
function countAllPoints(lines)
    mark = Dict()
    for line in lines
        if vertical(line)
            for i = min(line.start.x, line.ending.x):max(line.start.x, line.ending.x)
                if haskey(mark, (i, line.start.y))
                    mark[(i, line.start.y)] += 1
                else
                    mark[(i, line.start.y)] = 1
                end
            end
        elseif horizontal(line)
            for i = min(line.start.y, line.ending.y):max(line.start.y, line.ending.y)
                if haskey(mark, (line.start.x, i))
                    mark[(line.start.x, i)] += 1
                else
                    mark[(line.start.x, i)] = 1
                end
            end
        else
            yi = 0
            xi = 0
            if line.start.x < line.ending.x
                xi = 1
            else
                xi = -1
            end
            if line.start.y < line.ending.y
                yi = 1
            else
                yi = -1
            end
            x = line.start.x
            y = line.start.y
            while (line.ending.x) != x && (y != line.ending.y)
                if haskey(mark, (x, y))
                    mark[(x, y)] += 1
                else
                    mark[(x, y)] = 1
                end
                x += xi
                y += yi
            end
            if haskey(mark, (line.ending.x, line.ending.y))
                mark[(line.ending.x, line.ending.y)] += 1
            else
                mark[(line.ending.x, line.ending.y)] = 1
            end
        end
    end
    rs = 0
    for key in keys(mark)
        if mark[key] > 1
            rs += 1
        end
    end
    return rs
end
function task1()
    lines = Vector{Line}()
    while true
        a = readline()
        if a == ""
            break
        end
        line = ParseLine(a)
        if horizontal(line) || vertical(line)
            push!(lines, line)
        end
    end
    println(countPoints(lines))
end
function task2()
    lines = Vector{Line}()
    while true
        a = readline()
        if a == ""
            break
        end
        line = ParseLine(a)
        push!(lines, line)
    end
    println(countAllPoints(lines))
end
task2()