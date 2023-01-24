RedEM = exports["redem_roleplay"]:RedEM()


local newCharacter = false
local pressed = false
local revived = false
local medicsAlerted = false
local TrackingDoctors = false

local Weapons = {
    {'weapon_melee_knife_jawbone','group_melee',},                                      -- {0x1086D041,0xD49321D4,},
    {'weapon_melee_machete','group_melee',},                                            -- {0x28950C71,0xD49321D4,},
    {'weapon_melee_torch','group_melee',},                                              -- {0x67DC3FDE,0xD49321D4,},
    {'weapon_melee_knife','group_melee',},                                              -- {0xDB21AC8C,0xD49321D4,},
    {'weapon_pistol_volcanic','group_pistol',},                                         -- {0x020D13FF,0x18D5FA97,},
    {'weapon_pistol_m1899','group_pistol',},                                            -- {0x5B78B8DD,0x18D5FA97,},
    {'weapon_pistol_semiauto','group_pistol',},                                         -- {0x657065D6,0x18D5FA97,},
    {'weapon_pistol_mauser','group_pistol',},                                           -- {0x8580C63E,0x18D5FA97,},
    {'weapon_repeater_evans','group_repeater',},                                        -- {0x7194721E,0xDC8FB3E9,},
    {'weapon_repeater_henry','group_repeater',},                                        -- {0x95B24592,0xDC8FB3E9,},
    {'weapon_repeater_winchester','group_repeater',},                                   -- {0xA84762EC,0xDC8FB3E9,},
    {'weapon_repeater_carbine','group_repeater',},                                      -- {0xF5175BA1,0xDC8FB3E9,},
    {'weapon_revolver_doubleaction','group_revolver',},                                 -- {0x0797FBF5,0xBE5B8969,},
    {'weapon_revolver_cattleman','group_revolver',},                                    -- {0x169F59F7,0xBE5B8969,},
    {'weapon_revolver_cattleman_mexican','group_revolver',},                            -- {0x16D655F7,0xBE5B8969,},
    {'weapon_revolver_lemat','group_revolver',},                                        -- {0x5B2D26B5,0xBE5B8969,},
    {'weapon_revolver_schofield','group_revolver',},                                    -- {0x7BBD1FF6,0xBE5B8969,},
    {'weapon_revolver_doubleaction_gambler','group_revolver',},                         -- {0x83DD5617,0xBE5B8969,},
    {'weapon_rifle_springfield','group_rifle',},                                        -- {0x63F46DE6,0x39D5C192,},
    {'weapon_rifle_boltaction','group_rifle',},                                         -- {0x772C8DD6,0x39D5C192,},
    {'weapon_rifle_varmint','group_rifle',},                                            -- {0xDDF7BC1E,0x39D5C192,},
    {'weapon_shotgun_sawedoff','group_shotgun',},                                       -- {0x1765A8F8,0x33431399,},
    {'weapon_shotgun_doublebarrel_exotic','group_shotgun',},                            -- {0x2250E150,0x33431399,},
    {'weapon_shotgun_pump','group_shotgun',},                                           -- {0x31B7B9FE,0x33431399,},
    {'weapon_shotgun_repeating','group_shotgun',},                                      -- {0x63CA782A,0x33431399,},
    {'weapon_shotgun_semiauto','group_shotgun',},                                       -- {0x6D9BB970,0x33431399,},
    {'weapon_shotgun_doublebarrel','group_shotgun',},                                   -- {0x6DFA071B,0x33431399,},
    {'weapon_sniperrifle_carcano','group_sniper',},                                     -- {0x53944780,0xB7BBD827,},
    {'weapon_sniperrifle_rollingblock','group_sniper',},                                -- {0xE1D2B317,0xB7BBD827,},
    {'weapon_melee_hatchet','group_thrown',},                                           -- {0x09E12A01,0x5C4C5883,},

    {'weapon_melee_hatchet_hunter','group_thrown',},                                    -- {0x2A5CF9D6,0x5C4C5883,},
    {'weapon_thrown_molotov','group_thrown',},                                          -- {0x7067E7A7,0x5C4C5883,},
    {'weapon_thrown_tomahawk_ancient','group_thrown',},                                 -- {0x7F23B6C7,0x5C4C5883,},
    {'weapon_thrown_tomahawk','group_thrown',},                                         -- {0xA5E972D7,0x5C4C5883,},
    {'weapon_thrown_dynamite','group_thrown',},                                         -- {0xA64DAA5E,0x5C4C5883,},
    {'weapon_melee_hatchet_double_bit','group_thrown',},                                -- {0xBCC63763,0x5C4C5883,},
    {'weapon_thrown_throwing_knives','group_thrown',},                                  -- {0xD2718D48,0x5C4C5883,},

    {'weapon_melee_cleaver','group_thrown',},                                           -- {0xEF32A25D,0x5C4C5883,},

    {'weapon_melee_davy_lantern','group_held',},                                          -- {0x4A59E501,0xC715F939,},

    {'weapon_kit_binoculars','group_held',},                                              -- {0xF6687C5A,0xC715F939,},
    {'weapon_kit_camera','group_held',},                                                  -- {0xc3662b7d,0xc715f939,},

    {'weapon_bow','group_bow',},                                                         -- {0x88a8505c,0xb5fd67cd,},
    {'weapon_fishingrod','group_fishingrod',},                                                  -- {0xaba87754,0x60b51da4,},
    {'weapon_lasso','group_lasso',},                                                       -- {0x7a8a724a,0x126210c3,},

    {'weapon_kit_camera_advanced','group_held',},
    {'weapon_melee_machete_horror','group_melee',},
    {'weapon_bow_improved','group_bow',},
    {'weapon_rifle_elephant','group_rifle',},
    {'weapon_revolver_navy','group_revolver',},
    {'weapon_lasso_reinforced','group_lasso',},
    {'weapon_kit_binoculars_improved','group_held',},
    {'weapon_melee_knife_trader','group_melee',},
    {'weapon_melee_machete_collector','group_melee',},
    {'weapon_moonshinejug_mp','group_petrolcan',},
    {'weapon_thrown_bolas','group_thrown',},
    {'weapon_thrown_poisonbottle','group_thrown',},

    {'weapon_kit_metal_detector','group_held',},
    {'weapon_revolver_navy_crossover','group_revolver',},
    {'weapon_thrown_bolas_hawkmoth','group_thrown',},
    {'weapon_thrown_bolas_ironspiked','group_thrown',},
    {'weapon_thrown_bolas_intertwined','group_thrown',},

    {'weapon_melee_knife_horror','group_melee',},
    {'weapon_melee_knife_rustic','group_melee',},
    {'weapon_melee_lantern_halloween','group_held',},

}


