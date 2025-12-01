--!strict

local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

return {
	name = "Satchel",
	storyRoots = {
		script.Parent,
	},
	packages = {
		React = React,
		ReactRoblox = ReactRoblox,
	},
}
