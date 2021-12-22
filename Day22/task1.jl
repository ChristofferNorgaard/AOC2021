mutable struct Point
    x::Int64
    y::Int64
    z::Int64
end
struct Move
    st::Point
    en::Point
    turn::Bool
end
function task1()
    inp = r"([A-z]*) x=([0-9]*)\.\.([0-9]*),y=([0-9]*)\.\.([0-9]*),z=([0-9]*)\.\.([0-9]*)"
    moves = Vector{Move}()
    for line in readlines(ARGS[1])
        m = match(inp, line)
        st = Point(parse(Int64, m[2]), parse(Int64, m[4]), parse(Int64, m[6]))
        en = Point(parse(Int64, m[3]), parse(Int64, m[5]), parse(Int64, m[7]))
        tr = (m[1] == "on")
        push!(moves, Move(st, en, tr))
    end
    
end