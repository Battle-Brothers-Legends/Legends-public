this.legend_merc_company_disbands_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.legend_merc_company_disbands";
		this.m.Name = "Mercenaries For Hire";
		this.m.Description = "A mercenary company has recently disbanded, leaving their highly trained fighters to fend for themselves.";
		this.m.Icon = "ui/settlement_status/settlement_effect_30.png";
		this.m.Rumors = [
			"The battle at %settlement%? Gods, what a massacre! I heard a group \' sellswords got themselves in a tight place with somthin\' fierce. Company commander quit on the spot before the battle was even over! Lots \'o them lookin\' fer work now...",
			"There\'s a bunch of good fighters over at %settlement%, company comman\'r couldn't pay \'em so they sit all day in the square pickin\' their boots and spittin\' at people.",
			"I hear there\'s a large group of sellswords over at %settlement% without a banner to stand under. If you get there quick you might pick up a few good fighters before the Militia or Nobles do!"
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
		_modifiers.RecruitsMult *= 1.5;
	}

	function onUpdateDraftList( _draftList )
	{
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("swordmaster_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_noble") {
			_draftList.push("legend_noble_2h");
			_draftList.push("legend_noble_shield");
			_draftList.push("legend_noble_ranged");
			_draftList.push("adventurous_noble_background");
			_draftList.push("adventurous_noble_background");
			_draftList.push("hedge_knight_background");
		}
	}

});

