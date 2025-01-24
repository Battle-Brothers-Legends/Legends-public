this.perk_legend_carnage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendCarnage);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
			return;

		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Bleeding) || _targetEntity.getSkills().hasEffect(::Legends.Effect.LegendGrazedEffect) && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			_properties.DamageRegularMin *= 1.1;
			_properties.DamageRegularMax *= 1.1;
		}
	}

	function onAdded()
	{
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			return;
		}
		if (!this.getContainer().hasSkill("actives.legend_prepare_bleed"))
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_prepare_bleed_skill"));
		}
		if (!this.getContainer().hasSkill("actives.legend_prepare_graze"))
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_prepare_graze_skill"));
		}
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.legend_prepare_bleed");
		this.getContainer().removeByID("actives.legend_prepare_graze");
	}

});
