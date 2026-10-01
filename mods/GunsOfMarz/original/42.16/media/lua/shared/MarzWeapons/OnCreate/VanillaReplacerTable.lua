local MarzGuns_VanillaReplacer = {}

MarzGuns_VanillaReplacer.VanillaWeaponMap = {
    ["Base.AssaultRifle"] = {
        {
            {
                items = {
                    "MarzGuns.M16A1",
                    "MarzGuns.M16A2",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.556x45Magazine20_STANAG",
                    "MarzGuns.556x45Magazine30_STANAG",
                },
                amountChance = 4,
            },
            {
                items = {
                    "MarzGuns.556x45_Box"
                },
                amountChance = 4,
            },
        },
    },

    ["Base.AssaultRifle2"] = {
        {
            {
                items = {
                    "MarzGuns.M14",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.762x51Magazine20_M14",
                },
                amountChance = 4,
            },
            {
                items = {
                    "MarzGuns.762x51_Box"
                },
                amountChance = 4,
            },
        },
    },

    ["Base.DoubleBarrelShotgun"] = {
        {
            {
                items = {
                    "MarzGuns.DOUBLEBARREL",
                    "MarzGuns.STEVENS_555",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.12Gauge_Box_Buckshot",
                    "MarzGuns.12Gauge_Box_Slug",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.DoubleBarrelShotgunSawnoff"] = {
        {
            {
                items = {
                    "MarzGuns.DOUBLEBARREL",
                    "MarzGuns.STEVENS_555",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.12Gauge_Box_Buckshot",
                    "MarzGuns.12Gauge_Box_Slug",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.HuntingRifle"] = {
        {
            {
                items = {
                    "MarzGuns.REMINGTON_700",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.308_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.Pistol"] = {
        {
            {
                items = {
                    "MarzGuns.M92FS",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.9x19Magazine15_M92FS",
                },
                amountChance = 4,
            },
            {
                items = {
                    "MarzGuns.9x19_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.Pistol2"] = {
        {
            {
                items = {
                    "MarzGuns.M1911",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.45Magazine7_M1911",
                },
                amountChance = 4,
            },
            {
                items = {
                    "MarzGuns.45_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.Pistol3"] = {
        {
            {
                items = {
                    "MarzGuns.DEAGLE",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.50Magazine8_DEAGLE",
                },
                amountChance = 4,
            },
            {
                items = {
                    "MarzGuns.50_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.Revolver"] = {
        {
            {
                items = {
                    "MarzGuns.PYTHON",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.357_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.Revolver_Long"] = {
        {
            {
                items = {
                    "MarzGuns.SW629",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.44_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.Revolver_Short"] = {
        {
            {
                items = {
                    "MarzGuns.DETECTIVE_38",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.38_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.Shotgun"] = {
        {
            {
                items = {
                    "MarzGuns.MOSSBERG_590",
                    "MarzGuns.REMINGTON_870",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.ShotgunSawnoff"] = {
        {
            {
                items = {
                    "MarzGuns.MOSSBERG_590",
                    "MarzGuns.REMINGTON_870",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.12Gauge_Box_Buckshot",
                    "MarzGuns.12Gauge_Box_Slug",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.VarmintRifle"] = {
        {
            {
                items = {
                    "MarzGuns.MODEL_70",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.223_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.JS14_Rifle"] = {
        {
            {
                items = {
                    "MarzGuns.MINI_14",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.223Magazine10_Mini14",
                    "MarzGuns.223Magazine20_Mini14",
                },
                amountChance = 4,
            },
            {
                items = {
                    "MarzGuns.223_Box",
                },
                amountChance = 4,
            },
        },
        {
            {
                items = {
                    "MarzGuns.AR15",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.556x45Magazine20_STANAG",
                },
                amountChance = 4,
            },
            {
                items = {
                    "MarzGuns.223_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.JS3T_Shotgun"] = {
        {
            {
                items = {
                    "MarzGuns.SPAS12",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.12Gauge_Box_Buckshot",
                    "MarzGuns.12Gauge_Box_Slug",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.L92_Carbine"] = {
        {
            {
                items = {
                    "MarzGuns.W1873",
                    "MarzGuns.W1873_CARBINE"
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.357_Box",
                    "MarzGuns.38_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.L94_Rifle"] = {
        {
            {
                items = {
                    "MarzGuns.W1894",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.3030_Box",
                },
                amountChance = 4,
            },
        },
        {
            {
                items = {
                    "MarzGuns.M1895",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.4570_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.MSR7T_Rifle"] = {
        {
            {
                items = {
                    "MarzGuns.M24",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.762x51_Box",
                },
                amountChance = 4,
            },
        },
    },

    ["Base.TrapperCarbine"] = {
        {
            {
                items = {
                    "MarzGuns.CAMP_CARBINE",
                },
                amountChance = 1,
            },
            {
                items = {
                    "MarzGuns.45Magazine7_M1911",
                },
                amountChance = 4,
            },
            {
                items = {
                    "MarzGuns.45_Box",
                },
                amountChance = 4,
            },
        },
    },
}

MarzGuns_VanillaReplacer.VanillaAmmoMap = {
    ["Base.308Bullets"] = {
        {
            {
                items = {
                    "SWMG.762x51_Bullet",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.308Box"] = {
        {
            {
                items = {
                    "MarzGuns.762x51_Box",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.308Carton"] = {
        {
            {
                items = {
                    "MarzGuns.762x51_Carton",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.556Bullets"] = {
        {
            {
                items = {
                    "SWMG.556x45_Bullet",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.556Box"] = {
        {
            {
                items = {
                    "MarzGuns.556x45_Box",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.556Carton"] = {
        {
            {
                items = {
                    "MarzGuns.556x45_Carton",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.3030Bullets"] = {
        {
            {
                items = {
                    "SWMG.3030_Bullet",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.3030Box"] = {
        {
            {
                items = {
                    "MarzGuns.3030_Box",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.3030Carton"] = {
        {
            {
                items = {
                    "MarzGuns.3030_Carton",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets357"] = {
        {
            {
                items = {
                    "SWMG.357_Bullet",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets357Box"] = {
        {
            {
                items = {
                    "MarzGuns.357_Box",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets357Carton"] = {
        {
            {
                items = {
                    "MarzGuns.357_Carton",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets38"] = {
        {
            {
                items = {
                    "SWMG.38_Bullet",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets38Box"] = {
        {
            {
                items = {
                    "MarzGuns.38_Box",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets38Carton"] = {
        {
            {
                items = {
                    "MarzGuns.38_Carton",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets44"] = {
        {
            {
                items = {
                    "SWMG.44_Bullet",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets44Box"] = {
        {
            {
                items = {
                    "MarzGuns.44_Box",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets44Carton"] = {
        {
            {
                items = {
                    "MarzGuns.44_Carton",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets45"] = {
        {
            {
                items = {
                    "SWMG.45_Bullet",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets45Box"] = {
        {
            {
                items = {
                    "MarzGuns.45_Box",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets45Carton"] = {
        {
            {
                items = {
                    "MarzGuns.45_Carton",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets9mm"] = {
        {
            {
                items = {
                    "SWMG.9x19_Bullet",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets9mmBox"] = {
        {
            {
                items = {
                    "MarzGuns.9x19_Box",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Bullets9mmCarton"] = {
        {
            {
                items = {
                    "MarzGuns.9x19_Carton",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.ShotgunShells"] = {
        {
            {
                items = {
                    "SWMG.12Gauge_Shell_Buckshot",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.ShotgunShellsBox"] = {
        {
            {
                items = {
                    "MarzGuns.12Gauge_Box_Buckshot",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.ShotgunShellsCarton"] = {
        {
            {
                items = {
                    "MarzGuns.12Gauge_Carton_Buckshot",
                },
                amountChance = 1,
            },
        },
    },
}

MarzGuns_VanillaReplacer.VanillaMagazineMap = {
    ["Base.44Clip"] = {
        {
            {
                items = {
                    "MarzGuns.50Magazine8_DEAGLE",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.45Clip"] = {
        {
            {
                items = {
                    "MarzGuns.45Magazine7_M1911",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.9mmClip"] = {
        {
            {
                items = {
                    "MarzGuns.9x19Magazine15_M92FS",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.M14Clip"] = {
        {
            {
                items = {
                    "MarzGuns.762x51Magazine20_M14",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.556Clip"] = {
        {
            {
                items = {
                    "MarzGuns.556x45Magazine30_STANAG",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.JS14_Clip"] = {
        {
            {
                items = {
                    "MarzGuns.223Magazine10_Mini14",
                    "MarzGuns.223Magazine20_Mini14",
                    "MarzGuns.223Magazine30_Mini14",
                },
                amountChance = 1,
            },
        },
    },
}

MarzGuns_VanillaReplacer.VanillaAttachmentMap = {
    ["Base.TritiumSights"] = {
        {
            {
                items = {
                    "MarzGuns.ReflexS2_Sight",
                    "MarzGuns.Kobra_Sight",
                    "MarzGuns.OKP3_Sight",
                    "MarzGuns.JS14_Sight",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.RedDot"] = {
        {
            {
                items = {
                    "MarzGuns.ReflexS2_Sight",
                    "MarzGuns.Kobra_Sight",
                    "MarzGuns.OKP3_Sight",
                    "MarzGuns.JS14_Sight",
                    "MarzGuns.EXPS3_Sight",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.x2Scope"] = {
        {
            {
                items = {
                    "MarzGuns.EXPS1_Sight",
                    "MarzGuns.Aimpoint_Sight",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.x4Scope"] = {
        {
            {
                items = {
                    "MarzGuns.LR4X_Scope",
                    "MarzGuns.TA28_Scope",
                    "MarzGuns.ElcanX2_Scope",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.x8Scope"] = {
        {
            {
                items = {
                    "MarzGuns.TR06X_Scope",
                    "MarzGuns.PSO1_Scope",
                    "MarzGuns.LR10X_Scope",
                    "MarzGuns.LRX12X_Scope",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.AmmoStraps"] = {
        {
            {
                items = {
                    "MarzGuns.Shellholder",
                    "MarzGuns.Beretta_Stock_Folded",
                    "MarzGuns.VP70M_Stock",
                    "MarzGuns.Rem700_Sling",
                    "MarzGuns.Model_70_Sling",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.RecoilPad"] = {
        {
            {
                items = {
                    "MarzGuns.Bipod_Folded",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.Laser"] = {
        {
            {
                items = {
                    "MarzGuns.PJ-3_Laser",
                    "MarzGuns.PX1_Laser",
                    "MarzGuns.TR-1_Laser",
                    "MarzGuns.AimRight_Laser",
                    "MarzGuns.LRX-7_Laser",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.GunLight"] = {
        {
            {
                items = {
                    "MarzGuns.LP_Light",
                    "MarzGuns.TL_Light",
                    "MarzGuns.BrightPoint-5_Light",
                    "MarzGuns.SR7_Light",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.ChokeTubeFull"] = {
        {
            {
                items = {
                    "MarzGuns.LR2_Compensator",
                    "MarzGuns.LX_Flashhider",
                    "MarzGuns.Trix42_Muzzlebreak",
                },
                amountChance = 1,
            },
        },
    },

    ["Base.ChokeTubeImproved"] = {
        {
            {
                items = {
                    "MarzGuns.AR_Muzzle_Mount_Device",
                    "MarzGuns.AK_Muzzle_Mount_Device",
                    "MarzGuns.Pistol_Muzzle_Mount_Device",
                    "MarzGuns.45_Muzzle_Mount_Device",
                },
                amountChance = 1,
            },
        },
    },
}

return MarzGuns_VanillaReplacer
