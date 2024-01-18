fx_version 'cerulean'
game 'gta5'

description 'QB-ptk_stats'
version '1.0.0'

shared_scripts {
    'config.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'utils/vectorTokenValidator_QB.lua',
    'utils/vectorDiscordWebhook.lua',
    'server/killTracker.lua',
    'server/playTimeTracker.lua'
}
client_scripts {
    'client/killTracker.lua'
}

escrow_ignore {
    'client/*',
    'server/*',
    'SQL/*',
    'config.lua'
}

lua54 'yes'
dependency '/assetpacks'