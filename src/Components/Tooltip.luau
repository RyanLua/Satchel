--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require("../../react")

local function TooltipTextBox(props: {
	text: string,
})
	return React.createElement("TextLabel", {
		Text = props.text,
		tag = "tooltip",
	})
end

return TooltipTextBox
