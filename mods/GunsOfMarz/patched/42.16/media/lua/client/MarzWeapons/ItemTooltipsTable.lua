local MarzGuns_TooltipsTable = {}

MarzGuns_TooltipsTable.tooltipsPergun = {
    ["MarzGuns.M16A1"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up, Down.",
        "Compatible Muzzle Device: AR Muzzle Mount.",
        "Can Attach Bayonets.",
    },
    ["MarzGuns.M16A2"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right.",
        "Compatible Muzzle Device: AR Muzzle Mount.",
        "Can Attach Bayonets.",
    },
    ["MarzGuns.M16A2_M203"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up.",
        "Compatible Muzzle Device: AR Muzzle Mount.",
    },
    ["MarzGuns.M16A3"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right.",
        "Compatible Muzzle Device: AR Muzzle Mount.",
        "Can Attach Bayonets.",
    },
    ["MarzGuns.AR15"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up, Down.",
        "Can Attach Bayonets.",
    },
    ["MarzGuns.FNC"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up.",
    },
    ["MarzGuns.CAR15"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right.",
        "Compatible Muzzle Device: AR Muzzle Mount.",
    },
    ["MarzGuns.XM177"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right.",
    },
    ["MarzGuns.M4A1"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right.",
        "Compatible Muzzle Device: AR Muzzle Mount.",
        "Has Integrated Stock",
    },
    ["MarzGuns.G36C"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right.",
        "Compatible Muzzle Device: AR Muzzle Mount.",
        "Has Integrated Stock",
    },
    ["MarzGuns.G36"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Down, Left, Right.",
        "Compatible Muzzle Device: AR Muzzle Mount.",
        "Has Integrated Stock",
    },
    ["MarzGuns.AK74"] = {
        "Uses 5.45x39mm rounds.",
        "Compatible Mounting Device: AK Mount.",
        "Compatible Muzzle Device: AK Muzzle Mount.",
    },
    ["MarzGuns.AKS74U"] = {
        "Uses 5.45x39mm rounds.",
        "Compatible Mounting Device: AK Mount.",
        "Available Picatinny Slots: Down.",
        "Compatible Muzzle Device: AK Muzzle Mount.",
        "Has Integrated Stock",
    },
    ["MarzGuns.ASVAL"] = {
        "Uses 9x39mm rounds.",
        "Compatible Mounting Device: AK Mount.",
        "Available Picatinny Slots: Down, Left, Right.",
        "Has Integrated Stock",
    },
    ["MarzGuns.FAMAS"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up, Down.",
        "Compatible Muzzle Device: AR Muzzle Mount.",
        "Can Attach Bayonet.",
    },
    ["MarzGuns.AK47"] = {
        "Uses 7.62x39mm rounds.",
        "Compatible Mounting Device: AK Mount.",
        "Compatible Muzzle Device: AK Muzzle Mount.",
    },
    ["MarzGuns.M14"] = {
        "Uses .308/7.62x51mm NATO rounds.",
        "Available Picatinny Slots: Up, Down.",
        "Can Attach Bayonets.",
    },
    ["MarzGuns.M1_GARAND"] = {
        "Uses .30-06 Springfield rounds.",
        "Can Attach Bayonets.",
    },
    ["MarzGuns.FAL"] = {
        "Uses .308/7.62x51mm NATO rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right.",
    },
    ["MarzGuns.G3"] = {
        "Uses .308/7.62x51mm NATO rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right.",
        "Can Attach Bayonet.",
    },
    ["MarzGuns.MOSIN"] = {
        "Uses 7.62x54mmR rounds.",
        "Compatible Mounting Device: Sniper Mount.",
        "Can Attach Bayonet.",
    },
    ["MarzGuns.M24"] = {
        "Uses .308/7.62x51mm NATO rounds.",
        "Available Picatinny Slots: Up.",
        "Has Integrated Bipod"
    },
    ["MarzGuns.M1903"] = {
        "Uses .30-06 Springfield rounds.",
        "Compatible Mounting Device: Sniper Mount.",
        "Can Attach Bayonet.",
    },
    ["MarzGuns.MODEL_70"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Compatible Mounting Device: Sniper Mount.",
    },
    ["MarzGuns.REMINGTON_700"] = {
        "Uses .308/7.62x51mm NATO rounds.",
        "Compatible Mounting Device: Sniper Mount.",
    },
    ["MarzGuns.M79"] = {
        "Uses 40mm rounds."
    },
    ["MarzGuns.W1894"] = {
        "Uses .30-30 Winchester rounds.",
        "Available Picatinny Slots: Up."
    },
    ["MarzGuns.M1895"] = {
        "Uses .45-70 Government rounds.",
        "Available Picatinny Slots: Up."
    },
    ["MarzGuns.W1887"] = {
        "Uses 12-gauge shells.",
        "Available Picatinny Slots: Up."
    },
    ["MarzGuns.W1873"] = {
        "Uses .38Special/.357 Magnum rounds.",
        "Available Picatinny Slots: Up."
    },
    ["MarzGuns.W1873_CARBINE"] = {
        "Uses .38Special/.357 Magnum rounds.",
    },
    ["MarzGuns.M60"] = {
        "Uses .308/7.62x51mm NATO rounds.",
        "Has Integrated Bipod",
    },
    ["MarzGuns.BAR"] = {
        "Uses .30-06 Springfield rounds.",
        "Has Integrated Bipod",
    },
    ["MarzGuns.SVD"] = {
        "Uses 7.62x54mmR rounds.",
        "Compatible Mounting Device: AK Mount.",
        "Available Picatinny Slots: Down.",
    },
    ["MarzGuns.SKS"] = {
        "Uses 7.62x39mm rounds.",
        "Has Integrated Bayonet.",
    },
    ["MarzGuns.PSG1"] = {
        "Uses .308/7.62x51mm NATO rounds.",
        "Available Picatinny Slots: Up, Down.",
    },
    ["MarzGuns.MINI_14"] = {
        "Uses .223/5.56x45mm NATO rounds.",
        "Available Picatinny Slots: Up, Down.",
    },
    ["MarzGuns.MOSSBERG_590"] = {
        "Uses 12-gauge shells.",
        "Available Picatinny Slots: Up.",
        "Can Attach Bayonet.",
    },
    ["MarzGuns.TRENCHGUN"] = {
        "Uses 12-gauge shells.",
        "Can Attach Bayonet.",
    },
    ["MarzGuns.BENELLI_M4"] = {
        "Uses 12-gauge shells.",
        "Available Picatinny Slots: Up.",
        "Can Attach Bayonet.",
    },
    ["MarzGuns.SPAS12"] = {
        "Uses 12-gauge shells."
    },
    ["MarzGuns.STEVENS_555"] = {
        "Uses 12-gauge shells."
    },
    ["MarzGuns.DOUBLEBARREL"] = {
        "Uses 12-gauge shells."
    },
    ["MarzGuns.AA12"] = {
        "Uses 12-gauge shells.",
        "Available Picatinny Slots: Down, Left, Right.",
    },
    ["MarzGuns.REMINGTON_870"] = {
        "Uses 12-gauge shells.",
        "Available Picatinny Slots: Up.",
        "Can Attach Bayonet.",
    },
    ["MarzGuns.TOZ34"] = {
        "Uses 12-gauge shells."
    },
    ["MarzGuns.THOMPSON"] = {
        "Uses .45 rounds.",
    },
    ["MarzGuns.MP5"] = {
        "Uses 9x19mm rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right."
    },
    ["MarzGuns.MP5SD"] = {
        "Uses 9x19mm rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right.",
    },
    ["MarzGuns.MP5A2"] = {
        "Uses 9x19mm rounds.",
        "Available Picatinny Slots: Up, Down, Left, Right.",
    },
    ["MarzGuns.MP5K"] = {
        "Uses 9x19mm rounds.",
        "Available Picatinny Slots: Up.",
    },
    ["MarzGuns.TEC9"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.MAC10"] = {
        "Uses .45 rounds.",
        "Compatible Muzzle Device: .45 Muzzle Mount.",
    },
    ["MarzGuns.M92FS"] = {
        "Uses 9x19mm rounds.",
        "Compatible Mounting Device: Beretta Mount.",
        "Compatible Muzzle Device: Pistol Muzzle Mount.",
    },
    ["MarzGuns.M93R"] = {
        "Uses 9x19mm rounds.",
        "Compatible Mounting Device: Beretta Mount.",
        "Compatible Muzzle Device: Pistol Muzzle Mount.",
    },
    ["MarzGuns.HIPOWER"] = {
        "Uses 9x19mm rounds.",
        "Compatible Mounting Device: Beretta Mount.",
        "Compatible Muzzle Device: Pistol Muzzle Mount.",
    },
    ["MarzGuns.P226"] = {
        "Uses 9x19mm rounds.",
        "Compatible Mounting Device: Beretta Mount.",
        "Compatible Muzzle Device: Pistol Muzzle Mount.",
    },
    ["MarzGuns.M1911"] = {
        "Uses .45 rounds.",
        "Compatible Mounting Device: Colt Mount.",
        "Compatible Muzzle Device: .45 Muzzle Mount.",
    },
    ["MarzGuns.USP"] = {
        "Uses .45 rounds.",
        "Compatible Mounting Device: Colt Mount.",
        "Compatible Muzzle Device: .45 Muzzle Mount.",
    },
    ["MarzGuns.DEAGLE"] = {
        "Uses .50 rounds.",
        "Compatible Mounting Device: Heavy Pistol Rail.",
    },
    ["MarzGuns.SW629"] = {
        "Uses .44 rounds."
    },
    ["MarzGuns.PYTHON"] = {
        "Uses .38Special/.357 Magnum rounds.",
        "Has Speedloader available."
    },
    ["MarzGuns.RHINO"] = {
        "Uses .38Special/.357 Magnum rounds.",
        "Has Speedloader available."
    },
    ["MarzGuns.MP412"] = {
        "Uses .38Special/.357 Magnum rounds.",
    },
    ["MarzGuns.COLT_SINGLE"] = {
        "Uses .45 rounds."
    },
    ["MarzGuns.DETECTIVE_38"] = {
        "Uses .38Special/.357 Magnum rounds.",
        "Has Speedloader available."
    },

    ---- Attachments
    ["MarzGuns.ReflexS2_Sight"] = {
        "Aiming Time reduced by 10%",
        "Critical and Hit Chance increased by 5%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.Kobra_Sight"] = {
        "Aiming Time reduced by 8%",
        "Critical and Hit Chance increased by 10%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.OKP3_Sight"] = {
        "Aiming Time reduced by 5%",
        "Critical and Hit Chance increased by 15%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.JS14_Sight"] = {
        "Critical and Hit Chance increased by 20%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.EXPS3_Sight"] = {
        "Critical and Hit Chance increased by 2%",
        "Sight Range increased by 10%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.EXPS1_Sight"] = {
        "Critical and Hit Chance increased by 2%",
        "Sight Range increased by 12%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.Aimpoint_Sight"] = {
        "Critical and Hit Chance increased by 3%",
        "Sight Range increased by 15%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.LR4X_Scope"] = {
        "Aiming Time increased by 10%",
        "Critical and Hit Chance increased by 6%",
        "Sight Range increased by 20%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.TA28_Scope"] = {
        "Aiming Time increased by 15%",
        "Critical and Hit Chance increased by 10%",
        "Sight Range increased by 25%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.ElcanX2_Scope"] = {
        "Aiming Time increased by 20%",
        "Critical and Hit Chance increased by 12%",
        "Sight Range increased by 25%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.TR06X_Scope"] = {
        "Aiming Time increased by 25%",
        "Critical and Hit Chance increased by 15%",
        "Sight Range increased by 30%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.PSO1_Scope"] = {
        "Aiming Time increased by 30%",
        "Critical and Hit Chance increased by 20%",
        "Sight Range increased by 50%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.LR10X_Scope"] = {
        "Aiming Time increased by 35%",
        "Critical and Hit Chance increased by 30%",
        "Sight Range increased by 70%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.LRX12X_Scope"] = {
        "Aiming Time increased by 50%",
        "Critical and Hit Chance increased by 50%",
        "Sight Range increased by 100%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.PL4_Sight"] = {
        "Critical and Hit Chance increased by 2%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.PS1_Sight"] = {
        "Critical and Hit Chance increased by 3%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.PM2_Sight"] = {
        "Critical and Hit Chance increased by 8%",
        "Sight Range increased by 8%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.PRL1_Scope"] = {
        "Critical and Hit Chance increased by 10%",
        "Sight Range increased by 10%",
        "Needs Screwdriver to install or remove."
    },

    ["MarzGuns.Stub_Foregrip"] = {
        "Aiming Time reduced by 20%",
        "Critical and Hit Chance increased by 15%"
    },
    ["MarzGuns.MKC_Foregrip"] = {
        "Aiming Time reduced by 5%",
        "Critical and Hit Chance increased by 25%"
    },
    ["MarzGuns.MK2_Foregrip"] = {
        "Aiming Time reduced by 25%",
        "Critical and Hit Chance increased by 10%"
    },
    ["MarzGuns.MKI_Suppressor"] = {
        "Requires AR Muzzle Mount",
        "Sound Radius and Volume reduced by 70%",
        "Damage reduced by 10%",
        "Removes Muzzle Flash",
        "Can be mounted on 5.56mm rifles",
        "Needs Wrench to install or remove.",
    },
    ["MarzGuns.NDR_Suppressor"] = {
        "Requires AR Muzzle Mount",
        "Sound Radius and Volume reduced by 70%",
        "Damage reduced by 10%",
        "Removes Muzzle Flash",
        "Can be mounted on 5.56mm rifles",
        "Needs Wrench to install or remove.",
    },
    ["MarzGuns.PBS-1_Suppressor"] = {
        "Requires AK Muzzle Mount",
        "Sound Radius and Volume reduced by 70%",
        "Damage reduced by 10%",
        "Removes Muzzle Flash",
        "Can be mounted on AK-47, AK-74 and AKS-74U",
        "Needs Wrench to install or remove.",
    },
    ["MarzGuns.M&P_Suppressor"] = {
        "Requires Pistol Muzzle Mount",
        "Sound Radius and Volume reduced by 70%",
        "Damage reduced by 10%",
        "Removes Muzzle Flash",
        "Can be mounted on 9x19mm pistols",
        "Needs Wrench to install or remove.",
    },
    ["MarzGuns.Shh9_Suppressor"] = {
        "Requires Pistol Muzzle Mount",
        "Sound Radius and Volume reduced by 70%",
        "Damage reduced by 10%",
        "Removes Muzzle Flash",
        "Can be mounted on 9x19mm pistols",
        "Needs Wrench to install or remove.",
    },
    ["MarzGuns.P45_Suppressor"] = {
        "Requires .45 Muzzle Mount",
        "Sound Radius and Volume reduced by 70%",
        "Damage reduced by 10%",
        "Removes Muzzle Flash",
        "Can be mounted on .45 pistols and SMGs",
        "Needs Wrench to install or remove.",
    },
    ["MarzGuns.PJ-3_Laser"] = {
        "Aiming Time reduced by 10%",
        "Critical and Hit Chance increased by 3%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.PX1_Laser"] = {
        "Aiming Time reduced by 10%",
        "Critical and Hit Chance increased by 3%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.TR-1_Laser"] = {
        "Aiming Time reduced by 10%",
        "Critical and Hit Chance increased by 3%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.LP_Light"] = {
        "Provides Weapon Light",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.TL_Light"] = {
        "Provides Weapon Light",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.AimRight_Laser"] = {
        "Aiming Time reduced by 5%",
        "Critical and Hit Chance increased by 5%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.LRX-7_Laser"] = {
        "Aiming Time reduced by 10%",
        "Critical and Hit Chance increased by 3%",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.BrightPoint-5_Light"] = {
        "Provides Weapon Light",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.SR7_Light"] = {
        "Provides Weapon Light",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.AR_Muzzle_Mount_Device"] = {
        "No Direct Stat Changes",
        "Enables AR Muzzle Attachments",
        "Needs Wrench to install or remove."
    },
    ["MarzGuns.AK_Muzzle_Mount_Device"] = {
        "No Direct Stat Changes",
        "Enables AK Muzzle Attachments",
        "Needs Wrench to install or remove."
    },
    ["MarzGuns.Pistol_Muzzle_Mount_Device"] = {
        "No Direct Stat Changes",
        "Enables Pistol Muzzle Attachments",
        "Needs Wrench to install or remove."
    },
    ["MarzGuns.45_Muzzle_Mount_Device"] = {
        "No Direct Stat Changes",
        "Enables .45 Muzzle Attachments",
        "Needs Wrench to install or remove."
    },
    ["MarzGuns.LR2_Compensator"] = {
        "Sound Radius and Volume reduced by 10%",
        "Removes Muzzle Flash",
        "Needs Wrench to install or remove."
    },
    ["MarzGuns.LX_Flashhider"] = {
        "Sound Radius and Volume reduced by 5%",
        "Removes Muzzle Flash",
        "Needs Wrench to install or remove."
    },
    ["MarzGuns.Trix42_Muzzlebreak"] = {
        "Sound Radius and Volume reduced by 5%",
        "Removes Muzzle Flash",
        "Needs Wrench to install or remove."
    },

    ["MarzGuns.Bipod_Deployed"] = {
        "Aiming Time increased by 10%",
        "Critical and Hit Chance increased by 15%",
        "Needs Screwdriver to install or remove.",
    },
    ["MarzGuns.Bipod_Folded"] = {
        "Bipod is folded. No bonuses to Aiming Time, Critical Chance, or Hit Chance.",
        "Needs Screwdriver to install or remove.",
    },

    --- Bayonets
    ["MarzGuns.K98_BAYONET"] = {
        "Can be attached to compatible rifles",
    },
    ["MarzGuns.M5_BAYONET"] = {
        "Can be attached to compatible rifles",
    },
    ["MarzGuns.M9_BAYONET"] = {
        "Can be attached to compatible rifles",
    },

    ---- Ammunitions
    ["SWMG.556x45_Bullet_ArmorPiercing"] = {
        "Damage to targets decreased by 15%",
        "Piercing targets",
        "Able to hit up to 5 targets",
    },
    ["SWMG.556x45_Bullet_HollowPoint"] = {
        "Damage to targets increased by 20%",
        "Change to degrade weapon condition increased by 15%",
    },
    ["SWMG.223_Bullet"] = {
        "Damage to targets decrease by 30%",
        "Change to degrade weapon condition decreased by 50%",
    },
    ["SWMG.556x45_Bullet_Overpressured"] = {
        "Damage to targets increased by 50%",
        "Change to degrade weapon condition increased by 50%",
        "Piercing targets",
        "Able to hit up to 2 targets",
    },
    ["SWMG.556x45_Bullet_Subsonic"] = {
        "Damage to targets decreased by 60%",
        "Sound Radius and volume reduced by 50%",
        "Sound Volume -50%",
        "Change to degrade weapon condition decreased by 100%",
        "Required rack after shoot",
        "Stacks with suppressors for maximun effectiveness",
    },
    ["SWMG.308_Bullet"] = {
        "Damage to targets decreased by 25%",
        "Change to degrade weapon condition decreased by 50%",
    },
    ["SWMG.12Gauge_Shell_Slug"] = {
        "Damage to targets increased by 100%",
        "Will pierce targets",
        "Able to hit up to 3 targets",
        "One single slug rounds per shell",
    },

    --- Others
    ["MarzGuns.Picatinny_Rail"] = {
        "Allows attachments to be installed on weapons",
        "Options will be presented in the upgrade menu",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.AK_Mount"] = {
        "Allows mounting of scopes in AK family rifles (AK-47, AK-74, AKS-74U, ASVAL, SVD)",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.Sniper_Mount"] = {
        "Allows mounting of scopes in bolt action rifles (Mosin, M1903)",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.Beretta_Mount"] = {
        "Allows mounting of scopes in 9x19mm pistols",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.Colt_Mount"] = {
        "Allows mounting of scopes in .45 pistols",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.Heavy_Pistol_Rail"] = {
        "Allows mounting of scopes in Heavy Pistols and Revolvers",
        "Needs Screwdriver to install or remove."
    },

    ["MarzGuns.Shellholder"] = {
        "Allows the user to fire 40% faster",
        "Needs Screwdriver to install or remove."
    },
    ["MarzGuns.Beretta_Stock_Deployed"] = {
        "Aiming Time reduced by 10%",
        "Hit Chance increased by 10%",
        "Needs Screwdriver to install or remove.",
    },
    ["MarzGuns.Beretta_Stock_Folded"] = {
        "Stock is folded. No bonuses to Aiming Time or Hit Chance.",
        "Needs Screwdriver to install or remove.",
    },

    --- Mags and speedloaders
    ["MarzGuns.38357SpeedLoader6"] = {
        "Uses .38Special/.357 Magnum rounds.",
        "Speedloader needs to be previous fully loaded to reload the revolver.",
    },

    ["MarzGuns.556x45Magazine20_STANAG"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.556x45Magazine25_STANAG"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.556x45Magazine30_STANAG"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.556x45Magazine50_STANAG"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.556x45Magazine60_STANAG"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.556x45Magazine75_STANAG"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.556x45Magazine100_STANAG"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.556x45Magazine150_STANAG"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.556x45Magazine30_G36"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.545x39Magazine30_Bakelite"] = {
        "Uses 5.45x39mm rounds.",
    },
    ["MarzGuns.545x39Magazine45_Bakelite"] = {
        "Uses 5.45x39mm rounds.",
    },
    ["MarzGuns.545x39Magazine100_Drum"] = {
        "Uses 5.45x39mm rounds.",
    },
    ["MarzGuns.9x39Magazine30"] = {
        "Uses 9x39mm rounds.",
    },
    ["MarzGuns.762x39Magazine30"] = {
        "Uses 7.62x39mm rounds.",
    },
    ["MarzGuns.762x39Magazine75"] = {
        "Uses 7.62x39mm rounds.",
    },
    ["MarzGuns.3006Clip8"] = {
        "Uses .30-06 Springfield rounds.",
    },
    ["MarzGuns.762x51Magazine20_M14"] = {
        "Uses .308/7.62x51mm NATO rounds.",
    },
    ["MarzGuns.762x51Magazine20_FAL"] = {
        "Uses .308/7.62x51mm NATO rounds.",
    },
    ["MarzGuns.762x51Magazine20_G3"] = {
        "Uses .308/7.62x51mm NATO rounds.",
    },
    ["MarzGuns.762x54StripperClip5_MOSIN"] = {
        "Uses 7.62x54mmR rounds.",
    },
    ["MarzGuns.762x51Box100_M60"] = {
        "Uses .308/7.62x51mm NATO rounds.",
    },
    ["MarzGuns.3006Magazine20_BAR"] = {
        "Uses .30-06 Springfield rounds.",
    },
    ["MarzGuns.762x54Magazine10_SVD"] = {
        "Uses 7.62x54mmR rounds.",
    },
    ["MarzGuns.762x51Magazine5_PSG1"] = {
        "Uses .308/7.62x51mm NATO rounds.",
    },
    ["MarzGuns.223Magazine10_Mini14"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.223Magazine20_Mini14"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.223Magazine30_Mini14"] = {
        "Uses .223/5.56x45mm NATO rounds.",
    },
    ["MarzGuns.12GMagazine8_AA12"] = {
        "Uses 12-gauge shells.",
    },
    ["MarzGuns.12GMagazine20_AA12"] = {
        "Uses 12-gauge shells.",
    },
    ["MarzGuns.45Magazine20_THOMPSON"] = {
        "Uses .45 rounds.",
    },
    ["MarzGuns.45Magazine30_THOMPSON"] = {
        "Uses .45 rounds.",
    },
    ["MarzGuns.45Magazine100_THOMPSON"] = {
        "Uses .45 rounds.",
    },
    ["MarzGuns.9x19Magazine20_MP5"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine25_MP5"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine30_MP5"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine60_MP5"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine100_MP5"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine20_TEC9"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.45Magazine30_MAC10"] = {
        "Uses .45 rounds.",
    },
    ["MarzGuns.45Magazine40_MAC10"] = {
        "Uses .45 rounds.",
    },
    ["MarzGuns.9x19Magazine15_M92FS"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine30_M92FS"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine50_M92FS"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine18_M93R"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine60_M93R"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine13_HIPOWER"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine10_P226"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine18_VP70M"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.9x19Magazine30_VP70M"] = {
        "Uses 9x19mm rounds.",
    },
    ["MarzGuns.45Magazine7_M1911"] = {
        "Uses .45 rounds.",
    },
    ["MarzGuns.45Magazine12_USP"] = {
        "Uses .45 rounds.",
    },
    ["MarzGuns.45Magazine20_USP"] = {
        "Uses .45 rounds.",
    },
    ["MarzGuns.50Magazine8_DEAGLE"] = {
        "Uses .50 rounds.",
    },
    ["MarzGuns.50Magazine12_DEAGLE"] = {
        "Uses .50 rounds.",
    },
}

return MarzGuns_TooltipsTable
