::mods_hookExactClass("skills/perks/perk_dodge", function(o) {
	o.onAdded <- function ()
	{
		::Legends.Effects.grant(this, ::Legends.Effect.Dodge, function (_skill) {
			_skill.m.NormalBonus = this.getContainer().getActor().isPlayerControlled() ? true : false;
		}.bindenv(this));
	}

	o.onCombatStarted = function ()
	{}
});