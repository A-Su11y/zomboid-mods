local Ammo = require("WeaponSystems/Utils/Ammo")
local StatsFactory = require("WeaponSystems/Utils/StatsFactory")

-------------------------------------------------
-- Restore Stats: stats that ammo profiles may modify
-------------------------------------------------
Ammo.RegisterRestoreStats({
    "MaxDamage",
    "MinDamage",
    "MaxRange",
    "MinRange",
    "CritDmgMultiplier",
    "ProjectileCount",
    "MaxHitCount",
    "CriticalChance",
    "PiercingBullets",
    "SoundRadius",
    "SoundVolume",
    "RackAfterShot",
    "ConditionLowerChanceOneIn",
    "MuzzleFlashModelKey",
})

-------------------------------------------------
-- Item -> Ammo Family mappings
-------------------------------------------------
Ammo.RegisterMultipleItemsWithFamilies({
    ["5.56x45mm"] = {
        "MarzGuns.556x45Magazine20_STANAG",
        "MarzGuns.556x45Magazine25_STANAG",
        "MarzGuns.556x45Magazine30_STANAG",
        "MarzGuns.556x45Magazine50_STANAG",
        "MarzGuns.556x45Magazine75_STANAG",
        "MarzGuns.556x45Magazine100_STANAG",
        "MarzGuns.556x45Magazine150_STANAG",
        "MarzGuns.556x45Magazine60_STANAG",
        "MarzGuns.556x45Magazine30_G36",
        "MarzGuns.223Magazine10_Mini14",
        "MarzGuns.223Magazine20_Mini14",
        "MarzGuns.223Magazine30_Mini14",
        "MarzGuns.MODEL_70",
    },

    ["7.62x51mm"] = {
        "MarzGuns.762x51Magazine20_M14",
        "MarzGuns.762x51Magazine20_FAL",
        "MarzGuns.762x51Magazine20_G3",
        "MarzGuns.762x51Box100_M60",
        "MarzGuns.762x51Magazine5_PSG1",
        "MarzGuns.REMINGTON_700",
        "MarzGuns.M24",
    },

    ["12Gauge"] = {
        "MarzGuns.MOSSBERG_590",
        "MarzGuns.TRENCHGUN",
        "MarzGuns.BENELLI_M4",
        "MarzGuns.SPAS12",
        "MarzGuns.STEVENS_555",
        "MarzGuns.DOUBLEBARREL",
        "MarzGuns.REMINGTON_870",
        "MarzGuns.TOZ34",
        "MarzGuns.12GMagazine8_AA12",
        "MarzGuns.12GMagazine20_AA12",
        "MarzGuns.W1887",
    },

    [".30-30 Winchester"] = {
        "MarzGuns.W1894",
    },

    [".38 .357"] = {
        "MarzGuns.PYTHON",
        "MarzGuns.RHINO",
        "MarzGuns.38357SpeedLoader6",
        "MarzGuns.W1873",
        "MarzGuns.W1873_CARBINE",
        "MarzGuns.MP412",
        "MarzGuns.DETECTIVE_38",
    },

    [".44 Magnum"] = {
        "MarzGuns.SW629",
    },

    [".50 AE"] = {
        "MarzGuns.50Magazine8_DEAGLE",
        "MarzGuns.50Magazine12_DEAGLE",
    },

    [".45 ACP"] = {
        "MarzGuns.COLT_SINGLE",
        "MarzGuns.45Magazine7_M1911",
        "MarzGuns.45Magazine12_USP",
        "MarzGuns.45Magazine20_USP",
        "MarzGuns.45Magazine30_THOMPSON",
        "MarzGuns.45Magazine20_THOMPSON",
        "MarzGuns.45Magazine100_THOMPSON",
        "MarzGuns.45Magazine30_MAC10",
        "MarzGuns.45Magazine40_MAC10",
    },

    ["9x19mm"] = {
        "MarzGuns.9x19Magazine15_M92FS",
        "MarzGuns.9x19Magazine30_M92FS",
        "MarzGuns.9x19Magazine50_M92FS",
        "MarzGuns.9x19Magazine18_M93R",
        "MarzGuns.9x19Magazine60_M93R",
        "MarzGuns.9x19Magazine13_HIPOWER",
        "MarzGuns.9x19Magazine10_P226",
        "MarzGuns.9x19Magazine20_MP5",
        "MarzGuns.9x19Magazine25_MP5",
        "MarzGuns.9x19Magazine30_MP5",
        "MarzGuns.9x19Magazine60_MP5",
        "MarzGuns.9x19Magazine100_MP5",
        "MarzGuns.9x19Magazine20_TEC9",
        "MarzGuns.9x19Magazine18_VP70M",
        "MarzGuns.9x19Magazine30_VP70M",
    },

    ["5.45x39mm"] = {
        "MarzGuns.545x39Magazine30_Bakelite",
        "MarzGuns.545x39Magazine45_Bakelite",
        "MarzGuns.545x39Magazine100_Drum"
    },

    ["7.62x39mm"] = {
        "MarzGuns.762x39Magazine30",
        "MarzGuns.762x39Magazine75",
        "MarzGuns.SKS",
    },

    ["9x39mm"] = {
        "MarzGuns.9x39Magazine30",
    },

    [".30-06"] = {
        "MarzGuns.3006Clip8",
        "MarzGuns.3006Magazine20_BAR",
        "MarzGuns.M1903",
    },

    ["7.62x54mm"] = {
        "MarzGuns.762x54StripperClip5_MOSIN",
        "MarzGuns.762x54Magazine10_SVD"
    },

    ["40mm"] = {
        "MarzGuns.M79",
        "MarzGuns.M203_Weapon",
    },

    [".45-70 Government"] = {
        "MarzGuns.M1895",
    },
})

