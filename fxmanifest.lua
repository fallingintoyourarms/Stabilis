fx_version 'cerulean'
game 'gta5'

name 'Stabilis'
description 'Automatic resource monitor & cleanup system'
version '1.0.0'

server_scripts {
    'config.lua',
    'shared/utils.lua',
    'server/monitor.lua',
    'server/detection.lua',
    'server/cleanup.lua',
    'server/main.lua',
    'server/restart.lua'
}