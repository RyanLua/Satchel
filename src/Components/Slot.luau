local React = require("../Packages/React")

export type Props = {
	toolName: string,
	slotNumber: number,
}

local function SlotButton(props: Props)
	return React.createElement(
		"TextButton",
		{
			Size = UDim2.new(0, 50, 0, 50),
			Text = props.toolName,
		},
		{
			React.createElement("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		},
		React.createElement("TextLabel"),
		{
			Size = UDim2.new(1, 0, 1, 0),
			Text = props.slotNumber,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		}
	)
end

return SlotButton
