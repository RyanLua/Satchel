--!strict

local React = require("../../react")
local ReactRoblox = require("../../react-roblox")

local Slot = require("../Components/Slot")

return function(target)
	local root = ReactRoblox.createRoot(target)

	root:render(React.createElement(Slot, { toolName = "Hello world!" }))

	return function()
		root:unmount()
	end
end
