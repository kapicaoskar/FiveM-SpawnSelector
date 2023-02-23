fx_version 'adamant'

game 'gta5'
lua54 'yes'

author 'https://github.com/kapicaoskar'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/server.lua'
}

client_scripts {
    'config.lua',
    'client/client.lua'
}

ui_pages {
    'public/index.html'
}

files {
    'public/index.html',
    'public/css/root.css',
    'public/script/js.js'
}

escrow_ignore {
    'config.lua'
}

