-- Blackthornes Pets -- UI/FeedButton.lua
-- A small Feed button just above the quest tracker's "All Objectives", shown
-- only while a hunter's pet needs feeding and there is food it will eat.
--
-- Like the window's Feed button it is a secure action button (Feed Pet is
-- protected), so it can only be shown, hidden or moved out of combat. It is
-- put away as combat starts, which is no loss: Feed Pet cannot be cast in
-- combat anyway.

local _, ns = ...
local L = ns.L

local FeedButton = ns.NewModule("FeedButton")

-- How far above the tracker's top edge the button sits.
local GAP = 4

-- Where it goes when there is no quest tracker on screen: the top right,
-- under the minimap, where the tracker usually starts.
local FALLBACK_X, FALLBACK_Y = -60, -230

local function InCombat()
    if type(InCombatLockdown) ~= "function" then return false end
    local ok, locked = pcall(InCombatLockdown)
    return ok and locked == true
end

function FeedButton:Build()
    if self.button then return self.button end

    local button = ns.Widgets.CreateButton(UIParent, L["Feed"], nil, {
        name = "BlackthornesPetsQuickFeed",
        template = "SecureActionButtonTemplate",
        primary = true,
        width = 50,
        height = 20,
    })
    button:SetFrameStrata("HIGH")
    -- Only the left button feeds; the right button drags it (the owner,
    -- 2026-10-26), out of combat only, and its spot is kept account wide
    -- in quickFeedX/quickFeedY (never rename them).
    button:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
    button:SetMovable(true)
    button:SetClampedToScreen(true)
    button:RegisterForDrag("RightButton")
    button:SetScript("OnDragStart", function(self)
        if InCombat() then return end
        self:StartMoving()
    end)
    button:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        FeedButton:SavePlace()
    end)
    button:HookScript("OnEnter", function(self)
        local stack = FeedButton.stack
        if not (stack and GameTooltip) then return end
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine(L.Format("Feed %s", ns.Food.ShownName(stack)))
        GameTooltip:AddLine(L.Format("%s is %s.", FeedButton.petName or L["Your pet"],
            FeedButton.mood or L["hungry"]), 0.7, 0.7, 0.7)
        GameTooltip:AddLine(L["Hold right-click and drag to move it."], 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    button:HookScript("OnLeave", function()
        if GameTooltip then GameTooltip:Hide() end
    end)
    button:Hide()
    self.button = button
    return button
end

--- The quest tracker, if this client has one and it is on screen.
local function Tracker()
    local tracker = _G.ObjectiveTrackerFrame
    if type(tracker) ~= "table" then return nil end
    local ok, shown = pcall(tracker.IsVisible, tracker)
    if not (ok and shown) then return nil end
    return tracker
end

--- Put the button just above the tracker's top left corner. It is placed by
--- screen position rather than anchored to the tracker, so the tracker stays
--- free to move itself in combat.
function FeedButton:Place()
    local button = self.button
    button:ClearAllPoints()

    local db = ns.db
    if db and type(db.quickFeedX) == "number" and type(db.quickFeedY) == "number" then
        button:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", db.quickFeedX, db.quickFeedY)
        return
    end

    local tracker = Tracker()
    if tracker then
        local ok, left, top, scale = pcall(function()
            return tracker:GetLeft(), tracker:GetTop(),
                tracker:GetEffectiveScale() / UIParent:GetEffectiveScale()
        end)
        if ok and type(left) == "number" and type(top) == "number" and type(scale) == "number" then
            button:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left * scale, top * scale + GAP)
            return
        end
    end
    button:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", FALLBACK_X, FALLBACK_Y)
end

--- Keep where the player dragged the button: its top left corner, in
--- UIParent's units.
function FeedButton:SavePlace()
    local button = self.button
    if not (button and ns.db) then return end
    local ok, left, top, scale = pcall(function()
        return button:GetLeft(), button:GetTop(),
            button:GetEffectiveScale() / UIParent:GetEffectiveScale()
    end)
    if not (ok and type(left) == "number" and type(top) == "number" and type(scale) == "number") then
        return
    end
    ns.db.quickFeedX, ns.db.quickFeedY = left * scale, top * scale
    if not InCombat() then self:Place() end
end

--- Back above the quest tracker, as it started.
function FeedButton:ResetPlace()
    if not ns.db then return end
    ns.db.quickFeedX, ns.db.quickFeedY = nil, nil
    if self.button and self.button:IsShown() and not InCombat() then self:Place() end
end

--- Whether the pet needs feeding: below the feed warning's line.
function FeedButton:Hungry(status)
    local level = status and status.exists and status.happiness
    return level ~= nil and level < ns.PetStatus:WarnBelow()
end

--- Show the button pointed at the best food while the pet is hungry, and
--- hide it otherwise. Out of combat only, unless `beforeCombat` says combat
--- is only about to start, when it can still be put away.
function FeedButton:Update(status, stacks, beforeCombat)
    local button = self.button
    if not button then return end
    if InCombat() and not beforeCombat then return end

    local stack = stacks and stacks[1]
    local wanted = not beforeCombat
        and ns.db and ns.db.quickFeed ~= false
        and stack and self:Hungry(status)

    if wanted then
        button:SetAttribute("type", "macro")
        button:SetAttribute("macrotext", ns.Food:FeedMacro(stack))
        self:Place()
        button:Show()
        self.stack = stack
        self.petName = status.name
        local info = ns.PetStatus.HAPPINESS[status.happiness]
        self.mood = info and info.name:lower()
    else
        button:Hide()
        button:ClearAllPoints()
        button:SetAttribute("macrotext", nil)
        self.stack = nil
    end
end

function FeedButton:OnEnable()
    self:Build()
    ns.RegisterEvent(self, "PLAYER_REGEN_DISABLED", function()
        FeedButton:Update(nil, nil, true)
    end)
end
