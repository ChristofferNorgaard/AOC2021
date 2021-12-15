function fver(lin, x)
    for i in 1:size(lin)[1]
        for j in 1:size(lin)[2]
            if i > x && x - (i - x) > 0
                lin[x - (i - x), j] = max(lin[i, j], lin[x - (i - x), j])
                lin[i, j] = 0
            end
        end
    end
    return lin
end
function fhor(lin, y)
    for i in 1:size(lin)[1]
        for j in 1:1:size(lin)[2]
            if j > y && y - (j - y) > 0
                lin[i, y - (j - y)] = max(lin[i, j], lin[i, y - (j - y)])
                lin[i, j] = 0
            end
        end
    end
    return lin
end
function fold(mode, n, lin)
    if mode == "y"
        lin = fhor(lin, n)
    else
        lin = fver(lin, n)
    end
    return lin
end
function task1()
    pointsMode = true
    points = Vector()
    folds = Vector()
    maxx = 0
    maxy = 0
    for line in readlines(ARGS[1])
        if line == ""
            pointsMode = false
            continue
        end
        if pointsMode
            ln = split(line, ",")
            a = parse(Int64, ln[1])
            a += 1
            b = parse(Int64, ln[2])
            b += 1
            maxx = max(a, maxx)
            maxy = max(b, maxy)
            push!(points, (a, b))
        else
            eles = split(line, " ")[3]
            m, c = split(line, "=")
            m = split(m, " ")[3]
            c = parse(Int64, c)
            c = c + 1
            push!(folds, (m, c))
        end
    end
    lin = zeros(Int64, (maxx+1, maxy+1))
    for i in points
        lin[i[1], i[2]] = 1
    end
    #display(lin)
    for f in folds
        println(f)
        lin = fold(f[1], f[2], lin)
    end
    lun = zeros(Int64, (40, 40))
    for i in 1:size(lun)[1]
        for j in 1:1:size(lun)[2]
            lun[j, i] = lin[i,j]
        end
    end
    println()
    display(lun)
    println()
    println(sum(lin))
end
task1()