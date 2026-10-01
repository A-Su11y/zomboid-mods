local Animations            = require("WeaponSystems/Utils/Animations")

local Slide                 = { SingleAttachment = { open = "MarzGuns.Slide_Fired", locked = "MarzGuns.Slide_Lock" }, cycleTicks = 5 }
local Pump                  = { SingleAttachment = { open = "MarzGuns.Pump_Fired", locked = "MarzGuns.Pump_Lock" } }
local Bolt                  = { SingleAttachment = { open = "MarzGuns.Bolt_Fired", locked = "MarzGuns.Bolt_Lock" }, cycleTicks = 3 }
local Lever                 = { SingleAttachment = { open = "MarzGuns.Lever_Fired", locked = "MarzGuns.Lever_Lock" } }
local Barrel                = { SingleAttachment = { open = "MarzGuns.Barrel_Open", locked = "MarzGuns.Barrel_Close" } }
local Break_Shotgun_Barrels = {
    MultipleAttachmentsVariant = {
        Barrel = {
            partType = "Barrel",
            variants = {
                ["MarzGuns.DOUBLEBARREL_Barrel_Close"]         = { open = "MarzGuns.DOUBLEBARREL_Barrel_Open", locked = "MarzGuns.DOUBLEBARREL_Barrel_Close" },
                ["MarzGuns.DOUBLEBARREL_Barrel_Open"]          = { open = "MarzGuns.DOUBLEBARREL_Barrel_Open", locked = "MarzGuns.DOUBLEBARREL_Barrel_Close" },
                ["MarzGuns.DOUBLEBARREL_Barrel_Sawnoff_Close"] = { open = "MarzGuns.DOUBLEBARREL_Barrel_Sawnoff_Open", locked = "MarzGuns.DOUBLEBARREL_Barrel_Sawnoff_Close" },
                ["MarzGuns.DOUBLEBARREL_Barrel_Sawnoff_Open"]  = { open = "MarzGuns.DOUBLEBARREL_Barrel_Sawnoff_Open", locked = "MarzGuns.DOUBLEBARREL_Barrel_Sawnoff_Close" },

                ["MarzGuns.STEVENS_555_Barrel_Close"]          = { open = "MarzGuns.STEVENS_555_Barrel_Open", locked = "MarzGuns.STEVENS_555_Barrel_Close" },
                ["MarzGuns.STEVENS_555_Barrel_Open"]           = { open = "MarzGuns.STEVENS_555_Barrel_Open", locked = "MarzGuns.STEVENS_555_Barrel_Close" },
                ["MarzGuns.STEVENS_555_Barrel_Sawnoff_Close"]  = { open = "MarzGuns.STEVENS_555_Barrel_Sawnoff_Open", locked = "MarzGuns.STEVENS_555_Barrel_Sawnoff_Close" },
                ["MarzGuns.STEVENS_555_Barrel_Sawnoff_Open"]   = { open = "MarzGuns.STEVENS_555_Barrel_Sawnoff_Open", locked = "MarzGuns.STEVENS_555_Barrel_Sawnoff_Close" },

                ["MarzGuns.TOZ34_Barrel_Close"]                = { open = "MarzGuns.TOZ34_Barrel_Open", locked = "MarzGuns.TOZ34_Barrel_Close" },
                ["MarzGuns.TOZ34_Barrel_Open"]                 = { open = "MarzGuns.TOZ34_Barrel_Open", locked = "MarzGuns.TOZ34_Barrel_Close" },
                ["MarzGuns.TOZ34_Barrel_Sawnoff_Close"]        = { open = "MarzGuns.TOZ34_Barrel_Sawnoff_Open", locked = "MarzGuns.TOZ34_Barrel_Sawnoff_Close" },
                ["MarzGuns.TOZ34_Barrel_Sawnoff_Open"]         = { open = "MarzGuns.TOZ34_Barrel_Sawnoff_Open", locked = "MarzGuns.TOZ34_Barrel_Sawnoff_Close" },
            },
        },
    }
}
local Revolvers             = {
    MultipleAttachment = {
        Hammer = { open = "MarzGuns.Hammer_Open", locked = "MarzGuns.Hammer_Close" },
        Cylinder = { open = "MarzGuns.Cylinder_Open", locked = "MarzGuns.Cylinder_Close" },
    },
    cycleTicks = 20,
    force = true
}
local Underbarrel           = { SingleAttachment = { open = "MarzGuns.Underbarrel_Open", locked = "MarzGuns.Underbarrel_Close" } }
local SPAS12                = {
    MultipleAttachmentsVariant = {
        Bolt = {
            partType = "Selector",
            variants = {
                ["MarzGuns.SPAS12_Selector_Semi"] = { open = "MarzGuns.Bolt_Fired", locked = "MarzGuns.Bolt_Lock" },
                ["MarzGuns.SPAS12_Selector_Pump"] = { open = "MarzGuns.Bolt_Fired", locked = "MarzGuns.Bolt_Lock" },
            },
        },
        Pump = {
            partType = "Selector",
            variants = {
                ["MarzGuns.SPAS12_Selector_Pump"] = { open = "MarzGuns.Pump_Fired", locked = "MarzGuns.Pump_Lock" },
            },
        },
    }
}

