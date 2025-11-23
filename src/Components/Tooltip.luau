--!strict

local React = require("../Packages/React")
local Constants = require("../Constants")

local function TooltipTextBox(props: {
	text: string,
})
	return React.createElement("TextLabel", {
		Text = props.text,
	})
end

return TooltipTextBox
