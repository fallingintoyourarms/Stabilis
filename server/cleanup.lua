Cleanup = {}

local function IsVehicleAbandoned(veh)
    return GetPedInVehicleSeat(veh, -1) == 0
end

function Cleanup.Run()
    local vehicles = GetAllVehicles()
    local peds = GetAllPeds()
    local objects = GetAllObjects()

    local removed = {
        vehicles = 0,
        peds = 0,
        objects = 0
    }

    if Config.DeleteEmptyVehicles then
        for _, veh in ipairs(vehicles) do
            if DoesEntityExist(veh) and IsVehicleAbandoned(veh) then
                DeleteEntity(veh)
                removed.vehicles += 1
            end
        end
    end

    if Config.DeleteOrphanPeds then
        for _, ped in ipairs(peds) do
            if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
                DeleteEntity(ped)
                removed.peds += 1
            end
        end
    end

    if Config.DeleteObjects then
        local limit = Config.MaxObjects

        if #objects > limit then
            for i = 1, (#objects - limit) do
                local obj = objects[i]
                if DoesEntityExist(obj) then
                    DeleteEntity(obj)
                    removed.objects += 1
                end
            end
        end
    end

    Utils.Log((
        "Cleanup done | Vehicles: %d | Peds: %d | Objects: %d"
    ):format(removed.vehicles, removed.peds, removed.objects))
end