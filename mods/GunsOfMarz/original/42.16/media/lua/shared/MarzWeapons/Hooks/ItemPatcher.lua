local Ammo = require("WeaponSystems/Utils/Ammo")
local GSU = require("GunworksUtils/itemAdjustments")

--- well rather than forcing an ammotype on the weapons, I will make them use GoM profiles
local AmmoToRegistries = {
    [AmmoType.BULLETS_3030] = ".30-30 Winchester",
    [AmmoType.BULLETS_357] = ".38 .357",
    [AmmoType.BULLETS_38] = ".38 .357",
    [AmmoType.BULLETS_44] = ".44 Magnum",
    [AmmoType.BULLETS_45] = ".45 ACP",
    [AmmoType.SHOTGUN_SHELLS] = "12Gauge",
    [AmmoType.BULLETS_556] = "5.56x45mm",
    [AmmoType.BULLETS_308] = "7.62x51mm",
    [AmmoType.BULLETS_9MM] = "9x19mm",
}

local WeaponMap = {
    "Base.AssaultRifle", "Base.AssaultRifle2", "Base.DoubleBarrelShotgun",
    "Base.DoubleBarrelShotgunSawnoff", "Base.HuntingRifle",
    "Base.Pistol", "Base.Pistol2", "Base.Pistol3",
    "Base.Revolver", "Base.Revolver_Long", "Base.Revolver_Short",
    "Base.Shotgun", "Base.ShotgunSawnoff", "Base.VarmintRifle",
    "Base.JS14_Rifle", "Base.JS3T_Shotgun", "Base.L92_Carbine",
    "Base.L94_Rifle", "Base.MSR7T_Rifle", "Base.TrapperCarbine",
}

local MagMap = {
    "Base.44Clip", "Base.45Clip", "Base.556Clip",
    "Base.9mmClip", "Base.M14Clip", "Base.JS14_Clip",
}

local AmmoMap = {
    "Base.308Bullets", "Base.556Bullets", "Base.3030Bullets",
    "Base.Bullets357", "Base.Bullets38", "Base.Bullets44",
    "Base.Bullets45", "Base.Bullets9mm", "Base.ShotgunShells",
    "Base.308Box", "Base.308Carton",
    "Base.556Box", "Base.556Carton",
    "Base.3030Box", "Base.3030Carton",
    "Base.Bullets357Box", "Base.Bullets357Carton",
    "Base.Bullets38Box", "Base.Bullets38Carton",
    "Base.Bullets44Box", "Base.Bullets44Carton",
    "Base.Bullets45Box", "Base.Bullets45Carton",
    "Base.Bullets9mmBox", "Base.Bullets9mmCarton",
    "Base.ShotgunShellsBox", "Base.ShotgunShellsCarton",
}

local AttachmentsMap = {
    "Base.TritiumSights", "Base.RedDot", "Base.x2Scope",
    "Base.x4Scope", "Base.x8Scope", "Base.AmmoStraps",
    "Base.RecoilPad", "Base.Laser", "Base.GunLight",
    "Base.ChokeTubeFull", "Base.ChokeTubeImproved",
}

local function patchAllItemsAmmo()
    local SM = getScriptManager()
    local allItems = SM:getAllItems()
    for i = 0, allItems:size() - 1 do
        local itemScript = allItems:get(i)
        local currentAmmoType = itemScript:getAmmoType()

        if currentAmmoType then
            local AmmoRegistry = AmmoToRegistries[currentAmmoType]
            if AmmoRegistry then
                Ammo.RegisterItemWithFamily(AmmoRegistry, itemScript:getFullName())
            end
        end
    end
end

local function init()
    local sandboxVars = (SandboxVars and SandboxVars.MarzGuns) or {}

    if sandboxVars.VanillaWeaponReplacement then
        for i = 1, #WeaponMap do
            GSU.Adjust(WeaponMap[i], "OnCreate", "MarzGuns_OnCreate.VanillaReplace")
        end
        for i = 1, #MagMap do
            GSU.Adjust(MagMap[i], "OnCreate", "MarzGuns_OnCreate.VanillaReplace")
        end
    end

    if sandboxVars.VanillaAttachmentReplacement then
        for i = 1, #AttachmentsMap do
            GSU.Adjust(AttachmentsMap[i], "OnCreate", "MarzGuns_OnCreate.VanillaReplace")
        end
    end

    if sandboxVars.VanillaAmmoReplacement then
        for i = 1, #AmmoMap do
            GSU.Adjust(AmmoMap[i], "OnCreate", "MarzGuns_OnCreate.VanillaReplace")
        end
    end

    patchAllItemsAmmo()
end

Events.OnInitGlobalModData.Add(init)
