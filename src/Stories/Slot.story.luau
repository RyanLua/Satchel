local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local Slot = require("../Components/Slot")

return {
	summary = "A generic button component that can be used anywhere",
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		return React.createElement(Slot, {
			toolName = "Tool ",
		})
	end,
}
