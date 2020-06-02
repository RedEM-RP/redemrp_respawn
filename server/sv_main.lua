local playerCoords = {}

AddEventHandler("redemrp:playerLoaded", function(_source, user)
    print("Get spawn location")

    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        print(tostring(user.get('identifier')) .. tostring(user.getSessionVar("charid")))
        MySQL.Async.fetchAll('SELECT * FROM characters WHERE `identifier`=@identifier AND `characterid`=@charid;', {identifier = user.get('identifier'), charid = user.getSessionVar("charid")}, function(result)
            print(json.encode(result[1].coords))
            
            if(result[1].coords == "{}")then
                print("[RedEMRP-Respawn] No spawn location saved, showing UI instead...")
                TriggerClientEvent("redemrp_respawn:respawn", _source)
            else
                print("[RedEMRP-Respawn] Coords to spawn at: " .. result[1].coords)
                TriggerClientEvent("redemrp_respawn:respawnCoords", _source, json.decode(result[1].coords))
            end
        end)        
    end)
end)

RegisterServerEvent("redemrp_respawn:registerCoords")
AddEventHandler("redemrp_respawn:registerCoords", function(coords)
    print("Registered coords: " .. json.encode(coords))

    playerCoords[source] = coords
end)

AddEventHandler("redemrp:playerDropped", function(player)
    local coords = playerCoords[player.get('source')]
    local characterId = player.getSessionVar("charid")
    local identifier = player.get('identifier')

    print("Saving coords for: " .. tostring(characterId) .. " | " .. json.encode(coords))

    if coords then
        MySQL.Async.execute('UPDATE characters SET `coords`=@coords WHERE `identifier`=@identifier AND `characterid`=@charid;', {coords = json.encode(coords), identifier = identifier, charid = characterId})
    end
end)
