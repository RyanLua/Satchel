local React = require("../Packages/React")

local Theme = require("../Theme")

local function SlotButton(props: {
	toolName: string,
	textureIcon: string,
	tooltip: string,
	slotNumber: string,
	equipped: boolean,
	onActivated: () -> (),
})
	return React.createElement("TextButton", {
		Size = UDim2.new(0, 60, 0, 60),
		TextScaled = true,
		Text = props.toolName,
		[React.Event.Activated] = props.onActivated,
	}, {
		React.createElement("UITextSizeConstraint", {
			MaxTextSize = 18,
		}),
	}, {
		React.createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 5),
			PaddingLeft = UDim.new(0, 5),
			PaddingRight = UDim.new(0, 5),
			PaddingTop = UDim.new(0, 5),
		}),
	}, {
		React.createElement("ImageLabel", {
			BackgroundTransparency = 1,
			Image = props.textureIcon,
			Size = UDim2.new(1, 0, 1, 0),
		}, {
			React.createElement("UICorner", {
				CornerRadius = UDim.new(0, 3),
			}),
		}),
	}, {
		React.createElement("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
	}, {
		React.createElement("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(1, 0, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			Text = props.slotNumber,
		}, {
			React.createElement("UICorner", {
				CornerRadius = UDim.new(0, 3),
			}),
		}, {
			React.createElement("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = 5,
				Enabled = props.equipped,
			}),
		}),
	})
end

return SlotButton
