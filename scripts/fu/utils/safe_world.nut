// FU safe access helpers for engine singletons (World, Assets, Tactical)
// These avoid fragile `in` checks on native-bound objects and wrap calls in try/catch.

if (!("FU" in getroottable())) ::FU <- {};
if (!("Safe" in ::FU)) ::FU.Safe <- {};

// World / Assets helpers
::FU.Safe.WorldHasStash <- function()
{
    try { return ::World.Assets.getStash() != null; } catch (e) { return false; }
}

::FU.Safe.GetStash <- function()
{
    try { return ::World.Assets.getStash(); } catch (e) { return null; }
}

::FU.Safe.HasStashSpace <- function()
{
    try {
        local s = ::World.Assets.getStash();
        return s != null && s.hasEmptySlot();
    } catch (e) { return true; }
}

::FU.Safe.InTown <- function()
{
    try { return ::World.State.getCurrentTown() != null; } catch (e) { return false; }
}

::FU.Safe.GetCurrentTown <- function()
{
    try { return ::World.State.getCurrentTown(); } catch (e) { return null; }
}

::FU.Safe.IsLegendaryDifficulty <- function()
{
    try { return ::World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary; } catch (e) { return false; }
}

// Tactical helpers
::FU.Safe.HasTacticalState <- function()
{
    try { return ::Tactical.State != null; } catch (e) { return false; }
}

::FU.Safe.InScenario <- function()
{
    try { return ::Tactical.State.isScenarioMode(); } catch (e) { return false; }
}

::FU.Safe.IsBattleEnded <- function()
{
    try { return ::Tactical.State.isBattleEnded(); } catch (e) { return false; }
}

::FU.Safe.IsAutoRetreat <- function()
{
    try { return ::Tactical.State.isAutoRetreat(); } catch (e) { return false; }
}

// Convenience
::FU.Safe.GetPlayer <- function()
{
    try { return ::World.State.getPlayer(); } catch (e) { return null; }
}

// Functional helpers (execute callback only when context exists)
// Each returns the callback's return value, or null if not executed

::FU.Safe.WithStash <- function( _fn )
{
    try {
        local s = ::World.Assets.getStash();
        if (s != null) return _fn(s);
    } catch (e) {}
    return null;
}

::FU.Safe.WithCurrentTown <- function( _fn )
{
    try {
        local t = ::World.State.getCurrentTown();
        if (t != null) return _fn(t);
    } catch (e) {}
    return null;
}

::FU.Safe.WithPlayer <- function( _fn )
{
    try {
        local p = ::World.State.getPlayer();
        if (p != null) return _fn(p);
    } catch (e) {}
    return null;
}

::FU.Safe.WithTacticalState <- function( _fn )
{
    try {
        if (::Tactical.State != null) return _fn(::Tactical.State);
    } catch (e) {}
    return null;
}

// Expose convenience aliases at ::FU for succinct usage in ifs
::FU.WorldHasStash <- ::FU.Safe.WorldHasStash;
::FU.GetStash <- ::FU.Safe.GetStash;
::FU.HasStashSpace <- ::FU.Safe.HasStashSpace;
::FU.InTown <- ::FU.Safe.InTown;
::FU.GetCurrentTown <- ::FU.Safe.GetCurrentTown;
::FU.IsLegendaryDifficulty <- ::FU.Safe.IsLegendaryDifficulty;
::FU.HasTacticalState <- ::FU.Safe.HasTacticalState;
::FU.InScenario <- ::FU.Safe.InScenario;
::FU.IsBattleEnded <- ::FU.Safe.IsBattleEnded;
::FU.IsAutoRetreat <- ::FU.Safe.IsAutoRetreat;
::FU.GetPlayer <- ::FU.Safe.GetPlayer;

// Functional alias shorthands
::FU.WithStash <- ::FU.Safe.WithStash;
::FU.WithCurrentTown <- ::FU.Safe.WithCurrentTown;
::FU.WithPlayer <- ::FU.Safe.WithPlayer;
::FU.WithTacticalState <- ::FU.Safe.WithTacticalState;