Animations.RegisterMultipleWeaponsWithAnimatedParts({
    ["MarzGuns.M92FS"] = Slide,
    ["MarzGuns.M93R"] = Slide,
    ["MarzGuns.USP"] = Slide,
    ["MarzGuns.DEAGLE"] = Slide,
    ["MarzGuns.HIPOWER"] = Slide,
    ["MarzGuns.P226"] = Slide,
    ["MarzGuns.M1911"] = Slide,
    ["MarzGuns.VP70M"] = Slide,

    ["MarzGuns.MOSSBERG_590"] = Pump,
    ["MarzGuns.TRENCHGUN"] = Pump,
    ["MarzGuns.REMINGTON_870"] = Pump,

    ["MarzGuns.STEVENS_555"] = Break_Shotgun_Barrels,
    ["MarzGuns.DOUBLEBARREL"] = Break_Shotgun_Barrels,
    ["MarzGuns.TOZ34"] = Break_Shotgun_Barrels,
    ["MarzGuns.M79"] = Barrel,

    ["MarzGuns.AA12"] = Bolt,
    ["MarzGuns.SPAS12"] = SPAS12,
    ["MarzGuns.BENELLI_M4"] = Bolt,

    ["MarzGuns.M16A1"] = Bolt,
    ["MarzGuns.M16A2"] = Bolt,
    ["MarzGuns.M16A2_M203"] = Bolt,
    ["MarzGuns.M203_Weapon"] = Underbarrel,
    ["MarzGuns.M16A3"] = Bolt,
    ["MarzGuns.AR15"] = Bolt,
    ["MarzGuns.FNC"] = Bolt,
    ["MarzGuns.AK74"] = Bolt,
    ["MarzGuns.AKS74U"] = Bolt,
    ["MarzGuns.ASVAL"] = Bolt,
    ["MarzGuns.G36C"] = Bolt,
    ["MarzGuns.G36"] = Bolt,
    ["MarzGuns.FAMAS"] = Bolt,
    ["MarzGuns.CAR15"] = Bolt,
    ["MarzGuns.AK47"] = Bolt,
    ["MarzGuns.XM177"] = Bolt,
    ["MarzGuns.M4A1"] = Bolt,
    ["MarzGuns.MINI_14"] = Bolt,

    ["MarzGuns.M1_GARAND"] = Bolt,
    ["MarzGuns.G3"] = Bolt,
    ["MarzGuns.M14"] = Bolt,
    ["MarzGuns.FAL"] = Bolt,

    ["MarzGuns.M60"] = Bolt,
    ["MarzGuns.BAR"] = Bolt,

    ["MarzGuns.MOSIN"] = Bolt,
    ["MarzGuns.M24"] = Bolt,
    ["MarzGuns.M1903"] = Bolt,
    ["MarzGuns.REMINGTON_700"] = Bolt,
    ["MarzGuns.MODEL_70"] = Bolt,

    ["MarzGuns.SVD"] = Bolt,
    ["MarzGuns.SKS"] = Bolt,
    ["MarzGuns.PSG1"] = Bolt,
    ["MarzGuns.CAMP_CARBINE"] = Bolt,

    ["MarzGuns.THOMPSON"] = Bolt,
    ["MarzGuns.MP5"] = Bolt,
    ["MarzGuns.MP5K"] = Bolt,
    ["MarzGuns.TEC9"] = Bolt,
    ["MarzGuns.MP5SD"] = Bolt,
    ["MarzGuns.MP5A2"] = Bolt,
    ["MarzGuns.MAC10"] = Bolt,

    ["MarzGuns.W1894"] = Lever,
    ["MarzGuns.M1895"] = Lever,
    ["MarzGuns.W1887"] = Lever,
    ["MarzGuns.W1873"] = Lever,
    ["MarzGuns.W1873_CARBINE"] = Lever,

    ["MarzGuns.SW629"] = Revolvers,
    ["MarzGuns.PYTHON"] = Revolvers,
    ["MarzGuns.COLT_SINGLE"] = Revolvers,
    ["MarzGuns.MP412"] = Revolvers,
    ["MarzGuns.RHINO"] = Revolvers,
    ["MarzGuns.DETECTIVE_38"] = Revolvers,
})

Animations.RegisterWeaponsWithCustomStates("MarzGuns.M60",
    {
        { threshold = 1, part = "MarzGuns.Bullet_1", slot = "Animated1" },
        { threshold = 2, part = "MarzGuns.Bullet_2", slot = "Animated2" },
        { threshold = 3, part = "MarzGuns.Bullet_3", slot = "Animated3" },
        { threshold = 4, part = "MarzGuns.Bullet_4", slot = "Animated4" },
        { threshold = 5, part = "MarzGuns.Bullet_5", slot = "Animated5" },
        { threshold = 6, part = "MarzGuns.Bullet_6", slot = "Animated6" },
        { threshold = 7, part = "MarzGuns.Bullet_7", slot = "Animated7" },
        { threshold = 8, part = "MarzGuns.Bullet_8", slot = "Animated8" },
        { threshold = 9, part = "MarzGuns.Bullet_9", slot = "Animated9" },
    })
