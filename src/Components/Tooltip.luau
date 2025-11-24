--!strict

local React = require("../../react")

local function TooltipTextBox(props: {
	text: string,
})
	return React.createElement("TextLabel", {
		Text = props.text,
	})
end

return TooltipTextBox
