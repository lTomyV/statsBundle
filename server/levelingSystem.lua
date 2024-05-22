local QBCore = exports['qb-core']:GetCoreObject()


--================================================================================================
--======================================= ADD XP =================================================
--================================================================================================
RegisterServerEvent('statsBundle:addXp')
AddEventHandler('statsBundle:addXp', function(xp, token)
    if validateToken(token) then
        local PlayerId = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        addXp(PlayerId, xp)
    else
        sendToDiscord(16753920, "XP LOG", "some one tried to exploit statsBundle:addXp")
    end
end)

-- Column is char_xp in table players
function addXp(PlayerId, xp)
    MySQL.update(
        'UPDATE players set char_xp = char_xp + @xp where citizenid = @citizenid',
        {['@citizenid'] = PlayerId, ['@xp'] = xp},
        function(affectedRows)
            if affectedRows < 1 then
                sendToDiscord(16753920, "XP LOG", "ERROR: No se pudo agregar " .. xp .. " xp a " .. PlayerId)
            else
                sendToDiscord(16753920, "XP LOG", PlayerId .. " ganó " .. xp .. " xp")
            end
        end
    )
end


--================================================================================================
--========================================= REMOVE XP ============================================
--================================================================================================
RegisterServerEvent('statsBundle:removeXp')
AddEventHandler('statsBundle:removeXp', function(xp, token)
    if validateToken(token) then
        local PlayerId = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        removeXp(PlayerId, xp)
    else
        sendToDiscord(16753920, "XP LOG", "some one tried to exploit statsBundle:removeXp")
    end
end)

-- Column is char_xp in table players
function removeXp(PlayerId, xp)
    MySQL.update(
        'UPDATE players set char_xp = char_xp - @xp where citizenid = @citizenid',
        {['@citizenid'] = PlayerId, ['@xp'] = xp},
        function(affectedRows)
            if affectedRows < 1 then
                sendToDiscord(16753920, "XP LOG", "ERROR: No se pudo quitar " .. xp .. " xp a " .. PlayerId)
            else
                sendToDiscord(16753920, "XP LOG", PlayerId .. " perdió " .. xp .. " xp")
            end
        end
    )
end


-- Callbacks

--================================================================================================
--========================================= GET XP ===============================================
--================================================================================================
QBCore.Functions.CreateCallback('statsBundle:GetLevel', function(source, cb)
    local PlayerId = QBCore.Functions.GetPlayer(source).PlayerData.citizenid

    MySQL.Async.fetchAll(
        'SELECT char_xp FROM players WHERE citizenid = @citizenid',
        {['@citizenid'] = PlayerId},
        function(result)
            if result[1] then
                local xpL = result[1].char_xp
                local levelL, progressL = calculateLevelAndProgress(xpL)
                local readyCB = {xp = xpL, level = levelL, progress = progressL}
                cb(readyCB)
            else
                cb(0)
            end
        end
    )
end)

function calculateLevelAndProgress(currentXP)
    local level = 1
    local xpForNextLevel = Config.levelOneXP

    while currentXP >= xpForNextLevel do
        currentXP = currentXP - xpForNextLevel
        level = level + 1
        xpForNextLevel = xpForNextLevel * Config.xpMultiplierToNextLevel
    end

    local progress = (currentXP / xpForNextLevel) * 100

    return level, progress
end
