this.legend_brothers_in_chains_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendBrothersInChains);
		this.m.Name = "United in Chains";
		this.m.Icon = "ui/settlement_status/settlement_effect_40.png";
		this.m.Description = "This character has formed a bond with other former slaves. For every other Indebted on the field, this character gets [color=%positive%]+1[/color] Melee Skill, Ranged Skill, Melee Defense, Ranged Defense, and Resolve.";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onCombatStarted()
	{
		::Legends.Effects.grant(this, ::Legends.Effect.LegendBrothersInChains);
		this.m.IsHidden = true;
	}

	function onCombatFinished()
	{
		::Legends.Effects.remove(this, ::Legends.Effect.LegendBrothersInChains);
		this.m.IsHidden = false;
	}

});

