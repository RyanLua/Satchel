--!strict

local React = require("../../react")

local Slot = require("../Components/Slot")

-- TODO: Update to use proper types when React Luau is on Wally.
local function BackpackFrame(): React.ReactElement<any>
	return React.createElement("Frame", {
		[React.Tag] = "Backpack",
	}, {
		Slot = React.createElement(Slot, {
			toolName = "Hello world!",
		}),
	})
end

return BackpackFrame
