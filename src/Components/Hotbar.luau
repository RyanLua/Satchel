local React = require("../Packages/React")

local Theme = require("../Theme")

export type Props = {}

local function HotbarFrame(props: Props)
	return React.createElement("Frame", {
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
	}, {
		React.createElement("UIListLayout", {
			Padding = UDim.new(0, 5),
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),
	}, {
		React.createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 5),
			PaddingLeft = UDim.new(0, 5),
			PaddingRight = UDim.new(0, 5),
			PaddingTop = UDim.new(0, 5),
		}),
	})
end

return HotbarFrame
