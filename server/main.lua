CreateThread(function()
    Utils.Log("Stabilis started")

    while true do
        Wait(Config.Interval)

        Monitor.CheckMemory()
        Monitor.TrackResources()

        local counts = Monitor.GetEntityCounts()

        if counts.vehicles > Config.MaxVehicles then
            Utils.Log(("Vehicle overflow: %d"):format(counts.vehicles))
            Cleanup.Run()
        end

        if counts.peds > Config.MaxPeds then
            Utils.Log(("Ped overflow: %d"):format(counts.peds))
            Cleanup.Run()
        end

        if counts.objects > Config.MaxObjects then
            Utils.Log(("Object overflow: %d"):format(counts.objects))
            Cleanup.Run()
        end

        Detection.AnalyzeResources()
        Detection.Process()
    end
end)

CreateThread(function()
    while true do
        Wait(Config.CleanupInterval)
        Cleanup.Run()
    end
end)