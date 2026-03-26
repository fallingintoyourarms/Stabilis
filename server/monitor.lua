Monitor = {}

Monitor.LastMemory = 0
Monitor.ResourceStats = {}

function Monitor.GetMemory()
    return collectgarbage("count")
end

function Monitor.TrackResources()
    for i = 0, GetNumResources() - 1 do
        local res = GetResourceByFindIndex(i)

        if GetResourceState(res) == "started" then
            if not Monitor.ResourceStats[res] then
                Monitor.ResourceStats[res] = {
                    ticks = 0,
                    lastUpdate = os.time(),
                    flagged = false
                }
            end

            Monitor.ResourceStats[res].ticks += 1
        end
    end
end

function Monitor.CheckMemory()
    local current = Monitor.GetMemory()
    local diff = current - Monitor.LastMemory

    if Monitor.LastMemory ~= 0 and diff > Config.MemoryIncreaseThreshold then
        Utils.Log(("Memory spike detected: +%d KB"):format(diff))
        Detection.Flag("memory_spike", diff)
    end

    Monitor.LastMemory = current
end