--!strict

local React = require("../Packages/React")
local constants = require("../Constants")

local function SlotButton(props: {
	toolName: string?,
	textureIcon: string?,
	tooltip: string?,
	slotNumber: string?,
	locked: boolean?,
	equipped: boolean?,
	onActivated: (() -> ())?,
})
	return React.createElement("TextButton", {
		BackgroundColor3 = constants.theme.backgroundColor,
		TextColor3 = constants.theme.textColor,
		TextSize = constants.theme.textSize,
		TextStrokeColor3 = constants.theme.textStrokeColor,
		TextStrokeTransparency = constants.theme.textStrokeTransparency,
		Font = constants.theme.font,
		BackgroundTransparency = if props.locked then 0 else constants.theme.backgroundTransparency,
		Text = props.toolName or "",
		Size = UDim2.new(0, 60, 0, 60),
		TextScaled = true,
		[React.Event.Activated] = props.onActivated,
	}, {
		React.createElement("UITextSizeConstraint", {
			MaxTextSize = constants.theme.textSize,
		}),
	}, {
		React.createElement("UIPadding", {
			PaddingBottom = constants.theme.padding,
			PaddingLeft = constants.theme.padding,
			PaddingRight = constants.theme.padding,
			PaddingTop = constants.theme.padding,
		}),
	}, {
		React.createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = props.textureIcon or "",
			Size = UDim2.new(1, 0, 1, 0),
		}, {
			React.createElement("UICorner", {
				CornerRadius = constants.theme.cornerRadiusSmall,
			}),
		}),
	}, {
		React.createElement("UICorner", {
			CornerRadius = constants.theme.cornerRadius,
		}),
	}, {
		React.createElement("TextLabel", {
			TextColor3 = constants.theme.textColor,
			TextSize = constants.theme.textSizeSmall,
			TextStrokeColor3 = constants.theme.textStrokeColor,
			TextStrokeTransparency = constants.theme.textStrokeTransparency,
			Font = constants.theme.fontSmall,
			Text = props.slotNumber or "",
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(1, 0, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		}, {
			React.createElement("UICorner", {
				CornerRadius = constants.theme.cornerRadiusSmall,
			}),
		}, {
			React.createElement("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = constants.theme.thickness,
				Color = constants.theme.equippedColor,
				Enabled = props.equipped or false,
			}),
		}),
	})
end

return SlotButton
