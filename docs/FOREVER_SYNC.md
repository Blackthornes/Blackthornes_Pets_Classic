# Forever sync

Where this Classic Era copy stands against Forever Pets
(`Blackthornes/Blackthornes_Pets`). Forever is only ever read from here.

Last Forever commit copied over: `dfc8d41` (Forever main, the merge of its
PR #138, 2026-10-24). This copy was made from it with its history on
2026-10-24.

Copied over since, one at a time:
- `b325d9c` Start release posts with the game name (2026-10-24, copied
  by hand with "Classic Era" in place of "Forever"; see
  `docs/CLASSIC_DIFFERENCES.md`).
- `24e06d9` One minimap button for every Blackthornes addon (2026-10-28,
  Forever PR #148, cherry-picked as it is; `UI/SharedMinimap.lua` and its test
  are the same in all five Classic repos).
- `23d57bd` Shared minimap button shows the Blackthornes thorn B (2026-10-29,
  taken as it is: `UI/SharedMinimap.lua` at FILE_VERSION 2,
  `Media/Frame/MinimapBadge.tga` and `tools/make_minimap_art.py`, the same
  in all five Classic repos).
- `f4b9961` Slim the shared minimap menu: names only, sized to fit (2026-10-29,
  taken as it is: `UI/SharedMinimap.lua` at FILE_VERSION 3 and its test, the
  same in all five Classic repos).
- `fc724ba` Time arrow flights by their real length (2026-10-29, as it is).
- `e8a5525` Show on Map always shows: our own marker and the arrow
  (2026-10-29; Forever's own zones left out of `ZONE_MAPS`, the test uses
  Durotar; `UI/SpotMarker.lua` is the same in Farmer, Butler, Tradeskills and
  Pets Classic).
- `dea75f5` (Butler's) the way there card's rows grow when a step wraps
  (2026-10-29, `UI/TravelCard.lua` only).
- `765faba` Settings: "Show Descriptions" in Title Case (2026-10-29,
  Forever PR #144, as it is).
- `67399d8` One look across the five addons (2026-10-29, Forever PR #156):
  `UI/HouseKit.lua`, `UI/RowMenu.lua`, `UI/Notice.lua` and
  `UI/SharedChoices.lua` as they are (the same in all five Classic repos),
  the compendium's one-line rows, chips and footer, Title Case buttons and
  the General page. Left out: Arrow Size and the compendium's Forever tag.
  `UI/Plaque.lua` keeps Classic's own copy with the new `Plaque.TextWidth`,
  the same in Farmer, Pets, Equipment and Tradeskills Classic.
- `53ba8c3` One Window steps aside for an open letter (2026-10-31): docked at
  the mailbox it moves beside the letter and back, and tells side panels
  when it docks, moves or undocks (`SharedWindow.Watch`, `DockedFrame`).
  `UI/SharedWindow.lua` is FILE_VERSION 5, the same in all five Classic
  repos.

Every catch-up reads `docs/CLASSIC_DIFFERENCES.md` first, and the PR that
brings Forever commits over updates the line above to the newest one it took.
