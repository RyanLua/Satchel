--!strict

local UserInputService = game:GetService("UserInputService")

local React = require("../Packages/React")

local function SlotButton(props: {
	LayoutOrder: number?,
	image: string,
})
	return React.createElement("ImageLabel", {
		LayoutOrder = props.LayoutOrder or -1,
		Image = props.image,
		ScaleType = Enum.ScaleType.Fit,
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 60, 0, 37),
	})
end

return SlotButton
