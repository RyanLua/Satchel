local designTokens = Instance.new("StyleSheet")
designTokens.Name = "DesignTokenSheet"
-- tokens.Parent = ReplicatedStorage
designTokens:SetAttribute("StyleCategory", "Tokens")

designTokens:SetAttribute("BackgroundColor", Color3.fromRGB(25, 27, 29))
designTokens:SetAttribute("CornerRadius", UDim.new(0, 8))
designTokens:SetAttribute("FontFace", Font.fromEnum(Enum.Font.BuilderSansMedium))
designTokens:SetAttribute("SmallCornerRadius", UDim.new(0, 4))
designTokens:SetAttribute("SmallTextSize", 15)
designTokens:SetAttribute("TextColor", Color3.new(1, 1, 1))
designTokens:SetAttribute("TextSize", 18)
designTokens:SetAttribute("TextStrokeColor", Color3.new())
designTokens:SetAttribute("TextStrokeTransparency", 0.5)
