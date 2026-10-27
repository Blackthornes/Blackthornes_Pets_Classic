-- The small Feed button above the quest tracker: shown only while the pet
-- needs feeding and there is food it will eat, and never changed in combat.

local env = dofile(lfs_cwd .. "/tools/testenv.lua")
local suite = env.NewSuite("feedbutton")

local ns = env.Load()
local FeedButton = ns.FeedButton
local button = FeedButton:Build()

local happiness = 3
_G.UnitClass = function() return "Hunter", "HUNTER" end
_G.UnitExists = function() return true end
_G.UnitName = function() return "Scorpid" end
_G.UnitLevel = function() return 12 end
_G.C_PetInfo = {
    GetPetHappiness = function() return happiness, 100, 5 end,
    GetPetFoodTypes = function() return { "Meat" } end,
}
local bags = { [0] = { [3] = { itemID = 117, stackCount = 30 } } }
_G.C_Container = {
    GetContainerNumSlots = function(bag) return bags[bag] and 16 or 0 end,
    GetContainerItemInfo = function(bag, slot) return bags[bag] and bags[bag][slot] end,
}
_G.C_Item = { GetItemInfo = function() return "Tough Jerky", nil, 1, 5 end }

-- The quest tracker, with its top left corner at 950, 700.
_G.ObjectiveTrackerFrame = env.Stub({ _shown = true })
function ObjectiveTrackerFrame:IsVisible() return self._shown end
function ObjectiveTrackerFrame:GetLeft() return 950 end
function ObjectiveTrackerFrame:GetTop() return 700 end

local function Refresh() ns.Food:Update() end

Refresh()
suite.check("a happy pet gets no button", not button:IsShown())

happiness = 2
Refresh()
suite.check("a content pet does, by default", button:IsShown())
suite.check("it feeds the food", (button:GetAttribute("macrotext") or ""):find("/use 0 3", 1, true),
    button:GetAttribute("macrotext"))
local point, relativeTo, relativePoint, x, y = unpack(button._point)
suite.check("just above the tracker's top left",
    point == "BOTTOMLEFT" and relativeTo == UIParent and relativePoint == "BOTTOMLEFT"
        and x == 950 and y == 704, table.concat({ tostring(point), tostring(relativePoint), tostring(x), tostring(y) }, " "))

-- The gold plaque's words: the pet by name, then the food and how many.
local first, second = button.first:GetText(), button.second:GetText()
suite.check("the plaque names the pet", first == "Feed Scorpid", first)
suite.check("and the food with how many are carried",
    type(second) == "string" and second:find("Tough Jerky", 1, true) and second:find("x30", 1, true), second)

ns.db.feedWarnOnlyUnhappy = true
Refresh()
suite.check("only when unhappy follows the warning's setting", not button:IsShown())
happiness = 1
Refresh()
suite.check("and an unhappy pet gets it", button:IsShown())
ns.db.feedWarnOnlyUnhappy = false

bags[0] = {}
Refresh()
suite.check("no food, no button", not button:IsShown())
bags[0] = { [3] = { itemID = 117, stackCount = 30 } }

ObjectiveTrackerFrame._shown = false
Refresh()
suite.check("with no tracker it still shows, at the top right",
    button:IsShown() and button._point[1] == "TOPRIGHT", button._point[1])

-- Era's quest list is QuestWatchFrame.
_G.QuestWatchFrame = env.Stub({})
function QuestWatchFrame:IsVisible() return true end
function QuestWatchFrame:GetLeft() return 900 end
function QuestWatchFrame:GetTop() return 650 end
Refresh()
suite.check("Era's quest list is found too",
    button._point[1] == "BOTTOMLEFT" and button._point[4] == 900 and button._point[5] == 654,
    tostring(button._point[4]) .. " " .. tostring(button._point[5]))
_G.QuestWatchFrame = nil
ObjectiveTrackerFrame._shown = true

-- Combat: left alone, but put away as combat starts.
_G.InCombatLockdown = function() return true end
happiness = 3
Refresh()
suite.check("in combat nothing is changed", button:IsShown())
_G.InCombatLockdown = nil
happiness = 1
FeedButton:Update(nil, nil, true)
suite.check("combat starting puts it away", not button:IsShown())
Refresh()
suite.check("and it comes back after", button:IsShown())

ns.db.quickFeed = false
Refresh()
suite.check("the setting turns it off", not button:IsShown())
ns.db.quickFeed = true

-- The settings page has the switch.
ns.SettingsUI:Show()
local box = ns.SettingsUI.controls.quickFeed
suite.check("the settings page shows it on", box:GetChecked())
box:GetScript("OnClick")(box)
suite.check("and unticking turns it off", ns.db.quickFeed == false and not button:IsShown())


-- Moving it: only the left button feeds, the right button drags it, and the
-- spot it is dropped on is kept and used from then on.
_G.InCombatLockdown = nil
ns.db.quickFeed = true
happiness = 1
Refresh()
suite.check("it shows again", button:IsShown())
suite.check("only the left button feeds", button._clicks and button._clicks[1] == "LeftButtonUp",
    button._clicks and button._clicks[1])
suite.check("the right button drags it", button._drag == "RightButton")
local moved = false
function button:StartMoving() moved = true end
button._scripts.OnDragStart(button)
suite.check("a drag moves it", moved)
button._left, button._top = 300, 500
button._scripts.OnDragStop(button)
suite.check("the spot is kept", ns.db.quickFeedX == 300 and ns.db.quickFeedY == 500)
Refresh()
suite.check("and used from then on", button._point[1] == "TOPLEFT" and button._point[4] == 300
    and button._point[5] == 500)
moved = false
_G.InCombatLockdown = function() return true end
button._scripts.OnDragStart(button)
suite.check("no moving in a fight", not moved)
_G.InCombatLockdown = nil
ns.SettingsUI:ResetPositions()
suite.check("Set Default puts it back", ns.db.quickFeedX == nil
    and button._point[1] == "BOTTOMLEFT", button._point[1])

_G.C_Container, _G.C_Item, _G.C_PetInfo, _G.ObjectiveTrackerFrame = nil, nil, nil, nil
_G.UnitExists, _G.UnitName, _G.UnitLevel = nil, nil, nil

suite.done()
