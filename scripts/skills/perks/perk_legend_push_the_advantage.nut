this.perk_legend_push_the_advantage <- this.inherit("scripts/skills/skill", {
	m = {
		HighBonus = [
			::Legends.Effect.Debilitated,
			::Legends.Effect.LegendTackled
		],
		LowBonus = [
			::Legends.Effect.Dazed,
			::Legends.Effect.Distracted,
			::Legends.Effect.LegendBaffled,
			::Legends.Effect.LegendParried,
			::Legends.Effect.LegendGrappled,
			::Legends.Effect.Net,
			::Legends.Effect.Rooted,
			::Legends.Effect.Shellshocked,
			::Legends.Effect.Sleeping,
			::Legends.Effect.Staggered,
			::Legends.Effect.Stunned,
			::Legends.Effect.Web,
			::Legends.Effect.Withered
		]
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPushTheAdvantage);
		this.m.Icon = "ui/perks/onslaught_circle.png";
		this.m.IconDisabled = "ui/perks/onslaught_circle_bw.png";
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if ( _targetEntity != null && this.calculateBonus(_targetEntity) != 0)
		{
			this.spawnIcon("perk_16", this.getContainer().getActor().getTile());
		}
	}

	function calculateBonus ( _targetEntity )
	{

		local bonus = 0;

		if (_targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
		{
			bonus += 20;
		}
		else
		{
			foreach (effect in this.m.HighBonus)
			{
				if (_targetEntity.getSkills().hasEffect(effect))
				{
					bonus += 20;
					break;
				}
			}
		}

		foreach (effect in this.m.LowBonus)
		{
			if (_targetEntity.getSkills().hasEffect(effect))
			{
				bonus += 10;
				break;
			}
		}

		return bonus;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
			return;

		local bonus = this.calculateBonus(_targetEntity);
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.01 * bonus;
		_properties.HitChance[this.Const.BodyPart.Head] += bonus;
	}
});
