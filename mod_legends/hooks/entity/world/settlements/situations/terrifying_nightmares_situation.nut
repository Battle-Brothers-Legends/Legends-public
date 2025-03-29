::mods_hookExactClass("entity/world/settlements/situations/terrifying_nightmares_situation", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The people of this settlement are terrorized by nightmares. Many prefer to stay awake all night just to be safe. The local townsfolk have called in Witch Hunters and Beast Slayers alike, desperately hoping for either group to put an end to their terrors. Upon resolution this will refresh the hiring roster in town.";
		this.m.Rumors.push("A Witch Hunter and a Beast Hunter walked in yesterday - No! This isn\'t a joke! Anyway the two were arguing over how best to kill a monster that haunts your dreams. I would avoid %settlement% if I were you.");
	}

	o.onAdded <- function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		
		_settlement.resetRoster(true);
	}

	o.onResolved <- function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
		
		_settlement.resetRoster(true);

		if (::Math.rand(1,10)==1)
			_settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1,3));
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		if ( this.World.Assets.getOrigin().getID() == "scenario.militia") {
			_draftList.push("legend_nightwatch_background");
			_draftList.push("legend_nightwatch_background");
			_draftList.push("legend_nightwatch_background");
			_draftList.push("legend_man_at_arms_background");
		}

		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("beast_hunter_background");
		_draftList.push("beast_hunter_background");

	}
});
