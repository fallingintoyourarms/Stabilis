Utils = {}

function Utils.Log(msg)
    local text = ("[Stabilis] %s"):format(msg)
    print(text)

    if Config.LogToFile then
        local file = io.open("logs/stabilis.log", "a")
        if file then
            file:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. msg .. "\n")
            file:close()
        end
    end
end

function Utils.TableLength(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end