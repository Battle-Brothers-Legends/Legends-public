this.legend_reload_ally_bolt_skill <- this.inherit("scripts/skills/actives/legend_reload_ally_skill", {
	m = {
		ApplicableSkill = "actives.reload_bolt",

	},
	function create()
	{
		this.legend_reload_ally_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendReloadAllyBolt);
		this.m.Description = "Make yourself helpful and reload an ally\'s crossbow. You\'ll need to use your own ammunition.";
		this.m.Icon = "skills/active_16.png";
		this.m.IconDisabled = "skills/active_16_sw.png";
		this.m.Overlay = "active_16";
		this.m.SoundOnUse = [
			"sounds/combat/reload_01.wav",
			"sounds/combat/reload_02.wav"
		];
		this.m.ActionPointCost = 6;
	}
});
