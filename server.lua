local Framework = nil

Citizen.CreateThread(function()
    Framework = GetFramework()
end)

Citizen.CreateThread(function()
    while Framework == nil do
        Citizen.Wait(7)
    end
    if Settings.Framework == 'QBCore' or Settings.Framework == 'OldQBCore' then
        Framework.Functions.CreateCallback('getAllPlayerData', function(source, cb)
            ExecuteSql('SELECT * FROM players', function(players)
                for _, player in ipairs(players) do
                    local charinfo = json.decode(player.charinfo)
                    local job = json.decode(player.job)
                end
                cb(players)
            end)
        end)
        Framework.Functions.CreateCallback("DeletePlayer", function(source, cb, phone)
            ExecuteSql("SELECT * FROM players WHERE `charinfo` LIKE '%" .. phone .. "%'", function(result)
                if result and result[1] ~= nil then
                    ExecuteSql("DELETE FROM players WHERE `charinfo` LIKE '%" .. phone .. "%'", function(rowsChanged)
                        print("Deleted player with phone number: " .. phone)
                        cb(rowsChanged ~= 0)
                    end)
                else
                    print("No player found with phone number: " .. phone)
                    cb(false)
                end
            end)
        end)        
    elseif Settings.Framework == 'ESX' or Settings.Framework == 'NewESX' then
        Framework.RegisterServerCallback('getAllPlayerData', function(source, cb)
            ExecuteSql('SELECT job, firstname, sex, phone_number FROM users', function(players)
                cb(players)
            end)
        end)
        Framework.RegisterServerCallback("DeletePlayer", function(source, cb, phone)
            ExecuteSql("SELECT * FROM users WHERE phone_number = '" .. phone .. "' LIMIT 1", function(result)
                if result and result[1] ~= nil then
                    ExecuteSql("DELETE FROM users WHERE phone_number = '" .. phone .. "'", function(rowsChanged)
                        print("Deleted player with phone number: " .. phone)
                        cb(rowsChanged ~= 0)
                    end)
                else
                    print("No player found with phone number: " .. phone)
                    cb(false)
                end
            end)
        end)                                                    
    end
end)

