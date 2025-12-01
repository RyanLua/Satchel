--!strict

local React = require("../../react")

export type TooltipTextLabelProps = {
	text: string?,
}

local function TooltipTextLabel(props: TooltipTextLabelProps)
	return React.createElement("TextLabel", {
		Text = props.text or "",
		[React.Tag] = "tooltip",
	})
end

return TooltipTextLabel
