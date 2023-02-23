

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1000)
    end
end)



--TESTING COMMAND
RegisterCommand("multichar", function()
TriggerEvent('OSKAR:CHARACTERS-SETUP')
end)






-- Setup TriggerEvent('OSKAR:CHARACTERS-SETUP')
RegisterNetEvent('OSKAR:CHARACTERS-SETUP')
AddEventHandler('OSKAR:CHARACTERS-SETUP', function()
    SetNuiFocus(true,true)
    SendNUIMessage({ type = 'OPEN_CHARS' })
    if Config.ChangeCharTrigger == "none" then 
        SendNUIMessage({ type = 'NONE_CHAR' })
    end
    
    --char info
    ESX.TriggerServerCallback('char_info', function(target, data)
        if target then

            
            local  firstname  = data[1].firstname 
            local  lastname = data[1].lastname 
            local  leavetime = data[1].leavetime
            local  position  = json.decode(data[1].position)
            local   street, route = GetStreetNameAtCoord(position.x, position.y, position.z)
            local   ulica = GetStreetNameFromHashKey(street)
            
            

            SendNUIMessage({
                type = "UPDATE_INFO",
                firstname = firstname,
                lastname = lastname,
                leavetime = leavetime,
                position = json.encode(position),
                ulica = ulica,
            })
        else
            print('error sql bad sql trigger')
        end
    end)

end)



--SPAWN MAIN
local spawnCoords
RegisterNUICallback("spawn", function(data) 
    
    SetNuiFocus(false,false)
    ESX.TriggerServerCallback('char_time')
    if data then 
        Citizen.CreateThread(function()
        while true do
            Citizen.Wait(60000)
            ESX.TriggerServerCallback('char_time')
        end
    end)
    if data.data.name == 'last_spawn' then
        ESX.TriggerServerCallback('char_info', function(target, data)
            if target then

                local cam = nil
                local  position2  = json.decode(data[1].position)
                cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1718.61,1553.65,1553.65, 300.00,500.00,0.00, 100.00, false, 0)
                SetCamActive(cam, true)
                RenderScriptCams(true, false, 1, true, true)
                SetEntityCoords(GetPlayerPed(-1), position2.x,position2.y,position2.z, 1, 0, 0, 1)
                cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1718.61,1553.65,1553.65, 300.00,500.00,0.00, 100.00, false, 0)
                PointCamAtCoord(cam, position2.x,position2.y,position2.z+2)
                SetCamActiveWithInterp(cam, 3700, true, true)
                Citizen.Wait(3700)
                PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
                RenderScriptCams(false, true, 500, true, true)
                PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
                FreezeEntityPosition(GetPlayerPed(-1), false)
                ShakeGameplayCam("MEDIUM_EXPLOSION_SHAKE  ", 1.0)
                Citizen.Wait(500)
                SetCamActive(cam, false)
                DestroyCam(cam, true)
            else
                print('error sql bad sql trigger')
            end
        end)




    else





    local cam = nil
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1718.61,1553.65,1553.65, 300.00,500.00,0.00, 100.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)

    spawnCoords = Config.Spots[data.data.name]
    SetEntityCoords(GetPlayerPed(-1), spawnCoords.x,spawnCoords.y,spawnCoords.z, 1, 0, 0, 1)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1718.61,1553.65,1553.65, 300.00,500.00,0.00, 100.00, false, 0)
    PointCamAtCoord(cam, spawnCoords.x,spawnCoords.y,spawnCoords.z+2)
    SetCamActiveWithInterp(cam, 3700, true, true)
    Citizen.Wait(3700)
    PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    ShakeGameplayCam("MEDIUM_EXPLOSION_SHAKE  ", 1.0)
    Citizen.Wait(500)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    end
end
end)


--CHANGE CHARACTER
RegisterNUICallback("changechar", function(data)
    if data then 
SetNuiFocus(false,false)
if Config.ChangeChar == 'server' then
    TriggerServerEvent(Config.ChangeCharTrigger)
elseif Config.ChangeChar == 'client' then
    TriggerEvent(Config.ChangeCharTrigger)
end
end
end)