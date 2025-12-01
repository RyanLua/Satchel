--!strict

local React = require("../../react")

export type Props = {
	toolName: string?,
	slotNumber: number?,
	toolImage: string?,
	tooltipText: string?,

	equipped: boolean?,
	unlocked: boolean?,
}

local function SlotTextLabel(props: Props): React.ReactNode
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
		Number = React.createElement("TextLabel", {
			Text = props.slotNumber or 0,
		}),
		TextureIcon = React.createElement("ImageLabel", {
			Image = props.toolImage or "",
		}),
		ToolTip = React.createElement("TextLabel", {
			Text = props.tooltipText or "",
			[React.Tag] = "tooltip",
		}),
	})
end

return SlotTextLabel
