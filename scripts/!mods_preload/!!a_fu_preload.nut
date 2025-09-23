// FU early bootstrap: define ::FU and load core utils so MSU shim can attach
if (!("FU" in getroottable())) ::FU <- {};
if (!("ID" in ::FU)) ::FU.ID <- "mod_fu";
if (!("Name" in ::FU)) ::FU.Name <- "Functional Utilities";
if (!("Version" in ::FU)) ::FU.Version <- "1.0.0";
if (!("VanillaID" in ::FU)) ::FU.VanillaID <- "vanilla";
if (!("Class" in ::FU)) ::FU.Class <- {};
if (!("EndQueue" in ::FU)) ::FU.EndQueue <- {
    _queue = [],
    add = function(_func) { this._queue.push(_func); },
    execute = function() {
        foreach (func in this._queue) func();
        this._queue.clear();
    }
};
// Load core utilities expected by shims - exceptions must come before globals
::include("scripts/fu/utils/exceptions.nut");
::include("scripts/fu/utils/globals.nut");
::include("scripts/fu/utils/include.nut");
::include("scripts/fu/utils/io.nut");
::include("scripts/fu/utils/skills.nut");
::include("scripts/fu/utils/semver.nut");
::include("scripts/fu/utils/utils.nut");
::include("scripts/fu/utils/log.nut");
::include("scripts/fu/utils/array.nut");
::include("scripts/fu/utils/string.nut");
::include("scripts/fu/utils/math.nut");
::include("scripts/fu/utils/table.nut");
::include("scripts/fu/utils/text.nut");
::include("scripts/fu/utils/type_checkers.nut");

// Install MSU shim and enhanced mod_hooks wrappers before validation/queue
::include("scripts/fu/shims/msu_shim_early.nut");
// mod_hooks wrapper is included in register_legends after vanilla mod_hooks is ready


::FU.Popup <- ::new("scripts/mods/FU/popup");
