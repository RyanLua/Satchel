--!strict

local Players = game:GetService("Players")

local React = require("./react")
local ReactRoblox = require("./react-roblox")

local player = Players.LocalPlayer :: Player
local playerGui = player.PlayerGui

local tooltip = require("@self/Components/Tooltip")

local handle = Instance.new("ScreenGui")
handle.Name = "SatchelGui"
handle.Parent = playerGui
local root = ReactRoblox.createRoot(handle)
root:render(React.createElement(tooltip, { text = "Hello world!" }))

return {}
