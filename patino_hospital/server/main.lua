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