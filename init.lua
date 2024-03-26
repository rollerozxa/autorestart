
local interval = minetest.settings:get("autorestart_interval") or 24*60*60
local restartdelay = minetest.settings:get("autorestart_delay") or 10*60

local shouldrestart = false

local polldelay = 5
local waittime = 0

local function dotherestart()
	minetest.request_shutdown("Server is restarting. Please reconnect in a couple seconds.", true, 5)
end

local function pollplayers()
	waittime = waittime + polldelay
	if #minetest.get_connected_players() > 0 and waittime < restartdelay then
		minetest.after(polldelay, pollplayers)
	else
		dotherestart()
	end
end

minetest.after(interval, function()
	shouldrestart = true
	if #minetest.get_connected_players() > 0 and restartdelay ~= 0 then
		minetest.chat_send_all(red("Server is restarting soon!"))
		minetest.chat_send_all(yellow("The server will automatically restart in "..(restartdelay/60).." minutes, or right away if no players are online."))

		minetest.after(polldelay, pollplayers)
	else
		dotherestart()
	end
end)
