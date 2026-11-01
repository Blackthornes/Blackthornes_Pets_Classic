# News

What each release says in the Discord server's #general channel: a few
short bullets per version, in plain words for players, saying what they'll
notice, then one line thanking, by their Discord name, everyone whose
feedback or report led to the changes (each name once; no line when nobody
asked). Each release PR writes the new version's section here next to its
CHANGELOG.md section, and after the upload `tools/post_general.py` posts it
under a line with the addon's name and version that points players to
#announcements for the full list. No link or addon card goes with it. This
is the only report that names players. A version with no section here posts
nothing in #general.
This file does not ship in the addon, but its newest sections do, without
the thanks line: `python tools/make_whatsnew.py` writes them into
Core/WhatsNewText.lua for the in-game What's New window. Run it after
writing a section; the release check refuses a tag while it is behind.

The window shows new features only. Write a section's features first, then
a "Fixes and changes:" line with the fixes and other changes under it: those
go to Discord but stay out of the window, and a section of only fixes puts
nothing in it. Say what each feature does in a few plain words, the way you'd
tell a friend: no hype, no questions to the reader, no exclamation marks
outside the thanks line, no dashes as punctuation, no "now you can". The
tool prints a note for a shipped line that reads like an advert.

## 0.8.4

Fixes and changes:
- Various bug fixes.

## 0.8.3

Fixes and changes:
- Various bug fixes.

## 0.8.2

Fixes and changes:
- Various bug fixes.

## 0.8.1

Fixes and changes:
- Various bug fixes.

## 0.8.0

- Item icons now have a ring and a name colour that match their quality.
- Stack counts show on the corner of item icons.
- Items show a small mark and colour for what to do with them.
- Demon book prices show in gold, silver and copper coins.

Fixes and changes:
- Various bug fixes.

## 0.7.0

- All your Blackthornes add-ons now open in one window, with a button for each add-on down the side.
- The window moves beside the auction house, mailbox, vendor and trainer when you open them.

Fixes and changes:
- Various bug fixes.

## 0.6.0

- Every window has a new look that matches the other Blackthornes add-ons.

Fixes and changes:
- Various bug fixes.

## 0.5.0

- The minimap button has a new Blackthornes badge.
- Show on Map now puts a gold marker on your map.

Fixes and changes:
- Various bug fixes.

## 0.4.0

- One minimap button now opens all your Blackthornes add-ons.

## 0.3.1

Fixes and changes:
- Various bug fixes.

## 0.3.0

- The small Feed button has a new gold look.

Fixes and changes:
- Various bug fixes.

## 0.2.0

- You can move the small Feed button by holding right-click and dragging it.

Fixes and changes:
- Various bug fixes.

## 0.1.0

- Pets is here for Classic Era. Hunters get a Feed button and a warning when their pet gets hungry.
- The Pet Compendium lists every beast you can tame. Shift-click one and an arrow points you to it.
- The Skills card shows what your pet knows and what it can learn.
- Warlocks get a Skills card for their demons, and a soul shard count.

Thanks for trying it on Era.
