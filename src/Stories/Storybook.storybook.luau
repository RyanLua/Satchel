--!strict

local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

return {
	name = script.Parent.Name,
	storyRoots = {
		script.Parent,
	},
	packages = {
		React = React,
		ReactRoblox = ReactRoblox,
	},
}
