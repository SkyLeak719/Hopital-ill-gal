local ped = nil
local pedHash = `s_m_m_doctor_01`
local pedCoords = vector4(-621.94, 312.62, 82.93, 180.21)
local markerCoords = vector3(-621.98, 311.94, 83.93)

-- Création du PED médecin
CreateThread(function()
    lib.requestModel(pedHash)
    
    ped = CreatePed(4, pedHash, pedCoords.x, pedCoords.y, pedCoords.z, pedCoords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'illegal_hospital:talk',
            label = 'Parler au médecin illégal',
            icon = 'fa-solid fa-user-doctor',
            distance = 2.0,
            onSelect = OpenHospitalMenu
        }
    })
end)

function OpenHospitalMenu()
    local options = {
        {
            title = 'Soigner un joueur',
            description = 'Coût: $5000',
            icon = 'syringe',
            event = 'illegal_hospital:heal',
            args = { price = 5000 },
            arrow = true
        },
        {
            title = 'Réanimer un joueur',
            description = 'Coût: $10000',
            icon = 'heart-pulse',
            event = 'illegal_hospital:revive',
            args = { price = 10000 },
            arrow = true
        }
    }

    lib.registerContext({
        id = 'illegal_hospital_menu',
        title = 'Médecin Illégal',
        menu = 'interaction_menu',
        options = options
    })

    lib.showContext('illegal_hospital_menu')
end

-- Gestion des événements
RegisterNetEvent('illegal_hospital:heal', function(data)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
    if closestPlayer == -1 or closestDistance > 3.0 then
        return lib.notify({ type = 'error', description = 'Aucun joueur à proximité' })
    end

    TriggerServerEvent('illegal_hospital:healPlayer', GetPlayerServerId(closestPlayer), data.price)
end)

RegisterNetEvent('illegal_hospital:revive', function(data)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
    if closestPlayer == -1 or closestDistance > 3.0 then
        return lib.notify({ type = 'error', description = 'Aucun joueur à proximité' })
    end

    TriggerServerEvent('illegal_hospital:revivePlayer', GetPlayerServerId(closestPlayer), data.price)
end)

-- Marker avec ox_lib
CreateThread(function()
    local point = lib.points.new({
        coords = markerCoords,
        distance = 20.0,
    })

    function point:onEnter()
        lib.requestModel(pedHash)
    end


    function point:onExit()
        lib.hideTextUI()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if DoesEntityExist(ped) then DeleteEntity(ped) end
    end
end)