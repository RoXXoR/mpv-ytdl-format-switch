-- Domains list for domains to use ytdl-format settings, other use defaults
local function Set (t)
	local set = {}
	for _, v in pairs(t) do set[v] = true end
	return set
end

local StreamSource = Set {
	'youtu.be', 'youtube.com', 'www.youtube.com' 
}

local function getStreamSource(path)
	local hostname = path:match '^%a+://([^/]+)/' or ''
	return hostname:match '([%w%.]+%w+)$'
end

-- local msg = require 'mp.msg'

local function setYTdlFormat()
	local path = mp.get_property("path", "")
--	msg.info("Current file: "..path)
--	msg.info("Current ytdl-format: "..mp.get_property("ytdl-format"))
	if not StreamSource[getStreamSource(string.lower(path))] then
		mp.set_property("ytdl-format", "")
	end
--	msg.info("Current ytdl-format: "..mp.get_property("ytdl-format"))
end

mp.add_hook("on_load", 10, setYTdlFormat)

