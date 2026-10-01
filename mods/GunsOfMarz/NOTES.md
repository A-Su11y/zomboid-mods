# GunsOfMarz — ammo box opening

## Reported bug

Opening a box of ammo in-game asks for **two different ammo box types**
simultaneously as inputs. A player with a single box in their inventory
cannot open it — they would need, e.g., a 9x19 box *and* a .45 box to
perform the "open box" action, which consumes neither correctly.

## Where the recipe lives

`patched/42.16/media/scripts/MarzWeapons/recipes/ammunition.txt`

The affected recipes are:

- `OpenBoxOf50Bullets` — 9x19, .45, .38, .357
- `OpenBoxOf20Bullets` — rifle rounds
- `OpenBoxOf25Bullets` — shotgun shells, .44, .50
- `OpenBoxOf10Bullets` — 40mm rounds

All four have the same shape:

```
inputs {
    item 1 tags[marzguns:ammobox50] mappers[ammoType] flags[Prop2;AllowFavorite;InheritFavorite],
}
outputs {
    item 50 mapper:ammoType,
}
itemMapper ammoType {
    SWMG.9x19_Bullet = MarzGuns.9x19_Box,
    ...
}
```

## Hypotheses

**(A) `Prop2` flag double-counts the input.** `Prop2` marks the item as a
secondary-hand prop during the animation. If the B42 craft engine treats
prop-flagged inputs separately from the consumable input stack, the recipe
might effectively require "one item to hold" + "one item to consume" = two
items total. Fix: remove `Prop2`.

**(B) `mappers[ammoType]` on the input conflicts with the tag.** The mapper
narrows a tagged input to specific types. If the engine iterates the mapper
and demands one input per mapper key (vs. one input total), that produces
the "two different types needed" symptom exactly. Fix: drop `mappers[ammoType]`
from the input, keep it only on the output. (Risk: this may break the output
mapping entirely — need to verify in-game.)

**(C) The recipes should be split per ammo type.** Rather than one recipe
with a mapper, write N tiny recipes:

```
craftRecipe OpenBoxOf_9x19 {
    inputs  { item 1 [MarzGuns.9x19_Box] flags[AllowFavorite;InheritFavorite], }
    outputs { item 50 SWMG.9x19_Bullet, }
}
```

Verbose but unambiguous. Guaranteed fix at the cost of a longer file.

## Plan

1. Try (A) first — minimal diff, easiest rollback. Deploy, test with one
   box of 9x19 in-game.
2. If (A) doesn't work, (B).
3. If (B) breaks output mapping, (C).

## What's NOT in scope

- Changing the `OpenCartonOfBoxesOfAmmo` or `OpenCrateOfBoxesOfAmmo` recipes
  (no reported bug there).
- Touching the `place*BulletsInBox` recipes (reverse direction, no reported
  bug).
- Any gameplay rebalance.
