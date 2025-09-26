::Legends.isLegendaryDifficulty <- function() {
local isLegendary = false;
try
{
    if (::World != null && ::World.Assets != null)
    {
        isLegendary = (::World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary);
    }
}
catch (e)
{
    isLegendary = false;
}
return isLegendary;
}
