this.perk_legend_promised_potential <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPromisedPotential);
	}

	function onUpdate(_properties)
	{
		local actor = this.getContainer().getActor();
		if (actor.m.Type != ::Const.EntityType.Player)
			return;
		local talents = actor.getTalents();
		if (talents.len() == 0)
			return;

		_properties.Hitpoints += ::Math.max(1, talents[::Const.Attributes.Hitpoints] * 2);
		_properties.Bravery += ::Math.max(1, talents[::Const.Attributes.Bravery] * 2);
		_properties.Stamina += ::Math.max(1, talents[::Const.Attributes.Fatigue] * 2);
		_properties.Initiative += ::Math.max(1, talents[::Const.Attributes.Initiative] * 2);
		_properties.MeleeSkill += ::Math.max(1, talents[::Const.Attributes.MeleeSkill] * 2);
		_properties.RangedSkill += ::Math.max(1, talents[::Const.Attributes.RangedSkill] * 2);
		_properties.MeleeDefense += ::Math.max(1, talents[::Const.Attributes.MeleeDefense] * 2);
		_properties.RangedDefense += ::Math.max(1, talents[::Const.Attributes.RangedDefense] * 2);
	}
});
