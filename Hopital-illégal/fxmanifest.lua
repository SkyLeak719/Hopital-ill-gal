fx_version 'cerulean'
game 'gta5'

author 'Spencers'
description 'Service médical illégal avec ox_lib et ox_target'
version '1.0.1'

shared_script '@ox_lib/init.lua'

client_scripts {
    '@es_extended/imports.lua',
    'client/main.lua'
}

server_scripts {
    '@es_extended/imports.lua',
    'server/main.lua'
}

dependencies {
    'es_extended',
    'ox_lib',
    'ox_target',
}

lua54 'yes'