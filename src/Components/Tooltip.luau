--!strict

local React = require("../Packages/React")
local Constants = require("../Constants")

local function TooltipTextBox(props: {
	text: string,
})
	return React.createElement("TextLabel", {
		Text = props.text,
		TextSize = Constants.Theme.TextSizeSmall,
		TextColor3 = Constants.Theme.TextColor,
		Font = Constants.Theme.Font,
		BackgroundColor3 = Constants.Theme.TooltipBackgroundColor,
		BackgroundTransparency = Constants.Theme.TooltipBackgroundTransparency,
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 0, -10),
		AutomaticSize = Enum.AutomaticSize.XY,
	}, {
		React.createElement("UICorner", {
			CornerRadius = Constants.Theme.CornerRadiusSmall,
		}),
	}, {
		React.createElement("UIPadding", {
			PaddingTop = Constants.Theme.Padding,
			PaddingLeft = Constants.Theme.Padding,
			PaddingRight = Constants.Theme.Padding,
			PaddingBottom = Constants.Theme.Padding,
		}),
	})
end

return TooltipTextBox
