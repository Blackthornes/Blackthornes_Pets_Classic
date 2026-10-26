-- Core/WhatsNewText.lua
-- Written by tools/make_whatsnew.py from NEWS.md. Never edit it by hand:
-- change NEWS.md and run the tool. UI/WhatsNew.lua shows it.

local _, ns = ...

ns.WHATS_NEW = {
    { version = "0.2.0", lines = {
        "You can move the small Feed button by holding right-click and dragging it.",
    } },
    { version = "0.1.0", lines = {
        "Pets is here for Classic Era. Hunters get a Feed button and a warning when their pet gets hungry.",
        "The Pet Compendium lists every beast you can tame. Shift-click one and an arrow points you to it.",
        "The Skills card shows what your pet knows and what it can learn.",
        "Warlocks get a Skills card for their demons, and a soul shard count.",
    } },
}