-------------------------------------------------
-- Ammo Families (bullet types per caliber)
-------------------------------------------------
Ammo.RegisterMultipleAmmoFamilies({
    ["5.56x45mm"] = {
        { type = "SWMG.556x45_Bullet",               enum = SWMG_AmmoTypes.BULLET_556x45,               profile = "556x45mmBaseAmmo" },
        { type = "SWMG.223_Bullet",                  enum = SWMG_AmmoTypes.BULLET_223,                  profile = "556x45mmCivilianAmmo" },
        { type = "SWMG.556x45_Bullet_ArmorPiercing", enum = SWMG_AmmoTypes.BULLET_556x45_ArmorPiercing, profile = "556x45mmArmorPiercingAmmo" },
        { type = "SWMG.556x45_Bullet_HollowPoint",   enum = SWMG_AmmoTypes.BULLET_556x45_HollowPoint,   profile = "556x45mmHollowPointAmmo" },
        { type = "SWMG.556x45_Bullet_Overpressured", enum = SWMG_AmmoTypes.BULLET_556x45_Overpressured, profile = "556x45mmOverpressuredAmmo" },
        { type = "SWMG.556x45_Bullet_Subsonic",      enum = SWMG_AmmoTypes.BULLET_556x45_Subsonic,      profile = "556x45mmSubsonicAmmo" },

        { type = "Base.556Bullets",                  enum = AmmoType.BULLETS_556,                       profile = "556x45mmBaseAmmo" },
    },

    ["7.62x51mm"] = {
        { type = "SWMG.762x51_Bullet", enum = SWMG_AmmoTypes.BULLET_762x51, profile = "762x51mmBaseAmmo" },
        { type = "SWMG.308_Bullet",    enum = SWMG_AmmoTypes.BULLET_308,    profile = "762x51mmCivilianAmmo" },

        { type = "Base.308Bullets",    enum = AmmoType.BULLETS_308,         profile = "762x51mmBaseAmmo" },
    },

    ["12Gauge"] = {
        { type = "SWMG.12Gauge_Shell_Buckshot", enum = SWMG_AmmoTypes.SHELL_12G_BUCKSHOT, profile = "12GaugeBuckAmmo" },
        { type = "SWMG.12Gauge_Shell_Slug",     enum = SWMG_AmmoTypes.SHELL_12G_SLUG,     profile = "12GaugeSlugAmmo" },

        { type = "Base.ShotgunShells",          enum = AmmoType.SHOTGUN_SHELLS,           profile = "12GaugeBuckAmmo" },
    },

    [".30-30 Winchester"] = {
        { type = "SWMG.3030_Bullet", enum = SWMG_AmmoTypes.BULLET_3030, profile = "3030WinchesterAmmo" },

        { type = "Base.3030Bullets", enum = AmmoType.BULLETS_3030,      profile = "3030WinchesterAmmo" },
    },

    [".38 .357"] = {
        { type = "SWMG.357_Bullet", enum = SWMG_AmmoTypes.BULLET_357, profile = "357MagnumAmmo" },
        { type = "SWMG.38_Bullet",  enum = SWMG_AmmoTypes.BULLET_38,  profile = "38SpecialAmmo" },

        { type = "Base.Bullets357", enum = AmmoType.BULLETS_357,      profile = "357MagnumAmmo" },
        { type = "Base.Bullets38",  enum = AmmoType.BULLETS_38,       profile = "38SpecialAmmo" },
    },

    [".44 Magnum"] = {
        { type = "SWMG.44_Bullet", enum = SWMG_AmmoTypes.BULLET_44, profile = "44MagnumAmmo" },

        { type = "Base.Bullets44", enum = AmmoType.BULLETS_44,      profile = "44MagnumAmmo" },
    },

    [".50 AE"] = {
        { type = "SWMG.50_Bullet", enum = SWMG_AmmoTypes.BULLET_50, profile = "50EAAmmo" },
    },

    [".45 ACP"] = {
        { type = "SWMG.45_Bullet", enum = SWMG_AmmoTypes.BULLET_45, profile = "45ACPAmmo" },

        { type = "Base.Bullets45", enum = AmmoType.BULLETS_45,      profile = "45ACPAmmo" },
    },

    ["9x19mm"] = {
        { type = "SWMG.9x19_Bullet", enum = SWMG_AmmoTypes.BULLET_9x19, profile = "9x19mmAmmo" },

        { type = "Base.Bullets9mm",  enum = AmmoType.BULLETS_9MM,       profile = "9x19mmAmmo" },
    },

    ["5.45x39mm"] = {
        { type = "SWMG.545x39_Bullet", enum = SWMG_AmmoTypes.BULLET_545x39, profile = "545x39mmAmmo" },
    },

    ["7.62x39mm"] = {
        { type = "SWMG.762x39_Bullet", enum = SWMG_AmmoTypes.BULLET_762x39, profile = "762x39mmAmmo" },
    },

    ["9x39mm"] = {
        { type = "SWMG.9x39_Bullet", enum = SWMG_AmmoTypes.BULLET_9x39, profile = "9x39mmAmmo" },
    },

    [".30-06"] = {
        { type = "SWMG.3006_Bullet", enum = SWMG_AmmoTypes.BULLET_3006, profile = "3006Ammo" },
    },

    ["7.62x54mm"] = {
        { type = "SWMG.762x54_Bullet", enum = SWMG_AmmoTypes.BULLET_762x54, profile = "762x54mmAmmo" },
    },

    ["40mm"] = {
        { type = "SWMG.40mm_Round_Buckshot",   enum = SWMG_AmmoTypes.ROUND_40MM_BUCKSHOT,   profile = "40mmBuckshotAmmo" },
        { type = "SWMG.40mm_Round_HE",         enum = SWMG_AmmoTypes.ROUND_40MM_HE,         profile = "40mmHEAmmo" },
        { type = "SWMG.40mm_Round_Incendiary", enum = SWMG_AmmoTypes.ROUND_40MM_INCENDIARY, profile = "40mmIncendiaryAmmo" },
    },

    [".45-70 Government"] = {
        { type = "SWMG.4570_Bullet", enum = SWMG_AmmoTypes.BULLET_4570, profile = "4570GovernmentAmmo" },
    },
})

