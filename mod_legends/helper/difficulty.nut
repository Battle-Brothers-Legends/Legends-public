::Legends.isLegendaryDifficulty <- function() {
	return ("Assets" in ::World) && ::World.Assets != null && ::World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary;
}
