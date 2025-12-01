--!strict

local React = require("../../react")

local Tooltip = require("./Tooltip")

export type SlotTextLabelProps = {
	equipped: boolean?,
	unlocked: boolean?,

	toolImage: string?,
	toolName: string?,
	slotNumber: number?,
	tooltipText: string?,
}

local function SlotTextLabel(props: SlotTextLabelProps)
	-- Determine tags based on slot state
	local tags = "slot"
	if props.unlocked then
		tags = tags .. " unlocked"
	end
	if props.equipped then
		tags = tags .. " equipped"
	end

	return React.createElement("TextLabel", {
		Text = props.toolName or "",
		[React.Tag] = tags,
	}, {
		React.createElement("TextLabel", {
			Text = props.slotNumber or 0,
		}),
		React.createElement("ImageLabel", {
			Image = props.toolImage or "",
		}),
		React.createElement(Tooltip, {
			text = props.tooltipText,
		}),
	})
end

return SlotTextLabel
