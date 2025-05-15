--!strict

local React = require("../Packages/React")

local function TooltipTextBox(props: {
	text: string,
})
	return React.createElement("TextLabel", {
		Text = props.text,
		TextSize = 15,
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 0, -10),
		AutomaticSize = Enum.AutomaticSize.XY,
	}, {
		React.createElement("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
	}, {
		React.createElement("UIPadding", {
			PaddingTop = UDim.new(0, 4),
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
			PaddingBottom = UDim.new(0, 4),
		}),
	})
end

return TooltipTextBox
