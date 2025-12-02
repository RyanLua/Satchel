local defaultTheme = Instance.new("StyleSheet")
defaultTheme.Name = "DefaultThemeStyle"
-- theme.Parent = ReplicatedStorage
local tokensDerive = Instance.new("StyleDerive")
-- tokensDerive.StyleSheet = baseTokens
tokensDerive.Parent = defaultTheme
defaultTheme:SetAttribute("StyleCategory", "Themes")
