--!strict

local React = require("../Packages/React")
local constants = require("../Constants")

local function SlotButton(props: {
	LayoutOrder: number?,
	text: string,
	image: string,
})
	return React.createElement("Frame", {
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = props.LayoutOrder or 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 0, 1, 0),
	}, {
		React.createElement("ImageLabel", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.new(0, 37, 0, 37),
			Image = props.image,
		}),
	}, {
		React.createElement("TextLabel", {
			AutomaticSize = Enum.AutomaticSize.X,
			Position = UDim2.new(0, 42, 0, 0),
			Font = constants.theme.font,
			TextColor3 = constants.theme.textColor,
			BackgroundTransparency = 1,
			Text = props.text,
			TextSize = constants.theme.textSize,
			Size = UDim2.new(0, 0, 1, 0),
		}),
	})
end

return SlotButton
