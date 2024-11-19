::mods_hookExactClass("entity/world/settlements/situations/unhold_attacks_situation", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Large Unholds have been seen and heard in the area. The townsfolk are scared of leaving the vicinity of the settlement. Beast Slayers and Sellswords have shown up offering to slay these giants in exchange for coin.";
		this.m.Rumors = [
			"A traveling merchant told me about giant footprints near the road from %settlement%. Sure as hell would not want to meet whatever beast left those!",
			"When I was in %settlement% the other day, a group of hunters went missing. They were after some sort of giant...",
			"Ever heard of unholds? Huge monsters that stomp whole carts under a foot! I heard rumors of sightings near %settlement%.",
			"Only a fool would go seeking after the unholds that attacked %settlement% recently. You couldn\'t pay me enough to do it, that\'s for sure!"
		];
	}

	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		}
		onAdded(_settlement)
	}

	o.onResolved <- function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
		}
		_settlement.resetRoster(true);

		if (::Math.rand(1,10)==1)
		{
			_settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1,3));
		}
	}

	o.onUpdateDraftList <- function ( _draftList, _gender = null)
	{
		if  (this.World.Assets.getOrigin().getID() == "scenario.legends_necro" || this.World.Assets.getOrigin().getID() == "scenario.legends_solo_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}

		if  ( this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
		}

		_draftList.push("beast_hunter_background");
		_draftList.push("beast_hunter_background");
		_draftList.push("beast_hunter_background");
		_draftList.push("beast_hunter_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
	}
});
