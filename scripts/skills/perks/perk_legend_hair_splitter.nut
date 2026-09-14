this.perk_legend_hair_splitter <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHairSplitter);
	}


	function onUpdate( _properties )
	{
		// this.character_background.onUpdate(_properties); //(i dont think this should be here at all? leaving it in case it should be something else?)
		_properties.HitChance[this.Const.BodyPart.Head] += 30;
	}

});

