this.legend_reload_ally_handgonne_skill <- this.inherit("scripts/skills/actives/legend_reload_ally_skill", {
	m = {
		ApplicableSkill = "actives.reload_handgonne"
	},
	function create()
	{
		this.legend_reload_ally_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendReloadAllyHandgonne);
		this.m.Description = "Make yourself helpful and reload an ally\'s handgonne. You\'ll need to use your own ammunition.";
		this.m.Icon = "skills/active_204.png";
		this.m.IconDisabled = "skills/active_204_sw.png";
		this.m.Overlay = "active_204";
		this.m.SoundOnUse = [
			"sounds/combat/dlc6/reload_gonne_01.wav",
			"sounds/combat/dlc6/reload_gonne_02.wav"
		];
		this.m.ActionPointCost = 9;
	}

	function onAfterUpdate( _properties )
	{
		this.legend_reload_ally_skill.onAfterUpdate( _properties )
		if (_properties.IsSpecializedInCrossbows)
		{
			this.ActionPointCost -= 2;	
		}
	}
});

