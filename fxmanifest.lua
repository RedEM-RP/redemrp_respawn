fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
client_scripts {
	'config.lua',
	'client/cl_main.lua'
}

server_scripts {
	'server/sv_main.lua',
	'@mysql-async/lib/MySQL.lua',
}

files{
'html/map.jpg',
'html/map_shadow.jpg',
'html/map2.html',
'html/js/listener.js',
'html/js/jquery-func.js',
'html/js/jquery-1.4.1.min.js',
'html/js/jquery.jcarousel.pack.js'
}

ui_page 'html/map2.html'