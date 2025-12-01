--!strict

local React = require("../../react")

export type TooltipTextLabel = {
	text: string,
}

local function TooltipTextLabel(props: TooltipTextLabel)
	return React.createElement("TextLabel", {
		Text = props.text,
		[React.Tag] = "tooltip",
	})
end

return TooltipTextLabel