RegisterCommand("kys", function(source, args, rawCommand) -- KILL YOURSELF COMMAND
    local _source = source
    Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 500000, false, true, true)
end, false)

RegisterNetEvent("redemrp_respawn:client:Revived", function(c)
    DoScreenFadeOut(500)
    Wait(500)
    revived = true
    EndDeathCam()
    --AnimpostfxStop("DeathFailMP01")
    --ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    --Citizen.InvokeNative(0xFDB74C9CC54C3F37, 0.0)
    DestroyAllCams(true)
    Wait(1000)
    TriggerEvent("redemrp_respawn:respawnCoords", GetEntityCoords(PlayerPedId()))
end)

RegisterCommand("revive", function(source, args, rawCommand)
    if args[1] ~= nil then
        TriggerServerEvent('redemrp_respawn:server:RequestRevive', tonumber(args[1]))
    else
        TriggerServerEvent('redemrp_respawn:server:RequestRevive', source)
    end
end, false)

RegisterNetEvent("redemrp_respawn:KillPlayer", function()
    Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 500000, false, true, true)
end)


local ConfirmingRespawn = false
local onPlayerDead = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        while IsPlayerDead(PlayerId()) and not revived do
            Wait(1)
            local timer = GetGameTimer()+Config.RespawnTime
            while timer >= GetGameTimer() and not revived do
                if revived == false then

                    if onPlayerDead == false then
                        local DeathReason = "suicide"
                        local PedKiller = Citizen.InvokeNative(0x93C8B64DEB84728C, PlayerPedId()) -- _GET_PED_SOURCE_OF_DEATH
                        local killername = GetPlayerName(PedKiller)
                        local DeathCauseHash = Citizen.InvokeNative(0x16FFE42AB2D2DC59, PlayerPedId()) -- _GET_PED_CAUSE_OF_DEATH
                        if Citizen.InvokeNative(0xCF8176912DDA4EA5, PedKiller) --[[ _IS_ENTITY_A_PED ]] and Citizen.InvokeNative(0x12534C348C6CB68B, PedKiller) --[[ _IS_PED_A_PLAYER ]] then
                            Killer = NetworkGetPlayerIndexFromPed(PedKiller)
                        elseif IsEntityAVehicle(PedKiller) and Citizen.InvokeNative(0xCF8176912DDA4EA5, GetPedInVehicleSeat(PedKiller, -1)) and Citizen.InvokeNative(0x12534C348C6CB68B, GetPedInVehicleSeat(PedKiller, -1)) then
                            Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
                        end
                        if Killer == nil then
                            DeathReason = "died"
                        end
                        local weaponName = GetWeaponName(DeathCauseHash)
                        if weaponName then
                            DeathReason = weaponName
                        end

                        if DeathReason == "suicide" or DeathReason == "died" then
                            TriggerServerEvent('redemrp_respawn:server:LogPlayerDeath', { type = 1, player_id = GetPlayerServerId(PlayerId()), death_reason = DeathReason })
                        else
                            TriggerServerEvent('redemrp_respawn:server:LogPlayerDeath', { type = 2, player_id = GetPlayerServerId(PlayerId()), player_2_id = GetPlayerServerId(Killer), death_reason = DeathReason, weapon = Weapon })
                        end
                        -- ON PLAYER DEAD STUFF
                        --
                        --
                        --

                        DisplayHud(false)
                        DisplayRadar(false)
                        exports.spawnmanager:setAutoSpawn(false)
                        --Citizen.InvokeNative(0xFA08722A5EA82DA7, "LensDistDrunk")
                        --Citizen.InvokeNative(0xFDB74C9CC54C3F37, 1.0)
                        TriggerServerEvent("redemrp_respawn:DeadTable", "add")
                        --AnimpostfxPlay("DeathFailMP01")
                        StartDeathCam()
                        onPlayerDead = true
                    end

                    Wait(1)
                    ProcessCamControls()
                    DrawTxt(Config.LocaleTimer .. " " .. tonumber(string.format("%.0f", (((GetGameTimer() - timer) * -1)/1000))), 0.50, 0.80, 0.7, 0.7, true, 255, 255, 255, 255, true)
                    if not medicsAlerted then
                        DrawTxt("[~pa~ENTER~q~] ALERT DOCTORS", 0.50, 0.85, 0.5, 0.5, true, 255, 255, 255, 255, true)
                    else
                        DrawTxt("DOCTORS ALERTED", 0.50, 0.85, 0.5, 0.5, true, 255, 255, 255, 255, true)
                    end

                    if IsControlJustReleased(0, 0xC7B5340A) and not medicsAlerted then
                        medicsAlerted = true
                        TriggerServerEvent("redemrp_doctorjob:server:AlertDead")
                        TrackingDoctors = true
                        TriggerServerEvent("redemrp_respawn:server:TrackDoctors")
                    end
                else
                    break
                end
            end
            while true do
                Wait(0)
                ProcessCamControls()
                if not ConfirmingRespawn then
                    DrawTxt("Press E to Respawn", 0.50, 0.45, 0.8, 0.8, true, 255, 255, 255, 255, true)
                else
                    DrawTxt("Are you sure~n~you want to respawn?~n~(~pa~E~q~) Yes~n~(~pa~BACKSPACE~q~) No", 0.50, 0.45, 0.8, 0.8, true, 255, 255, 255, 255, true)
                end
                if IsControlJustReleased(0, 0xDFF812F9) then
                    if not ConfirmingRespawn then
                        ConfirmingRespawn = true
                    else
                        medicsAlerted = false
                        
                        respawn()
                        revived = false
                        onPlayerDead = false
                        TriggerServerEvent("redemrp_respawn:DeadTable", "remove")
                        break
                    end
                end
                if IsControlJustReleased(0, 0x156F7119) then
                    if ConfirmingRespawn then
                        ConfirmingRespawn = false
                    end
                end
                if revived then
                    medicsAlerted = false
                    onPlayerDead = false
                    TriggerServerEvent("redemrp_respawn:DeadTable", "remove")
                    break
                end
            end
        end
    end
