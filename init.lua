
local interval = core.settings:get("autorestart_interval") or 24*60*60
local restartdelay = core.settings:get("autorestart_delay") or 10*60

local polldelay = 5
local waittime = 0

local function dotherestart()
	core.request_shutdown("Server is restarting. Please reconnect in a couple seconds.", true, 5)
end

local function pollplayers()
	waittime = waittime + polldelay
	if #core.get_connected_players() > 0 and waittime < restartdelay then
		core.after(polldelay, pollplayers)
	else
		dotherestart()
	end
end

core.after(interval, function()
	if #core.get_connected_players() > 0 and restartdelay ~= 0 then
		core.chat_send_all(red("Server is restarting soon!"))
		core.chat_send_all(yellow("The server will automatically restart in "..(restartdelay/60).." minutes, or right away if no players are online."))

		core.after(polldelay, pollplayers)
	else
		dotherestart()
	end
end)
