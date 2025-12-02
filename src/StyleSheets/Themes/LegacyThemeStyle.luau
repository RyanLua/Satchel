local legacyTheme = Instance.new("StyleSheet")
legacyTheme.Name = "LegacyThemeStyle"
-- theme.Parent = ReplicatedStorage
local tokensDerive = Instance.new("StyleDerive")
-- tokensDerive.StyleSheet = baseTokens
tokensDerive.Parent = legacyTheme
legacyTheme:SetAttribute("StyleCategory", "Themes")

legacyTheme:SetAttribute("ContainerBackgroundColor", Color3.fromRGB(94, 94, 94))
legacyTheme:SetAttribute("ContainerStrokeTransparency", 1)
legacyTheme:SetAttribute("CornerRadius", UDim.new())
legacyTheme:SetAttribute("FontFace", Font.fromEnum(Enum.Font.SourceSans))
legacyTheme:SetAttribute("HintFontFace", Font.fromEnum(Enum.Font.SourceSansBold))
legacyTheme:SetAttribute("HintTextSize", 24)
legacyTheme:SetAttribute("SearchPadding", UDim.new())
legacyTheme:SetAttribute("SearchPlaceholderColor", Color3.new(1, 1, 1))
legacyTheme:SetAttribute("SearchTextSize", 24)
legacyTheme:SetAttribute("SlotBackgroundColor", Color3.fromRGB(31, 31, 31))
legacyTheme:SetAttribute("SlotEquipStrokeColor", Color3.fromRGB(90, 142, 233))
legacyTheme:SetAttribute("SlotEquipStrokeThickness", 5)
legacyTheme:SetAttribute("SlotPadding", UDim.new(0, 6))
legacyTheme:SetAttribute("SlotUnlockBackgroundColor", Color3.fromRGB(49, 49, 49))
legacyTheme:SetAttribute("SmallCornerRadius", UDim.new())
legacyTheme:SetAttribute("SmallTextSize", 14)
legacyTheme:SetAttribute("TextSize", 14)
legacyTheme:SetAttribute("TextStrokeTransparency", 1)
legacyTheme:SetAttribute("ToolTipBackgroundColor", Color3.fromRGB(102, 102, 102))
legacyTheme:SetAttribute("ToolTipPadding", UDim.new(0, 2))
