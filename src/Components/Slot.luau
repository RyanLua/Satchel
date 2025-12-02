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

local function SlotButton(props: Props)
	local tags = "Slot"
	if props.unlocked then
		tags = tags .. " Unlocked"
	end
	if props.equipped then
		tags = tags .. " Equipped"
	end

	local slotText = if props.toolImage == nil or "" then "" else props.toolName or ""

	return React.createElement("TextButton", {
		Text = slotText,
		[React.Tag] = tags,
	}, {
		NumberHint = React.createElement("TextLabel", {
			Text = props.slotNumber or 0,
			[React.Tag] = "SlotNumber",
		}),
		TextureIcon = React.createElement("ImageLabel", {
			Image = props.toolImage or "",
		}),
		ToolTip = React.createElement("TextLabel", {
			Text = props.tooltipText or "",
			[React.Tag] = "ToolTip",
		}),
		StyleLink = React.createElement("StyleLink", {
			StyleSheet = game.ReplicatedStorage.Design.SatchelStyleSheet,
		}),
	})
end

return SlotButton
