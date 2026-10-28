-- Core/WhatsNewText.lua
-- Written by tools/make_whatsnew.py from NEWS.md. Never edit it by hand:
-- change NEWS.md and run the tool. UI/WhatsNew.lua shows it.

local _, ns = ...

ns.WHATS_NEW = {
    { version = "0.4.0", lines = {
        "One minimap button now opens all your Blackthornes add-ons.",
    } },
    { version = "0.3.0", lines = {
        "The small Feed button has a new gold look.",
    } },
    { version = "0.2.0", lines = {
        "You can move the small Feed button by holding right-click and dragging it.",
    } },
}
