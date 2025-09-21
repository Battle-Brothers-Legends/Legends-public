// FU early bootstrap: define ::FU and load core utils so MSU shim can attach
if (!("FU" in getroottable())) ::FU <- {};
::FU.Version <- ::rawget(::FU, "Version", "1.0.0");
::FU.VanillaID <- ::rawget(::FU, "VanillaID", "vanilla");
// Load core utilities expected by shims
::include("scripts/fu/utils/globals.nut");
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
::include("scripts/fu/squirrel_hooks/mod_hooks.nut");
