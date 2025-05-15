local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local Hotbar = require("../Components/Hotbar")
local Slot = require("../Components/Slot")

return {
	summary = "Hotbar which holds tool slots",
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		return React.createElement(Hotbar, {
			child = React.createElement(Slot, {
				toolName = "Tool",
				slotNumber = "0",
			}),
		}, {})
	end,
}
