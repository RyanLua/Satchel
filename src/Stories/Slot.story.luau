local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local Slot = require("../Components/Slot")

return {
	summary = "A slot for a tool",
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		return React.createElement(Slot, {
			toolName = "Tool Name",
			slotNumber = "0",
			textureIcon = "rbxasset://textures/ui/GuiImagePlaceholder.png",
			equipped = true,
			onActivated = function()
				print("click")
			end,
		})
	end,
}
