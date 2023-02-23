
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)







--MY CODE


ESX.RegisterServerCallback('char_info', function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[2]
    
    local identik = string.sub(identifier, 9, identifier:len())
    MySQL.Async.fetchAll('SELECT `firstname`, `lastname`, `position`, `leavetime` FROM `users` WHERE `identifier` = @identifier', {
        ['@identifier'] = identik
    }, function(result)
        if #result > 0 then
            cb(true, result)
        else
            cb(false)
        end
    end)
end)






ESX.RegisterServerCallback('char_time', function(source)
    local identifier2 = GetPlayerIdentifiers(source)[2]

    local identik2 = string.sub(identifier2, 9, identifier2:len())
    local date = os.date("%d/%m/%Y %H:%M")
    MySQL.Async.execute("UPDATE users SET leavetime='" .. date .. "' WHERE identifier='" .. identik2.."';")
end)