-------------------------------------------------
-- Ammo Stat Profiles
-------------------------------------------------
Ammo.RegisterMultipleAmmoStats({
    ["556x45mmBaseAmmo"] = {
        -- no modifiers, use base stats
    },
    ["556x45mmArmorPiercingAmmo"] = {
        StatsFactory.Multiply("MaxDamage", 0.85),
        StatsFactory.Multiply("MinDamage", 0.85),
        StatsFactory.Multiply("CritDmgMultiplier", 0.95),
        StatsFactory.Multiply("CriticalChance", 0.9),
        StatsFactory.Set("PiercingBullets", true),
        StatsFactory.Set("MaxHitCount", 5),
    },
    ["556x45mmHollowPointAmmo"] = {
        StatsFactory.Multiply("MaxDamage", 1.2),
        StatsFactory.Multiply("MinDamage", 1.2),
        StatsFactory.Multiply("CritDmgMultiplier", 1.15),
        StatsFactory.Multiply("CriticalChance", 1.05),
        StatsFactory.Multiply("ConditionLowerChanceOneIn", 0.85),
    },
    ["556x45mmCivilianAmmo"] = {
        StatsFactory.Multiply("MaxDamage", 0.7),
        StatsFactory.Multiply("MinDamage", 0.7),
        StatsFactory.Multiply("CritDmgMultiplier", 0.80),
        StatsFactory.Multiply("CriticalChance", 0.9),
        StatsFactory.Multiply("ConditionLowerChanceOneIn", 1.50),
    },
    ["556x45mmOverpressuredAmmo"] = {
        StatsFactory.Multiply("MaxDamage", 1.5),
        StatsFactory.Multiply("MinDamage", 1.5),
        StatsFactory.Multiply("CritDmgMultiplier", 1.50),
        StatsFactory.Multiply("CriticalChance", 1.05),
        StatsFactory.Multiply("ConditionLowerChanceOneIn", 0.5),
        StatsFactory.Set("PiercingBullets", true),
        StatsFactory.Set("MaxHitCount", 2),
    },
    ["556x45mmSubsonicAmmo"] = {
        StatsFactory.Multiply("MaxDamage", 0.4),
        StatsFactory.Multiply("MinDamage", 0.4),
        StatsFactory.Multiply("SoundRadius", 0.5),
        StatsFactory.Multiply("SoundVolume", 0.5),
        StatsFactory.Multiply("ConditionLowerChanceOneIn", 2.0),
        StatsFactory.Set("RackAfterShot", true),
    },

    ["762x51mmBaseAmmo"] = {
        -- no modifiers, use base stats
    },
    ["762x51mmCivilianAmmo"] = {
        StatsFactory.Multiply("MaxDamage", 0.75),
        StatsFactory.Multiply("MinDamage", 0.75),
        StatsFactory.Multiply("CritDmgMultiplier", 0.85),
        StatsFactory.Multiply("CriticalChance", 0.9),
        StatsFactory.Multiply("ConditionLowerChanceOneIn", 1.50),
    },

    ["12GaugeBuckAmmo"] = {
        -- no modifiers, use base stats
    },
    ["12GaugeSlugAmmo"] = {
        StatsFactory.Multiply("MaxDamage", 2.0),
        StatsFactory.Multiply("MinDamage", 2.0),
        StatsFactory.Set("PiercingBullets", true),
        StatsFactory.Set("MaxHitCount", 3),
        StatsFactory.Set("ProjectileCount", 1),
    },

    ["40mmHEAmmo"] = {
        StatsFactory.Set("ProjectileCount", 0),
        StatsFactory.Set("MaxHitCount", 0),
        StatsFactory.Set("MuzzleFlashModelKey", nil),
        StatsFactory.Set("MaxRange", 1),
        StatsFactory.Set("MinRange", 1),
    },
    ["40mmIncendiaryAmmo"] = {
        StatsFactory.Set("ProjectileCount", 0),
        StatsFactory.Set("MaxHitCount", 0),
        StatsFactory.Set("MuzzleFlashModelKey", nil),
        StatsFactory.Set("MaxRange", 1),
        StatsFactory.Set("MinRange", 1),
    },

    ["38SpecialAmmo"] = {
        StatsFactory.Multiply("MaxDamage", 0.8),
        StatsFactory.Multiply("MinDamage", 0.8),
        StatsFactory.Multiply("CritDmgMultiplier", 0.80),
        StatsFactory.Multiply("CriticalChance", 0.9),
        StatsFactory.Multiply("ConditionLowerChanceOneIn", 1.20),
    },
})
