--!strict

--[[
	Script to handle inputs for the hotbar and backpack using Input Action System.
]]

-- When only the hotbar is showing
local hotbarContext = Instance.new("InputContext")
hotbarContext.Name = "HotbarContext"
hotbarContext.Priority = 2000

-- Open the backpack
local backpackAction = Instance.new("InputAction")
backpackAction.Name = "OpenBackpackAction"
backpackAction.Parent = hotbarContext

local backpackKeyBinding = Instance.new("InputBinding")
backpackKeyBinding.Name = "KeyBinding"
backpackKeyBinding.KeyCode = Enum.KeyCode.Backquote
backpackKeyBinding.Parent = backpackAction

-- Select slot to the left
local slotLeftAction = Instance.new("InputAction")
slotLeftAction.Name = "SlotLeftAction"
slotLeftAction.Parent = hotbarContext

local slotLeftGamepadBinding = Instance.new("InputBinding")
slotLeftGamepadBinding.Name = "GamepadBinding"
slotLeftGamepadBinding.KeyCode = Enum.KeyCode.ButtonL1
slotLeftGamepadBinding.Parent = slotLeftAction

-- Select slot to the right
local slotRightAction = Instance.new("InputAction")
slotRightAction.Name = "SlotRightAction"
slotRightAction.Parent = hotbarContext

local slotRightGamepadBinding = Instance.new("InputBinding")
slotRightGamepadBinding.Name = "GamepadBinding"
slotRightGamepadBinding.KeyCode = Enum.KeyCode.ButtonR1
slotRightGamepadBinding.Parent = slotRightAction

-- Select slot one
local slotOneAction = Instance.new("InputAction")
slotOneAction.Name = "SlotOneAction"
slotOneAction.Parent = hotbarContext

local slotOneKeyBinding = Instance.new("InputBinding")
slotOneKeyBinding.Name = "KeyBinding"
slotOneKeyBinding.KeyCode = Enum.KeyCode.One
slotOneKeyBinding.Parent = slotOneAction

-- Select slot two
local slotTwoAction = Instance.new("InputAction")
slotTwoAction.Name = "SlotTwoAction"
slotTwoAction.Parent = hotbarContext

local slotTwoKeyBinding = Instance.new("InputBinding")
slotTwoKeyBinding.Name = "KeyBinding"
slotTwoKeyBinding.KeyCode = Enum.KeyCode.Two
slotTwoKeyBinding.Parent = slotTwoAction

-- Select slot three
local slotThreeAction = Instance.new("InputAction")
slotThreeAction.Name = "SlotThreeAction"
slotThreeAction.Parent = hotbarContext

local slotThreeKeyBinding = Instance.new("InputBinding")
slotThreeKeyBinding.Name = "KeyBinding"
slotThreeKeyBinding.KeyCode = Enum.KeyCode.Three
slotThreeKeyBinding.Parent = slotThreeAction

-- Select slot four
local slotFourAction = Instance.new("InputAction")
slotFourAction.Name = "SlotFourAction"
slotFourAction.Parent = hotbarContext

local slotFourKeyBinding = Instance.new("InputBinding")
slotFourKeyBinding.Name = "KeyBinding"
slotFourKeyBinding.KeyCode = Enum.KeyCode.Four
slotFourKeyBinding.Parent = slotFourAction

-- Select slot five
local slotFiveAction = Instance.new("InputAction")
slotFiveAction.Name = "SlotFiveAction"
slotFiveAction.Parent = hotbarContext

local slotFiveKeyBinding = Instance.new("InputBinding")
slotFiveKeyBinding.Name = "KeyBinding"
slotFiveKeyBinding.KeyCode = Enum.KeyCode.Five
slotFiveKeyBinding.Parent = slotFiveAction

-- Select slot six
local slotSixAction = Instance.new("InputAction")
slotSixAction.Name = "SlotSixAction"
slotSixAction.Parent = hotbarContext

