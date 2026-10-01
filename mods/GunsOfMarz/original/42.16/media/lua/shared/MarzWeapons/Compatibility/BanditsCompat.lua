local function init()
    if not BanditWeapons or not BanditWeapons.Make then return end

    local originalMake = BanditWeapons.Make

    BanditWeapons.Make = function(itemType, boxCount)
        local replacementType = MarzGuns_OnCreate.ComputeVanillaReplacementType(itemType)
        return originalMake(replacementType or itemType, boxCount)
    end
end

Events.OnInitGlobalModData.Add(init)
