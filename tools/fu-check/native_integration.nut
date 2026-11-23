// Exercise Legends consumers with FU loaded and no MSU namespace.
::logInfo <- function(message) {};
::logWarning <- function(message) {};
::logError <- function(message) { ::print(message + "\n"); };
::include <- function(path) {
    if (path.len() < 4 || path.slice(-4) != ".nut") path += ".nut";
    return ::dofile(path);
};
::new <- function(path) {
    assert(path == "scripts/mods/FU/popup");
    local scope = {};
    ::loadfile(path + ".nut").call(scope);
    return scope.popup;
};
::IO <- { enumerateFiles = function(path) { return [path + "/conflict"]; } };
::Const <- { Serialization = { Version = 1 } };
::Const.UI <- { Color = { PositiveValue = "green", NegativeValue = "red" }, getColorized = function(text, color) { return text; } };
::World <- {};
::include("scripts/!mods_preload/!!a_fu_preload.nut");
delete ::MSU;

::FU.System <- {};
::FU.SystemID <- { Tooltips = 6 };
foreach (path in [
    "systems/system", "systems/system_mod_addon", "classes/weighted_container",
    "systems/tooltips/abstract_tooltip", "systems/tooltips/tooltips/basic_tooltip",
    "systems/tooltips/tooltips/custom_tooltip", "systems/tooltips/tooltips_mod_addon",
    "systems/tooltips/tooltips_system"
]) ::include("scripts/fu/" + path);
::FU.System.Tooltips <- ::FU.Class.TooltipsSystem();
::FU.System.Tooltips.Mods.mod_legends <- {};
::Legends <- { Mod = { getID = function() { return "mod_legends"; } } };
::Legends.Mod.Tooltips <- ::FU.Class.TooltipsModAddon(::Legends.Mod);
::include("mod_legends/register/tooltips.nut");
local tooltip = ::Legends.Mod.Tooltips.getTooltip("CampingPresets.ButtonSavePreset");
assert(tooltip.getUIData({})[0].text == "Save Preset");
::World.Camp <- { getPresetName = function(index) { return "Camp " + index; } };
local slot = ::Legends.Mod.Tooltips.getTooltip("CampingPresets.ButtonPresetSlot").getUIData({ index = 2 });
assert(slot[0].text == "Preset Slot 3" && slot[1].text == "Camp 2");
::World.Encounters <- { getEncounter = function(type) { return { getName = function() { return "Visitors"; } }; } };
assert(::Legends.Mod.Tooltips.getTooltip("Encounters.Element").getUIData({ encounterType = "test" })[0].text == "Visitors");

// The real tooltip hooks route Legends data into FU's tooltip registry.
local events = {
    tactical_queryTileTooltipData = function() {}, general_querySkillTooltipData = function(a, b) {},
    general_queryStatusEffectTooltipData = function(a, b) {}, general_queryUIElementTooltipData = function(a, b, c) {}
};
local module = {};
::mods_hookNewObjectOnce <- function(path, fn) { fn(events); };
::mods_hookNewObject <- function(path, fn) { fn(module); };
::include("scripts/fu/hooks/ui/screens/tooltip/tooltip_events.nut");
::include("scripts/fu/hooks/ui/screens/tooltip/modules/tooltip.nut");
::TooltipScreen <- { m = { TooltipEvents = events } };
assert(module.onQueryFUTooltipData({ modId = "mod_legends", elementId = "CampingPresets.ButtonSavePreset" })[0].text == "Save Preset");

// All six compatibility warning branches must work without MSU's Debug/Popup APIs.
local incompat = { ID = "conflict", Version = "1.0.0", Replacement = null, Files = ["test/conflict.nut"], PatchID = null, Patch = "patch" };
local otherVersion = clone incompat;
otherVersion.Version = ["1.0.0"];
::Legends.Compat <- {
    HardIncompat = { List = [incompat] }, IncompatNotRegistered = { List = [incompat] },
    SoftIncompat = { List = [incompat] }, IncompatButPatched = { List = [incompat] },
    OtherVersionCompat = { List = [otherVersion] }, Integrated = ["conflict"],
    normalizeVersion = function(version) { return version; }
};
::Hooks <- {
    hasMod = function(id) { return id == "conflict"; },
    getMod = function(id) { return { Name = "Conflict", getVersion = function() { return "2.0.0"; } }; }
};
local messages = [];
::UI <- { connect = function(name, backend) {
    assert(name == "FUPopup");
    return { asyncCall = function(method, data) { messages.push(data); } };
} };
::FU.Popup.connect();
::include("mod_legends/compat.nut");
assert(messages.len() == 6);
foreach (message in messages) assert(message.text.len() > 0 && !message.forceQuit);

// Skill-book tooltips must not modify the perk-group definition when flattening it.
::inherit <- function(path, definition) { return definition; };
local scope = {};
::loadfile("scripts/items/misc/legend_skill_book.nut").call(scope);
local book = scope.legend_skill_book;
book.getDescription <- function() { return "Book"; };
book.getValueString <- function() { return "100 crowns"; };
book.getIcon <- function() { return "book.png"; };
book.m.ID <- "test.skill_book";
book.m.PerkGroupSelection = "Test";
local tree = [[1], [2]];
book.m.PerkGroups = [{ Name = "Test", Tree = tree }];
::Const.Perks <- { PerkDefObjects = { [1] = { Icon = "one.png", Name = "One" }, [2] = { Icon = "two.png", Name = "Two" } } };
::World.State <- { m = { CharacterScreen = { getSelectedActor = function() { return null; } } }, isInCharacterScreen = function() { return false; } };
local first = book.getTooltip();
local second = book.getTooltip();
assert(first.len() == second.len() && tree.len() == 2 && tree[0].len() == 1 && tree[1].len() == 1);
assert(!("MSU" in getroottable()));
::print("PASS: Legends tooltips, compatibility warnings and skill books run without MSU\n");
