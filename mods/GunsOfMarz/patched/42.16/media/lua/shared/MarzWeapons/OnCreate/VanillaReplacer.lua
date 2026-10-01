MarzGuns_OnCreate = MarzGuns_OnCreate or {}
local r = newrandom()

local ItemSpawnCore = require("SpawnerSystems/ItemSpawnCore")
local VanillaReplacerTable = require("MarzWeapons/OnCreate/VanillaReplacerTable")

local pendingQueue = ItemSpawnCore.newDeferredQueue()

local function rollOptionItems(bonusItems, option)
    local list = option and option.items
    local maxCount = option and option.amountChance
    if not list or #list == 0 or not maxCount or maxCount <= 0 then return end

    local count = r:random(0, maxCount)
    for _ = 1, count do
        local item = instanceItem(ItemSpawnCore.pickRandomItem(list))
        if item then bonusItems[#bonusItems + 1] = item end
    end
end

local function getVanillaReplacementEntry(fullType)
    local vars = (SandboxVars and SandboxVars.MarzGuns) or {}

    local weapon = VanillaReplacerTable.VanillaWeaponMap[fullType]
    local magazine = VanillaReplacerTable.VanillaMagazineMap[fullType]
    local ammo = VanillaReplacerTable.VanillaAmmoMap[fullType]
    local attachment = VanillaReplacerTable.VanillaAttachmentMap[fullType]

    return (vars.VanillaWeaponReplacement and (weapon or magazine))
        or (vars.VanillaAmmoReplacement and ammo)
        or (vars.VanillaAttachmentReplacement and attachment)
end

local function resolveVanillaReplacement(spawnerItem, entry)
    if #entry == 0 then return nil end

    local selectedType = ItemSpawnCore.getSelectedItemType(spawnerItem, entry[1].items)
    if not selectedType then return nil end

    local newItem = instanceItem(selectedType)
    if not newItem then return nil end

    local bonusItems = {}
    for i = 2, #entry do
        rollOptionItems(bonusItems, entry[i])
    end

    return newItem, bonusItems
end

local function resolveItem(item)
    local entry = getVanillaReplacementEntry(item:getFullType())
    if not entry then return end
    local randomEntry = r:random(#entry)

    ItemSpawnCore.resolve(item, entry[randomEntry], resolveVanillaReplacement, pendingQueue, resolveItem)
end

function MarzGuns_OnCreate.VanillaReplace(item)
    if not item then return end
    resolveItem(item)
end

function MarzGuns_OnCreate.ComputeVanillaReplacement(item)
    local entry = getVanillaReplacementEntry(item:getFullType())
    if not entry then return nil end
    local randomEntry = r:random(#entry)

    return resolveVanillaReplacement(item, entry[randomEntry])
end

function MarzGuns_OnCreate.ComputeVanillaReplacementType(fullType)
    local entry = getVanillaReplacementEntry(fullType)
    if not entry or #entry == 0 then return nil end

    local randomEntry = r:random(#entry)
    return ItemSpawnCore.pickRandomItem(entry[randomEntry][1].items)
end