end)



GetWeaponName = function(Weapon)
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon[1]) == Weapon then
			return CurrentWeapon[1]
		end
	end
	return false
end

function respawn(changetown)
    DoScreenFadeOut(100)
    Wait(100)
    ClearFocus()
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)
    cam = nil
    Wait(100)

    local pos = vector3(2813.0659, -1335.537, 46.282081)
    SetEntityCoords(PlayerPedId(), pos)
    DestroyAllCams(true)
    selectcamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 2827.71, -1357.64, 80.57, 0.00, 0.00, 0.00, GetGameplayCamFov())
    SetCamActive(selectcamera, true)
    RenderScriptCams(true, false, 0, true, false)
    PointCamAtCoord(selectcamera, 2827.71, -1357.64, 80.57+10.0)
    Wait(100)
    DoScreenFadeIn(250)

    SendNUIMessage({
        type = 1
    })
    SetNuiFocus(true, true)
    --AnimpostfxStop("DeathFailMP01")
    --ShakeGameplayCam("DRUNK_SHAKE", 0.0)


    local pl = Citizen.InvokeNative(0x217E9DC48139933D)
    local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
    local coords = GetEntityCoords(ped, false)
    SetEntityCoords(ped, coords.x, coords.y, coords.z)
    FreezeEntityPosition(ped, true)
    Citizen.InvokeNative(0x71BC8E838B9C6035, ped)
    Citizen.InvokeNative(0x0E3F4AF2D63491FB)
