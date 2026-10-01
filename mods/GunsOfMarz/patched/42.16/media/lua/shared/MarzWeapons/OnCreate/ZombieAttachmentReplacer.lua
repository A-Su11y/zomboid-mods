MarzGuns_OnCreate = MarzGuns_OnCreate or {}

local ItemSpawnCore = require("SpawnerSystems/ItemSpawnCore")
require("MarzWeapons/OnCreate/ItemSpawner")
require("MarzWeapons/OnCreate/VanillaReplacer")

local function computeReplacement(item)
    local newItem, bonusItems = MarzGuns_OnCreate.ComputeSpawnerItem(item)
    if newItem then return newItem, bonusItems end

    return MarzGuns_OnCreate.ComputeVanillaReplacement(item)
end

function MarzGuns_OnCreate.SyncZombieAttachments(zombie)
    if not ItemSpawnCore.shouldProcess() or not instanceof(zombie, "IsoZombie") then return end

    local attachedItems = zombie:getAttachedItems()
    if attachedItems:isEmpty() then return end

    for i = 0, attachedItems:size() - 1 do
        local attachedItem = attachedItems:get(i)
        local actualItem = attachedItem and attachedItem:getItem()
        if actualItem then
            local newItem, bonusItems = computeReplacement(actualItem)
            if newItem then
                local location = attachedItem:getLocation()
                zombie:setAttachedItem(location, newItem)

                if isServer() then
                    sendAttachedItem(zombie, location, newItem)
                end

                if bonusItems then
                    for j = 1, #bonusItems do
                        zombie:addItemToSpawnAtDeath(bonusItems[j])
                    end
                end
            end
        end
    end
end

-- Will this shite resolve the bodies of zombies in MP? I really hope
function MarzGuns_OnCreate.ResolveZombieInventorySpawners(zombie)
    if not ItemSpawnCore.shouldProcess() or not instanceof(zombie, "IsoZombie") then return end

    local container = zombie:getInventory()
    local items = container and container:getItems()
    if not items then return end

    local existing = {}
    for i = 0, items:size() - 1 do
        existing[#existing + 1] = items:get(i)
    end

    local changed = false
    for i = 1, #existing do
        local oldItem = existing[i]
        local newItem, bonusItems = computeReplacement(oldItem)
        if newItem then
            local addedItem = container:AddItem(newItem)
            if addedItem then
                container:DoRemoveItem(oldItem)
                zombie:removeAttachedItem(oldItem)

                if bonusItems then
                    for j = 1, #bonusItems do
                        container:AddItem(bonusItems[j])
                    end
                end

                changed = true
            end
        end
    end

    if changed then
        container:setDirty(true)
        container:setDrawDirty(true)
    end
end
