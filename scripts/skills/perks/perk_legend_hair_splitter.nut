this.perk_legend_hair_splitter <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendHairSplitter);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onUpdate( _properties )
	{
		// this.character_background.onUpdate(_properties); //(i dont think this should be here at all? leaving it in case it should be something else?)
		_properties.HitChance[this.Const.BodyPart.Head] += 30;
	}

});

