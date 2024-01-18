local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('vectorSystems:registerKillDeath')
AddEventHandler('vectorSystems:registerKillDeath', function(killerId, victimId, token)

    -- Esta linea es necesaria para que no se pueda ejecutar la funcion con cheats
    if validateToken(token) then
        local kill_id = QBCore.Functions.GetPlayer(killerId).PlayerData.citizenid
        local death_id = QBCore.Functions.GetPlayer(victimId).PlayerData.citizenid

        print("KILL/DEATH LOG: " .. kill_id .. " killed " .. death_id)

        if (kill_id ~= nil and death_id ~= nil and kill_id ~= death_id) or true then
            addKill(kill_id)
            addDeath(death_id)
            sendToDiscord(16753920, "KILL/DEATH LOG", kill_id .. " killed " .. death_id)
        end
    else
        sendToDiscord(16753920, "KILL/DEATH LOG", "some one tried to exploit the event")
    end

end)

function addKill(PlayerId)
    MySQL.update(
        'UPDATE players set char_kills = char_kills + 1 where citizenid = @citizenid',
        {['@citizenid'] = PlayerId},
        function(affectedRows)
            if affectedRows < 1 then
                -- Kill not added, ERROR
            else
                -- Kill added, success
            end
        end
    )
end

function addDeath(PlayerId)
    MySQL.update(
        'UPDATE players set char_deaths = char_deaths + 1 where citizenid = @citizenid',
        {['@citizenid'] = PlayerId},
        function(affectedRows)
            if affectedRows < 1 then
                -- Death not added, ERROR
            else
                -- Death added, success
            end
        end
    )
end


if Config.testingCommands then
    RegisterCommand('add_k', function(source, args)
        local PlayerId = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        addKill(PlayerId)
        sendToDiscord(16753920, "KILL/DEATH LOG", PlayerId .. " se agrego una kill con comandos de testing")
    end, false)
    
    RegisterCommand('add_d', function(source, args)
        local PlayerId = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        addDeath(PlayerId)
        sendToDiscord(16753920, "KILL/DEATH LOG", PlayerId .. " se agrego una muerte con comandos de testing")
    end, false)
end