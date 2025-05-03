ESX = exports['es_extended']:getSharedObject()

-- Événement pour soigner un joueur
RegisterNetEvent('illegal_hospital:healPlayer', function(targetId, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetId)

    if not targetPlayer then
        return lib.notify(source, { type = 'error', description = 'Joueur cible introuvable' })
    end

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        lib.notify(source, { type = 'success', description = ('Vous avez payé $%s pour soigner le joueur'):format(price) })
        lib.notify(targetPlayer.source, { type = 'success', description = 'Vous avez été soigné par un médecin illégal' })
        TriggerClientEvent('esx_basicneeds:healPlayer', targetPlayer.source)
    else
        lib.notify(source, { type = 'error', description = ('Vous n\'avez pas assez d\'argent ($%s requis)'):format(price) })
    end
end)

-- Événement pour réanimer un joueur
RegisterNetEvent('illegal_hospital:revivePlayer', function(targetId, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetId)

    if not targetPlayer then
        return lib.notify(source, { type = 'error', description = 'Joueur cible introuvable' })
    end

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        lib.notify(source, { type = 'success', description = ('Vous avez payé $%s pour réanimer le joueur'):format(price) })
        lib.notify(targetPlayer.source, { type = 'success', description = 'Vous avez été réanimé par un médecin illégal' })
        TriggerClientEvent('esx_ambulancejob:revive', targetPlayer.source)
    else
        lib.notify(source, { type = 'error', description = ('Vous n\'avez pas assez d\'argent ($%s requis)'):format(price) })
    end
end)