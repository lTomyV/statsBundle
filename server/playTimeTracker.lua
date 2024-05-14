local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)

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

--================================================================================================
--========================================= CALLBACKS ============================================
--================================================================================================
QBCore.Functions.CreateCallback('statsBundle:GetPlayTime', function(source, cb)
    local PlayerId = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
    MySQL.Async.fetchAll(
        'SELECT play_time FROM players WHERE citizenid = @citizenid',
        {['@citizenid'] = PlayerId},
        function(result)
            if result[1] then
                cb(result[1].play_time)
            else
                cb(0)
            end
        end
    )
end)