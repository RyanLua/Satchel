--!strict

local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local Slot = require("../Components/Slot")

local controls = {
	ToolName = "Sword",
	SlotNumber = 9,
	ToolImage = "rbxasset://Textures/Sword128.png",
	TooltipText = "A classic sword",
	Equipped = false,
	Unlocked = false,
}

return {
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,
	story = function(props)
		local component = React.createElement(Slot, {
			toolName = props.controls.ToolName,
			slotNumber = props.controls.SlotNumber,
			toolImage = props.controls.ToolImage,
			tooltipText = props.controls.TooltipText,
			equipped = props.controls.Equipped,
			unlocked = props.controls.Unlocked,
		})

		return component
	end,
}
