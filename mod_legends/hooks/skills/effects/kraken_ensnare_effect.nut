::mods_hookExactClass("skills/effects/kraken_ensnare_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		local tooltip = "Unable to move or use skills";
		if (this.m.Mode == 0) {
			function getActorHoverTooltip(_activeEntity, _stacks = 1) {
				tooltip += " [color=%negative%]10[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
			}
		}
		return tooltip;
	}
});
