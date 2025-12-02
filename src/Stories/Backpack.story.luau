--!strict

local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local Backpack = require("../Components/Backpack")

return {
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		local component = React.createElement(Backpack, {})

		return component
	end,
}
