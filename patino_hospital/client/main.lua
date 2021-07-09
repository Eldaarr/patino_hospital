if not Config.UsingESXLegacy then
    ESX = nil
    Citizen.CreateThread(function()
    	while ESX == nil do
    		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    		Citizen.Wait(0)
    	end
    end)
end

-- Creating the ped
Citizen.CreateThread(function()

    createNpc()
end)

-- Creating the ped function
function createNpc()

    RequestModel(GetHashKey("s_m_m_doctor_01"))
    while (not HasModelLoaded(GetHashKey("s_m_m_doctor_01"))) do
        Citizen.Wait(1)
    end

    -- Check for locations
    for k,v in pairs(Config.PedLocations) do
        local npc = CreatePed(5, Config.PedModel, v.x, v.y, v.z-0.95, v.h, false, true)

        -- Prevent to NPC to be agressive or move by a player
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
    end

end

-- CREATE 3D TEXT
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    local color = Config.Text.Color
    SetTextScale(Config.Text.Scale, Config.Text.Scale)
    SetTextFont(Config.Text.Font)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

Citizen.CreateThread(function()
    while true do
        local letSleep = true
        local wait = 5
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for k,v in pairs(Config.PedLocations) do
            local dist = #(playerCoords - vector3(v.x, v.y, v.z))
            if dist <= Config.Text.Distance then
                letSleep = false
                DrawText3D(v.x, v.y, v.z, Locales[Config.Language]['press_to_heal'])
                if IsControlJustReleased(0, 38) then

                    if IsEntityDead(playerPed) then
                    
                        ESX.TriggerServerCallback('patino_hospital:canPay', function(canPay)
                            if canPay then
                                if Config.UseRprogress then
                                    exports.rprogress:Custom({
                                        Duration = 10000,
                                        Label = "Doctor is checking you...",
                                        DisableControls = {
                                            Mouse = false,
                                            Player = true,
                                            Vehicle = true
                                        }
                                    })
                                    Citizen.Wait(10000)
                                    TriggerEvent('esx_ambulancejob:revive')
                                    ESX.ShowNotification(Locales[Config.Language]['successfully_paid'])
                                else
                                    TriggerEvent('esx_ambulancejob:revive')
                                    ESX.ShowNotification(Locales[Config.Language]['successfully_paid'])
                                end
                            else
                                ESX.ShowNotification(Locales[Config.Language]['not_enough_money'])
                            end

                        end, price)

                    else
                        ESX.ShowNotification(Locales[Config.Language]['player_is_not_dead'])
                    end
                end
            end
        end

        if letSleep then
            Citizen.Wait(1000)
        end

        Citizen.Wait(wait)
    end
end)
