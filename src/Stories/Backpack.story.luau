--!strict

local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local Backpack = require("../Components/Backpack")

return {
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		return React.createElement(Backpack)
	end,
}
