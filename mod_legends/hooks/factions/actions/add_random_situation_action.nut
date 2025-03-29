::mods_hookExactClass("factions/actions/add_random_situation_action", function(o)
{
	o.onUpdate = function ( _faction )
	{
		this.m.Settlement = _faction.getSettlements()[this.Math.rand(0, _faction.getSettlements().len() - 1)];
		this.m.Settlement.updateSituations();

		if (this.Math.rand(1, 100) > 2)
		{
			return;
		}

		if (_faction.getType() == this.Const.FactionType.NobleHouse && !this.m.Settlement.isMilitary())
		{
			return;
		}

		if (this.m.Settlement.getSituations().len() >= 2)
		{
			return;
		}

		if (this.m.Settlement.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 10)
		{
			return;
		}

		if (this.m.Settlement.hasSituation("situation.raided") || this.m.Settlement.hasSituation("situation.conquered") || this.m.Settlement.hasSituation("situation.besieged") || this.m.Settlement.hasSituation("situation.short_on_food"))
		{
			return;
		}

		local possible_situations = [];

		if (this.World.FactionManager.isGreaterEvil())
		{
			possible_situations.push("refugees_situation");
			possible_situations.push("refugees_situation");
		}

		if (this.m.Settlement.getSize() >= 2)
		{
			possible_situations.push("warehouse_burned_down_situation");
			possible_situations.push("public_executions_situation");

			if (!this.isKindOf(this.m.Settlement, "city_state"))
			{
				possible_situations.push("cultist_procession_situation");
				possible_situations.push("archery_contest_situation");

				if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
				{
					possible_situations.push("cultist_procession_situation");
				}

				if (!this.m.Settlement.isMilitary())
				{
					possible_situations.push("collectors_situation");

					if (this.m.Settlement.hasBuilding("building.taxidermist"))
					{
						possible_situations.push("collectors_situation");
						possible_situations.push("collectors_situation");
					}
				}
			}
		}

		if (this.m.Settlement.getSize() >= 3)
		{
			if (!this.m.Settlement.hasSituation("situation.ambushed_trade_routes"))
			{
				possible_situations.push("seasonal_fair_situation");
			}
		}

		if (this.m.Settlement.getSize() >= 3 && !::MSU.isKindOf(this.m.Settlement, "city_state"))
		{
			if (this.m.Settlement.hasSituation("situation.ambushed_trade_routes") || this.m.Settlement.hasSituation("situation.abducted_children") || this.m.Settlement.hasSituation("situation.disappearing_villagers") || this.m.Settlement.hasSituation("situation.raided") || this.m.Settlement.hasSituation("situation.unhold_attacks"))
			{
				possible_situations.push("legend_rallied_militia_situation");
				possible_situations.push("legend_merc_company_disbands_situation");
			}
		}

		if (!this.m.Settlement.isMilitary())
		{
			possible_situations.push("local_holiday_situation");

			if (!this.isKindOf(this.m.Settlement, "city_state"))
			{
				possible_situations.push("witch_burnings_situation");
				possible_situations.push("sickness_situation");
			}
		}
		else
		{
			possible_situations.push("mustering_troops_situation");

			if (!this.World.FactionManager.isGreaterEvil())
			{
				possible_situations.push("disbanded_troops_situation");

				if (!this.m.Settlement.hasSituation("situation.ambushed_trade_routes"))
				{
					possible_situations.push("preparing_feast_situation");
				}
			}
		}

		if (this.isKindOf(this.m.Settlement, "legends_fishing_village") || this.isKindOf(this.m.Settlement, "small_fishing_village") || this.isKindOf(this.m.Settlement, "medium_fishing_village"))
		{
			possible_situations.push("lost_at_sea_situation");
			possible_situations.push("full_nets_situation");
		}

		if (this.isKindOf(this.m.Settlement, "legends_steppe_village") || this.isKindOf(this.m.Settlement, "legends_farming_village") || this.isKindOf(this.m.Settlement, "small_steppe_village") || this.isKindOf(this.m.Settlement, "medium_steppe_village") || this.isKindOf(this.m.Settlement, "large_steppe_village") || this.isKindOf(this.m.Settlement, "small_farming_village") || this.isKindOf(this.m.Settlement, "medium_farming_village") || this.isKindOf(this.m.Settlement, "large_farming_village") || this.isKindOf(this.m.Settlement, "city_state"))
		{
			if (!this.isKindOf(this.m.Settlement, "city_state"))
			{
				possible_situations.push("draught_situation");
			}

			possible_situations.push("good_harvest_situation");
		}

		if (this.isKindOf(this.m.Settlement, "legends_snow_village") || this.isKindOf(this.m.Settlement, "small_snow_village") || this.isKindOf(this.m.Settlement, "medium_snow_village") || this.isKindOf(this.m.Settlement, "large_snow_village"))
		{
			possible_situations.push("snow_storms_situation");
		}

		if (this.isKindOf(this.m.Settlement, "legends_mining_village") || this.isKindOf(this.m.Settlement, "small_mining_village") || this.isKindOf(this.m.Settlement, "medium_mining_village"))
		{
			possible_situations.push("mine_cavein_situation");
			possible_situations.push("rich_veins_situation");
		}

		if (this.isKindOf(this.m.Settlement, "legends_lumber_village") || this.isKindOf(this.m.Settlement, "legends_forest_fort") || this.isKindOf(this.m.Settlement, "small_lumber_village") || this.isKindOf(this.m.Settlement, "medium_lumber_village") || this.isKindOf(this.m.Settlement, "large_lumber_village") || this.isKindOf(this.m.Settlement, "small_forest_fort") || this.isKindOf(this.m.Settlement, "medium_forest_fort") || this.isKindOf(this.m.Settlement, "large_forest_fort"))
		{
			possible_situations.push("hunting_season_situation");
		}

		if (!this.m.Settlement.isSouthern() && this.m.Settlement.hasBuilding("building.temple"))
		{
			possible_situations.push("ceremonial_season_situation");
		}
		else if (this.m.Settlement.isSouthern())
		{
			possible_situations.push("sand_storm_situation");

			if (this.m.Settlement.hasBuilding("building.arena"))
			{
				if (!this.m.Settlement.hasSituation("situation.arena_tournament"))
				{
					possible_situations.push("bread_and_games_situation");
				}

				if (this.World.getTime().Days > 10 && !this.m.Settlement.hasSituation("situation.bread_and_games"))
				{
					possible_situations.push("arena_tournament_situation");
				}
			}
		}

		if (possible_situations.len() == 0)
		{
			return;
		}

		if (this.Math.rand(1, 100) <= 75 - possible_situations.len() * 25)
		{
			return;
		}

		this.m.Situation = possible_situations[this.Math.rand(0, possible_situations.len() - 1)];
		this.m.Score = 1;
	}
});
