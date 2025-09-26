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
{
    try { return ::World.State.getPlayer(); } catch (e) { return null; }
}
