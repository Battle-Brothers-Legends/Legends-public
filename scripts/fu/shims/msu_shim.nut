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
::MSU.Popup <- ("Popup" in ::FU ? ::FU.Popup : (("MSU" in getroottable() && "Popup" in ::MSU) ? ::MSU.Popup : null));
::MSU.EndQueue <- ("EndQueue" in ::FU ? ::FU.EndQueue : (("MSU" in getroottable() && "EndQueue" in ::MSU) ? ::MSU.EndQueue : null));

// Utilities and helpers
if ("Exception" in ::FU) ::MSU.Exception <- ::FU.Exception;
if ("Array" in ::FU) ::MSU.Array <- ::FU.Array;
if ("String" in ::FU) ::MSU.String <- ::FU.String;
if ("Math" in ::FU) ::MSU.Math <- ::FU.Math;
if ("Table" in ::FU) ::MSU.Table <- ::FU.Table;
if ("Text" in ::FU) ::MSU.Text <- ::FU.Text;
if ("TypeCheckers" in ::FU) ::MSU.TypeCheckers <- ::FU.TypeCheckers;
if ("Tile" in ::FU) ::MSU.Tile <- ::FU.Tile;
if ("SemVer" in ::FU) ::MSU.SemVer <- ::FU.SemVer;
if ("Utils" in ::FU) ::MSU.Utils <- ::FU.Utils;
if ("AI" in ::FU) ::MSU.AI <- ::FU.AI;
if ("Skills" in ::FU) ::MSU.Skills <- ::FU.Skills;
if ("Key" in ::FU) ::MSU.Key <- ::FU.Key;
if ("Tile" in ::FU) ::MSU.Tile <- ::FU.Tile;
if ("Log" in ::FU) ::MSU.Log <- ::FU.Log;
if ("Globals" in ::FU) ::MSU.Globals <- ::FU.Globals;

// Common require/checker aliases
foreach (k, v in ::FU)
{
    if (typeof v == "function" && ::FU.String.startsWith(k, "require")) ::MSU[k] <- v;
}

// Provide minimal MSU.Serialization API via FU for drop-in compatibility
// Do not override if a real MSU.Serialization exists
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

// Provide MSU.Registry ModSourceDomain.GitHubTags and class if missing (compat for submods)
if ("System" in ::MSU && "Registry" in ::MSU.System)
{
    local domain = ::MSU.System.Registry.ModSourceDomain;
    // Add enum key if supported and missing
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
                // Use tags endpoint as requested by some submods
                return "https://api.github.com/repos/" + owner + "/" + repo + "/tags";
            }
        };
    }
    // Register source class if not present
    try { ::MSU.System.Registry.addNewModSource(::MSU.Class.ModSourceGitHubTags); } catch(e) {}
}

// Align MSU.Serialization meta naming across versions (some mods expect SerializationMetaData)
if ("UI" in ::FU && "addOnConnectCallback" in ::FU.UI)
{
    ::FU.UI.addOnConnectCallback(function(){
        try
        {
            if ("MSU" in getroottable() && "System" in ::MSU && "Serialization" in ::MSU.System)
            {
                local s = ::MSU.System.Serialization;
                if (("MetaData" in s) && !("SerializationMetaData" in s)) s.SerializationMetaData <- s.MetaData;
            }
        }
        catch(e) {}
    });
}
