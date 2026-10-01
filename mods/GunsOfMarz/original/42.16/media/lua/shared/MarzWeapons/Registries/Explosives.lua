local OrdnanceFactory = require("ExplosivesSystems/OrdnanceFactory")

OrdnanceFactory.Register("MarzGuns.M67", {
    throwForce          = 8,
    maxThrowDist        = 15,
    floorBounces        = 5,
    bounceEnergy        = 0.2,
    forwardOffset       = 0.50,
    heightOffset        = 0.55,

    detonateOnImpact    = false,
    detonationDelay     = 3,

    explosionFXObject   = "MarzGuns.frag_",
    frames              = { 0, 15 },
    explosionFXDuration = { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3 },
})

OrdnanceFactory.Register("MarzGuns.M18", {
    throwForce          = 8,
    maxThrowDist        = 15,
    floorBounces        = 5,
    bounceEnergy        = 0.2,
    forwardOffset       = 0.50,
    heightOffset        = 0.55,

    detonateOnImpact    = false,
    detonationDelay     = 3,

    explosionFXObject   = "MarzGuns.explosion_0",
    explosionFXDuration = 5,
})

OrdnanceFactory.Register("MarzGuns.M14_Incendiary", {
    throwForce          = 8,
    maxThrowDist        = 15,
    floorBounces        = 5,
    bounceEnergy        = 0.2,
    forwardOffset       = 0.50,
    heightOffset        = 0.55,

    detonateOnImpact    = false,
    detonationDelay     = 3,

    explosionFXObject   = "MarzGuns.explosion_0",
    explosionFXDuration = 5,
})

OrdnanceFactory.RegisterAmmo("SWMG.40mm_Round_HE", {
    throwSpeed          = 40,
    maxThrowDist        = 40,
    arcFactor           = 0.03,

    detonateOnImpact    = true,

    parentItem          = "MarzGuns.40mm_HE_Explosion",

    worldModel          = "MarzGuns.M67",
    explosionFXObject   = "MarzGuns.frag_",
    frames              = { 0, 15 },
    explosionFXDuration = 2,
    directProjectile    = true,

    forwardOffset       = 0.60,
    heightOffset        = 0.50,
})

OrdnanceFactory.RegisterAmmo("SWMG.40mm_Round_Incendiary", {
    throwSpeed          = 40,
    maxThrowDist        = 40,
    arcFactor           = 0.03,

    detonateOnImpact    = true,

    parentItem          = "MarzGuns.40mm_Incendiary_Explosion",

    worldModel          = "MarzGuns.M67",
    explosionFXObject   = "MarzGuns.frag_",
    frames              = { 0, 15 },
    explosionFXDuration = 2,
    directProjectile    = true,

    forwardOffset       = 0.60,
    heightOffset        = 0.50,
})
