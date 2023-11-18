local TooltipLayer = Instance.new("ScreenGui")
TooltipLayer.Name = "TooltipLayer"
TooltipLayer.DisplayOrder = 1e+09
TooltipLayer.IgnoreGuiInset = true
TooltipLayer.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
TooltipLayer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

return TooltipLayer