// MSU compatibility shim provided by FU
// Completes or defines ::MSU mapping. Safe to include multiple times.
// Note: use getroottable() instead of 'in ::' which is invalid in Squirrel.
if (!("MSU" in getroottable()))
{
    ::MSU <- {
        Version = ::FU.Version,
        ID = "mod_msu",
        Name = "MSU shim (via FU)",
        VanillaID = ::FU.VanillaID,
        IsShim = true,
        includeLoad = function( _prefix, _folder ) { ::FU.includeLoad(_prefix, _folder); },
        includeFile = function( _prefix, _file ) { ::FU.includeFile(_prefix, _file); },
        includeFiles = function( _files, _includeLoad = false ) { ::FU.includeFiles(_files, _includeLoad); }
    };
}

// Core namespace mappings (once FU systems/UI are available)
if ("System" in ::FU) ::MSU.System <- ::FU.System;
if ("Mod" in ::FU) ::MSU.Mod <- ::FU.Mod;
::MSU.Class <- ::FU.Class;
if ("UI" in ::FU) ::MSU.UI <- ::FU.UI;
::MSU.Popup <- ("Popup" in ::FU ? ::FU.Popup : ::rawget(::MSU, "Popup", null));
::MSU.EndQueue <- ("EndQueue" in ::FU ? ::FU.EndQueue : ::rawget(::MSU, "EndQueue", null));

// Utilities and helpers
::MSU.Exception <- ::FU.Exception;
::MSU.Array <- ::FU.Array;
::MSU.String <- ::FU.String;
::MSU.Math <- ::FU.Math;
::MSU.Table <- ::FU.Table;
::MSU.Text <- ::FU.Text;
::MSU.TypeCheckers <- ::FU.TypeCheckers;
if ("Tile" in ::FU) ::MSU.Tile <- ::FU.Tile;
::MSU.SemVer <- ::FU.SemVer;
::MSU.Utils <- ::FU.Utils;
if ("AI" in ::FU) ::MSU.AI <- ::FU.AI;
if ("Skills" in ::FU) ::MSU.Skills <- ::FU.Skills;
if ("Key" in ::FU) ::MSU.Key <- ::FU.Key;
if ("Tile" in ::FU) ::MSU.Tile <- ::FU.Tile;
::MSU.Log <- ::FU.Log;
::MSU.Globals <- ::FU.Globals;

// Common require/checker aliases
foreach (k, v in ::FU)
{
    if (typeof v == "function" && ::FU.String.startsWith(k, "require")) ::MSU[k] <- v;
}
