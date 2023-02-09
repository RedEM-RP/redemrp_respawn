RedEM = exports["redem_roleplay"]:RedEM()

local playerCoords = {}
local DeadPlayers = {}
math.randomseed(os.time())

RegisterServerEvent("redemrp_respawn:CheckPos", function()
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        MySQL.query('SELECT * FROM characters WHERE `citizenid`=@citizenid;', {citizenid = Player.citizenid}, function(result)
            if result[1] then
                local spawnCoords = result[1].coords
                if spawnCoords ~= "{}" then
                    spawnCoords = json.decode(spawnCoords)
                    if spawnCoords ~= nil and spawnCoords ~= {} then
                        TriggerClientEvent("redemrp_respawn:respawnCoords", _source, spawnCoords)
                    else
                        TriggerClientEvent("redemrp_respawn:respawn", _source, true)
                    end
                else
                    TriggerClientEvent("redemrp_respawn:respawn", _source, true)
                end
            end
        end)
    end
end)

RegisterServerEvent("redemrp_respawn:server:RequestRevive", function(id)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if (Player.GetGroup() == "superadmin" or Player.GetGroup() == "admin" or Player.GetGroup() == "mod") then
        if id ~= 0 and id ~= nil then
            TriggerClientEvent('redemrp_respawn:client:Revived', id)
        else
            TriggerClientEvent('redemrp_respawn:client:Revived', _source )
        end
    else
        print("Player ID: [" .. _source .. "] - Tried to use/revive without permissions")
    end
end)


AddEventHandler("redemrp_respawn:server:RequestRevivePlayer", function(id)
    local _source = source
    if id ~= 0 and id ~= nil then
        local Player = RedEM.GetPlayer(id)
        if Player then
            TriggerClientEvent('redemrp_respawn:client:Revived', tonumber(id) )
        end
    end
end)


RegisterServerEvent("redemrp_respawn:TestDeathStatus", function()
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if DeadPlayers[Player.citizenid] then
            Citizen.SetTimeout(3000, function()
                TriggerClientEvent('redemrp_respawn:KillPlayer', _source)
            end)
        end
    end
end)

RedEM.RegisterCallback("redemrp_respawn:IsPlayerDead", function(source, cb)
    local Player = RedEM.GetPlayer(source)
    if Player then
        if DeadPlayers[Player.citizenid] then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent("redemrp_respawn:IsPlayerDead", function(playerId, cb)
    local Player = RedEM.GetPlayer(playerId)
    if Player then
        if DeadPlayers[Player.citizenid] then
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterServerEvent("redemrp_respawn:DeadTable", function(type)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        if type == "add" then
            DeadPlayers[Player.citizenid] = true
        else
            DeadPlayers[Player.citizenid] = false
        end
    end
end)