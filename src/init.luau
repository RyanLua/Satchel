local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local React = require("./react")
local ReactRoblox = require("./react-roblox")

local tooltip = require("@self/Components/Tooltip")

local Satchel = {}

local function runExample()
	local handle = Instance.new("ScreenGui", Players.LocalPlayer.PlayerGui)
	local root = ReactRoblox.createRoot(handle)

	root:render(React.createElement(tooltip, {}))
end

runExample()

return Satchel
