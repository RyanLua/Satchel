local LocalizationService = game:GetService("LocalizationService")
local CoreGui = game.Players.LocalPlayer.PlayerGui
local RobloxGui = CoreGui:WaitForChild("BackpackGui")
local Players = game:GetService("Players")
local FFlagCoreScriptEnableRobloxTranslatorFallback = false

local FALLBACK_ENGLISH_TRANSLATOR
if FFlagCoreScriptEnableRobloxTranslatorFallback then
    FALLBACK_ENGLISH_TRANSLATOR = false
end

-- Waiting for the player ensures that the RobloxLocaleId has been set.
if Players.LocalPlayer == nil then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
end

local coreScriptTableTranslator
local function getTranslator()
    if coreScriptTableTranslator == nil then
        coreScriptTableTranslator = CoreGui.CoreScriptLocalization:GetTranslator(
            LocalizationService.RobloxLocaleId)
    end
    return coreScriptTableTranslator
end

local translatorsCache = {}

local function getTranslatorForLocale(locale)
    local translator = translatorsCache[locale]
    if translator then
        return translator
    end

    translator = CoreGui.CoreScriptLocalization:GetTranslator(locale)
    translatorsCache[locale] = translator

    return translator
end

local function formatByKeyWithFallback(key, args, translator)
    local success, result = pcall(function()
        return translator:FormatByKey(key, args)
    end)

    if success then
        return result
    else
        return FALLBACK_ENGLISH_TRANSLATOR:FormatByKey(key, args)
    end
end

local RobloxTranslator = {}

function RobloxTranslator:FormatByKey(key, args)
    if FFlagCoreScriptEnableRobloxTranslatorFallback then
        return formatByKeyWithFallback(key, args, getTranslator())
    else
        return getTranslator():FormatByKey(key, args)
    end
end

function RobloxTranslator:FormatByKeyForLocale(key, locale, args)
    if FFlagCoreScriptEnableRobloxTranslatorFallback then
        return formatByKeyWithFallback(key, args, getTranslatorForLocale(locale))
    else
        return getTranslatorForLocale(locale):FormatByKey(key, args)
    end
end

return RobloxTranslator
