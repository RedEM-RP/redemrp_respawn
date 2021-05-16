local playerCoords = {}
local Players_Dead = {}
math.randomseed(os.time())
local code =  math.random(100000,999999)

AddEventHandler("redemrp:playerLoaded", function(source, user)
    TriggerClientEvent("redemrp_respawn:TransferCode", source, code)
end)


RegisterServerEvent("redemrp_respawn:CheckPos")
AddEventHandler("redemrp_respawn:CheckPos", function()
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
	if user then
	    MySQL.Async.fetchAll('SELECT * FROM characters WHERE `identifier`=@identifier AND `characterid`=@charid;', {identifier = user.get('identifier'), charid = user.getSessionVar("charid")}, function(result)
		  if(result[1].coords ~= "{}")then
		      TriggerClientEvent("redemrp_respawn:respawnCoords", _source, json.decode(result[1].coords) , code)
		  else
	  	      TriggerClientEvent("redemrp_respawn:respawn", _source, true)
	          end
	     end)
	end
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
        print("saved coords")
        MySQL.Async.execute('UPDATE characters SET `coords`=@coords WHERE `identifier`=@identifier AND `characterid`=@charid;', {coords = json.encode(coords), identifier = identifier, charid = characterId})
    end
end)

RegisterServerEvent("redemrp_respawn:revive")
AddEventHandler("redemrp_respawn:revive", function(id , c)
    if c ~= code then return end
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        if (user.getGroup() == "superadmin" or user.getGroup() == "admin") then
            if id ~= 0 and id ~= nil then
                print("Player ID: [" .. _source .. "] - uses/revive on [" .. id .. "]")
                TriggerClientEvent('redemrp_respawn:gotRevive', id , code)
            else
                print("Player ID: [" .. _source .. "] - uses/revive on itself")
                TriggerClientEvent('redemrp_respawn:gotRevive', _source , code )
            end
        else
            print("Player ID: [" .. _source .. "] - Tried to use/revive without permissions")
        end
    end)
end)


AddEventHandler("redemrp_respawn:RevivePlayer", function(id)
    local _source = source
    if id ~= 0 and id ~= nil then
        TriggerEvent('redemrp:getPlayerFromId', tonumber(id), function(user)
            local charid = user.getSessionVar("charid")
            print("Player z ID: [" .. _source .. "] - uses /revive on [" .. id .. "]")
            TriggerClientEvent('redemrp_respawn:gotRevive', tonumber(id) , code )
        end)
    end
end)


RegisterServerEvent("redemrp_respawn:TestDeathStatus")
AddEventHandler("redemrp_respawn:TestDeathStatus", function()
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', tonumber(_source), function(user)
        if user ~= nil then
            local identifier = user.getIdentifier()
            local charid = user.getSessionVar("charid")
            if Players_Dead[identifier.."_"..charid] then
                TriggerClientEvent('redemrp_respawn:KillPlayer',_source , code)
            end
        end
    end)
end)

RegisterServerEvent("redemrp_respawn:DeadTable")
AddEventHandler("redemrp_respawn:DeadTable", function(type , c)
    if c ~= code then return end
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        if type == "add" then
            Players_Dead[identifier.."_"..charid] = true
        else
            Players_Dead[identifier.."_"..charid] = false
        end
    end)
end)
