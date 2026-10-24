# Classic differences

Every place this Classic Era copy differs from Forever Pets, and why. Keep
it short and current: a PR that adds a Classic-only change adds its line
here in the same breath.

## The catch-up rule

Every Forever catch-up checks this note first, before sorting commits into
"fits Era", "Forever only, skip" or "needs changes for Era".

- A Forever commit that touches nothing listed here comes over as it is.
- A Forever commit that touches only a file Classic removed (below) is
  "Forever only, skip", unless it also changes how the readers that ask
  for it behave.
- A Forever commit that lands on something listed here is a clash. Show the
  owner both versions side by side and offer three choices:
  - **Keep Classic's:** skip the Forever change.
  - **Take Forever's:** only when it really replaces what Classic did.
  - **Blend them (the usual pick):** bring Forever's idea over on top of
    Classic's version.
- Whatever is picked, nothing below gets lost by accident. If a pick changes
  a line here, the same PR changes the note.

## What differs

### The TOC
- `## Interface: 11509`, what the owner's Era client reports. Forever is 16001.
- `## X-Curse-Project-ID: 1763344`, Pets Classic's own project. Forever's
  1720056 must never be here: `tools/check_release.py` refuses a tag that has
  it, and `tools/test_check_release.py` checks the Classic ID is there.
- The folder and TOC (`Blackthornes_Pets`), saved data
  (`BlackthornesPetsDB`, `BlackthornesPetsCharDB`), the global and `/bpet`
  are the same as Forever's, on purpose. Never rename them.

### Forever's beasts are gone
- `Data/ForeverBeasts.lua` and `tools/forever_beasts.py` are deleted here,
  not just left out of the TOC (unlike the other Classic repos). A Forever
  change to either is "Forever only, skip".
- `Logic/Compendium.lua` and `Logic/Taming.lua` still read
  `ns.ForeverBeasts` only when it exists, so a Forever change to them still
  merges. Their comments say Classic Era ships without it; keep those lines
  in a blend.
- The Compendium is Classic's list with this account's own tames
  (`tamedBeasts`, `Logic/TameRecord.lua`) laid over it.
- Tested in `tools/test_compendium.lua` (rewritten for Classic's list alone)
  and `tools/test_taming.lua` (no Forever data, own tames still win).

### Notes and docs
- `CLAUDE.md` opens with "This repo is the Classic Era copy".
- `README.md` names the Classic CurseForge project and says no Forever
  findings ship.

### Discord release posts
- `tools/announce_discord.py` and `tools/post_general.py` start both
  posts with "Classic Era: " (their `GAME`), where Forever's start with
  "Forever: ", so the two games' releases read apart. A catch-up that
  touches these tools keeps Classic's word. Tested in
  `tools/test_announce_discord.py` and `tools/test_post_general.py`.

### No Forever words in the Compendium
- The owner asked (2026-10-24) for no "Forever" a player can see. The
  Compendium has no "Seen on Forever" tick box (a saved `foreverOnly` stays
  in the save, unread; `Compendium:List` still takes it), its hint line is
  only "Click a beast to pin it on your map, or Shift-click to point the
  arrow at it.", rows and tooltips carry no green Forever mark or line, and
  the speed line no longer says "(seen on Forever)". The beast arrow's note
  for your own tame is "Where you tamed it" (`BeastArrow.Note`), never
  `Compendium.ForeverText`, which stays for clean merges. A catch-up that
  brings any of these back keeps Classic's. Tested in
  `tools/test_beastarrow.lua`.

## Not yet done
- The rest of the plan (Era's pet calls as fallbacks, the probe in Era,
  data made again from Era's tables, the sister lists) is in the project's
  `pets-classic-plan.md`, one small PR each. Each step adds its line here.
- Not yet seen in an Era client. Client calls are read in a pcall.
