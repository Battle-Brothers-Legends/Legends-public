// Engine-independent checks of real FU code. No campaign or combat is simulated.
::logInfo <- function(message) {};
::logWarning <- function(message) {};
::logError <- function(message) { ::print(message + "\n"); };
::include <- function(path) {
    if (path.len() < 4 || path.slice(-4) != ".nut") path += ".nut";
    return ::dofile(path);
};
::new <- function(path) {
    if (path == "scripts/mods/FU/popup") {
        local scope = {};
        local script = ::loadfile(path + ".nut");
        script.call(scope);
        return scope.popup;
    }
    if (path == "scripts/mods/FU/FU_connection") return { connect = function() {} };
    throw "Unexpected engine object in unit test: " + path;
};
::IO <- { enumerateFiles = function(path) { throw "Unexpected enumeration: " + path; } };
::Const <- { Serialization = { Version = 1 } };
::World <- {};
::writeText <- function(stream, text) {
    for (local i = 0; i < text.len(); ++i) stream.writen(text[i], 'b');
};

::include("scripts/!mods_preload/!!a_fu_preload.nut");
foreach (key in ["AI", "Tile", "Safe", "InScenario", "HasStashSpace"])
    assert(key in ::FU);
assert(!::FU.InScenario());
assert(!::FU.HasStashSpace());
assert(::MSU.Tile == ::FU.Tile);

// Extensionless game enumeration must not recurse into the loader itself.
local originalInclude = ::include;
local included = [];
::include = function(path) { included.push(path); };
::FU.includeFiles(["x/load", "x/load.nut", "x/real"]);
::MSU.includeFiles(["x/load", "x/load.nut", "x/other"]);
assert(included.len() == 2 && included[0] == "x/real" && included[1] == "x/other");
::include = originalInclude;

// Execute the UI loader to verify its actual registration manifest.
local resources = ::file("build/fu-check/ui-assets.txt", "w");
::mods_registerJS <- function(path) { ::writeText(resources, "js " + path + "\n"); };
::mods_registerCSS <- function(path) { ::writeText(resources, "css " + path + "\n"); };
::include("scripts/fu/ui/load.nut");
resources.close();

local payloads = [];
local connects = 0;
local failSend = false;
::UI <- { connect = function(name, backend) {
    assert(name == "FUPopup");
    connects++;
    return { asyncCall = function(method, payload) {
        if (failSend) throw "Disconnected UI";
        payloads.push({method = method, payload = payload});
    } };
} };
::FU.Popup.showRawText("Before connection");
local quits = 0;
local menu = {
    m = {},
    create = function() {},
    onQuitButtonPressed = function() { quits++; }
};
::mods_hookExactClass <- function(path, hook) {
    assert(path == "ui/screens/menu/modules/main_menu_module");
    hook(menu);
};
::include("scripts/fu/hooks/ui/screens/menu/modules/main_menu_module.nut");
menu.create();
menu.connectBackend();
assert(connects == 1 && payloads.len() == 1);
assert(payloads[0].payload.text == "Before connection");
assert(payloads[0].payload.forceQuit == false);
::FU.UI.connect();
assert(connects == 1);
::FU.Popup.quitGame();
assert(quits == 1);
local wrongTypeRejected = false;
try { ::FU.Popup.showRawText("Title", "Body"); }
catch (error) { wrongTypeRejected = true; }
assert(wrongTypeRejected);
failSend = true;
::FU.Popup.showRawText("Retry after send failure");
assert(::FU.Popup._state.pendingMessages.len() == 1);
::FU.Popup._processPendingMessages();
assert(::FU.Popup._state.pendingMessages.len() == 1);
failSend = false;
::FU.Popup._processPendingMessages();
assert(::FU.Popup._state.pendingMessages.len() == 0);

::include("scripts/fu/hooks/upload_company.nut");
::FU.UploadCompany.onResult({ success = true, companyId = 123 });
local result = payloads.top().payload;
assert(result.text.find("123") != null && result.forceQuit == false);
::FU.Popup.showRawText("Fatal test", true);
assert(payloads.top().payload.forceQuit);
// Pass the actual Squirrel-produced payload contract into the JS test.
local bridge = ::file("build/fu-check/popup-payload.json", "w");
::writeText(bridge, format("{\"text\":\"%s\",\"forceQuit\":%s}",
    payloads.top().payload.text, payloads.top().payload.forceQuit ? "true" : "false"));
