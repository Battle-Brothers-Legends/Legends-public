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

    // Early add of MSU.Registry ModSourceDomain.GitHubTags and class if missing
    if ("System" in ::MSU && "Registry" in ::MSU.System)
    {
        local domain = ::MSU.System.Registry.ModSourceDomain;
        try { if ("add" in domain && (function(){ try { domain["GitHubTags"]; return true; } catch(e) { return false; } }()) == false) domain.add("GitHubTags"); } catch(e) {}

        if (!("ModSourceGitHubTags" in ::MSU.Class))
        {
            ::MSU.Class.ModSourceGitHubTags <- class extends ::MSU.Class.ModSource
            {
                static ModSourceDomain = (function(){ try { return ::MSU.System.Registry.ModSourceDomain.GitHubTags; } catch(e) { return ::MSU.System.Registry.ModSourceDomain.GitHub; } })();
                static Regex = regexp("https:\\/\\/github\\.com\\/([-\\w]+)\\/([-\\w]+)");
                constructor( _url )
                {
                    if (!this.Regex.match(_url))
                    {
                        ::logError("A GitHub link must be a link to a specific repository, e.g. 'https://github.com/org/repo'");
                        throw ::MSU.Exception.InvalidValue(_url);
                    }
                    base.constructor(_url);
                }
                function getUpdateURL()
                {
                    local capture = this.Regex.capture(this.__URL);
                    local owner = ::MSU.regexMatch(capture, this.__URL, 1);
                    local repo = ::MSU.regexMatch(capture, this.__URL, 2);
                    return "https://api.github.com/repos/" + owner + "/" + repo + "/tags";
                }
            };
        }
        try { ::MSU.System.Registry.addNewModSource(::MSU.Class.ModSourceGitHubTags); } catch(e) {}
    }

    // Early minimal MSU.Serialization shim if needed
    if (!("Serialization" in ::MSU))
    {
        ::MSU.Serialization <- {
            serialize = function( _object, _out )
            {
                if (!("Utils" in ::FU))
                {
                    throw "MSU.Serialization.serialize called before FU.Utils is available";
                }
                ::FU.Utils.serialize(_object, _out);
            },
            deserialize = function( _in )
            {
                if (!("Utils" in ::FU))
                {
                    throw "MSU.Serialization.deserialize called before FU.Utils is available";
                }
                return ::FU.Utils.deserialize(_in);
            },
            deserializeInto = function( _object, _in )
            {
                if (!("Utils" in ::FU))
                {
                    throw "MSU.Serialization.deserializeInto called before FU.Utils is available";
                }
                return ::FU.Utils.deserializeInto(_object, _in);
            }
        };
    }
}
