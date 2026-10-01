MarzGuns_OnCreate = MarzGuns_OnCreate or {}
local r = newrandom()

local ItemSpawnCore = require("SpawnerSystems/ItemSpawnCore")
local SpawnerTable = require("MarzWeapons/OnCreate/ItemSpawnerTable")

local pendingQueue = ItemSpawnCore.newDeferredQueue()

local function getItemSpawnerEntry(fullType)
    return SpawnerTable.ItemSpawnerMap[fullType]
end

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

local function resolveDynamicSpawner(spawnerItem, entry)
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
    local entry = getItemSpawnerEntry(item:getFullType())
    if not entry then return end
    local randomEntry = r:random(#entry)

    ItemSpawnCore.resolve(item, entry[randomEntry], resolveDynamicSpawner, pendingQueue, resolveItem)
end

function MarzGuns_OnCreate.SelectItem(item)
    if not item then return end
    resolveItem(item)
end

function MarzGuns_OnCreate.ComputeSpawnerItem(item)
    local entry = getItemSpawnerEntry(item:getFullType())
    if not entry then return nil end
    local randomEntry = r:random(#entry)

    return resolveDynamicSpawner(item, entry[randomEntry])
end
