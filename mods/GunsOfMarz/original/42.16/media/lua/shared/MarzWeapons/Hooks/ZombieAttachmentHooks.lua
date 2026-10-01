local ItemSpawnCore = require("SpawnerSystems/ItemSpawnCore")
local ZOMBIE_ATTACHMENTS_SYNCED_KEY = "MarzGuns_ZombieAttachmentsSynced"
local createQueue = ItemSpawnCore.newDeferredQueue()

local function onZombieCreate(zombie)
    createQueue.mark(zombie, function(z)
        createQueue.clear(z)
        MarzGuns_OnCreate.SyncZombieAttachments(z)
    end)
end

local function onZombieUpdate(zombie)
    local modData = zombie:getModData()
    if modData[ZOMBIE_ATTACHMENTS_SYNCED_KEY] then return end
    modData[ZOMBIE_ATTACHMENTS_SYNCED_KEY] = true

    MarzGuns_OnCreate.SyncZombieAttachments(zombie)
end

-- Forcing the update on their dead. there is no way this time it doesn't clean up
local function onZombieDead(zombie)
    MarzGuns_OnCreate.ResolveZombieInventorySpawners(zombie)
end

Events.OnZombieCreate.Add(onZombieCreate)
Events.OnZombieUpdate.Add(onZombieUpdate)
Events.OnZombieDead.Add(onZombieDead)
