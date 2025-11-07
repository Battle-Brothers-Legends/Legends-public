this.perk_legend_hippology <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHippology);
	}

	function onAdded()
	{
		getContainer().getActor().getFlags().set("HasVeterinarian", true);
	}

	function onRemoved()
	{
		getContainer().getActor().getFlags().remove("HasVeterinarian");
	}

});

