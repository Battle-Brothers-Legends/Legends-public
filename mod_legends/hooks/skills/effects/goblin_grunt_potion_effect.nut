::mods_hookExactClass("skills/effects/goblin_grunt_potion_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Rotation and Footwork: " + ::Legends.S.inlineIcon("action_points") + " set to [color=%positive%]2[/color], [color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("fatigue") + "cost";
	}
});
