function task1()
    rstring = r"target area: x=([0-9, -]*)\.\.([0-9, -]*), y=([0-9, -]*)\.\.([0-9, -]*)"
    l = readlines(ARGS[1])[1]
    ml = match(rstring, l)
    x = (parse(Int64, ml[1]), parse(Int64, ml[2]))
    y = (parse(Int64, ml[3]), parse(Int64, ml[4]))
    xspeed = ceil((1 + ceil(sqrt(1 + 4*2*x[1]))) / 2)
    
end