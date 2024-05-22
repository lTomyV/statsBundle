local QBCore = exports['qb-core']:GetCoreObject()

local tokenList = {}

function generateToken()
    local token = ""
    for i = 1, 16 do
        local rand = math.random(1, 3)
        if rand == 1 then
            token = token .. string.char(math.random(48, 57))
        elseif rand == 2 then
            token = token .. string.char(math.random(65, 90))
        else
            token = token .. string.char(math.random(97, 122))
        end
    end
    table.insert(tokenList, token)
    return token
end

function validateToken(token)
    for i = 1, #tokenList do
        if tokenList[i] == token then
            table.remove(tokenList, i)
            return true
        end
    end
    return false
end

QBCore.Functions.CreateCallback('vectorSystems:generateToken', function(source, cb)
    local token = GenerateToken()
    cb(token)
end)
