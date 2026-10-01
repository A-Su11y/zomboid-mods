require("GunworksUtils/GunworksAttachAndDetach")

MarzGuns_AttachAndDetach = Gunworks_AttachAndDetach

local Check = Gunworks_AttachAndDetach.Check

Gunworks_AttachAndDetach.RegisterPartTools({
    ["Foregrip"]    = { Check.Screwdriver },
    ["Scope"]       = { Check.Screwdriver },
    ["RailUp"]      = { Check.Screwdriver },
    ["RailDown"]    = { Check.Screwdriver },
    ["RailRight"]   = { Check.Screwdriver },
    ["RailLeft"]    = { Check.Screwdriver },
    ["Bipod"]       = { Check.Screwdriver },
    ["Shellholder"] = { Check.Screwdriver },
    ["Stock"]       = { Check.Screwdriver },
    ["Underbarrel"] = { Check.Screwdriver },
    ["Sling"]       = { Check.Screwdriver },
    ["CanonMount"]  = { Check.Wrench },
    ["Canon"]       = { Check.Wrench },
    ["LaserRifle"]  = { Check.Screwdriver },
    ["LightRifle"]  = { Check.Screwdriver },
    ["Barrel"]      = { Check.Wrench, Check.Screwdriver },
})
