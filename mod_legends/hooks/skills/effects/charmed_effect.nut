::mods_hookExactClass("skills/effects/charmed_effect", function(o) {

	o.getDescription = function()
	{
		return "This character has been charmed, and no longer has any control over their actions and is a puppet that has no choice but to obey a master. Wears off in [color=%negative%]" + this.m.TurnsLeft + "[/color] turn(s).\n\nThe higher a character\'s resolve, the higher the chance to resist being charmed.";
	}
});
