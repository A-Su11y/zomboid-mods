require("ISUI/ISInventoryPaneContextMenu")
require("TimedActions/ISLoadBulletsInMagazine")
if not getActivatedMods():contains("ReloadAllMagazines") then return end
require("ISUI/ReloadAllMagazines_ISInventoryPaneContextMenu")

local Ammo = require("WeaponSystems/Utils/Ammo")

local function getAvailableFamilyAmmo(playerObj, family)
    local inventory = playerObj:getInventory()
    local ordered = Ammo.GetOrderedBulletTypesForFamily(playerObj, family) or {}
    local result = {}
    for i = 1, #ordered do
        local bulletType = ordered[i]
        local count = inventory:getItemCountRecurse(bulletType)
        if count > 0 then
            local script = getScriptManager():FindItem(bulletType)
            result[#result + 1] = {
                type = bulletType,
                name = script and script:getDisplayName() or bulletType,
                count = count,
            }
        end
    end
    return result
end

local function collectMagazines(inventory, magType)
    local magazines = {}
    local items = inventory:getItems()
    for i = 0, items:size() - 1 do
        local item = items:get(i)
        if item:getType() == magType then
            magazines[#magazines + 1] = item
        elseif instanceof(item, "InventoryContainer") then
            local contained = item:getInventory():getItems()
            for j = 0, contained:size() - 1 do
                local sub = contained:get(j)
                if sub:getType() == magType then
                    magazines[#magazines + 1] = sub
                end
            end
        end
    end
    return magazines
end

local ISInventoryPaneContextMenu_onLoadBulletsInAllMagazines = ISInventoryPaneContextMenu.onLoadBulletsInAllMagazines

ISInventoryPaneContextMenu.onLoadBulletsInAllMagazines = function(playerObj, magazine, bulletType)
    local family = Ammo.ItemAmmoFamily[magazine:getFullType()]
    if not family then
        return ISInventoryPaneContextMenu_onLoadBulletsInAllMagazines(playerObj, magazine)
    end

    bulletType = bulletType or Ammo.GetAutomaticReloadAmmoType(playerObj, magazine)
    if not bulletType then return end

    local inventory = playerObj:getInventory()
    local remaining = inventory:getItemCountRecurse(bulletType)
    if remaining <= 0 then return end

    local magazines = collectMagazines(inventory, magazine:getType())

    local needed = 0
    for i = 1, #magazines do
        local mag = magazines[i]
        needed = needed + math.max(0, mag:getMaxAmmo() - mag:getCurrentAmmoCount())
    end
    needed = math.min(needed, remaining)
    if needed <= 0 then return end
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, inventory:getSomeTypeRecurse(bulletType, needed))

    for i = 1, #magazines do
        local mag = magazines[i]
        if remaining <= 0 then break end
        local ammoCount = math.min(mag:getMaxAmmo() - mag:getCurrentAmmoCount(), remaining)
        if ammoCount > 0 then
            remaining = remaining - ammoCount
            ISInventoryPaneContextMenu.transferIfNeeded(playerObj, mag)
            Ammo.MagazineAmmoProfileSetter(mag, bulletType)
            ISTimedActionQueue.add(ISLoadBulletsInMagazine:new(playerObj, mag, ammoCount))
        end
    end
end

local ISInventoryPaneContextMenu_doMagazineMenu = ISInventoryPaneContextMenu.doMagazineMenu
ISInventoryPaneContextMenu.doMagazineMenu = function(playerObj, magazine, context)
    ISInventoryPaneContextMenu_doMagazineMenu(playerObj, magazine, context)

    local family = Ammo.ItemAmmoFamily[magazine:getFullType()]
    if not family then return end

    local loadAllText = getText("ContextMenu_ReloadAllMagazines_LoadAllMagazines", magazine:getName())
    local unloadAllText = getText("ContextMenu_ReloadAllMagazines_UnloadAllMagazines", magazine:getName())

    context:removeOptionByName(loadAllText)
    context:removeOptionByName(unloadAllText)

    local available = getAvailableFamilyAmmo(playerObj, family)

    if #available <= 1 then
        local option = context:addOption(loadAllText, playerObj,
            ISInventoryPaneContextMenu.onLoadBulletsInAllMagazines, magazine, available[1] and available[1].type)
        if #available == 0 then
            option.notAvailable = true
        end
    else
        local parentOption = context:addOption(loadAllText)
        local subMenu = ISContextMenu:getNew(context)
        context:addSubMenu(parentOption, subMenu)
        for i = 1, #available do
            local entry = available[i]
            subMenu:addOption(entry.name .. " (x" .. entry.count .. ")", playerObj,
                ISInventoryPaneContextMenu.onLoadBulletsInAllMagazines, magazine, entry.type)
        end
    end

    context:addOption(unloadAllText, playerObj, ISInventoryPaneContextMenu.onUnloadBulletsFromAllMagazines, magazine)
end
