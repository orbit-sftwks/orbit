local Theme = {}

local currentThemeName = "Emerald"
local currentTheme = nil

local Themes = {
    Emerald = {
        TextColor = Color3.fromRGB(255, 255, 255),
        Background = Color3.fromRGB(2, 2, 2),
        Topbar = Color3.fromRGB(8, 20, 15),
        Shadow = Color3.fromRGB(0, 0, 0),
        NotificationBackground = Color3.fromRGB(12, 12, 12),
        NotificationActionsBackground = Color3.fromRGB(16, 185, 129),
        TabBackground = Color3.fromRGB(12, 12, 12),
        TabStroke = Color3.fromRGB(30, 30, 30),
        TabBackgroundSelected = Color3.fromRGB(20, 45, 35),
        TabTextColor = Color3.fromRGB(160, 160, 160),
        SelectedTabTextColor = Color3.fromRGB(16, 185, 129),
        ElementBackground = Color3.fromRGB(10, 10, 10),
        ElementBackgroundHover = Color3.fromRGB(18, 18, 18),
        SecondaryElementBackground = Color3.fromRGB(6, 6, 6),
        ElementStroke = Color3.fromRGB(35, 35, 35),
        SecondaryElementStroke = Color3.fromRGB(16, 185, 129),
        SliderBackground = Color3.fromRGB(25, 25, 25),
        SliderProgress = Color3.fromRGB(16, 185, 129),
        SliderStroke = Color3.fromRGB(20, 200, 140),
        ToggleBackground = Color3.fromRGB(20, 20, 20),
        ToggleEnabled = Color3.fromRGB(16, 185, 129),
        ToggleDisabled = Color3.fromRGB(45, 45, 45),
        ToggleEnabledStroke = Color3.fromRGB(20, 200, 140),
        ToggleDisabledStroke = Color3.fromRGB(70, 70, 70),
        ToggleEnabledOuterStroke = Color3.fromRGB(10, 60, 40),
        ToggleDisabledOuterStroke = Color3.fromRGB(5, 5, 5),
        DropdownSelected = Color3.fromRGB(15, 40, 30),
        DropdownUnselected = Color3.fromRGB(12, 12, 12),
        InputBackground = Color3.fromRGB(10, 10, 10),
        InputStroke = Color3.fromRGB(40, 40, 40),
        PlaceholderColor = Color3.fromRGB(100, 100, 100)
    },

    Red = {
        TextColor = Color3.fromRGB(255, 255, 255),
        Background = Color3.fromRGB(2, 2, 2),
        Topbar = Color3.fromRGB(25, 10, 10),
        Shadow = Color3.fromRGB(0, 0, 0),
        NotificationBackground = Color3.fromRGB(12, 12, 12),
        NotificationActionsBackground = Color3.fromRGB(239, 68, 68),
        TabBackground = Color3.fromRGB(12, 12, 12),
        TabStroke = Color3.fromRGB(30, 30, 30),
        TabBackgroundSelected = Color3.fromRGB(50, 20, 20),
        TabTextColor = Color3.fromRGB(160, 160, 160),
        SelectedTabTextColor = Color3.fromRGB(239, 68, 68),
        ElementBackground = Color3.fromRGB(10, 10, 10),
        ElementBackgroundHover = Color3.fromRGB(18, 18, 18),
        SecondaryElementBackground = Color3.fromRGB(6, 6, 6),
        ElementStroke = Color3.fromRGB(35, 35, 35),
        SecondaryElementStroke = Color3.fromRGB(239, 68, 68),
        SliderBackground = Color3.fromRGB(25, 25, 25),
        SliderProgress = Color3.fromRGB(239, 68, 68),
        SliderStroke = Color3.fromRGB(255, 80, 80),
        ToggleBackground = Color3.fromRGB(20, 20, 20),
        ToggleEnabled = Color3.fromRGB(239, 68, 68),
        ToggleDisabled = Color3.fromRGB(45, 45, 45),
        ToggleEnabledStroke = Color3.fromRGB(255, 80, 80),
        ToggleDisabledStroke = Color3.fromRGB(70, 70, 70),
        ToggleEnabledOuterStroke = Color3.fromRGB(70, 15, 15),
        ToggleDisabledOuterStroke = Color3.fromRGB(5, 5, 5),
        DropdownSelected = Color3.fromRGB(45, 15, 15),
        DropdownUnselected = Color3.fromRGB(12, 12, 12),
        InputBackground = Color3.fromRGB(10, 10, 10),
        InputStroke = Color3.fromRGB(40, 40, 40),
        PlaceholderColor = Color3.fromRGB(100, 100, 100)
    },

    Gold = {
        TextColor = Color3.fromRGB(255, 255, 255),
        Background = Color3.fromRGB(2, 2, 2),
        Topbar = Color3.fromRGB(25, 20, 5),
        Shadow = Color3.fromRGB(0, 0, 0),
        NotificationBackground = Color3.fromRGB(12, 12, 12),
        NotificationActionsBackground = Color3.fromRGB(245, 158, 11),
        TabBackground = Color3.fromRGB(12, 12, 12),
        TabStroke = Color3.fromRGB(30, 30, 30),
        TabBackgroundSelected = Color3.fromRGB(50, 35, 10),
        TabTextColor = Color3.fromRGB(160, 160, 160),
        SelectedTabTextColor = Color3.fromRGB(245, 158, 11),
        ElementBackground = Color3.fromRGB(10, 10, 10),
        ElementBackgroundHover = Color3.fromRGB(18, 18, 18),
        SecondaryElementBackground = Color3.fromRGB(6, 6, 6),
        ElementStroke = Color3.fromRGB(35, 35, 35),
        SecondaryElementStroke = Color3.fromRGB(245, 158, 11),
        SliderBackground = Color3.fromRGB(25, 25, 25),
        SliderProgress = Color3.fromRGB(245, 158, 11),
        SliderStroke = Color3.fromRGB(255, 200, 50),
        ToggleBackground = Color3.fromRGB(20, 20, 20),
        ToggleEnabled = Color3.fromRGB(245, 158, 11),
        ToggleDisabled = Color3.fromRGB(45, 45, 45),
        ToggleEnabledStroke = Color3.fromRGB(255, 200, 50),
        ToggleDisabledStroke = Color3.fromRGB(70, 70, 70),
        ToggleEnabledOuterStroke = Color3.fromRGB(60, 40, 5),
        ToggleDisabledOuterStroke = Color3.fromRGB(5, 5, 5),
        DropdownSelected = Color3.fromRGB(40, 30, 10),
        DropdownUnselected = Color3.fromRGB(12, 12, 12),
        InputBackground = Color3.fromRGB(10, 10, 10),
        InputStroke = Color3.fromRGB(40, 40, 40),
        PlaceholderColor = Color3.fromRGB(100, 100, 100)
    }
}

local function clone(tbl)
    local copy = {}
    for k, v in pairs(tbl) do
        copy[k] = v
    end
    return copy
end

function Theme:Set(name)
    local selected = Themes[name]
    if not selected then
        warn("[Theme] Unknown theme:", name)
        return currentTheme
    end

    currentThemeName = name
    currentTheme = clone(selected)
    return currentTheme
end

function Theme:Get()
    if not currentTheme then
        currentTheme = clone(Themes[currentThemeName])
    end
    return currentTheme
end

function Theme:GetName()
    return currentThemeName
end

function Theme:List()
    local list = {}
    for name in pairs(Themes) do
        table.insert(list, name)
    end
    table.sort(list)
    return list
end

return Theme
