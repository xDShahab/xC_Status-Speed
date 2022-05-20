ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

AddEventHandler("onKeyUP",function(b)
    if b == "g" then
        SendNUIMessage({action = "playerinfo"})
    end
end)

CreateThread(function()
    while true do
        Wait(300)
        local c = PlayerPedId()
        local d = IsPedInAnyVehicle(c, false)
        if d then
            Show = true
            local e = GetVehiclePedIsIn(c)
            local f = GetVehicleFuelLevel(e)
            local g = GetEntitySpeed(e) * 3.6
            local h = GetVehicleCurrentGear(e)
            SendNUIMessage({action = "carhud", show = Show, speed = g, fuel = f, gear = h})
        else
            Show = false
            SendNUIMessage({action = "carhud", show = Show})
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        ESX.TriggerServerCallback("xCoore:GetPlayerData",function(i)
            SendNUIMessage(
                {
                    action = "playerdata",
                    playername = i.name,
                    money = MakeDigit(i.money),
                    playerid = GetPlayerServerId(PlayerId()),
                    job = i.job.label .. " | " .. i.job.grade_label,
                    gang = i.gang.name .. " | " .. i.gang.grade_label
                }
            )
        end)
        Citizen.Wait(8000)
    end
end)
function time()
    hour = GetClockHours()
    minute = GetClockMinutes()
    if hour <= 9 then
        hour = "0" .. hour
    end
    if minute <= 9 then
        minute = "0" .. minute
    end
    return hour .. ":" .. minute
end
function MakeDigit(j)
    local k, l, m = string.match(j, "^([^%d]*%d)(%d*)(.-)$")
    return "$" .. k .. l:reverse():gsub("(%d%d%d)", "%1" .. ","):reverse() .. m
end
CreateThread(function()
    while true do
        Citizen.Wait(10000)
        SendNUIMessage({action = "time", clock = time(), name = GetPlayerName(source)})
    end
end)