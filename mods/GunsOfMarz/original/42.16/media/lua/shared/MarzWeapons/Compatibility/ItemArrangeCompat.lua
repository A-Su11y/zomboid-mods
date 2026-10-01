local function init()
    if IA then
        IA.arrangables["MarzGuns.9x19_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.12Gauge_Box_Buckshot"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.12Gauge_Box_Slug"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.45_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.38_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.44_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.50_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.762x51_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.308_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.762x54_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.556x45_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.556x45_Box_HollowPoint"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.556x45_Box_ArmorPiercing"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.556x45_Box_Subsonic"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.556x45_Box_Overpressured"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.223_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.545x39_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.762x39_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.9x39_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.3006_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.3030_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.357_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.4570_Box"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.40mm_Box_Buckshot"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.40mm_Box_HE"] = IA.arrangableProfile.ammoBox
        IA.arrangables["MarzGuns.40mm_Box_Incendiary"] = IA.arrangableProfile.ammoBox

        IA.arrangables["MarzGuns.9x19_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.12Gauge_Carton_Buckshot"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.12Gauge_Carton_Slug"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.45_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.38_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.44_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.50_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.762x51_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.308_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.762x54_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.556x45_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.556x45_Carton_HollowPoint"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.556x45_Carton_ArmorPiercing"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.556x45_Carton_Subsonic"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.556x45_Carton_Overpressured"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.223_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.545x39_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.762x39_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.9x39_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.3006_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.3030_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.357_Carton"] = IA.arrangableProfile.ammoCarton
        IA.arrangables["MarzGuns.4570_Carton"] = IA.arrangableProfile.ammoCarton
    end
end

Events.OnInitGlobalModData.Add(init)
