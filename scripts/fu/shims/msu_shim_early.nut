// Early MSU shim: provide ::MSU presence and utilities before queue runs
// Note: use getroottable() instead of 'in ::' which is invalid in Squirrel.
if (!("MSU" in getroottable()))
{
    ::MSU <- {
        Version = ::FU.Version,
        ID = "mod_msu",
        Name = "MSU shim (via FU)",
        VanillaID = ::FU.VanillaID,
        Class = {},
        BBClass = { Empty = "scripts/mods/FU/empty_bb_class" },
        IsShim = true
    };

    // Legacy include helpers
    ::MSU.includeLoad <- function( _prefix, _folder ) { ::include(_prefix + _folder + "/load.nut"); };
    ::MSU.includeFile <- function( _prefix, _file ) { ::include(_prefix + _file); };
    ::MSU.includeFiles <- function( _files, _includeLoad = false )
    {
        foreach (file in _files)
        {
            if (_includeLoad || split(file, "/").pop() != "load.nut") ::include(file);
        }
    };

    // Map utilities available at config time (only if already defined on ::FU)
    if ("Exception" in ::FU) ::MSU.Exception <- ::FU.Exception;
    if ("Array" in ::FU) ::MSU.Array <- ::FU.Array;
    if ("String" in ::FU) ::MSU.String <- ::FU.String;
    if ("Math" in ::FU) ::MSU.Math <- ::FU.Math;
    if ("Table" in ::FU) ::MSU.Table <- ::FU.Table;
    if ("Text" in ::FU) ::MSU.Text <- ::FU.Text;
    if ("TypeCheckers" in ::FU) ::MSU.TypeCheckers <- ::FU.TypeCheckers;
    if ("SemVer" in ::FU) ::MSU.SemVer <- ::FU.SemVer;
    if ("Utils" in ::FU) ::MSU.Utils <- ::FU.Utils;
    if ("Log" in ::FU) ::MSU.Log <- ::FU.Log;
    if ("Globals" in ::FU) ::MSU.Globals <- ::FU.Globals;

    // Common direct aliases used by mods (avoid requiring .Globals)
    if ("isNull" in ::FU) ::MSU.isNull <- ::FU.isNull;
    if ("getField" in ::FU) ::MSU.getField <- ::FU.getField;
    if ("getMember" in ::FU) ::MSU.getMember <- ::FU.getMember;
    if ("isIn" in ::FU) ::MSU.isIn <- ::FU.isIn;
    if ("isKindOf" in ::FU) ::MSU.isKindOf <- ::FU.isKindOf;
    if ("asWeakTableRef" in ::FU) ::MSU.asWeakTableRef <- ::FU.asWeakTableRef;
    if ("regexMatch" in ::FU) ::MSU.regexMatch <- ::FU.regexMatch;
    if ("isEqual" in ::FU) ::MSU.isEqual <- ::FU.isEqual;
    if ("isBBObject" in ::FU) ::MSU.isBBObject <- ::FU.isBBObject;

    // Namespaces commonly referenced early
    if ("Key" in ::FU) ::MSU.Key <- ::FU.Key;
    if ("Tile" in ::FU) ::MSU.Tile <- ::FU.Tile;
    if ("Skills" in ::FU) ::MSU.Skills <- ::FU.Skills;

    // Copy require* helpers
    foreach (k, v in ::FU)
    {
        if (typeof v == "function" && ("String" in ::FU) && ::FU.String.startsWith(k, "require")) ::MSU[k] <- v;
    }
}
