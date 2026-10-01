MarzGuns_OnCreate = MarzGuns_OnCreate or {}

local r = newrandom()
local MarzGuns_AttachmentPointsTable = require("MarzWeapons/OnCreate/AttachmentPointsTable")

local function addRoundsToAmmoList(count, itemAmmoList, itemAmmo, itemModData)
    for _ = 1, count do
        itemAmmoList[#itemAmmoList + 1] = itemAmmo
    end
    itemModData.AmmoList = itemAmmoList
end

local function parseOptionalAttachmentEntry(entry)
    local itemType, chance, requiredMount = string.match(entry, "^([^:]+):([^:]+):([^:]+)$")
    if itemType then
        return itemType, tonumber(chance) or 0, requiredMount
    end

    itemType, chance = string.match(entry, "^([^:]+):([^:]+)$")
    if itemType then
        return itemType, tonumber(chance) or 0, nil
    end

    return entry, 100, nil
end

local function ensureRequiredMount(weapon, mountCode)
    local mountType = MarzGuns_AttachmentPointsTable.requiredAttachmentsForAttachments[mountCode]
    if not mountType then return end

    local mountPart = instanceItem(mountType)
    if not mountPart then return end

    if weapon:getWeaponPart(mountPart:getPartType()) then
        return
    end

    weapon:attachWeaponPart(mountPart)
end

function MarzGuns_OnCreate.AttachParts(weapon)
    if not weapon then return end

    local listOfAttachments = MarzGuns_AttachmentPointsTable.weaponAttachmentTablesAndChances[weapon:getFullType()]
    if listOfAttachments then
        local requiredParts = listOfAttachments["required"] or {}
        for i = 1, #requiredParts do
            local part = instanceItem(requiredParts[i])
            if part then
                weapon:attachWeaponPart(part)
            end
        end

        local optionalParts = listOfAttachments["optionals"] or {}
        for i = 1, #optionalParts do
            local itemType, chanceNum, requiredMount = parseOptionalAttachmentEntry(optionalParts[i])

            local roll = chanceNum > 0 and r:random(100) < chanceNum
            if roll then
                if requiredMount then
                    ensureRequiredMount(weapon, requiredMount)
                end

                local part = instanceItem(itemType)
                if part then
                    weapon:attachWeaponPart(part)
                end
            end
        end
    end

    local weaponModData  = weapon:getModData()
    local weaponAmmoList = weaponModData.AmmoList or {}
    local weaponAmmo     = weapon:getAmmoType():getItemKey()

    if weapon:getWeaponPart("BayonetKnife") ~= nil then
        weaponModData.GW_BayonetDeployed = true
    end

    if weapon:getWeaponPart("Clip") ~= nil then
        local magazine   = weapon:getWeaponPart("Clip")
        local randomAmmo = r:random(magazine:getMaxAmmo())
        weapon:setMaxAmmo(magazine:getMaxAmmo())
        weapon:setMagazineType(magazine:getFullType())
        weapon:setCurrentAmmoCount(randomAmmo)
        weapon:setContainsClip(true)
        weaponModData.MagazineType = magazine:getFullType()
        addRoundsToAmmoList(randomAmmo, weaponAmmoList, weaponAmmo, weaponModData)
    elseif weapon:getMagazineType() == nil then
        local randomAmmo = weapon:getMaxAmmo()
        weapon:setCurrentAmmoCount(randomAmmo)
        addRoundsToAmmoList(randomAmmo, weaponAmmoList, weaponAmmo, weaponModData)
    else
        weapon:setContainsClip(false)
    end
end

function MarzGuns_OnCreate.ReturnAmmoList(craftRecipeData, character)
    local consumedItems = craftRecipeData:getAllConsumedItems()
    local inventory = character:getInventory()

    for i = 0, consumedItems:size() - 1 do
        local consumedItem = consumedItems:get(i)
        local ammoList = consumedItem:getModData().AmmoList

        if ammoList then
            for j = 1, #ammoList do
                local newBullet = instanceItem(ammoList[j])
                if newBullet then
                    newBullet = inventory:AddItem(newBullet)
                    if newBullet and isServer() then
                        sendAddItemToContainer(inventory, newBullet)
                    end
                end
            end
        end
    end
end

function MarzGuns_OnCreate.GiveRandomMagAmmo(magazine)
    if not magazine then return end

    local magazineModData  = magazine:getModData()
    local magazineAmmoList = magazineModData.AmmoList or {}
    local magazineAmmo     = magazine:getAmmoType():getItemKey()

    local randomAmmo       = r:random(magazine:getMaxAmmo())
    magazine:setCurrentAmmoCount(randomAmmo)
    addRoundsToAmmoList(randomAmmo, magazineAmmoList, magazineAmmo, magazineModData)
end
