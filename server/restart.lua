RestartManager = {}

RestartManager.Queue = {}
RestartManager.Cooldowns = {}

local PROTECTED = {
    ["sessionmanager"] = true,
    ["spawnmanager"] = true,
    ["mapmanager"] = true,
    ["hardcap"] = true
}

function RestartManager.QueueRestart(resource)
    if PROTECTED[resource] then
        Utils.Log(("Skipped protected resource: %s"):format(resource))
        return
    end

    if RestartManager.Cooldowns[resource] then
        return
    end

    Utils.Log(("Queued restart for: %s"):format(resource))

    RestartManager.Queue[resource] = os.time()
    RestartManager.Cooldowns[resource] = true
end

CreateThread(function()
    while true do
        Wait(10000)

        for res, time in pairs(RestartManager.Queue) do
            if os.time() - time > 15 then
                Utils.Log(("Restarting resource: %s"):format(res))

                StopResource(res)
                Wait(2000)
                StartResource(res)

                RestartManager.Queue[res] = nil

                SetTimeout(300000, function()
                    RestartManager.Cooldowns[res] = nil
                end)
            end
        end
    end
end)