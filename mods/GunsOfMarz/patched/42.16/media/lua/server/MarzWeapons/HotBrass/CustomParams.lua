local SpentCasingPhysics

if getActivatedMods():contains("HBVCEFb42") then
    SpentCasingPhysics = require("SpentCasingPhysics/Init")
end

if SpentCasingPhysics then
    SpentCasingPhysics.RegisterCasingToAmmo({
        ["SWMG.9x19_Bullet"] = "HBVCEF.9x19_Casing",
        ["SWMG.45_Bullet"] = "HBVCEF.45_Casing",
        ["SWMG.44_Bullet"] = "HBVCEF.44_Casing",
        ["SWMG.50_Bullet"] = "HBVCEF.50_Casing",
        ["SWMG.500_Bullet"] = "HBVCEF.500_Casing",
        ["SWMG.38_Bullet"] = "HBVCEF.38_Casing",
        ["SWMG.3030_Bullet"] = "HBVCEF.3030_Casing",
        ["SWMG.4570_Bullet"] = "HBVCEF.4570_Casing",
        ["SWMG.357_Bullet"] = "HBVCEF.357_Casing",
        ["SWMG.545x39_Bullet"] = "HBVCEF.545x39_Casing",
        ["SWMG.9x39_Bullet"] = "HBVCEF.9x39_Casing",
        ["SWMG.762x39_Bullet"] = "HBVCEF.762x39_Casing",
        ["SWMG.762x54_Bullet"] = "HBVCEF.762x54_Casing",
        ["SWMG.3006_Bullet"] = "HBVCEF.3006_Casing",

        ["SWMG.308_Bullet"] = "HBVCEF.762x51_Casing",
        ["SWMG.762x51_Bullet"] = "HBVCEF.762x51_Casing",

        ["SWMG.223_Bullet"] = "HBVCEF.556x45_Casing",
        ["SWMG.556x45_Bullet"] = "HBVCEF.556x45_Casing",
        ["SWMG.556x45_Bullet_ArmorPiercing"] = "HBVCEF.556x45_Casing",
        ["SWMG.556x45_Bullet_HollowPoint"] = "HBVCEF.556x45_Casing",
        ["SWMG.556x45_Bullet_Overpressured"] = "HBVCEF.556x45_Casing",
        ["SWMG.556x45_Bullet_Subsonic"] = "HBVCEF.556x45_Casing",

        ["SWMG.12Gauge_Shell_Buckshot"] = "HBVCEF.12Gauge_Hull_Red",
        ["SWMG.12Gauge_Shell_Slug"] = "HBVCEF.12Gauge_Hull_Green",

        ["SWMG.40mm_Round_Buckshot"] = "HBVCEF.40mm_Casing",
        ["SWMG.40mm_Round_HE"] = "HBVCEF.40mm_Casing",
        ["SWMG.40mm_Round_Incendiary"] = "HBVCEF.40mm_Casing",
    })

    SpentCasingPhysics.RegisterWeaponParams({
        ["MarzGuns.M16A1"] = {
            forwardOffset = 0.30,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.M16A2"] = {
            forwardOffset = 0.30,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.M16A2_M203"] = {
            forwardOffset = 0.30,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.M16A3"] = {
            forwardOffset = 0.30,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.AR15"] = {
            forwardOffset = 0.30,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.FNC"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 55,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.CAR15"] = {
            forwardOffset = 0.30,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.XM177"] = {
            forwardOffset = 0.30,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.M4A1"] = {
            forwardOffset = 0.30,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.G36C"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 40,
            ejectAngle    = 65,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.G36"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 40,
            ejectAngle    = 65,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.AK74"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 75,
            ejectAngle    = 45,
            spinForce     = { 164, 164 }
        },

        ["MarzGuns.AKS74U"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 75,
            ejectAngle    = 45,
            spinForce     = { 164, 164 }
        },

        ["MarzGuns.ASVAL"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.09,
            heightOffset  = 0.47,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 75,
            ejectAngle    = 45,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.FAMAS"] = {
            forwardOffset = 0.10,
            sideOffset    = 0.08,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 55,
            spinForce     = { 64, 128 }
        },

        ["MarzGuns.AK47"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 75,
            ejectAngle    = 45,
            spinForce     = { 164, 164 }
        },

        ["MarzGuns.M14"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.55,
            sideSpread    = 90,
            heightSpread  = { 80, 90 },
            ejectAngle    = 25,
            spinForce     = { 86, 124 }
        },

        ["MarzGuns.M1_GARAND"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.40,
            sideSpread    = 90,
            heightSpread  = { 80, 90 },
            ejectAngle    = 10,
            verticalForce = 0.1,
            spinForce     = { 86, 124 }
        },

        ["MarzGuns.G3"] = {
            forwardOffset = 0.37,
            sideOffset    = 0.10,
            heightOffset  = 0.47,
            shellForce    = 1,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 55,
            spinForce     = { 86, 124 }
        },

        ["MarzGuns.FAL"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.85,
            sideSpread    = 60,
            heightSpread  = 90,
            ejectAngle    = 80,
            spinForce     = { 86, 124 }
        },

        ["MarzGuns.MOSIN"] = {
            forwardOffset = 0.38,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.45,
            sideSpread    = 60,
            heightSpread  = 60,
            ejectAngle    = 70,
            spinForce     = { 8, 12 }
        },

        ["MarzGuns.M24"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.45,
            sideSpread    = 60,
            heightSpread  = 60,
            spinForce     = { 8, 12 }
        },

        ["MarzGuns.M1903"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.45,
            sideSpread    = 60,
            heightSpread  = 60,
            spinForce     = { 8, 12 }
        },

        ["MarzGuns.REMINGTON_700"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.45,
            sideSpread    = 60,
            heightSpread  = 60,
            spinForce     = { 8, 12 }
        },

        ["MarzGuns.MODEL_70"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.45,
            sideSpread    = 60,
            heightSpread  = 60,
            spinForce     = { 8, 12 }
        },

        ["MarzGuns.M79"] = {
            forwardOffset = 0.27,
            sideOffset    = 0.0,
            heightOffset  = 0.45,
            shellForce    = 0.15,
            sideSpread    = 30,
            heightSpread  = 1,
            ejectAngle    = 180,
            spinForce     = { 0, 0 }
        },

        ["MarzGuns.M203_Weapon"] = {
            forwardOffset = 0.27,
            sideOffset = 0.10,
            heightOffset = 0.40,
            shellForce = 0.01,
            spinForce = { 0, 0 }
        },

        ["MarzGuns.W1894"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.35,
            sideSpread    = 50,
            heightSpread  = { 40, 50 },
            ejectAngle    = 10,
            spinForce     = { 4, 8 }
        },

        ["MarzGuns.M1895"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.35,
            sideSpread    = 50,
            heightSpread  = 30,
            ejectAngle    = 55,
            spinForce     = { 4, 8 }
        },

        ["MarzGuns.W1887"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.35,
            sideSpread    = 50,
            heightSpread  = { 40, 50 },
            ejectAngle    = 10,
            spinForce     = { 4, 8 }
        },

        ["MarzGuns.W1873"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.35,
            sideSpread    = 50,
            heightSpread  = { 40, 50 },
            ejectAngle    = 45,
            spinForce     = { 4, 8 }
        },

        ["MarzGuns.W1873_CARBINE"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.35,
            sideSpread    = 50,
            heightSpread  = { 40, 50 },
            ejectAngle    = 45,
            spinForce     = { 4, 8 }
        },

        ["MarzGuns.M60"] = {
            forwardOffset = 0.28,
            sideOffset    = 0.08,
            heightOffset  = 0.49,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 46, 64 }
        },

        ["MarzGuns.BAR"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 46, 64 }
        },

        ["MarzGuns.M92FS"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.0,
            heightOffset  = 0.50,
            shellForce    = 0.60,
            sideSpread    = 45,
            heightSpread  = 60,
            spinForce     = { 12, 16 }
        },

        ["MarzGuns.M93R"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.0,
            heightOffset  = 0.50,
            shellForce    = 0.60,
            sideSpread    = 45,
            heightSpread  = 60,
            ejectAngle    = 45,
            spinForce     = { 12, 16 }
        },

        ["MarzGuns.HIPOWER"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.0,
            heightOffset  = 0.50,
            shellForce    = 0.60,
            sideSpread    = 50,
            heightSpread  = 45,
            spinForce     = { 12, 16 }
        },

        ["MarzGuns.P226"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.0,
            heightOffset  = 0.50,
            shellForce    = 0.60,
            sideSpread    = 50,
            heightSpread  = 45,
            spinForce     = { 12, 16 }
        },

        ["MarzGuns.M1911"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.0,
            heightOffset  = 0.50,
            shellForce    = 0.60,
            sideSpread    = 50,
            heightSpread  = 45,
            spinForce     = { 14, 20 }
        },

        ["MarzGuns.USP"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.0,
            heightOffset  = 0.50,
            shellForce    = 0.60,
            sideSpread    = 45,
            heightSpread  = 90,
            spinForce     = { 14, 20 }
        },

        ["MarzGuns.DEAGLE"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.0,
            heightOffset  = 0.50,
            shellForce    = 0.35,
            sideSpread    = 30,
            heightSpread  = { 100, 130 },
            ejectAngle    = 0,
            spinForce     = { 14, 20 }
        },

        ["MarzGuns.VP70M"] = {
            forwardOffset = 0.40,
            sideOffset    = 0.0,
            heightOffset  = 0.50,
            shellForce    = 0.60,
            sideSpread    = 50,
            heightSpread  = 45,
            spinForce     = { 12, 16 }
        },

        ["MarzGuns.SW629"] = {
            forwardOffset = 0.10,
            sideOffset    = 0.0,
            heightOffset  = 0.30,
            shellForce    = 0.10,
            sideSpread    = 50,
            heightSpread  = { 30, 50 },
            spinForce     = { 3, 6 }
        },

        ["MarzGuns.PYTHON"] = {
            forwardOffset = 0.10,
            sideOffset    = 0.0,
            heightOffset  = 0.30,
            shellForce    = 0.10,
            sideSpread    = 50,
            heightSpread  = { 30, 50 },
            spinForce     = { 3, 6 }
        },

        ["MarzGuns.RHINO"] = {
            forwardOffset = 0.10,
            sideOffset    = 0.0,
            heightOffset  = 0.30,
            shellForce    = 0.10,
            sideSpread    = 50,
            heightSpread  = { 30, 50 },
            spinForce     = { 3, 6 }
        },

        ["MarzGuns.MP412"] = {
            forwardOffset = 0.10,
            sideOffset    = 0.0,
            heightOffset  = 0.30,
            shellForce    = 0.10,
            sideSpread    = 50,
            heightSpread  = { 30, 50 },
            spinForce     = { 3, 6 }
        },

        ["MarzGuns.COLT_SINGLE"] = {
            forwardOffset = 0.10,
            sideOffset    = 0.0,
            heightOffset  = 0.30,
            shellForce    = 0.10,
            sideSpread    = 50,
            heightSpread  = { 30, 50 },
            spinForce     = { 3, 6 }
        },

        ["MarzGuns.DETECTIVE_38"] = {
            forwardOffset = 0.10,
            sideOffset    = 0.0,
            heightOffset  = 0.30,
            shellForce    = 0.10,
            sideSpread    = 50,
            heightSpread  = { 30, 50 },
            spinForce     = { 3, 6 }
        },

        ["MarzGuns.SVD"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.90,
            sideSpread    = 90,
            heightSpread  = { 80, 90 },
            ejectAngle    = 65,
            spinForce     = { 86, 122 }
        },

        ["MarzGuns.SKS"] = {
            forwardOffset = 0.35,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.40,
            sideSpread    = 90,
            heightSpread  = { 70, 80 },
            ejectAngle    = 30,
            verticalForce = 0.1,
            spinForce     = { 86, 122 }
        },

        ["MarzGuns.PSG1"] = {
            forwardOffset = 0.37,
            sideOffset    = 0.10,
            heightOffset  = 0.47,
            shellForce    = 1,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 55,
            spinForce     = { 74, 86 }
        },

        ["MarzGuns.CAMP_CARBINE"] = {
            forwardOffset = 0.37,
            sideOffset    = 0.10,
            heightOffset  = 0.47,
            shellForce    = 0.55,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 55,
            spinForce     = { 32, 44 }
        },

        ["MarzGuns.MINI_14"] = {
            forwardOffset = 0.37,
            sideOffset    = 0.10,
            heightOffset  = 0.47,
            shellForce    = 0.65,
            sideSpread    = 60,
            heightSpread  = 30,
            ejectAngle    = 55,
            spinForce     = { 56, 70 }
        },

        ["MarzGuns.MOSSBERG_590"] = {
            forwardOffset = 0.27,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.25,
            sideSpread    = 30,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 4, 8 }
        },

        ["MarzGuns.TRENCHGUN"] = {
            forwardOffset = 0.27,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.25,
            sideSpread    = 30,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 4, 8 }
        },

        ["MarzGuns.BENELLI_M4"] = {
            forwardOffset = 0.27,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.25,
            sideSpread    = 30,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 12, 18 }
        },

        ["MarzGuns.SPAS12"] = {
            forwardOffset = 0.27,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.25,
            sideSpread    = 30,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 12, 18 }
        },

        ["MarzGuns.STEVENS_555"] = {
            forwardOffset = 0.27,
            sideOffset    = 0.0,
            heightOffset  = 0.45,
            shellForce    = 0.15,
            sideSpread    = 30,
            heightSpread  = { 80, 100 },
            ejectAngle    = 180,
            spinForce     = { 2, 6 }
        },

        ["MarzGuns.DOUBLEBARREL"] = {
            forwardOffset = 0.27,
            sideOffset    = 0.0,
            heightOffset  = 0.45,
            shellForce    = 0.15,
            sideSpread    = 30,
            heightSpread  = { 80, 100 },
            ejectAngle    = 180,
            spinForce     = { 2, 6 }
        },

        ["MarzGuns.AA12"] = {
            forwardOffset = 0.32,
            sideOffset    = 0.06,
            heightOffset  = 0.45,
            shellForce    = 0.65,
            sideSpread    = 50,
            heightSpread  = 50,
            ejectAngle    = 75,
            spinForce     = { 12, 18 }
        },

        ["MarzGuns.REMINGTON_870"] = {
            forwardOffset = 0.27,
            sideOffset    = 0.10,
            heightOffset  = 0.45,
            shellForce    = 0.25,
            sideSpread    = 30,
            heightSpread  = 30,
            ejectAngle    = 75,
            spinForce     = { 4, 8 }
        },

        ["MarzGuns.TOZ34"] = {
            forwardOffset = 0.27,
            sideOffset    = 0.0,
            heightOffset  = 0.45,
            shellForce    = 0.15,
            sideSpread    = 30,
            heightSpread  = { 80, 100 },
            ejectAngle    = 180,
            spinForce     = { 2, 6 }
        },

        ["MarzGuns.THOMPSON"] = {
            forwardOffset = 0.34,
            sideOffset    = 0.08,
            heightOffset  = 0.48,
            shellForce    = 0.75,
            sideSpread    = 50,
            heightSpread  = { 80, 100 },
            ejectAngle    = 90,
            spinForce     = { 24, 34 }
        },

        ["MarzGuns.MP5"] = {
            forwardOffset = 0.36,
            sideOffset    = 0.08,
            heightOffset  = 0.48,
            shellForce    = 0.65,
            sideSpread    = 50,
            heightSpread  = { 80, 100 },
            ejectAngle    = 80,
            spinForce     = { 24, 34 }
        },

        ["MarzGuns.MP5SD"] = {
            forwardOffset = 0.36,
            sideOffset    = 0.08,
            heightOffset  = 0.48,
            shellForce    = 0.65,
            sideSpread    = 50,
            heightSpread  = { 80, 100 },
            ejectAngle    = 80,
            spinForce     = { 24, 34 }
        },

        ["MarzGuns.MP5A2"] = {
            forwardOffset = 0.36,
            sideOffset    = 0.08,
            heightOffset  = 0.48,
            shellForce    = 0.65,
            sideSpread    = 50,
            heightSpread  = { 80, 100 },
            ejectAngle    = 80,
            spinForce     = { 24, 34 }
        },

        ["MarzGuns.MP5K"] = {
            forwardOffset = 0.55,
            sideOffset    = 0.06,
            heightOffset  = 0.53,
            shellForce    = 0.65,
            sideSpread    = 50,
            heightSpread  = { 80, 100 },
            ejectAngle    = 80,
            spinForce     = { 24, 34 }
        },

        ["MarzGuns.TEC9"] = {
            forwardOffset = 0.55,
            sideOffset    = 0.06,
            heightOffset  = 0.53,
            shellForce    = 0.45,
            sideSpread    = 50,
            heightSpread  = { 80, 100 },
            ejectAngle    = 80,
            spinForce     = { 24, 34 }
        },

        ["MarzGuns.MAC10"] = {
            forwardOffset = 0.55,
            sideOffset    = 0.06,
            heightOffset  = 0.53,
            shellForce    = 0.45,
            sideSpread    = 50,
            heightSpread  = { 80, 100 },
            ejectAngle    = 80,
            spinForce     = { 24, 34 }
        },
    })

    SpentCasingPhysics.RegisterPressureProfiles({
        ["556x45mmCivilianAmmo"] = 0.7,
        ["556x45mmSubsonicAmmo"] = 0.25,
        ["556x45mmArmorPiercingAmmo"] = 1.1,
        ["556x45mmHollowPointAmmo"] = 1.1,
        ["556x45mmOverpressuredAmmo"] = 1.7,
        ["762x51mmCivilianAmmo"] = 0.7,
    })

    SpentCasingPhysics.RegisterItemSound({
        ["SWMG.9x19_Bullet"] = "Bullet",
        ["SWMG.45_Bullet"] = "Bullet",
        ["SWMG.44_Bullet"] = "Bullet",
        ["SWMG.50_Bullet"] = "Bullet",
        ["SWMG.38_Bullet"] = "Bullet",
        ["SWMG.3030_Bullet"] = "Bullet",
        ["SWMG.4570_Bullet"] = "Bullet",
        ["SWMG.357_Bullet"] = "Bullet",
        ["SWMG.545x39_Bullet"] = "Bullet",
        ["SWMG.9x39_Bullet"] = "Bullet",
        ["SWMG.762x39_Bullet"] = "Bullet",
        ["SWMG.762x54_Bullet"] = "Bullet",
        ["SWMG.3006_Bullet"] = "Bullet",

        ["SWMG.308_Bullet"] = "Bullet",
        ["SWMG.762x51_Bullet"] = "Bullet",

        ["SWMG.223_Bullet"] = "Bullet",
        ["SWMG.556x45_Bullet"] = "Bullet",
        ["SWMG.556x45_Bullet_ArmorPiercing"] = "Bullet",
        ["SWMG.556x45_Bullet_HollowPoint"] = "Bullet",
        ["SWMG.556x45_Bullet_Overpressured"] = "Bullet",
        ["SWMG.556x45_Bullet_Subsonic"] = "Bullet",

        ["SWMG.12Gauge_Shell_Buckshot"] = "Shell",
        ["SWMG.12Gauge_Shell_Slug"] = "Shell",

        ["SWMG.40mm_Round_Buckshot"] = "Canister",
        ["SWMG.40mm_Round_HE"] = "Canister",
        ["SWMG.40mm_Round_Incendiary"] = "Canister",
    })
end
