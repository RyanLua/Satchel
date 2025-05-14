local React = require("../Packages/React")
local ReactRoblox = require("../Packages/ReactRoblox")

local Hotbar = require("../Components/Hotbar")
local Slot = require("../Components/Slot")

return {
	summary = "Hotbar which holds tool slots",
	react = React,
	reactRoblox = ReactRoblox,
	story = function()
		return React.createElement(Hotbar, {}, {
			React.createElement(Slot, {
				toolName = "Sword",
				textureIcon = "rbxassetid://7743866529",
				tooltip = "A sharp blade",
				slotNumber = "1",
				equipped = true,
				paddingOffset = 0,
				Parent = script.Parent,
			}),
			React.createElement(Slot, {
				toolName = "Bow",
				textureIcon = "rbxassetid://7743878358",
				tooltip = "For ranged attacks",
				slotNumber = "2",
				equipped = false,
				paddingOffset = 0,
			}),
			React.createElement(Slot, {
				toolName = "Shield",
				textureIcon = "rbxassetid://7743867987",
				tooltip = "Defensive item",
				slotNumber = "3",
				equipped = false,
				paddingOffset = 0,
			}),
			React.createElement(Slot, {
				toolName = "Potion",
				textureIcon = "rbxassetid://7743871218",
				tooltip = "Healing potion",
				slotNumber = "4",
				equipped = false,
				paddingOffset = 0,
			}),
		})
	end,
}
