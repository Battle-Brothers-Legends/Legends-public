::mods_hookExactClass("entity/world/settlements/situations/besieged_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.25);
		}
		onAdded( _settlement );
	}

	o.onResolved <- function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.4);
		}
	}

	o.onUpdateDraftList <- function ( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("gravedigger_background");
		_draftList.push("beggar_background");
		_draftList.push("beggar_background");
		_draftList.push("deserter_background");
		_draftList.push("militia_background");

		if  (this.World.Assets.getOrigin().getID() == "scenario.legends_necro" || this.World.Assets.getOrigin().getID() == "scenario.legends_solo_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}

		if  ( this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
		}

		if(this.LegendsMod.Configs().LegendMagicEnabled())
		{
			local r;
			if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_seer")
			{
			r = this.Math.rand(0, 2);
				if (r == 1)
				{
				 _draftList.push("legend_death_summoner_background");
				}
			}
			else
			{
			r = this.Math.rand(0, 5);
				if (r == 1)
				{
				  _draftList.push("legend_death_summoner_background");
				}
			}

			if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_warlock")
			{

			 	_draftList.push("legend_death_summoner_background");

			}
		}
	}
});