end

RegisterNetEvent("redemrp_respawn:respawn", function(new)
    newCharacter = new
    respawn(new)
end)

RegisterNetEvent("redemrp_respawn:respawnCoords", function(coords)
    RenderScriptCams(false, true, 100, true, false)
    DestroyCam(selectcamera)
    local ped = PlayerPedId()
    SetEntityCoords(ped, coords.x, coords.y, coords.z)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 2
    })
    FreezeEntityPosition(ped, false)

    ShutdownLoadingScreen()
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 59.95, true, true, false)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    ClearPedTasksImmediately(ped)
    ClearPlayerWantedLevel(PlayerId())
    FreezeEntityPosition(ped, false)
    SetPlayerInvincible(PlayerId(), false)
    SetEntityVisible(ped, true)
    SetEntityCollision(ped, true)
    TriggerEvent('playerSpawned')
    Citizen.InvokeNative(0xF808475FA571D823, true)
    NetworkSetFriendlyFireOption(true)
    RespawnCamera(coords)
    TriggerServerEvent("RedEM:server:RegisterCoords", coords)
    SavePosition()
    revived = false
end)

RegisterNUICallback('select', function(data, cb)
    RenderScriptCams(false, true, 100, true, false)
    DestroyCam(selectcamera)
    local spawn = data.selected
    local coords = Config[spawn][math.random(#Config[spawn])]
    local ped = PlayerPedId()
    SetEntityCoords(ped, coords.x, coords.y, coords.z)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 2
    })
    FreezeEntityPosition(ped, false)

    ShutdownLoadingScreen()
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 59.95, true, true, false)
    local ped = PlayerPedId()
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    ClearPedTasksImmediately(ped)
    ClearPlayerWantedLevel(PlayerId())
    FreezeEntityPosition(ped, false)
    SetPlayerInvincible(PlayerId(), false)
    SetEntityVisible(ped, true)
    SetEntityCollision(ped, true)
    TriggerEvent('playerSpawned', spawn)
    Citizen.InvokeNative(0xF808475FA571D823, true)
    NetworkSetFriendlyFireOption(true)
	if newCharacter then
        TriggerEvent("redemrp_skin:mpskin")
        TriggerServerEvent("RedEM:server:LoadSkin")
	end
    RespawnCamera(coords)
    TriggerServerEvent("RedEM:server:RegisterCoords", coords)
    SavePosition()

    TriggerServerEvent("redemrp_clothing:loadClothes", 1)
end)

