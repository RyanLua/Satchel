--!strict

local React = require("../Packages/React")
local Constants = require("../Constants")

local function SlotButton(props: {
	IsTenFootInterface: boolean?,
	toolName: string?,
	textureIcon: string?,
	tooltip: string?,
	slotNumber: string?,
	locked: boolean?,
	equipped: boolean?,
	onActivated: (() -> ())?,
})
	return React.createElement("TextButton", {
		BackgroundColor3 = Constants.Theme.BackgroundColor,
		TextColor3 = Constants.Theme.TextColor,
		TextSize = Constants.Theme.TextSize,
		TextStrokeColor3 = Constants.Theme.TextStrokeColor,
		TextStrokeTransparency = Constants.Theme.TextStrokeTransparency,
		Font = Constants.Theme.Font,
		BackgroundTransparency = if props.locked then 0 else Constants.Theme.BackgroundTransparency,
		Text = if props.textureIcon then "" else props.toolName or "",
		Size = if props.IsTenFootInterface then UDim2.new(0, 100, 0, 100) else UDim2.new(0, 60, 0, 60),
		TextScaled = true,
		[React.Event.Activated] = props.onActivated,
	}, {
		React.createElement("UITextSizeConstraint", {
			MaxTextSize = if props.IsTenFootInterface then Constants.Theme.TextSizeLarge else Constants.Theme.TextSize,
		}),
	}, {
		React.createElement("UIPadding", {
			PaddingBottom = Constants.Theme.Padding,
			PaddingLeft = Constants.Theme.Padding,
			PaddingRight = Constants.Theme.Padding,
			PaddingTop = Constants.Theme.Padding,
		}),
	}, {
		React.createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = props.textureIcon or "",
			Size = UDim2.new(1, 0, 1, 0),
		}, {
			React.createElement("UICorner", {
				CornerRadius = Constants.Theme.CornerRadiusSmall,
			}),
		}),
	}, {
		React.createElement("UICorner", {
			CornerRadius = Constants.Theme.CornerRadius,
		}),
	}, {
		React.createElement("TextLabel", {
			TextColor3 = Constants.Theme.TextColor,
			TextSize = if props.IsTenFootInterface then Constants.Theme.TextSize else Constants.Theme.TextSizeSmall,
			TextStrokeColor3 = Constants.Theme.TextStrokeColor,
			TextStrokeTransparency = Constants.Theme.TextStrokeTransparency,
			Font = Constants.Theme.FontSmall,
			Text = props.slotNumber or "",
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(1, 0, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		}, {
			React.createElement("UICorner", {
				CornerRadius = Constants.Theme.CornerRadiusSmall,
			}),
		}, {
			React.createElement("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = Constants.Theme.Thickness,
				Color = Constants.Theme.EquippedColor,
				Enabled = props.equipped or false,
			}),
		}),
	})
end

return SlotButton
