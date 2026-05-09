this.legend_heartseeker_javelin_skill <- ::inherit("scripts/skills/actives/throw_javelin", {
	m = {},
	function create() {
		this.throw_javelin.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHeartseekerJavelin);
		this.m.Description = "Put your full weight in a throw, targetting the enemy\'s weakpoints and inflicting terrible injuries.";
		this.m.KilledString = "Pierced";
		this.m.Icon = "skills/active_legend_heartseeker.png";
		this.m.IconDisabled = "skills/active_legend_heartseeker_bw.png";
		this.m.Overlay = "active_legend_heartseeker";
		this.m.SoundOnUse = [
			"sounds/combat/javelin_throw_01.wav",
			"sounds/combat/javelin_throw_02.wav",
			"sounds/combat/javelin_throw_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/javelin_hit_01.wav",
			"sounds/combat/javelin_hit_03.wav"
		];
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.ChanceDisembowel = 75;
	}

	function getTooltip() {
		local ret = this.throw_javelin.getTooltip();

		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=%damage%]30%[/color] damage increase if the target is wounded"
		});

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.throw_javelin.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (_skill != this)
			return;

		if (_targetEntity != null && _targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			_properties.DamageTotalMult *= 1.3;
	}
});