local saving = false
function SavePosition()
    if not saving then
        Citizen.CreateThread(function()
            while true do
                Wait(15000)
                local coords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent("RedEM:server:RegisterCoords", {x = coords.x, y = coords.y, z = coords.z})
            end
        end)
        saving = true
    end
end

--sin22
function RespawnCamera(coords)
    local tcam = CreateCamera("DEFAULT_SCRIPTED_CAMERA", true)
    if GetInteriorFromEntity(PlayerPedId()) == 0 then
        SetCamParams(tcam, coords.x, coords.y, coords.z+100.0, 90.0, 0.0, 0.0, 90.0, 1000, 1, 1, 1)
    else
        local offsetCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.25)
        SetCamParams(tcam, offsetCoords.x, offsetCoords.y, offsetCoords.z, 0.0, 0.0, 0.0, 90.0, 1000, 1, 1, 1)
    end
    SetCamActive(tcam, true)
    RenderScriptCams(true, false, 1, true, true)
    PointCamAtEntity(tcam, PlayerPedId(), 0.0, 0.0, 0.0, 1)
    Wait(2000)
    DoScreenFadeIn(250)
    Wait(1000)
    RenderScriptCams(false, true, 1000, true, true)
    DestroyAllCams()
	FreezeEntityPosition(PlayerPedId(), false)

    DisplayHud(true)
    DisplayRadar(true)
end
--=============================================================-- DRAW TEXT SECTION--=============================================================--
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)


    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 1);
	SetTextFontForCurrentCommand(7)
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

--=============================================================-- CAMERA SECTION--=============================================================--

local cam = nil

local isDead = false

local angleY = 0.0
local angleZ = 0.0

function StartDeathCam()
    Citizen.CreateThread(function()
        ClearFocus()

        local playerPed = PlayerPedId()

        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(playerPed), 0, 0, 0, GetGameplayCamFov())
        --ShakeCam(cam, "DRUNK_SHAKE", 0.5)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 1000, true, false)
    end)
end

function EndDeathCam()
    Citizen.CreateThread(function()
        ClearFocus()
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(cam, false)
        cam = nil
    end)
end


function ProcessCamControls()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        DisableFirstPersonCamThisFrame()
        local newPos = ProcessNewPosition()
        SetCamCoord(cam, newPos.x, newPos.y, newPos.z)
        PointCamAtCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
    end)
end

function ProcessNewPosition()
    local mouseX = 0.0
    local mouseY = 0.0


    -- keyboard
    if (IsInputDisabled(0)) then
        -- rotation
        mouseX = GetDisabledControlNormal(1, 0x4D8FB4C1) * 3.0
        mouseY = GetDisabledControlNormal(1, 0xFDA83190) * 3.0

        -- controller
    else
        -- rotation
        mouseX = GetDisabledControlNormal(1, 0x4D8FB4C1) * 1.0
        mouseY = GetDisabledControlNormal(1, 0xFDA83190) * 1.0
    end
    angleZ = angleZ - mouseX -- around Z axis (left / right)
    angleY = angleY + mouseY -- up / down
    -- limit up / down angle to 90°
    if (angleY > 89.0) then angleY = 89.0 elseif (angleY < -89.0) then angleY = -89.0 end

    local pCoords = GetEntityCoords(PlayerPedId())

    local behindCam = {
        x = pCoords.x + ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * (1.5 + 0.5),
        y = pCoords.y + ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * (1.5 + 0.5),
        z = pCoords.z + ((Sin(angleY))) * (1.5 + 0.5)
    }
    local rayHandle = StartShapeTestRay(pCoords.x, pCoords.y, pCoords.z + 0.5, behindCam.x, behindCam.y, behindCam.z, -1, PlayerPedId(), 0)
    local a, hitBool, hitCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

    local maxRadius = 1.5
    if (hitBool and Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords) < 1.5 + 0.5) then
        maxRadius = Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords)
    end

    local offset = {
        x = ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * maxRadius,
        y = ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * maxRadius,
        z = ((Sin(angleY))) * maxRadius
    }

    local pos = {
        x = pCoords.x + offset.x,
        y = pCoords.y + offset.y,
        z = pCoords.z + offset.z
    }

    return pos
end
