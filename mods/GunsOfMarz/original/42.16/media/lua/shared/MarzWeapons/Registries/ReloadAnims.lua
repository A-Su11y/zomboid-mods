local ReloadAnim = require("WeaponSystems/ReloadAnim/HandlerFactory")

local MAGAZINE_DURATIONS = { unload = 1.2, load = 1.5, rack = 1.2 }

local function magazineProfile(animId)
    return {
        animId = animId,
        style = "none",
        durations = MAGAZINE_DURATIONS,
    }
end

local SHOTGUN_SEMI_PROFILE = { animId = "shotgunsemi", archetype = "shotgun" }
local LEVER_PROFILE        = { animId = "lever", archetype = "lever" }
local BREAK_ACTION_PROFILE = { animId = "breakaction", archetype = "doublebarrel" }

ReloadAnim.RegisterMultipleWeapons({
    ["MarzGuns.FAL"]           = magazineProfile("FAL"),
    ["MarzGuns.AA12"]          = magazineProfile("FAL"),
    ["MarzGuns.BAR"]           = magazineProfile("FAL"),

    ["MarzGuns.MP5"]           = magazineProfile("MP5"),
    ["MarzGuns.MP5SD"]         = magazineProfile("MP5"),
    ["MarzGuns.MP5A2"]         = magazineProfile("MP5"),
    ["MarzGuns.G3"]            = magazineProfile("MP5"),
    ["MarzGuns.PSG1"]          = magazineProfile("MP5"),

    ["MarzGuns.MP5K"]          = magazineProfile("handgun2"),
    ["MarzGuns.TEC9"]          = magazineProfile("handgun2"),

    ["MarzGuns.FAMAS"]         = magazineProfile("BullpupReload"),
    ["MarzGuns.M1_GARAND"]     = magazineProfile("m1reload"),

    ["MarzGuns.BENELLI_M4"]    = SHOTGUN_SEMI_PROFILE,
    ["MarzGuns.SPAS12"]        = {
        animId = "shotgunsemi",
        archetype = "shotgun",
        whenParts = "MarzGuns.SPAS12_Selector_Semi",
    },

    ["MarzGuns.W1894"]         = LEVER_PROFILE,
    ["MarzGuns.W1887"]         = LEVER_PROFILE,
    ["MarzGuns.M1895"]         = LEVER_PROFILE,
    ["MarzGuns.W1873"]         = LEVER_PROFILE,
    ["MarzGuns.W1873_CARBINE"] = LEVER_PROFILE,

    ["MarzGuns.STEVENS_555"]   = BREAK_ACTION_PROFILE,
    ["MarzGuns.DOUBLEBARREL"]  = BREAK_ACTION_PROFILE,
    ["MarzGuns.TOZ34"]         = BREAK_ACTION_PROFILE,
    ["MarzGuns.M79"]           = BREAK_ACTION_PROFILE,
    ["MarzGuns.M203_Weapon"]   = BREAK_ACTION_PROFILE,
})
