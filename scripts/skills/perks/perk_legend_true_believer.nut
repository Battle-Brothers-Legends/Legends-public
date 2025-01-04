this.perk_legend_true_believer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendTrueBeliever);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByFleeingAllies = false;
		_properties.IsAffectedByDyingAllies = false;
		local bonus = this.getFleeing() * 0.05;
		_properties.BraveryMult += bonus;

	}

	function getFleeing()
	{
		if (!("Entities" in this.Tactical))
		{
			return 0;
		}
		if (this.Tactical.Entities == null)
		{
			return 0;
		}

		if (!this.Tactical.isActive())
		{
			return 0;
		}

		local fleeing = 0;

		local actors = this.Tactical.Entities.getAllInstancesAsArray();

		foreach( a in actors )
		{
			if (a.getMoraleState() == this.Const.MoraleState.Fleeing)
			{
				fleeing += 1;

			}

		}
		return fleeing;
	}

	function onAdded()
	{
		if (this.m.Container.hasSkill("trait.superstitious"))
		{
			this.m.Container.removeByID("trait.superstitious");
		}
		if (this.m.Container.hasSkill("trait.dastard"))
		{
			this.m.Container.removeByID("trait.dastard");
		}
		if (this.m.Container.hasSkill("trait.insecure"))
		{
			this.m.Container.removeByID("trait.insecure");
		}
		if (this.m.Container.hasSkill("trait.craven"))
		{
			this.m.Container.removeByID("trait.craven");
		}
	}
});
