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

Every catch-up reads `docs/CLASSIC_DIFFERENCES.md` first, and the PR that
brings Forever commits over updates the line above to the newest one it took.
