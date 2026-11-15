-- Core/WhatsNewText.lua
-- Written by tools/make_whatsnew.py from NEWS.md. Never edit it by hand:
-- change NEWS.md and run the tool. UI/WhatsNew.lua shows it.

local _, ns = ...

ns.WHATS_NEW = {
    { version = "0.10.0", lines = {
        "Feeding waits until your pet has finished eating.",
        "Shard Tracker stones can be clicked to make or use them.",
        "Mute All Sounds quiets every Blackthornes sound at once.",
        "Windows remember where you drag them.",
    } },
    { version = "0.9.0", lines = {
        "A new pet XP bar shows your hunter pet's progress.",
        "A new Shard Tracker shows a warlock's soul shards and stones.",
    } },
    { version = "0.8.0", lines = {
        "Item icons now have a ring and a name colour that match their quality.",
        "Stack counts show on the corner of item icons.",
        "Items show a small mark and colour for what to do with them.",
        "Demon book prices show in gold, silver and copper coins.",
    } },
}
