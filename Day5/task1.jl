function modelDays(days, fish)
    for i in 1:days
        newfish = zeros(Int64, 10)
        for j in length(fish):-1:2
            newfish[j-1] += fish[j]
        end
        newfish[6+2] += newfish[1]
        newfish[8+2] += newfish[1]
        newfish[1] = 0
        fish = copy(newfish)
    end
    return sum(fish)
end
function task1()
    a = readline()
    strs = split(a, ",")
    fish = zeros(Int64, 10)
    for s in strs
        fish[parse(Int64, s)+2] += 1
    end
    println(modelDays(256, fish))
end
task1()