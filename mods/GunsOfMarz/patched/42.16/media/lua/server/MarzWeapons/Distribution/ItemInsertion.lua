require("Items/ProceduralDistributions")
require("Vehicles/VehicleDistributions")
require("Items/Distribution_BagsAndContainers")
require("Definitions/AttachedWeaponDefinitions")

local pd = ProceduralDistributions.list
local vd = VehicleDistributions
local bd = BagsAndContainers

local Distribution = require("Distribution/Functions.lua")
local tables = { ProceduralDistributions.list, VehicleDistributions, SuburbsDistributions, BagsAndContainers }

local lootMultiplier = 1

local function addItem(distName, itemFullType, weight, distro)
    local dist = distro[distName]
    if not dist or not dist.items then
        return
    end
    dist.items[#dist.items + 1] = itemFullType
    dist.items[#dist.items + 1] = weight * lootMultiplier
end

local function addToContainer(containerName, entries)
    local container = ProceduralDistributions.list[containerName]
    if not container or not container.items then
        return
    end
    for fullType, weight in pairs(entries) do
        container.items[#container.items + 1] = fullType
        container.items[#container.items + 1] = weight
    end
end

local function addToContainers(containerNames, entries)
    for i = 1, #containerNames do
        addToContainer(containerNames[i], entries)
    end
end

local function addToBag(bagName, entries)
    local bag = BagsAndContainers[bagName]
    if not bag or not bag.items then
        return
    end
    for fullType, weight in pairs(entries) do
        bag.items[#bag.items + 1] = fullType
        bag.items[#bag.items + 1] = weight
    end
end

local function addToBags(bagNames, entries)
    for i = 1, #bagNames do
        addToBag(bagNames[i], entries)
    end
end

local function addToVehicle(vehicleName, entries)
    local vehicle = VehicleDistributions[vehicleName]
    if not vehicle or not vehicle.items then
        return
    end
    for fullType, weight in pairs(entries) do
        vehicle.items[#vehicle.items + 1] = fullType
        vehicle.items[#vehicle.items + 1] = weight
    end
end

local function addToVehicles(vehicleNames, entries)
    for i = 1, #vehicleNames do
        addToVehicle(vehicleNames[i], entries)
    end
end

local function injectNewWeapons()
    local sandbox = (SandboxVars and SandboxVars.MarzGuns) or {}

    lootMultiplier = tonumber(sandbox.LootMultiplier) or 1
    if lootMultiplier < 0 then lootMultiplier = 0 end

    local spawnHighCapMags = sandbox.SpawnHighCapMags
    if spawnHighCapMags == nil then spawnHighCapMags = true end

    local spawnExplosives = sandbox.SpawnExplosives == true

    local function addMag(distName, itemFullType, weight, distro)
        if not spawnHighCapMags then return end
        addItem(distName, itemFullType, weight, distro)
    end

    addItem("GunStoreCases", "MarzGuns.World_Import_Rifle_Spawner", 10, pd)
    addItem("GunStoreGuns", "MarzGuns.World_Import_Rifle_Spawner", 10, pd)

    addItem("ArmyStorageGuns", "MarzGuns.World_Army_Heavy_Spawner", 5, pd)
    addItem("ArmyStorageGuns", "MarzGuns.World_Army_Rifle_Spawner", 15, pd)

    addItem("DrugLabGuns", "MarzGuns.World_Russian_Rifle_Spawner", 25, pd)
    addItem("DrugShackWeapons", "MarzGuns.World_Russian_Rifle_Spawner", 25, pd)
    addItem("DrugLabMoney", "MarzGuns.World_Russian_Rifle_Spawner", 10, pd)
    addItem("PoliceEvidence", "MarzGuns.World_Russian_Rifle_Spawner", 10, pd)
    addItem("SafehouseBin_Late", "MarzGuns.World_Russian_Rifle_Spawner", 10, pd)
    addItem("SurvivalistTruckBed", "MarzGuns.World_Russian_Rifle_Spawner", 10, vd)
    addItem("SurvivalistSeatRear", "MarzGuns.World_Russian_Rifle_Spawner", 10, vd)
    addItem("SurvivalistSeatFront", "MarzGuns.World_Russian_Rifle_Spawner", 10, vd)

    addItem("GunStoreCases", "MarzGuns.World_Short_SMG_Spawner", 10, pd)
    addItem("GunStorePistols", "MarzGuns.World_Short_SMG_Spawner", 10, pd)
    addItem("GunStoreGuns", "MarzGuns.World_Short_SMG_Spawner", 10, pd)
    addItem("SurvivalistGloveBox", "MarzGuns.World_Short_SMG_Spawner", 15, vd)

    addItem("GunStoreShotguns", "MarzGuns.Zombie_Civilian_Shotgun_Spawner", 10, pd)
    addItem("PoliceStorageGuns", "MarzGuns.Zombie_Police_Shotgun_Spawner", 10, pd)
    addItem("PoliceEvidence", "MarzGuns.Zombie_Police_Shotgun_Spawner", 5, pd)

    addItem("GunStoreRifles", "MarzGuns.Zombie_Civilian_SemiRifle_Spawner", 10, pd)
    addItem("HuntingLockers", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 15, pd)
    addItem("GarageFirearms", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 10, pd)
    addItem("HunterGloveBox", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 10, vd)
    addItem("HunterTruckBed", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 15, vd)

    addItem("SurvivalistGloveBox", "MarzGuns.Zombie_Survivalist_Rifle_Spawner", 8, vd)
    addItem("SurvivalistTruckBed", "MarzGuns.Zombie_Survivalist_Rifle_Spawner", 8, vd)

    addItem("FirearmWeapons_Late", "MarzGuns.World_Anachronistic_Spawner", 5, pd)
    addItem("SafehouseBin_Late", "MarzGuns.World_Anachronistic_Spawner", 5, pd)

    addItem("GunStoreCases", "MarzGuns.World_Oldies_Spawner", 8, pd)
    addItem("GunStoreRifles", "MarzGuns.World_Oldies_Spawner", 8, pd)
    addItem("SafehouseBin", "MarzGuns.World_Oldies_Spawner", 8, pd)
    addItem("SafehouseBin_Mid", "MarzGuns.World_Oldies_Spawner", 8, pd)

    addItem("GunStoreGuns", "MarzGuns.World_Optics_Reflex_Spawner", 10, pd)
    addItem("GunStorePistols", "MarzGuns.World_Optics_Reflex_Spawner", 10, pd)
    addItem("GarageFirearms", "MarzGuns.World_Optics_Reflex_Spawner", 6, pd)
    addItem("SWATStorageGuns", "MarzGuns.World_Optics_Reflex_Spawner", 10, pd)

    addItem("GunStoreGuns", "MarzGuns.World_Optics_Magnified_Spawner", 8, pd)
    addItem("GunStoreRifles", "MarzGuns.World_Optics_Magnified_Spawner", 10, pd)
    addItem("GarageFirearms", "MarzGuns.World_Optics_Magnified_Spawner", 6, pd)
    addItem("HuntingLockers", "MarzGuns.World_Optics_Magnified_Spawner", 8, pd)
    addItem("ArmyStorageGuns", "MarzGuns.World_Optics_Magnified_Spawner", 3, pd)
    addItem("SWATStorageGuns", "MarzGuns.World_Optics_Magnified_Spawner", 6, pd)

    addItem("GunStorePistols", "MarzGuns.World_Optics_Pistol_Spawner", 10, pd)
    addItem("SWATStorageGuns", "MarzGuns.World_Optics_Pistol_Spawner", 8, pd)
    addItem("PoliceStorageGuns", "MarzGuns.World_Optics_Pistol_Spawner", 6, pd)

    addItem("SWATStorageGuns", "MarzGuns.World_Tactical_Light_Laser_Spawner", 10, pd)
    addItem("PoliceStorageGuns", "MarzGuns.World_Tactical_Light_Laser_Spawner", 4, pd)
    addItem("BanditGloveBox", "MarzGuns.World_Tactical_Light_Laser_Spawner", 4, vd)

    addItem("GunStoreGuns", "MarzGuns.World_Muzzle_Device_Spawner", 8, pd)
    addItem("GunStoreRifles", "MarzGuns.World_Muzzle_Device_Spawner", 6, pd)
    addItem("GarageFirearms", "MarzGuns.World_Muzzle_Device_Spawner", 6, pd)
    addItem("SWATStorageGuns", "MarzGuns.World_Muzzle_Device_Spawner", 6, pd)

    addItem("GunStoreGuns", "MarzGuns.World_Foregrip_Rail_Spawner", 8, pd)
    addItem("GunStoreRifles", "MarzGuns.World_Foregrip_Rail_Spawner", 8, pd)
    addItem("GunStoreShotguns", "MarzGuns.World_Foregrip_Rail_Spawner", 6, pd)
    addItem("GarageFirearms", "MarzGuns.World_Foregrip_Rail_Spawner", 6, pd)
    addItem("HuntingLockers", "MarzGuns.World_Foregrip_Rail_Spawner", 6, pd)
    addItem("SWATStorageGuns", "MarzGuns.World_Foregrip_Rail_Spawner", 8, pd)

    addItem("SWATStorageGuns", "MarzGuns.World_Suppressor_Spawner", 4, pd)
    addItem("PoliceEvidence", "MarzGuns.World_Suppressor_Spawner", 4, pd)
    addItem("DrugLabGuns", "MarzGuns.World_Suppressor_Spawner", 6, pd)
    addItem("DrugShackWeapons", "MarzGuns.World_Suppressor_Spawner", 6, pd)

    addItem("GunStoreCases", "MarzGuns.World_Bayonet_Spawner", 6, pd)
    addItem("ArmyStorageGuns", "MarzGuns.World_Bayonet_Spawner", 6, pd)
    addItem("GarageFirearms", "MarzGuns.World_Bayonet_Spawner", 4, pd)
    addItem("SafehouseBin", "MarzGuns.World_Bayonet_Spawner", 4, pd)

    addItem("DrugLabGuns", "MarzGuns.World_Russian_Attachment_Spawner", 15, pd)
    addItem("DrugShackWeapons", "MarzGuns.World_Russian_Attachment_Spawner", 15, pd)
    addItem("DrugLabMoney", "MarzGuns.World_Russian_Attachment_Spawner", 6, pd)
    addItem("PoliceEvidence", "MarzGuns.World_Russian_Attachment_Spawner", 6, pd)
    addItem("SafehouseBin_Late", "MarzGuns.World_Russian_Attachment_Spawner", 6, pd)
    addItem("SurvivalistTruckBed", "MarzGuns.World_Russian_Attachment_Spawner", 6, vd)
    addItem("SurvivalistSeatRear", "MarzGuns.World_Russian_Attachment_Spawner", 6, vd)
    addItem("SurvivalistSeatFront", "MarzGuns.World_Russian_Attachment_Spawner", 6, vd)

    addMag("GunStoreGuns", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, pd)
    addMag("ArmyStorageGuns", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, pd)
    addMag("SWATStorageGuns", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, pd)

    addMag("DrugLabGuns", "MarzGuns.World_HighCap_Russian_Magazine_Spawner", 3, pd)
    addMag("DrugShackWeapons", "MarzGuns.World_HighCap_Russian_Magazine_Spawner", 3, pd)
    addMag("SurvivalistGloveBox", "MarzGuns.World_HighCap_Russian_Magazine_Spawner", 2, vd)
    addMag("SurvivalistTruckBed", "MarzGuns.World_HighCap_Russian_Magazine_Spawner", 2, vd)

    addMag("SWATStorageGuns", "MarzGuns.World_HighCap_Tactical_Magazine_Spawner", 2, pd)
    addMag("PoliceStorageGuns", "MarzGuns.World_HighCap_Tactical_Magazine_Spawner", 2, pd)
    addMag("GunStoreCases", "MarzGuns.World_HighCap_Tactical_Magazine_Spawner", 2, pd)

    addMag("GunStoreCases", "MarzGuns.World_HighCap_Oldies_Magazine_Spawner", 2, pd)
    addMag("SafehouseBin", "MarzGuns.World_HighCap_Oldies_Magazine_Spawner", 2, pd)

    addItem("Bag_Police", "MarzGuns.Zombie_Police_Handgun_Spawner", 6, bd)
    addItem("Bag_Police", "MarzGuns.Zombie_Police_Revolver_Spawner", 4, bd)
    addItem("Bag_Police", "MarzGuns.Zombie_Police_Shotgun_Spawner", 6, bd)
    addItem("Bag_Police", "MarzGuns.Zombie_Police_SMG_Spawner", 4, bd)

    addItem("BanditBag", "MarzGuns.Zombie_Crime_Rifle_Spawner", 2, bd)
    addItem("BanditBag", "MarzGuns.World_Short_SMG_Spawner", 2, bd)

    addItem("SurvivorBag", "MarzGuns.Zombie_Civilian_Shotgun_Spawner", 6, bd)
    addItem("SurvivorBag", "MarzGuns.Zombie_Civilian_Rifle_Spawner", 6, bd)
    addItem("SurvivorBag", "MarzGuns.Zombie_Survivalist_Rifle_Spawner", 4, bd)
    addItem("SurvivorBag", "MarzGuns.World_HighCap_Russian_Magazine_Spawner", 1, bd)

    addItem("HandbagsAndPurses", "MarzGuns.Zombie_Civilian_Revolver_Spawner", 0.1, bd)

    addItem("PistolCase1", "MarzGuns.Zombie_Civilian_Handgun_Spawner", 30, bd)
    addItem("PistolCase2", "MarzGuns.Zombie_Army_Handgun_Spawner", 25, bd)
    addItem("PistolCase3", "MarzGuns.DEAGLE", 30, bd)
    addItem("PistolCase3", "MarzGuns.50Magazine8_DEAGLE", 15, bd)
    addItem("PistolCase3", "MarzGuns.50Magazine12_DEAGLE", 8, bd)
    addItem("PistolCase3", "MarzGuns.50_Box", 40, bd)

    addItem("RevolverCase1", "MarzGuns.Zombie_Civilian_Revolver_Spawner", 25, bd)
    addItem("RevolverCase2", "MarzGuns.Zombie_Cowboy_Revolver_Spawner", 25, bd)
    addItem("RevolverCase3", "MarzGuns.Zombie_Police_Revolver_Spawner", 25, bd)

    addItem("RifleCase1", "MarzGuns.Zombie_Civilian_SemiRifle_Spawner", 20, bd)
    addItem("RifleCase2", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 20, bd)
    addItem("RifleCase3", "MarzGuns.World_Army_Rifle_Spawner", 15, bd)
    addItem("RifleCase4", "MarzGuns.World_Import_Rifle_Spawner", 15, bd)
    addItem("RifleCase4", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, bd)

    addItem("ShotgunCase1", "MarzGuns.Zombie_Police_Shotgun_Spawner", 20, bd)
    addItem("ShotgunCase2", "MarzGuns.Zombie_Civilian_Shotgun_Spawner", 20, bd)

    addItem("PrisonArmoryShotguns", "MarzGuns.Zombie_Police_Shotgun_Spawner", 12, pd)
    addItem("PrisonArmoryShotguns", "MarzGuns.Zombie_SWAT_Shotgun_Spawner", 3, pd)
    addItem("PrisonStorageGuns", "MarzGuns.Zombie_Police_Shotgun_Spawner", 8, pd)
    addItem("PrisonStorageGuns", "MarzGuns.Zombie_Police_Revolver_Spawner", 8, pd)
    addItem("PrisonStorageGuns", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 5, pd)
    addItem("PrisonRiotStorage", "MarzGuns.Zombie_Police_SMG_Spawner", 3, pd)
    addItem("PrisonGuardLockers", "MarzGuns.Zombie_Police_Handgun_Spawner", 6, pd)
    addItem("PrisonGuardLockers", "MarzGuns.Zombie_Police_Revolver_Spawner", 4, pd)

    addItem("RangerStorageGuns", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 12, pd)
    addItem("RangerStorageGuns", "MarzGuns.Zombie_Civilian_SemiRifle_Spawner", 8, pd)
    addItem("RangerStorageGuns", "MarzGuns.Zombie_Cowboy_Revolver_Spawner", 6, pd)
    addItem("RangerStorageGuns", "MarzGuns.Zombie_Civilian_Revolver_Spawner", 6, pd)
    addItem("RangerStorageGuns", "MarzGuns.World_Optics_Magnified_Spawner", 5, pd)

    addItem("GunStoreAccessories", "MarzGuns.World_Optics_Reflex_Spawner", 10, pd)
    addItem("GunStoreAccessories", "MarzGuns.World_Optics_Magnified_Spawner", 8, pd)
    addItem("GunStoreAccessories", "MarzGuns.World_Optics_Pistol_Spawner", 8, pd)
    addItem("GunStoreAccessories", "MarzGuns.World_Muzzle_Device_Spawner", 8, pd)
    addItem("GunStoreAccessories", "MarzGuns.World_Foregrip_Rail_Spawner", 8, pd)
    addItem("GunStoreAccessories", "MarzGuns.World_Tactical_Light_Laser_Spawner", 6, pd)
    addItem("GunStoreAccessories", "MarzGuns.World_Bayonet_Spawner", 4, pd)

    addItem("PawnShopGuns", "MarzGuns.World_Oldies_Spawner", 8, pd)
    addItem("PawnShopGuns", "MarzGuns.Zombie_Civilian_Revolver_Spawner", 8, pd)
    addItem("PawnShopGuns", "MarzGuns.Zombie_Civilian_Handgun_Spawner", 6, pd)
    addItem("PawnShopGuns", "MarzGuns.Zombie_Cowboy_Rifles_Spawner", 5, pd)
    addItem("PawnShopGunsSpecial", "MarzGuns.World_Oldies_Spawner", 10, pd)
    addItem("PawnShopGunsSpecial", "MarzGuns.Zombie_Cowboy_Revolver_Spawner", 8, pd)
    addItem("PawnShopGunsSpecial", "MarzGuns.Zombie_Crime_Rifle_Spawner", 4, pd)
    addItem("PawnShopGunsSpecial", "MarzGuns.World_Short_SMG_Spawner", 4, pd)

    addItem("FirearmWeapons", "MarzGuns.Zombie_Civilian_Handgun_Spawner", 6, pd)
    addItem("FirearmWeapons", "MarzGuns.Zombie_Civilian_Shotgun_Spawner", 6, pd)
    addItem("FirearmWeapons", "MarzGuns.Zombie_Civilian_SemiRifle_Spawner", 5, pd)
    addItem("FirearmWeapons_Mid", "MarzGuns.Zombie_Civilian_Rifle_Spawner", 8, pd)
    addItem("FirearmWeapons_Mid", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 6, pd)
    addItem("FirearmWeapons_Mid", "MarzGuns.World_Oldies_Spawner", 5, pd)
    addItem("FirearmWeapons_Mid", "MarzGuns.World_Short_SMG_Spawner", 4, pd)
    addItem("FirearmWeapons_Late", "MarzGuns.World_Import_Rifle_Spawner", 7, pd)
    addItem("FirearmWeapons_Late", "MarzGuns.World_Army_Rifle_Spawner", 6, pd)
    addItem("FirearmWeapons_Late", "MarzGuns.World_Russian_Rifle_Spawner", 6, pd)

    addItem("PlankStashGun", "MarzGuns.Zombie_Civilian_Handgun_Spawner", 10, pd)
    addItem("PlankStashGun", "MarzGuns.Zombie_Civilian_Revolver_Spawner", 8, pd)
    addItem("PlankStashGun", "MarzGuns.Zombie_Crime_Rifle_Spawner", 2, pd)

    addItem("BarCounterWeapon", "MarzGuns.Zombie_Civilian_Shotgun_Spawner", 4, pd)
    addItem("BarCounterWeapon", "MarzGuns.Zombie_Civilian_Revolver_Spawner", 4, pd)

    -- Rare "someone brought it to school" find - this is fucked up lmao
    addItem("SchoolLockersBad", "MarzGuns.Zombie_Civilian_Handgun_Spawner", 0.01, pd)
    addItem("SchoolLockersBad", "MarzGuns.Zombie_Civilian_Revolver_Spawner", 0.01, pd)

    addItem("CampingStoreGear", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 3, pd)
    addItem("CampingStoreGear", "MarzGuns.World_Foregrip_Rail_Spawner", 4, pd)

    addItem("LockerArmyBedroom", "MarzGuns.Zombie_Army_Handgun_Spawner", 4, pd)
    addItem("ArmyBunkerLockers", "MarzGuns.Zombie_Army_Handgun_Spawner", 4, pd)
    addItem("ArmyBunkerStorage", "MarzGuns.World_Army_Rifle_Spawner", 4, pd)

    addItem("ArmyStorageGuns", "MarzGuns.World_Tactical_Light_Laser_Spawner", 4, pd)
    addItem("ArmyStorageGuns", "MarzGuns.World_Muzzle_Device_Spawner", 4, pd)
    addItem("ArmyStorageGuns", "MarzGuns.World_Foregrip_Rail_Spawner", 4, pd)
    addItem("PoliceStorageGuns", "MarzGuns.World_Foregrip_Rail_Spawner", 4, pd)
    addItem("HuntingLockers", "MarzGuns.World_Tactical_Light_Laser_Spawner", 4, pd)

    addItem("ArmyStorageAmmunition", "MarzGuns.762x51Box100_M60", 3, pd)
    addItem("ArmySurplusAmmoBoxes", "MarzGuns.762x51Box100_M60", 2, pd)

    addMag("GunStoreMagsAmmo", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 3, pd)
    addMag("GunStoreMagsAmmo", "MarzGuns.World_HighCap_Tactical_Magazine_Spawner", 3, pd)
    addMag("GunStoreMagsAmmo", "MarzGuns.World_HighCap_Oldies_Magazine_Spawner", 2, pd)
    addMag("GunStoreAmmunition", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, pd)
    addMag("GunStoreAmmunition", "MarzGuns.World_HighCap_Tactical_Magazine_Spawner", 2, pd)
    addMag("ArmyStorageAmmunition", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 3, pd)
    addMag("ArmySurplusAmmoBoxes", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, pd)
    addMag("SWATStorageAmmunition", "MarzGuns.World_HighCap_Tactical_Magazine_Spawner", 3, pd)
    addMag("SWATStorageAmmunition", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, pd)
    addMag("PoliceStorageAmmunition", "MarzGuns.World_HighCap_Tactical_Magazine_Spawner", 2, pd)
    addMag("DrugLabMoney", "MarzGuns.World_HighCap_Russian_Magazine_Spawner", 2, pd)

    addItem("PoliceGloveBox", "MarzGuns.Zombie_Police_Handgun_Spawner", 12, vd)
    addItem("PoliceGloveBox", "MarzGuns.Zombie_Police_Revolver_Spawner", 6, vd)
    addItem("PoliceSeatFront", "MarzGuns.Zombie_Police_Handgun_Spawner", 8, vd)
    addItem("PoliceTruckBed", "MarzGuns.Zombie_Police_Shotgun_Spawner", 10, vd)
    addItem("PoliceSeatRear", "MarzGuns.Zombie_Police_Shotgun_Spawner", 6, vd)
    addItem("PoliceSWATGloveBox", "MarzGuns.Zombie_SWAT_Handgun_Spawner", 12, vd)
    addItem("PoliceSWATSeatFront", "MarzGuns.Zombie_SWAT_Handgun_Spawner", 8, vd)
    addItem("PoliceSWATTruckBed", "MarzGuns.Zombie_Police_SMG_Spawner", 10, vd)
    addItem("PoliceSWATTruckBed", "MarzGuns.Zombie_SWAT_Shotgun_Spawner", 6, vd)
    addItem("PoliceSWATSeatRear", "MarzGuns.Zombie_Police_SMG_Spawner", 6, vd)
    addItem("PoliceSheriffSeatFront", "MarzGuns.Zombie_Cowboy_Revolver_Spawner", 8, vd)
    addItem("PoliceSheriffSeatFront", "MarzGuns.Zombie_Police_Handgun_Spawner", 6, vd)
    addItem("RangerGloveBox", "MarzGuns.Zombie_Civilian_Revolver_Spawner", 10, vd)
    addItem("RangerGloveBox", "MarzGuns.Zombie_Cowboy_Revolver_Spawner", 6, vd)
    addItem("RangerSeatFront", "MarzGuns.Zombie_Civilian_Revolver_Spawner", 6, vd)
    addItem("RangerTruckBed", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 10, vd)
    addItem("RangerSeatRear", "MarzGuns.Zombie_Hunter_SemiRifles_Spawner", 6, vd)
    addItem("ArmyGloveBox", "MarzGuns.Zombie_Army_Handgun_Spawner", 10, vd)
    addItem("ArmyLightSeatFront", "MarzGuns.Zombie_Army_Handgun_Spawner", 8, vd)
    addItem("ArmyLightTruckBed", "MarzGuns.World_Army_Rifle_Spawner", 10, vd)
    addItem("ArmyHeavyTruckBed", "MarzGuns.World_Army_Rifle_Spawner", 10, vd)
    addItem("ArmyHeavyTruckBed", "MarzGuns.World_Army_Heavy_Spawner", 3, vd)
    addMag("ArmyLightTruckBed", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, vd)
    addMag("ArmyHeavyTruckBed", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, vd)

    addItem("BanditBag_Early", "MarzGuns.Zombie_Civilian_Handgun_Spawner", 3, bd)
    addItem("BanditBag_Early", "MarzGuns.World_Short_SMG_Spawner", 2, bd)
    addItem("BanditBag_Mid", "MarzGuns.Zombie_Crime_Rifle_Spawner", 3, bd)
    addItem("BanditBag_Mid", "MarzGuns.World_Short_SMG_Spawner", 3, bd)
    addItem("BanditBag_Late", "MarzGuns.Zombie_Crime_Rifle_Spawner", 4, bd)
    addItem("BanditBag_Late", "MarzGuns.World_Army_Rifle_Spawner", 2, bd)
    addMag("BanditBag_Late", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, bd)
    addItem("SurvivorBag_Mid", "MarzGuns.Zombie_Civilian_Shotgun_Spawner", 5, bd)
    addItem("SurvivorBag_Mid", "MarzGuns.Zombie_Civilian_Rifle_Spawner", 5, bd)
    addItem("SurvivorBag_Mid", "MarzGuns.Zombie_Survivalist_Rifle_Spawner", 4, bd)
    addItem("SurvivorBag_Late", "MarzGuns.Zombie_Survivalist_Rifle_Spawner", 5, bd)
    addItem("SurvivorBag_Late", "MarzGuns.Zombie_Civilian_Rifle_Spawner", 4, bd)
    addMag("SurvivorBag_Late", "MarzGuns.World_HighCap_Russian_Magazine_Spawner", 2, bd)
    addItem("ALICEpack_Army", "MarzGuns.World_Army_Rifle_Spawner", 5, bd)
    addItem("ALICEpack_Army", "MarzGuns.Zombie_Army_Handgun_Spawner", 4, bd)
    addMag("ALICEpack_Army", "MarzGuns.World_HighCap_AR_Magazine_Spawner", 2, bd)

    -- Weapon-maintenance kits alongside tools & gun-store upkeep
    addItem("GunStoreAccessories", "MarzGuns.RepairPack", 4, pd)
    addItem("GunStoreCounter", "MarzGuns.RepairPack", 3, pd)
    addItem("StoreShelfMechanics", "MarzGuns.RepairPack", 2, pd)
    addItem("ToolStoreMisc", "MarzGuns.RepairPack", 2, pd)
    addItem("ToolStoreMetalwork", "MarzGuns.RepairPack", 1, pd)
    addItem("JanitorChemicals", "MarzGuns.RepairPack", 2, pd)
    addItem("GarageTools", "MarzGuns.RepairPack", 1, pd)
    addItem("CrateTools", "MarzGuns.RepairPack", 1, pd)
    addItem("CrateMechanics", "MarzGuns.RepairPack", 1, pd)
    addItem("LockerArmyBedroom", "MarzGuns.RepairPack", 2, pd)
    addItem("ArmyBunkerStorage", "MarzGuns.RepairPack", 2, pd)

    if spawnExplosives then
        addItem("ArmyStorageGuns", "MarzGuns.World_Ordnance_Spawner", 3, pd)
        addItem("ArmyBunkerStorage", "MarzGuns.World_Ordnance_Spawner", 2, pd)
        addItem("LockerArmyBedroom", "MarzGuns.World_Ordnance_Spawner", 1, pd)
        addItem("PoliceEvidence", "MarzGuns.World_Ordnance_Spawner", 1, pd)
        addItem("ArmyHeavyTruckBed", "MarzGuns.World_Ordnance_Spawner", 2, vd)
    end
end

Events.OnPreDistributionMerge.Add(injectNewWeapons)

local function applyDistributionPass()
    Distribution.Insert("Base.556Box", 1, tables, "MarzGuns.223_Box")
    Distribution.Insert("Base.556Carton", 1, tables, "MarzGuns.223_Carton")
    Distribution.Insert("Base.308Box", 1, tables, "MarzGuns.308_Box")
    Distribution.Insert("Base.308Carton", 1, tables, "MarzGuns.308_Carton")
    Distribution.Insert("Base.Bullets44Box", 1, tables, "MarzGuns.50_Box")
    Distribution.Insert("Base.Bullets44Carton", 1, tables, "MarzGuns.50_Carton")
    Distribution.Insert("Base.3030Box", 1, tables, "MarzGuns.4570_Box")
    Distribution.Insert("Base.3030Carton", 1, tables, "MarzGuns.4570_Carton")
    Distribution.Insert("Base.308Box", 1, tables, "MarzGuns.3006_Box")
    Distribution.Insert("Base.308Carton", 1, tables, "MarzGuns.3006_Carton")

    Distribution.Insert("Base.Whetstone", 0.25, tables, "MarzGuns.RepairPack")
    Distribution.Insert("Base.308Box", 0.5, tables, "MarzGuns.RepairPack")
    Distribution.Insert("Base.556Box", 0.5, tables, "MarzGuns.RepairPack")
end

Events.OnPostDistributionMerge.Add(applyDistributionPass)
