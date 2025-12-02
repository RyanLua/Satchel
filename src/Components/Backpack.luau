--!strict

local React = require("../../react")

local Slot = require("../Components/Slot")

local function BackpackFrame()
	return React.createElement("Frame", {
		[React.Tag] = "Backpack",
	}, {
		Slot = React.createElement(Slot, {
			toolName = "Hello world!",
		}),
	})
end

return BackpackFrame
