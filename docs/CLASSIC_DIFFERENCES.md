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
- The About thank-you (`About.THANKS`) has no "WoW Forever is almost here"
  paragraph (the owner, 2026-10-24). `UI/About.lua` is shared with Forever;
  a catch-up that brings the paragraph back keeps Classic's.

### Era's pet calls
- Era has no `C_PetInfo`, only the classic globals. `PetStatus:Read` asks
  `C_PetInfo` first, then `GetPetHappiness`, `GetPetLoyalty`,
  `GetPetFoodTypes` (one value each, not a list) and `GetPetTrainingPoints`
  (`CallEither`). Without them there was no food card, so no Feed button,
  no small Feed button and no feed warning. Loyalty's "Loyalty Level 3
  (Submissive)" is kept as its name (`PetStatus.LoyaltyName`).
  `Food:FeedSpellName` falls back on `GetSpellInfo`. A catch-up that
  touches these reads keeps the fallbacks. Tested in
  `tools/test_erapetcalls.lua`.
- Era's `UnitCreatureFamily` gives the family's name alone, and the family
  lookup may be missing, so `PetSkills.FamilyID` also matches the English
  names in `CompendiumData.FAMILIES` (`tools/test_petskills.lua`).
- Era's quest list is `QuestWatchFrame`: the small Feed button looks for
  it after `ObjectiveTrackerFrame` (`FeedButton.TRACKERS`,
  `tools/test_feedbutton.lua`).
- Spell names fall back on `GetSpellInfo` and `GetSpellSubtext` in
  `Taming:SkillNames` and `TameRecord` (`tools/test_german.lua`).

## Not yet done
- The rest of the plan (Era's pet calls as fallbacks, the probe in Era,
  data made again from Era's tables, the sister lists) is in the project's
  `pets-classic-plan.md`, one small PR each. Each step adds its line here.
- Not yet seen in an Era client. Client calls are read in a pcall.

### No Forever zones in the map list

Forever added its own zones (Mount Hyjal, Zephras Isle, Riverglades,
Shen'dralas) to `Waypoints.ZONE_MAPS` with its marker fix (2026-10-29).
Era has none of them, so Classic's list stays as it was. A catch-up that
adds them again leaves them out.

## The house look (2026-10-29)

- Brought over from Forever's "One look across the five addons". The game
  calls it uses (`CreateFrame`, `C_Timer.After`, `GetTime`, the usual frame
  methods) are all in Era, so nothing needed a fallback.
- No Arrow Size here: the shared choice is heard and left alone.
- A compendium row is the beast's name and its rare or elite tag only;
  there is no Forever tag.

## The one window

- `UI/SharedWindow.lua` is Classic's own (2026-10-30); Forever has no copy
  yet. "One Window:" is on unless unticked (2026-10-30). At the auction
  house only Tradeskills shows in it.
- Pets' Pet, Compendium and Settings tabs move into it when ticked
  (`PetsTabs.host`, `Route`, `Closed`); Forever's PetsTabs has none of it.
- Docking beside the auction house, mailbox, vendor and trainer (2026-10-30) is in the
  shared file, so Forever has none of it either.
