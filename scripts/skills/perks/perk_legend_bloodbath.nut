this.perk_legend_bloodbath <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBloodbath);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function isHidden()
	{
		return this.getBleeders() == 0;
	}

	function getTooltip()
	{
		local count = this.getBleeders();
		local tooltip = this.skill.getTooltip();
		if (count > 0)
		{
			tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "Gain an additional [color=" + this.Const.UI.Color.PositiveValue + "]+" + count + "%[/color] Melee Skill"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Gain an additional [color=" + this.Const.UI.Color.PositiveValue + "]+" + count + "%[/color] Ranged Skill"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.min(count, 5) + "%[/color] Fatigue Recovery per turn"
			}]);
		}

		return tooltip;
	}

	function getBleeders()
	{
		if (!("Entities" in this.Tactical))
			return 0;

		if (this.Tactical.Entities == null)
			return 0;

		if (!this.Tactical.isActive())
			return 0;

		local myself = this.getContainer().getActor();
		local myTile = myself.getTile();

		local bonus = ::Tactical.Entities.getAllInstancesAsArray()
			.filter(@(_, _actor) !::Legends.S.skillEntityAliveCheck(_actor) && !_actor.isAlliedWith(myself) && _actor.getTile() != null && _actor.getSkills() != null)
			.filter(@(_, _actor) _actor.getSkills().hasEffect(::Legends.Effect.Bleeding) || _actor.getSkills().hasEffect(::Legends.Effect.LegendGrazedEffect)  || _actor.getSkills().hasSkillOfType(::Const.SkillType.TemporaryInjury))
			.map(@(_actor) myTile.getDistanceTo(_actor.getTile()) > 1 ? 1 : 2)
			.reduce(@(a, b) a + b);
		if (bonus == null)
			return 0;
		return bonus;
	}

	function onUpdate( _properties )
	{
		local count = this.getBleeders();
		_properties.Bravery += count;
		_properties.FatigueRecoveryRate += this.Math.min(5, count);
		_properties.MeleeSkill += count;
		_properties.RangedSkill += count;
	}

});

