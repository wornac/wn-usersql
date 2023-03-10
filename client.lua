local Framework = nil

Citizen.CreateThread(function()
    Framework = GetFramework()
end)

Citizen.CreateThread(function()
    while Framework == nil do
        Citizen.Wait(7)
    end
        if Settings.Framework == 'QBCore' or Settings.Framework == 'OldQBCore' then
            RegisterNUICallback("DeletePlayer", function(data) Framework.Functions.TriggerCallback("DeletePlayer", function() end, data.phone) end)
            
            RegisterCommand("adminsql", function()
                Framework.Functions.TriggerCallback('getAllPlayerData', function(data)
                    for _, player in ipairs(data) do
                    local charinfo, job = json.decode(player.charinfo), json.decode(player.job)
                    SendNUIMessage ({  msg = "Info",  firstname = charinfo.firstname,  jobs = job.name,  phone = charinfo.phone,  sex = charinfo.gender })
                    Open()
                end
            end)
        end)
        elseif Settings.Framework == 'ESX' or Settings.Framework == 'NewESX' then

            RegisterNUICallback("DeletePlayer", function(data) Framework.TriggerServerCallback("DeletePlayer", function() end, data.phone) end)
            
            RegisterCommand("adminsql", function()
                Framework.TriggerServerCallback('getAllPlayerData', function(data)
                    local gender = data[1].sex == "m" and "Male" or "Woman"
                    SendNUIMessage({ msg = "Info", firstname = data[1].firstname, jobs = data[1].job, phone = data[1].phone_number, sex = gender })
                    Open()
                end)
            end)
        end
end)

RegisterNUICallback("Close", function() Close() end)

function Open()
    SetNuiFocus(true, true)
    SendNUIMessage({msg = "Open"})
    DisplayHud(false)
    DisplayRadar(false)
end

function Close()
    SetNuiFocus(false, false)
    SendNUIMessage({msg = "Close"})
    DisplayHud(true)
    DisplayRadar(true)
end