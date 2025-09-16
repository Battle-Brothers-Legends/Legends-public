::mods_hookExactClass("states/main_menu_state", function(o)
{

	o.onSiblingAdded = function ( _stateName )
	{
		if (_stateName == "TacticalState")
		{
			local tacticalState = this.RootState.get(_stateName);

			if (tacticalState != null)
			{


				switch(this.m.SelectedScenarioID)
				{
				case 0:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_combat_basics"));
					break;

				case 1:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_swipe"));
					break;

				case 2:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_defend_the_hill"));
					break;

				case 3:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_advanced_combat"));
					break;

				case 4:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_early_game"));
					break;

				case 6:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_line_battle"));
					break;

				case 7:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_vampire_hunt"));
					break;

				case 8:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_canyon"));
					break;

				case 9:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_line_battle_orcs"));
					break;

				case 10:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_line_battle_goblins"));
					break;

				case 12:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_line_battle_nobles"));
					break;


				case 13:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_wolfriders"));
					break;

				case 14:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_line_battle_lindwurm"));
					break;

				case 15:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_ghouls"));
					break;

				case 16:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_archers"));
					break;

				case 20:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_test_bed"));
					break;

				case 21:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_test_bed_orc"));
					break;

				case 22:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/scenario_test_bed_human"));
					break;

				case 30:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_skin_ghoul"));
					break;

				case 31:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_redback_spider"));
					break;

				case 32:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_line_battle_stollwurm"));
					break;

				case 33:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_hexe_leader"));
					break;

				case 34:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_white_wolf"));
					break;

				case 35:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_demon_alp"));
					break;

				case 36:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_rock_unhold"));
					break;

				case 37:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_banshee"));
					break;

				case 38:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_vampire_lord"));
					break;

				case 39:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_demon_hound"));
					break;

				case 40:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_wall_battle"));
					break;

				case 41:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_basilisks"));
					break;

				case 42:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_enraged_hyena"));
					break;

				default:
					tacticalState.setScenario(this.new("scripts/scenarios/tactical/legend_scenario_combat_basics"));
					break;
				}
			}
		}
		else if (_stateName == "WorldState")
		{
			local worldState = this.RootState.get(_stateName);

			if (worldState != null)
			{
				if (this.m.SelectedCampaignFileName != null)
				{
					worldState.setCampaignToLoadFileName(this.m.SelectedCampaignFileName);
					this.m.SelectedCampaignFileName = null;
				}
				else if (this.m.NewCampaignSettings != null)
				{
					worldState.setNewCampaignSettings(this.m.NewCampaignSettings);
					this.m.NewCampaignSettings = null;
				}
			}
		}
	}

	o.scenario_menu_module_onQueryData = function ()
	{

		local result = [
			{
				id = 42,
				name = "Enraged Hyenas (Legendary)",
				description = "[p=c][img]gfx/ui/events/legend_enraged_hyena.png[/img][/p]\n[p=c]Face a dozen raging hyenas.[/p]"
			},
			{
				id = 41,
				name = "Basilisks",
				description = "[p=c][img]gfx/ui/events/event_05.png[/img][/p]\n[p=c]Fight against Basilisk Drones[/p]"
			},
			{
				id = 39,
				name = "Höllenhunds (Legendary)",
				description = "[p=c][img]gfx/ui/events/event_57.png[/img][/p]\n[p=c]Undead demon hounds[/p]"
			},
			{
				id = 38,
				name = "Necrosavant Lords (Legendary)",
				description = "[p=c][img]gfx/ui/events/legend_vampire.png[/img][/p]\n[p=c]Necrosavant Lords[/p]"
			},
			{
				id = 37,
				name = "Banshees (Legendary)",
				description = "[p=c][img]gfx/ui/events/event_09.png[/img][/p]\n[p=c]Nightmares become reality[/p]"
			},
			{
				id = 30,
				name = "Skin Ghouls (Legendary)",
				description = "[p=c][img]gfx/ui/events/legend_skin_ghoul.png[/img][/p]\n[p=c]Head to head vs the creepy naked beasties[/p]"
			},
			{
				id = 31,
				name = "Redback Spiders (Legendary)",
				description = "[p=c][img]gfx/ui/events/legend_redback.png[/img][/p]\n[p=c]Defend yourself from the deadly arachnids[/p]"
			},
			{
				id = 34,
				name = "White Wolf (Legendary)",
				description = "[p=c][img]gfx/ui/events/legend_white_wolf.png[/img][/p]\n[p=c]A brutal battle against a pack led by the white wolf[/p]"
			},
			{
				id = 36,
				name = "Rock Unhold (Legendary)",
				description = "[p=c][img]gfx/ui/events/legend_rock_unhold.png[/img][/p]\n[p=c]Toe to toe with a living mountain[/p]"
			},
			{
				id = 14,
				name = "Heartwood Schrats (Legendary)",
				description = "[p=c][img]gfx/ui/events/legend_heartwood.png[/img][/p]\n[p=c]It is just one tree, how bad could it be?[/p]"
			},
			{
				id = 35,
				name = "Demon Alps (Legendary)",
				description = "[p=c][img]gfx/ui/events/legend_demonalp.png[/img][/p]\n[p=c]Nightmares become reality[/p]"
			},
			{
				id = 32,
				name = "Stollwurm (Legendary)",
				description = "[p=c][img]gfx/ui/events/legend_stollwurm.png[/img][/p]\n[p=c]The ground is no ally, the beast approaches[/p]"
			},
			{
				id = 33,
				name = "The Coven (Legendary)",
				description = "[p=c][img]gfx/ui/events/legend_hexe_leader.png[/img][/p]\n[p=c]A witch approaches.[/p]"
			},
			{
				id = 9,
				name = "Orc Battle(Legendary)",
				description = "[p=c][img]gfx/ui/events/event_49.png[/img][/p]\n[p=c]ORC ORC ORC ORC ORC ORC. Difficult.[/p]"
			},
			{
				id = 0,
				name = "Combat Basics",
				description = "[p=c][img]gfx/ui/events/event_28.png[/img][/p]\n[p=c]A simple scenario to learn combat basics. Easy.[/p]"
			},
			{
				id = 1,
				name = "Swipe",
				description = "[p=c][img]gfx/ui/events/event_133.png[/img][/p]\n[p=c]Few and easy opponents all over a map with lots of terrain features blocking sight. Well suited to get used to lines of sight, fog of war and ranged combat. Easy.[/p]"
			},
			{
				id = 4,
				name = "Early Game",
				description = "[p=c][img]gfx/ui/events/event_09.png[/img][/p]\n[p=c]A possible early game encounter in enemy composition and equipment available. Moderate difficulty.[/p]"
			},
			{
				id = 15,
				name = "Defend the Hill",
				description = "[p=c][img]gfx/ui/events/event_22.png[/img][/p]\n[p=c]Survive against overwhelming odds while positioned on top of a hill. Well suited to learn about height advantage and to test sight and usability issues with height levels. Difficult.[/p]"
			},
			{
				id = 6,
				name = "Line Battle (Undead)",
				description = "[p=c][img]gfx/ui/events/event_143.png[/img][/p]\n[p=c]Featuring two battle lines pitted against each other in close combat from the start. Difficult.[/p]"
			},
			{
				id = 10,
				name = "Line Battle (Goblins)",
				description = "[p=c][img]gfx/ui/events/event_48.png[/img][/p]\n[p=c]Featuring two battle lines pitted against each other in close combat from the start. Difficult.[/p]"
			},
			{
				id = 12,
				name = "Noble Camp (Legendary)",
				description = "[p=c][img]gfx/ui/events/event_05.png[/img][/p]\n[p=c]Try out against the new noble troops. Very Difficult.[/p]"
			},
			{
				id = 13,
				name = "Wolfriders",
				description = "[p=c][img]gfx/ui/events/event_60.png[/img][/p]\n[p=c]Defend against a pack of vicious Goblin Wolfriders. Don\'t let them encircle you! Moderate difficulty.[/p]"
			},
			{
				id = 3,
				name = "A Walk in the Woods",
				description = "[p=c][img]gfx/ui/events/event_127.png[/img][/p]\n[p=c]A possible late game encounter in enemy composition and equipment available. Difficult.[/p]"
			},
			{
				id = 40,
				name = "Camp battle (Experiment)",
				description = "[p=c][img]gfx/ui/events/event_05.png[/img][/p]\n[p=c]Taking the fight to an enemy may come with disadvantages, trial of wall combat[/p]"
			}
		];

		if (!this.isReleaseBuild())
		{
			result.push({
				id = 20,
				name = "Test",
				description = "[p=c]An empty map for AI testing. Spawn combatants manually and let them fight it out.[/p]"
			});
		}

		return result;
	}
});
