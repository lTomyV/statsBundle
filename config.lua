Config = {}


Config.consoleDebug = false
Config.discordWebhook = "https://discord.com/api/webhooks/1136813686770630697/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
Config.testingCommands = false
--[[
    Lista de comandos:
    - /add_k => Añade una kill al jugador que lo ejecuta
    - /add_d => Añade una muerte al jugador que lo ejecuta
    - /add_h => Añade una hora de juego al jugador que lo ejecuta
]]


--================================================================================================
--================================================================================================
--======================================== LEVELING SYSTEM =======================================
--================================================================================================
--================================================================================================
Config.levelOneXP = 100
Config.xpMultiplierToNextLevel = 2 -- If level 1 is 100xp, level 2 will be 200xp, level 3 will be 400xp, etc.