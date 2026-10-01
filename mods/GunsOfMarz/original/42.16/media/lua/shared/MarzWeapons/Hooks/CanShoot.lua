require("TimedActions/ISReloadWeaponAction")
require("TimedActions/ISUpgradeWeapon")
require("TimedActions/ISRemoveWeaponUpgrade")

local ISReloadWeaponAction_canShoot = ISReloadWeaponAction.canShoot

-- will expand this in the future, to include necessary parts for weapons to shoot, for now, this is enough
ISReloadWeaponAction.canShoot = function(player, weapon)
    if weapon:getFullType() == "MarzGuns.DOUBLEBARREL" or weapon:getFullType() == "MarzGuns.STEVENS_555" or weapon:getFullType() == "MarzGuns.TOZ34" then
        local barrel = weapon:getWeaponPart("Barrel")
        if not barrel then return false end
    end
    return ISReloadWeaponAction_canShoot(player, weapon);
end

-- I dont think its possible to leave the barrels open but not taking a risk.. users can break shit easily
local ISUpgradeWeapon_complete = ISUpgradeWeapon.complete
function ISUpgradeWeapon:complete()
    local part = self.part
    local toReplace = false
    local newPart = nil
    if part:getPartType() == "Barrel" then
        local fullType = part:getFullType()
        if fullType:sub(-5) == "_Open" then
            toReplace = true
            local closedFullType = fullType:sub(1, -6) .. "_Close"
            newPart = instanceItem(closedFullType)
        end
    end

    ISUpgradeWeapon_complete(self)

    if toReplace then
        self.weapon:attachWeaponPart(self.character, newPart)
    end
end
