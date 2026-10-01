# GunsOfMarz — alt "open ammo box" recipes

## What this patch does

Adds four new recipes alongside the author's originals so a single ammo box
can be opened using any **screwdriver or sharp knife** instead of requiring
a second ammo box of a different type (which is the author's intentional
design, not a bug).

The originals stay in place — removing them would break saves that already
reference them. Players now see two options in the UI under the "Open Box"
recipe group; they can use whichever they have on hand.

## File

`patched/42.16/media/scripts/MarzWeapons/recipes/ammunition.txt`

## New recipes

- `OpenBoxOf50Bullets_WithTool` — pistol-class box + Screwdriver/SharpKnife
- `OpenBoxOf20Bullets_WithTool` — rifle-class box + Screwdriver/SharpKnife
- `OpenBoxOf25Bullets_WithTool` — shotgun shell/44/50 box + Screwdriver/SharpKnife
- `OpenBoxOf10Bullets_WithTool` — 40mm box + Screwdriver/SharpKnife

Each mirrors its original one-for-one (same timedAction, same output, same
mapper), with one added `item` line in `inputs`:

```
item 1 tags[Screwdriver;SharpKnife] flags[Prop1;KeepItem],
```

The tool is held in the main hand (`Prop1`) and **not consumed** (`KeepItem`).

## Why

Can't remove the mod — the save references its items. Can't modify the
original recipes safely without the mod author's cooperation (and we don't
want to lose compatibility with Workshop updates when they come). Alt
recipes are additive, reversible, and leave the author's design visible to
anyone who wants it.

## Scope

- Not touching `OpenCartonOfBoxesOfAmmo` or `OpenCrateOfBoxesOfAmmo` — these
  work by consuming one carton/crate to produce boxes. No "two different
  types" problem there.
- Not touching `place*BulletsInBox` — reverse direction, no issue reported.
- Not touching translations (`Recipes.json`) — the game will auto-label from
  the recipe name. If the UI label looks ugly in-game, add a `Recipes.json`
  entry in a follow-up patch.

## Testing

In-game, with a single box of 9x19 and a Screwdriver in your inventory:
right-click the box → Open Box → there should be two options visible. Pick
the one that takes the Screwdriver. 15s action, 50 bullets out, screwdriver
kept.
