this.perk_legend_hex <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendHex);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = true;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendHex))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_hex_skill"));
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendHex);
	}

});
