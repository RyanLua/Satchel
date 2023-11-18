local UIShelf = require(game:GetService("ReplicatedStorage").Packages.UIShelf)

local Icon1 = UIShelf.CreateIcon({
	Name = "Icon1",
	Image = 12797061582,
	Order = 1,
	Area = UIShelf.HorizontalAlignment.Left,
})

local Icon2 = UIShelf.CreateIcon({
	Name = "Icon2",
	Image = 12663166329,
	Order = 1,
	Area = UIShelf.HorizontalAlignment.Right,
})

local Icon3 = UIShelf.CreateIcon({
	Name = "Icon3",
	Image = "rbxassetid://12515281752",
	Order = 2,
	Area = UIShelf.HorizontalAlignment.Left,
	Text = "Text Icon"
})

UIShelf.CreateIcon({
	Name = "Icon4",
	Order = 3,
	Area = UIShelf.HorizontalAlignment.Left,
	Text = "Creepy Text Icon 👻",
	Font = Enum.Font.Creepster
})

Icon3:SetTooltip("extremely long tooltip lololololololololololololololololololololoolllololololololololololololololol")
Icon3:BindKeyCode(Enum.KeyCode.Q)
Icon1:SetTooltip("Normal Tooltip")

local Menu1 = UIShelf.CreateMenuItem({
	Name = "Item 1",
	Image = "rbxassetid://14187970401"
})

local Menu2 = UIShelf.CreateMenuItem({
	Name = "Item 2",
	Image = "rbxassetid://14187977869"
})

Icon2:CreateMenu({
	Menu1,
	Menu2
})

Icon2:SetTooltip("skibidi toilet yes yes yes")

Menu1.Activated:Connect(function()
	print("Menu example!")
end)

Icon3.Activated:Connect(function()
	if Icon3.Notices == 100 then
		Icon3:RemoveIconNotices()
	end

	Icon3:AddIconNotices()
end)