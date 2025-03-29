this.legend_rallied_militia_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.legend_rallied_militia";
		this.m.Name = "Rallied Militia";
		this.m.Description = "The local militia has banded togeather with new recruits to deal with some of the local problems themselves. At a great cost.";
		this.m.Icon = "ui/settlement_status/settlement_effect_07.png";
		this.m.Rumors = [
			"I recently got out of the militia at %settlement%. Big battle. Lots of blood. No problems there now but it still drags on my mind...",
			"You headed to %settlement%? Don\'t bother. The locals got tired of waitin\' for you lot to appear and took matters into their own \'ands.",
			"Word is %settlement% cobbled togeather enough crowns to solve their problems. Shame you weren\'t there to find the easy work. A lot of folks died in those fights."
		];
	}

	function onAdded( _settlement ) //most bad events except the major ones.
	{
		_settlement.resetRoster(true);
		_settlement.removeSituationByID("situation.ambushed_trade_routes");
		_settlement.removeSituationByID("situation.abducted_children");
		_settlement.removeSituationByID("situation.disappearing_villagers");
		_settlement.removeSituationByID("situation.raided");
		_settlement.removeSituationByID("situation.unhold_attacks");
	}

	function onUpdate( _modifiers )
	{
		_modifiers.RecruitsMult *= 1.3;
	}

	function onUpdateDraftList( _draftList )
	{
		for (local i = 0; i < 15; ++i)
		{
			_draftList.push("militia_background");
		}

		if  (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			for (local i = 0; i < 6; ++i)
			{
				_draftList.push("legend_man_at_arms_background");
			}
		}

	}

});

