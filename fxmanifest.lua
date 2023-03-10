fx_version "cerulean"
game "gta5"
lua54 'yes'

client_scripts {
  'client.lua',
}

server_scripts {
  'server.lua',
}

shared_scripts {
  'Settings.lua'
}

files {
  'src/html/*.*',
  'src/Assets/*.*',
}

ui_page 'src/html/ui.html'