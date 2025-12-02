--!strict

local React = require("../../react")

local Slot = require("../Components/Slot")

local function BackpackFrame(): React.ReactElement<any> -- TODO: Update to use proper types when React Luau is on Wally.
	return React.createElement("Frame", {
		[React.Tag] = "backpack",
	}, {
		Slot = React.createElement(Slot, {
			toolName = "Hello world!",
		}),
	})
end

return BackpackFrame
