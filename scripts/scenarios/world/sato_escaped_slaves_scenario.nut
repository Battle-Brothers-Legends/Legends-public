this.sato_escaped_slaves_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.sato_escaped_slaves";
		this.m.Name = "Escaped Slaves";
		this.m.Description = "[p=c][img]gfx/ui/events/event_166.png[/img][/p][p]You lead a group of slaves trying to escape their cruel fate, but you cannot run forever. Can you keep your band intact and start a new life as mercenaries?\n\n[color=#bcad8c]Escapees:[/color] Start with five escaped Indebted and find others held in captivity.\n[color=#bcad8c]Brothers in Chains:[/color] Your newfound family of Indebted are stronger together and gain skill based on how many you field.\n[color=#bcad8c]Downtrodden and Discarded:[/color] Good relations with any faction decay 15% faster and bad relations recover 15% slower.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 120;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(12);
	}

	function isValid()
	{
		return this.Const.DLC.Desert;
	}

	function onInit()
	{
		this.starting_scenario.onInit();
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 5; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			i = ++i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"slave_background"
		]);
		bros[0].getBackground().m.RawDescription = "%name% was a sellsword like yourself before being enslaved and made a pit fighter. The arena was where you first met, the two of you saving each other several times in a bout against an unhold. You have been as close as siblings ever since. When you escaped, %name% was the first to pick up arms and follow and you know %name% will be the last to put them down, too.";
		bros[0].getBackground().buildDescription(true);
		bros[0].setPlaceInFormation(1);
		bros[0].addLightInjury();
		bros[0].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		this.setRetireText(bros[0]);
		local skills = bros[0].getSkills();
		skills.removeByID("trait.dastard");
		skills.removeByID("trait.craven");
		skills.removeByID("trait.fainthearted");
		skills.removeByID("trait.insecure");
		skills.removeByID("trait.fragile");

		if (bros[0].getBaseProperties().Bravery <= 30)
		{
			bros[0].getBaseProperties().Bravery += 5;
		}

		::Legends.Traits.grant(bros[0], ::Legends.Trait.LegendBrothersInChains);
		::Legends.Traits.grant(bros[0], ::Legends.Trait.ArenaFighter);
		bros[0].getFlags().set("ArenaFightsWon", 5);
		bros[0].getFlags().set("ArenaFights", 5);
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.RangedDefense] = 3;
		bros[0].improveMood(2.5, "Escaped a life of slavery");
		local items = bros[0].getItems();
		this.addRandomEquipment(items);

		bros[1].setStartValuesEx([
			"slave_barbarian_background"
		]);
		bros[1].getBackground().m.RawDescription = "A truly massive figure, %name% hulks like a boulder and has a face about as pretty. The night you escaped, you personally witnessed the savage rip a nomad\'s arm out of its socket and beat an ifrit to rubble with it. When you asked the barbarian what the newly-earned freedom meant, %name% simply responded  \'I must slay a god. Fight with you for now.\' You decided it was prudent not to press for details.";

		if (this.Math.rand(1, 100 <= 50))
		{
			local potentialTitles = [
				"the Quiet",
				"the Reticent",
				"the Silent",
				"the Cursed"
			];
			bros[1].setTitle(potentialTitles[this.Math.rand(0, potentialTitles.len() - 1)]);
		}

		bros[1].getBackground().buildDescription(true);
		bros[1].setPlaceInFormation(2);
		bros[1].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		this.setRetireText(bros[1]);
		skills.removeByID("trait.fragile");
		bros[1].getSkills().removeByID("trait.tiny");
		::Legends.Traits.grant(bros[1], ::Legends.Trait.Huge);
		::Legends.Traits.grant(bros[1], ::Legends.Trait.LegendBrothersInChains);
		local talents = bros[1].getTalents();
		local hasRangedSkill = talents[this.Const.Attributes.RangedSkill] != 0;
		local hasMeleeDefense = talents[this.Const.Attributes.MeleeDefense] != 0;
		local hasRangedDefense = talents[this.Const.Attributes.RangedDefense] != 0;
		local hasMeleeSkill = talents[this.Const.Attributes.MeleeSkill] != 0;
		local hasFatigue = talents[this.Const.Attributes.Fatigue] != 0;

		if (hasRangedSkill)
		{
			if (!hasMeleeDefense)
			{
				talents[this.Const.Attributes.RangedSkill] = 0;
				talents[this.Const.Attributes.MeleeDefense] = this.Math.rand(2, 3);
			}
			else if (!hasMeleeSkill)
			{
				talents[this.Const.Attributes.RangedSkill] = 0;
				talents[this.Const.Attributes.MeleeSkill] = this.Math.rand(2, 3);
			}
			else if (!hasFatigue)
			{
				talents[this.Const.Attributes.RangedSkill] = 0;
				talents[this.Const.Attributes.Fatigue] = this.Math.rand(2, 3);
			}
		}
		else if (hasRangedDefense)
		{
			if (!hasMeleeDefense)
			{
				talents[this.Const.Attributes.RangedDefense] = 0;
				talents[this.Const.Attributes.MeleeDefense] = this.Math.rand(2, 3);
			}
			else if (!hasMeleeSkill)
			{
				talents[this.Const.Attributes.RangedDefense] = 0;
				talents[this.Const.Attributes.MeleeSkill] = this.Math.rand(2, 3);
			}
			else if (!hasFatigue)
			{
				talents[this.Const.Attributes.RangedDefense] = 0;
				talents[this.Const.Attributes.Fatigue] = this.Math.rand(2, 3);
			}
		}

		bros[1].improveMood(2.5, "Escaped a life of slavery");
		local items = bros[1].getItems();
		this.addRandomEquipment(items);

		bros[2].setStartValuesEx([
			"slave_southern_background"
		]);
		bros[2].getBackground().m.RawDescription = "Formerly a gunner in a city-state regiment, %name% has never quite fit in with the rest of the Indebted. Cast out of the army and branded a heretic for some religious slight %name% refuses to talk about. The gunner was relegated to a disdained social strata and never managed to truly lose that distaste. Regardless, %name% is one of you now and shows enough talent that you are willing to overlook that personality.";
		bros[2].getBackground().buildDescription(true);
		bros[2].setPlaceInFormation(3);
		bros[2].addLightInjury();
		bros[2].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		this.setRetireText(bros[2]);
		::Legends.Traits.grant(bros[2], ::Legends.Trait.LegendBrothersInChains);
		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Initiative] = 2;
		talents[this.Const.Attributes.Bravery] = 2;
		talents[this.Const.Attributes.RangedSkill] = 2;
		bros[2].worsenMood(0.5, "Misses life in the army");
		bros[2].improveMood(2.5, "Escaped a life of slavery");
		local items = bros[2].getItems();
		this.addRandomEquipment(items);
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				5,
				"oriental/gunner_hat"
			]
		]));

		bros[3].setStartValuesEx([
			"slave_southern_background"
		]);
		bros[3].getBackground().m.RawDescription = "If you had to describe %name% in one word, it would be \'ornery.\' Bitter about life before becoming indebted, bitter about life as a slave, and now bitter about life on the run. Perhaps that bitterness is what compels %name% to cling to life so, having taken enough lashings and beatings for three men, endured punishments meant to kill and even gotten back up after catching an ifrit toss square in the chest. %name% is pretty bitter about that one, too.";
		bros[3].getBackground().buildDescription(true);
		bros[3].setPlaceInFormation(4);
		bros[3].addInjury(this.Const.Injury.Brawl);
		bros[3].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		this.setRetireText(bros[3]);
		::Legends.Traits.grant(bros[3], ::Legends.Trait.Survivor);
		::Legends.Traits.grant(bros[3], ::Legends.Trait.LegendBrothersInChains);
		bros[3].worsenMood(1.5, "Feels he deserves better in life");
		bros[3].improveMood(2.5, "Escaped a life of slavery");
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		this.addRandomEquipment(items);

		bros[4].setStartValuesEx([
			"slave_southern_background"
		]);
		bros[4].getBackground().m.RawDescription = "A scholar in a previous life, %name% was cast into slavery for research that was deemed offensive to the Gilder. The scholar accepted a new life with a grace few can muster. When the opportunity came to escape with you however, there was no hesitation, simply stating that this was the next fated path to take. It does not really make sense to you, but you do not care to debate after seeing the gruesome death of the conscript whose equipment %name% now wears.";
		bros[4].setTitle("the Sage");
		bros[4].getBackground().buildDescription(true);
		bros[4].setPlaceInFormation(5);
		bros[4].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		this.setRetireText(bros[4]);
		local talents = bros[4].getTalents();
		local hasRangedSkill = talents[this.Const.Attributes.RangedSkill] != 0;
		local hasMeleeDefense = talents[this.Const.Attributes.MeleeDefense] != 0;
		local hasRangedDefense = talents[this.Const.Attributes.RangedDefense] != 0;
		local hasInitiative = talents[this.Const.Attributes.Initiative] != 0;
		local hasFatigue = talents[this.Const.Attributes.Fatigue] != 0;

		if (hasRangedSkill)
		{
			if (!hasMeleeDefense)
			{
				talents[this.Const.Attributes.RangedSkill] = 0;
				talents[this.Const.Attributes.MeleeDefense] = this.Math.rand(2, 3);
			}
			else if (!hasRangedDefense)
			{
				talents[this.Const.Attributes.RangedSkill] = 0;
				talents[this.Const.Attributes.RangedDefense] = this.Math.rand(2, 3);
			}
			else if (!hasFatigue)
			{
				talents[this.Const.Attributes.RangedSkill] = 0;
				talents[this.Const.Attributes.Fatigue] = this.Math.rand(2, 3);
			}
		}
		else if (hasInitiative)
		{
			if (!hasMeleeDefense)
			{
				talents[this.Const.Attributes.Initiative] = 0;
				talents[this.Const.Attributes.MeleeDefense] = this.Math.rand(2, 3);
			}
			else if (!hasRangedDefense)
			{
				talents[this.Const.Attributes.Initiative] = 0;
				talents[this.Const.Attributes.RangedDefense] = this.Math.rand(2, 3);
			}
			else if (!hasFatigue)
			{
				talents[this.Const.Attributes.Initiative] = 0;
				talents[this.Const.Attributes.Fatigue] = this.Math.rand(2, 3);
			}
		}

		bros[4].improveMood(2.5, "Escaped a life of slavery");
		::Legends.Traits.grant(bros[4], ::Legends.Trait.LegendBrothersInChains);
		local items = bros[4].getItems();
		this.addRandomEquipment(items, true);

		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.m.Money = this.Math.max(this.World.Assets.m.Money - 600, 150);
	}

	function addRandomEquipment( items, shieldSpecific = false )
	{
		local getsArmor = this.Math.rand(1, 100) <= 50 ? true : false;
		local getsHelmet = this.Math.rand(1, 100) <= (50 + (getsArmor ? -17 : 17)) ? true : false;
		local getsWeapon = this.Math.rand(1, 100) <= (50 + (getsArmor ? -17 : 17) + (getsHelmet ? -17 : 17)) ? true : false;

		if (getsArmor) {
			items.equip(this.Const.World.Common.pickArmor([
				[
					10,
					"oriental/nomad_robe"
				],
				[
					10,
					"oriental/thick_nomad_robe"
				],
				[
					10,
					"oriental/padded_vest"
				],
				[
					5,
					"oriental/stitched_nomad_armor"
				],
				[
					5,
					"oriental/plated_nomad_mail"
				],
				[
					5,
					"oriental/linothorax"
				],
				[
					5,
					"legend_rabble_fur"
				],
				[
					5,
					"legend_rabble_tunic"
				]
			]));
			local armor = items.getItemAtSlot(this.Const.ItemSlot.Body);

			if (armor != null)
			{
				armor.setCondition(this.Math.rand(armor.getConditionMax() * 0.4, armor.getConditionMax()) * 1.0);
			}
		}

		if (getsHelmet) {
			items.equip(this.Const.World.Common.pickHelmet([
				[
					5,
					"oriental/nomad_reinforced_helmet"
				],
				[
					5,
					"oriental/wrapped_southern_helmet"
				],
				[
					5,
					"oriental/spiked_skull_cap_with_mail"
				],
				[
					20,
					"oriental/nomad_head_wrap"
				],
				[
					15,
					"oriental/nomad_leather_cap"
				],
				[
					15,
					"oriental/nomad_light_helmet"
				]
			]));
			local helmet = items.getItemAtSlot(this.Const.ItemSlot.Head);

			if (helmet != null)
			{
				helmet.setCondition(this.Math.rand(helmet.getConditionMax() * 0.4, helmet.getConditionMax()) * 1.0);
			}
		}

		if (getsWeapon) {
			local weaponRoll = this.Math.rand(1, 100);
			local weapons = [];

			if (weaponRoll <= 10)
			{
				weapons.extend([
					"shields/oriental/metal_round_shield",
					"weapons/scimitar",
					"weapons/boar_spear",
					"weapons/pitchfork",
					"weapons/oriental/light_southern_mace",
					"weapons/oriental/firelance"
				]);
			}
			else if (weaponRoll >= 11 && weaponRoll <= 60)
			{
				weapons.extend([
					"shields/oriental/southern_light_shield",
					"weapons/oriental/saif",
					"weapons/militia_spear",
					"weapons/oriental/nomad_mace",
					"weapons/legend_chain"
				]);
			}
			else
			{
				weapons.extend([
					"weapons/legend_shovel",
					"weapons/legend_shiv",
					"weapons/legend_hoe",
					"weapons/legend_saw",
					"weapons/legend_hammer",
					"weapons/legend_wooden_pitchfork",
					"weapons/legend_wooden_spear",
					"weapons/legend_chain"
				]);
			}

			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			local weapon = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
			weapon.setCondition(this.Math.rand(weapon.getConditionMax() * 0.4, weapon.getConditionMax()) * 1.0);
			items.equip(weapon);
		}
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isIsolatedFromRoads() && randomVillage.isSouthern() && !randomVillage.hasBuilding("building.arena"))
			{
				break;
			}

			i = ++i;
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 2)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		local cityStateFaction = randomVillage.getOwner();
		cityStateFaction.addPlayerRelation(-99.0, "You escaped before repaying your debts to the Gilder");
		this.logInfo("Sato: nemesis faction ID: " + cityStateFaction.getID());
		this.World.Statistics.getFlags().set("NemesisCityStateID", cityStateFaction.getID());
		this.World.Statistics.getFlags().set("SatoLastAmbushType", "");
		local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

		foreach( c in cityStates )
		{
			if (c.getID() != cityStateFaction.getID())
			{
				c.addPlayerRelation(-30.0, "You are rumored to be escaped Indebted");
			}
		}

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(116);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/worldmap_11.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.sato_escaped_slaves_scenario_intro");
		}, null);
	}

	function setRetireText( bro )
	{
		if (bro.getBackground().getEthnicity() == 1)
		{
			bro.getBackground().m.GoodEnding = "You freed the indebted %name% and helped them find a new life as a sellsword. %name% did become an effective fighter, no doubt believing it was better to fight and live free than to fight and die. After your departure, you heard that the %companyname% traveled south on a campaign and the indebted got a good chance to exact a fair bit of revenge on a number of enemies from the past. You count yourself lucky to have served in the same company.";
			bro.getBackground().m.BadEnding = "You found %name% as an indebted and after your retiring, they went on with the %companyname%. Word of the mercenary band\'s problems have trickled in, but nothing about the indebted\'s current situation. Knowing how this world works, the slave has either been put into the vanguard as fodder or forced out to distract manhunters on the company\'s trail. Either way, the world isn\'t easy on a sellsword, and it isn\'t easy on an indebted, and this mercenary is unfortunately both.";
		}
		else if (bro.getBackground().getEthnicity() != 1)
		{
			bro.getBackground().m.GoodEnding = "%name% the indebted has had a rough life and you\'ve both contributed to that and helped alleviate it in some way. You found them as a slave, far from family and home, and put them to work as a sellsword. After you left the %companyname%, they stayed on and has been rising through its ranks ever since. You hear they were so ferocious in a battle with manhunters that the city-states have reconsidered sending men after the company at all, fearing what might happen if %name% took the fight to them more directly.";
			bro.getBackground().m.BadEnding = "With your retiring from the unsuccessful %companyname%, %name% the indebted from the north carried on with the company for a time. You got wind that the mercenary band ran into troubles with manhunters and had to leave behind both \'man and material\' to escape. %name%\'s time with the company presumably ended sometime there. You hope %name%\'s time as a slave never started again.";
		}
	}

	function onHiredByScenario( bro )
	{
		if (bro.getBackground().getID() == "background.slave")
		{
			::Legends.Traits.grant(bro, ::Legends.Trait.LegendBrothersInChains);
			bro.getSprite("miniboss").setBrush("bust_miniboss_indebted");
			bro.improveMood(1.5, "Joined a mercenary company of freed slaves");
			this.setRetireText(bro);
		}
		else if (bro.getBackground().getID() == "background.manhunter")
		{
			local brothers = this.World.getPlayerRoster().getAll();

			foreach( bro in brothers )
			{
				if (bro.getBackground().getID() == "background.slave")
				{
					bro.worsenMood(2.0, "You hired " + bro.getNameOnly() + " the manhunter");
				}
			}
		}
	}

	function onInit()
	{
		this.World.Assets.m.RelationDecayGoodMult += 0.15;
		this.World.Assets.m.RelationDecayBadMult -= 0.15;
		this.World.Events.addSpecialEvent("event.sato_find_slave_after_battle");
	}

});

