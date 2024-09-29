fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'AxelWarZ'
description 'Script to start music in specific zones'
version '1.0.0'

client_scripts {
    'client.lua'
}

files {
    'index.html',
    'sounds/*.mp3',
}

ui_page 'index.html'

server_script 'server.lua'