local slotSixKeyBinding = Instance.new("InputBinding")
slotSixKeyBinding.Name = "KeyBinding"
slotSixKeyBinding.KeyCode = Enum.KeyCode.Six
slotSixKeyBinding.Parent = slotSixAction

-- Select slot seven
local slotSevenAction = Instance.new("InputAction")
slotSevenAction.Name = "SlotSevenAction"
slotSevenAction.Parent = hotbarContext

local slotSevenKeyBinding = Instance.new("InputBinding")
slotSevenKeyBinding.Name = "KeyBinding"
slotSevenKeyBinding.KeyCode = Enum.KeyCode.Seven
slotSevenKeyBinding.Parent = slotSevenAction

-- Select slot eight
local slotEightAction = Instance.new("InputAction")
slotEightAction.Name = "SlotEightAction"
slotEightAction.Parent = hotbarContext

local slotEightKeyBinding = Instance.new("InputBinding")
slotEightKeyBinding.Name = "KeyBinding"
slotEightKeyBinding.KeyCode = Enum.KeyCode.Eight
slotEightKeyBinding.Parent = slotEightAction

-- Select slot nine
local slotNineAction = Instance.new("InputAction")
slotNineAction.Name = "SlotNineAction"
slotNineAction.Parent = hotbarContext

local slotNineKeyBinding = Instance.new("InputBinding")
slotNineKeyBinding.Name = "KeyBinding"
slotNineKeyBinding.KeyCode = Enum.KeyCode.Nine
slotNineKeyBinding.Parent = slotNineAction

-- Select slot zero
local slotZeroAction = Instance.new("InputAction")
slotZeroAction.Name = "SlotZeroAction"
slotZeroAction.Parent = hotbarContext

local slotZeroKeyBinding = Instance.new("InputBinding")
slotZeroKeyBinding.Name = "KeyBinding"
slotZeroKeyBinding.KeyCode = Enum.KeyCode.Zero
slotZeroKeyBinding.Parent = slotZeroAction

-- Only when the backpack is open
local backpackContext = Instance.new("InputContext")
backpackContext.Name = "BackpackContext"
backpackContext.Priority = 2000

-- Close the backpack
local closeBackpackAction = Instance.new("InputAction")
closeBackpackAction.Name = "CloseBackpackAction"
closeBackpackAction.Parent = backpackContext

local closeBackpackKeyBinding = Instance.new("InputBinding")
closeBackpackKeyBinding.Name = "KeyBinding"
closeBackpackKeyBinding.KeyCode = Enum.KeyCode.Backquote
closeBackpackKeyBinding.Parent = closeBackpackAction

local closeBackpackGamepadBinding = Instance.new("InputBinding")
closeBackpackGamepadBinding.Name = "GamepadBinding"
closeBackpackGamepadBinding.KeyCode = Enum.KeyCode.ButtonB
closeBackpackGamepadBinding.Parent = closeBackpackAction

-- Remove tool from hotbar
local removeFromHotbarAction = Instance.new("InputAction")
removeFromHotbarAction.Name = "RemoveFromHotbarAction"
removeFromHotbarAction.Parent = backpackContext

local removeFromHotbarGamepadBinding = Instance.new("InputBinding")
removeFromHotbarGamepadBinding.Name = "GamepadBinding"
removeFromHotbarGamepadBinding.KeyCode = Enum.KeyCode.ButtonX
removeFromHotbarGamepadBinding.Parent = removeFromHotbarAction

-- Select/swap tools
local selectSwapAction = Instance.new("InputAction")
selectSwapAction.Name = "SelectSwapAction"
selectSwapAction.Parent = backpackContext

local selectSwapGamepadBinding = Instance.new("InputBinding")
selectSwapGamepadBinding.Name = "GamepadBinding"
selectSwapGamepadBinding.KeyCode = Enum.KeyCode.ButtonA
selectSwapGamepadBinding.Parent = selectSwapAction