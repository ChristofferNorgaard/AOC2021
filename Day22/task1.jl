mutable struct Point
    x::Int64
    y::Int64
    z::Int64
end
struct Cubiod
    st::Point
    en::Point
    turn::Int64
end
function volumen(c::Cubiod)
    return (abs(c.st.x - c.en.x) + 1) * (abs(c.st.y - c.en.y) + 1) * (abs(c.st.z - c.en.z) + 1) * c.turn
end
function IntersectionVolumen(c::Cubiod, d::Cubiod)
    return min(abs(c.st.x - c.en.x), abs(d.st.x - d.en.x)) * min(abs(c.st.y - c.en.y), abs(d.st.y - d.en.y)) * min(abs(c.st.z - c.en.z), abs(d.st.z - d.en.z))
end
function intersect(c::Cubiod, d::Cubiod)
    return max(c.st.x, c.en.x) >= min(d.st.x, d.en.x) && min(c.st.x, c.en.x) <= max(d.st.x, d.en.x) && max(c.st.y, c.en.y) >= min(d.st.y, d.en.y) && min(c.st.y, c.en.y) <= max(d.st.y, d.en.y) && max(c.st.z, c.en.z) >= min(d.st.z, d.en.z) && min(c.st.z, c.en.z) <= max(d.st.z, d.en.z)
end
function MakeIntersection(c::Cubiod, d::Cubiod)
    st = Point(min(max(c.st.x, c.en.x), max(d.st.x, d.en.x)), min(max(c.st.y, c.en.y), max(d.st.y, d.en.y)), min(max(c.st.z, c.en.z), max(d.st.z, d.en.z)))
    en = Point(max(min(c.st.x, c.en.x), min(d.st.x, d.en.x)), max(min(c.st.y, c.en.y), min(d.st.y, d.en.y)), max(min(c.st.z, c.en.z), min(d.st.z, d.en.z)))
    return Cubiod(st, en, -d.turn)
end
function task1()
    inp = r"([a-z]*) x=([-0-9]*)\.\.([-0-9]*),y=([-0-9]*)\.\.([-0-9]*),z=([-0-9]*)\.\.([-0-9]*)"
    cubes = Vector{Cubiod}()
    totalVolumen = 0
    for line in readlines(ARGS[1])
        println(line)
        m = match(inp, line)
        st = Point(parse(Int64, m[2]), parse(Int64, m[4]), parse(Int64, m[6]))
        en = Point(parse(Int64, m[3]), parse(Int64, m[5]), parse(Int64, m[7]))
        tr = convert(Int64, (m[1] == "on"))
        c = Cubiod(st, en, tr)
        ncubes = Vector{Cubiod}()
        for d in cubes
            #println(d)
            if intersect(c, d)
                push!(ncubes, MakeIntersection(c, d))
            end
        end
        println(length(ncubes))
        for i in ncubes
            push!(cubes, i)
        end
        println(line)
        push!(cubes, c)
    end
    for c in cubes
        totalVolumen += volumen(c)
    end
    println(totalVolumen)
end
task1()