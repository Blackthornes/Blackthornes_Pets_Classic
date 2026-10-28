-- Era has no C_PetInfo: the hunter's pet is read through the classic
-- globals, whose food types come back one value each. Without them the
-- pets window had no food card, so no Feed button, and the small Feed
-- button and the feed warning never knew the pet was hungry.

local env = dofile(lfs_cwd .. "/tools/testenv.lua")
local suite = env.NewSuite("erapetcalls")

local ns = env.Load()
local PetStatus = ns.PetStatus

local happiness = 2
_G.C_PetInfo = nil
_G.UnitClass = function() return "Hunter", "HUNTER" end
_G.UnitExists = function() return true end
_G.UnitName = function() return "Scorpid" end
_G.UnitLevel = function() return 10 end
_G.GetPetHappiness = function() return happiness, 100, 5 end
_G.GetPetLoyalty = function() return "Loyalty Level 3 (Submissive)" end
_G.GetPetFoodTypes = function() return "Meat", "Fish" end
_G.GetPetTrainingPoints = function() return 10, 5 end

local status = PetStatus:Read()
suite.check("reads happiness from the classic call", status.happiness == 2 and status.damagePercent == 100)
suite.check("reads each food type", status.foods and #status.foods == 2
    and status.foods[1] == "Meat" and status.foods[2] == "Fish")
suite.check("keeps only the loyalty name", status.loyalty == "Submissive", status.loyalty)
suite.check("reads training points", status.trainingFree == 5)

suite.check("keeps the loyalty level too", status.loyaltyLevel == 3, status.loyaltyLevel)
suite.check("the level reads in any language",
    PetStatus.LoyaltyLevelIn("Niveau de loyaut\195\169 5 (Fid\195\168le)") == 5)
suite.check("full-width brackets keep only the name",
    PetStatus.LoyaltyName("6\239\188\136X\239\188\137") == "X")
suite.check("a plain name has no level", PetStatus.LoyaltyLevelIn("Faithful") == nil)
suite.check("a plain loyalty name is left as it is", PetStatus.LoyaltyName("Faithful") == "Faithful")
suite.check("no loyalty is nil", PetStatus.LoyaltyName(nil) == nil)

-- C_PetInfo there but saying nothing still falls back on the globals.
_G.C_PetInfo = { GetPetHappiness = function() return nil end }
status = PetStatus:Read()
suite.check("an empty C_PetInfo answer falls back", status.happiness == 2 and status.foods ~= nil)
_G.C_PetInfo = nil

-- The small Feed button now shows for a hungry pet with food in the bags.
local button = ns.FeedButton:Build()
local bags = { [0] = { [3] = { itemID = 117, stackCount = 30 } } }
_G.C_Container = {
    GetContainerNumSlots = function(bag) return bags[bag] and 16 or 0 end,
    GetContainerItemInfo = function(bag, slot) return bags[bag] and bags[bag][slot] end,
}
_G.C_Item = { GetItemInfo = function() return "Tough Jerky", nil, 1, 5 end }
ns.Food:Update()
suite.check("the Feed button shows on Era", button:IsShown())
suite.check("it feeds the food", (button:GetAttribute("macrotext") or ""):find("/use 0 3", 1, true),
    button:GetAttribute("macrotext"))

-- Feed Pet's name from Era's older spell call.
local oldSpell = _G.C_Spell
_G.C_Spell = nil
_G.GetSpellInfo = function(id) return id == 6991 and "Tier füttern" or nil end
suite.check("Feed Pet named by GetSpellInfo", ns.Food:FeedSpellName() == "Tier füttern")
_G.GetSpellInfo = nil
_G.C_Spell = oldSpell

happiness = 3
ns.Food:Update()
suite.check("a happy pet gets no button", not button:IsShown())

_G.C_Container, _G.C_Item = nil, nil
suite.done()
