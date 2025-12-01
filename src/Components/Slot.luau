--!strict

local React = require("../../react")

export type TooltipTextLabel = {
	toolName: string,
	toolImage: string?,
	slotNumber: number?,
	unlocked: boolean?,
	equipped: boolean?,
}

local function TooltipTextLabel(props: TooltipTextLabel)
	local isUnlocked = props.unlocked or false
	local isEquipped = props.equipped or false

	-- Determine tags based on slot state
	local tags = "slot"
	if isUnlocked then
		tags = tags .. " unlocked"
	end
	if isEquipped then
		tags = tags .. " equipped"
	end

	return React.createElement("TextLabel", {
		Text = props.toolName,
		[React.Tag] = tags,
	})
end

return TooltipTextLabel
