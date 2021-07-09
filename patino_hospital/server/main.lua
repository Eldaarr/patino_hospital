if not Config.UsingESXLegacy then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

-- Check if player have money
ESX.RegisterServerCallback('patino_hospital:canPay', function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = Config.ReviveInvoice

    if xPlayer.getAccount('money').money >= price then
        xPlayer.removeAccountMoney('money', price)
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('patino_hospital:checkEMS', function(source, cb, emsRequired)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    local emsConnected = 0
    local emsRequired = Config.EMSRequired
    

    if Config.UsingESXLegacy then
        local xPlayers = ESX.GetExtendedPlayers('job', Config.EMSJobName)
        for _, xPlayer in pairs(xPlayers) do
            if xPlayer.job.name == Config.EMSJobName then
                emsConnected = emsConnected + 1
            end
        end
    else
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == Config.EMSJobName then
                emsConnected = emsConnected + 1
            end
        end
    end

    if emsConnected >= emsRequired then
        cb(true)
    else
        cb(false)
    end
        

end)
