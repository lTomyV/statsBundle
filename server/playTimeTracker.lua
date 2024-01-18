local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        print("Adding playtime")

        local citizenIDs = {}

        for _, player in ipairs(GetPlayers()) do
            local player = tonumber(player)
            local playerData = QBCore.Functions.GetPlayer(player)
            if playerData then
                table.insert(citizenIDs, playerData.PlayerData.citizenid)
            end
        end

        local quotedIDs = {}
        for _, id in ipairs(citizenIDs) do
            table.insert(quotedIDs, "'" .. id .. "'")
        end
        
        local query = 'UPDATE players SET play_time = play_time + 5 WHERE citizenid IN (' .. table.concat(quotedIDs, ', ') .. ');'
        
        MySQL.Async.execute(query, {}, function(affectedRows)
            if affectedRows < 1 then
                -- No one changed, ERROR or No one online
            else
                -- Playtime added, success
            end
        end)
        
    end
end)