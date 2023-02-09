fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
shared_script 	'config.lua'
client_scripts {
	'client/main.lua'
}

server_scripts {
	'server/main.lua',
	'@oxmysql/lib/MySQL.lua'
}

files{
	'html/css/grid.css',
	'html/img/armadillo.png',
	'html/img/chuparosa.png',
	'html/img/rhodes.png',
	'html/img/strawberry.png',
	'html/img/tumbleweed.png',
	'html/img/vanhorn.png',
	'html/index.html',
}

ui_page 'html/index.html'