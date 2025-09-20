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

    // Map utilities available at config time
    ::MSU.Exception <- ::FU.Exception;
    ::MSU.Array <- ::FU.Array;
    ::MSU.String <- ::FU.String;
    ::MSU.Math <- ::FU.Math;
    ::MSU.Table <- ::FU.Table;
    ::MSU.Text <- ::FU.Text;
    ::MSU.TypeCheckers <- ::FU.TypeCheckers;
    ::MSU.SemVer <- ::FU.SemVer;
    ::MSU.Utils <- ::FU.Utils;
    ::MSU.Log <- ::FU.Log;
    ::MSU.Globals <- ::FU.Globals;

    // Common direct aliases used by mods (avoid requiring .Globals)
    ::MSU.isNull <- ::FU.isNull;
    ::MSU.getField <- ::FU.getField;
    ::MSU.getMember <- ::FU.getMember;
    ::MSU.isIn <- ::FU.isIn;
    ::MSU.isKindOf <- ::FU.isKindOf;
    ::MSU.asWeakTableRef <- ::FU.asWeakTableRef;
    ::MSU.regexMatch <- ::FU.regexMatch;
    ::MSU.isEqual <- ::FU.isEqual;
    ::MSU.isBBObject <- ::FU.isBBObject;

    // Namespaces commonly referenced early
    if ("Key" in ::FU) ::MSU.Key <- ::FU.Key;
    if ("Tile" in ::FU) ::MSU.Tile <- ::FU.Tile;
    if ("Skills" in ::FU) ::MSU.Skills <- ::FU.Skills;

    // Copy require* helpers
    foreach (k, v in ::FU)
    {
        if (typeof v == "function" && ::FU.String.startsWith(k, "require")) ::MSU[k] <- v;
    }
}
