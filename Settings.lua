Settings = {

    Framework = 'QBCore', -- QBCore - ESX - OldQBCore - NewESX 
    Mysql = 'oxmysql', -- oxmysql, ghmattimysql, mysql-async

}

function GetFramework()
    local Get = nil
    if Settings.Framework == "ESX" then
        while Get == nil do
            TriggerEvent('esx:getSharedObject', function(Set)
                Get = Set
            end)
            Citizen.Wait(0)
        end
    end
    if Settings.Framework == "NewESX" then
        Get = exports['es_extended']:getSharedObject()
    end
    if Settings.Framework == "QBCore" then
        Get = exports["qb-core"]:GetCoreObject()
    end
    if Settings.Framework == "OldQBCore" then
        while Get == nil do
            TriggerEvent('QBCore:GetObject', function(Set)
                Get = Set
            end)
            Citizen.Wait(200)
        end
    end
    return Get
end

function ExecuteSql(query, cb)
    if Settings.Mysql == "oxmysql" then
        if MySQL == nil then
            exports.oxmysql:execute(query, {}, cb)
        else
            MySQL.query(query, {}, cb)
        end
    elseif Settings.Mysql == "ghmattimysql" then
        exports.ghmattimysql:execute(query, {}, cb)
    elseif Settings.Mysql == "mysql-async" then
        MySQL.Async.fetchAll(query, {}, cb)
    end
end

