--!strict

local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local Slot = require("../Components/Slot")

local controls = {
	IsTenFootInterface = false,
	toolName = "Tool name",
	textureIcon = "rbxasset://textures/ui/GuiImagePlaceholder.png",
	slotNumber = "0",
	equipped = false,
	locked = false,
}

type Props = {
	controls: typeof(controls),
}

return {
	summary = "A slot for a tool",
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props: Props)
		return React.createElement(Slot, {
			IsTenFootInterface = props.controls.IsTenFootInterface,
			toolName = props.controls.toolName,
			slotNumber = props.controls.slotNumber,
			textureIcon = props.controls.textureIcon,
			equipped = props.controls.equipped,
			locked = props.controls.locked,
			onActivated = function()
				print("Slot activated")
			end,
		})
	end,
}
