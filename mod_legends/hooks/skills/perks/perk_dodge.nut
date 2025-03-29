::mods_hookExactClass("skills/perks/perk_dodge", function(o) {
	o.onAdded <- function ()
	{
		::Legends.Effects.grant(this, ::Legends.Effect.Dodge);
	}

	o.onCombatStarted = function ()
	{}
});