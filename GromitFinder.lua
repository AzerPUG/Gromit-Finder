if AZP == nil then AZP = {} end
if AZP.VersionControl == nil then AZP.VersionControl = {} end

AZP.VersionControl["Gromit Finder"] = 1
if AZP.GromitFinder == nil then AZP.GromitFinder = {} end
if AZP.GromitFinder.Events == nil then AZP.GromitFinder.Events = {} end

local EventFrame = nil

function AZP.GromitFinder:OnLoadSelf()
    EventFrame = CreateFrame("Frame", nil)
    EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    EventFrame:SetScript("OnEvent", function(...) AZP.GromitFinder:OnEvent(...) end)
end

function AZP.GromitFinder.Events:CombatLogEventUnfiltered(...)
    local v1, combatEvent, v3, CasterGUID, casterName, v6, v7, destGUID, destName, v10, v11, spellID, v13, v14, v15 = CombatLogGetCurrentEventInfo()
    local playerGUID = UnitGUID("PLAYER")
    if playerGUID == CasterGUID and spellID == 357998 and combatEvent == "SPELL_CAST_SUCCESS" then
        EventFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
    end
end

function AZP.GromitFinder.Events:UpdateMouseOverUnit(...)
    local curMouseOverName = UnitName("MOUSEOVER")
    if curMouseOverName == "Swagsnout Gromit" then
        SetRaidTarget("MOUSEOVER", 3)
        EventFrame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
    end
end

function AZP.GromitFinder:OnEvent(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        AZP.GromitFinder.Events:CombatLogEventUnfiltered(...)
    elseif event == "UPDATE_MOUSEOVER_UNIT" then
        AZP.GromitFinder.Events:UpdateMouseOverUnit(...)
    end
end

if not IsAddOnLoaded("AzerPUGsCore") then
    AZP.GromitFinder:OnLoadSelf()
end