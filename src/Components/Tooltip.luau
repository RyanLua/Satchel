--!strict

local React = require("../Packages/React")
local constants = require("../Constants")

local function TooltipTextBox(props: {
	text: string,
})
	return React.createElement("TextLabel", {
		Text = props.text,
		TextSize = constants.theme.textSizeSmall,
		TextColor3 = constants.theme.textColor,
		Font = constants.theme.font,
		BackgroundColor3 = constants.theme.tooltipBackgroundColor,
		BackgroundTransparency = constants.theme.tooltipBackgroundTransparency,
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 0, -10),
		AutomaticSize = Enum.AutomaticSize.XY,
	}, {
		React.createElement("UICorner", {
			CornerRadius = constants.theme.cornerRadiusSmall,
		}),
	}, {
		React.createElement("UIPadding", {
			PaddingTop = constants.theme.padding,
			PaddingLeft = constants.theme.padding,
			PaddingRight = constants.theme.padding,
			PaddingBottom = constants.theme.padding,
		}),
	})
end

return TooltipTextBox
