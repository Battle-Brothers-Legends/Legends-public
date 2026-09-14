this.perk_legend_become_berserker <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBecomeBerserker);
	}

	function onAdded()
	{


		local actor = this.getContainer().getActor();
		local originalbackground = actor.getBackground().getID();
		local newbackground = ::Legends.Backgrounds.new(::Legends.Background.LegendBerserker);
		actor.getSkills().removeByID(originalbackground);
		actor.getSkills().add(newbackground);
	}


});
