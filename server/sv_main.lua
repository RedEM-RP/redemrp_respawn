local playerCoords = {}

AddEventHandler("redemrp:playerLoaded", function(_source, user)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        MySQL.Async.fetchAll('SELECT * FROM characters WHERE `identifier`=@identifier AND `characterid`=@charid;', {identifier = user.get('identifier'), charid = user.getSessionVar("charid")}, function(result)            
            if(result[1].coords == "{}")then
                TriggerClientEvent("redemrp_respawn:respawn", _source)
            else
                TriggerClientEvent("redemrp_respawn:respawnCoords", _source, json.decode(result[1].coords))
            end
        end)        
    end)
end)

RegisterServerEvent("redemrp_respawn:registerCoords")
AddEventHandler("redemrp_respawn:registerCoords", function(coords)
    playerCoords[source] = coords
end)

AddEventHandler("redemrp:playerDropped", function(player)
    local coords = playerCoords[player.get('source')]
    local characterId = player.getSessionVar("charid")
    local identifier = player.get('identifier')

    if coords then
        MySQL.Async.execute('UPDATE characters SET `coords`=@coords WHERE `identifier`=@identifier AND `characterid`=@charid;', {coords = json.encode(coords), identifier = identifier, charid = characterId})
    end
end)