bridge.close();
::print("PASS: preload, include guards, UI registration, popup queue and upload notification\n");

// Enabling the optional settings demo must not request a .nut.nut filename.
::FU.Mod <- { Debug = { isEnabled = @(flag) true } };
included.clear();
::include = function(path) { included.push(path); };
::dofile("scripts/fu/test/load.nut");
assert(included.len() == 1 && included[0] == "scripts/fu/test/mod_settings_system_test.nut");
::include = originalInclude;

// Exercise production flag serializers, including mixed nested values and cleanup.
::include("scripts/fu/systems/system.nut");
::include("scripts/fu/systems/system_mod_addon.nut");
::FU.System <- {};
::FU.SystemID <- { Serialization = 0 };
foreach (name in ["metadata_emulator", "serde_emulator", "serialization_emulator",
                 "deserialization_emulator", "serialization_system", "serialization_mod_addon"])
    ::include("scripts/fu/systems/serialization/" + name);
::FU.System.Serialization <- ::FU.Class.SerializationSystem();
::FU.System.Serialization.MetaData = ::FU.Class.MetaDataEmulator();
local mod = { getID = @() "mod_fu_test" };
local flags = {
    values = {},
    set = function(k, v) { this.values[k] <- v; },
    get = function(k) { return this.values[k]; },
    has = function(k) { return k in this.values; },
    remove = function(k) { if (k in this.values) delete this.values[k]; }
};
local saved = { label = "FU test", rounds = 3, lost = -2,
               values = [true, false, null, 1.25, { nested = [1, "two"] }] };
::FU.System.Serialization.flagSerialize(mod, "RoundTrip", saved, flags);
assert(flags.values.len() > 0);
local disk = clone flags.values;
::FU.System.Serialization.clearFlags();
assert(flags.values.len() == 0);
flags.values = disk;
local restored = ::FU.System.Serialization.flagDeserialize(mod, "RoundTrip", null, null, flags);
assert(restored.label == saved.label && restored.lost == -2 && restored.rounds == 3);
assert(restored.values[0] && !restored.values[1] && restored.values[2] == null);
assert(restored.values[3] == 1.25 && restored.values[4].nested[1] == "two");
assert(flags.values.len() == 0);
assert(::FU.System.Serialization.flagDeserialize(mod, "Absent", "default", null, flags) == "default");
::print("PASS: production FU flag serialization round trip (not a game save/load test)\n");

// The late MSU shim aliases FU.System; it must not suppress FU's metadata setup.
::MSU.System <- ::FU.System;
::FU.Mod <- mod;
local originalNew = ::new;
local failMetadata = false;
local metadataCalls = 0;
::new = function(path) {
    if (path == "scripts/tools/tag_collection") return flags;
    if (path == "scripts/states/world_state") return {
        onBeforeSerialize = function(out) {
            metadataCalls++;
            assert(out.Mod == mod);
            if (failMetadata) throw "Metadata failure";
            out.getMetaData().setString("legendsVersion", "test");
        }
    };
    return originalNew(path);
};
::include("scripts/fu/systems/serialization/load.nut");
local callback = ::FU.UI.Callbacks.pop();
assert(!("Assets" in ::World));
callback();
assert(metadataCalls == 1 && !("Assets" in ::World));
assert(::FU.System.Serialization.MetaData.getString("legendsVersion") == "test");
local originalAssets = { marker = "existing world assets" };
::World.Assets <- originalAssets;
callback();
assert(::World.Assets == originalAssets);
failMetadata = true;
local threw = false;
try { callback(); } catch (error) { threw = true; }
assert(threw && ::World.Assets == originalAssets);
delete ::World.Assets;
threw = false;
try { callback(); } catch (error) { threw = true; }
assert(threw && !("Assets" in ::World));
local callsBefore = metadataCalls;
delete ::MSU.IsShim;
callback();
assert(metadataCalls == callsBefore);
::new = originalNew;
::print("PASS: metadata initialization with shim, separate MSU, and failure cleanup\n");
