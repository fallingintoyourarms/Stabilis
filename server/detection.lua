Detection = {}

Detection.Flags = {}

function Detection.Flag(type, data)
    table.insert(Detection.Flags, {
        type = type,
        data = data,
        time = os.time()
    })

    Utils.Log(("Flagged issue: %s (%s)"):format(type, tostring(data)))
end

function Detection.AnalyzeResources()
    for res, data in pairs(Monitor.ResourceStats) do
        if data.ticks > 1000 then
            Utils.Log(("High tick usage detected: %s"):format(res))

            Detection.Flag("resource_overuse", res)
            data.flagged = true
        end

        data.ticks = 0
    end
end

function Detection.Process()
    for _, flag in ipairs(Detection.Flags) do
        if flag.type == "memory_spike" then
            Utils.Log("Potential global memory leak detected")
        end

        if flag.type == "resource_overuse" then
            local res = flag.data

            if Config.AutoRestartLeakingResources then
                RestartManager.QueueRestart(res)
            end
        end
    end

    Detection.Flags = {}
end