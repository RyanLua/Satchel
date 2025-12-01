--!strict

local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local Slot = require("../Components/Slot")

local controls = {
	toolName = "Sword",
	slotNumber = "9",
	toolImage = "rbxasset://Textures/Sword128.png",
	tooltipText = "A classic sword",
	equipped = false,
	unlocked = false,
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props)
		return React.createElement(Slot, {
			toolName = props.controls.toolName,
			slotNumber = props.controls.slotNumber,
			toolImage = props.controls.toolImage,
			tooltipText = props.controls.tooltipText,
			equipped = props.controls.equipped,
			unlocked = props.controls.unlocked,
			onActivated = function()
				print("Slot activated")
			end,
		})
	end,
}
