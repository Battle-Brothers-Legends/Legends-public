this.legend_hunting_greenwood_schrats_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = false,
		MinStrength = 10, // player needs to earn 10% of bonus (not including base 5% bonus) for this contract to be valid
		Perk =  ::Legends.Perk.LegendFavouredEnemySchrat,
		ValidTypes = this.Const.LegendMod.FavoriteSchrat,
		LevelSumRequiredForRandomSpawn = 50,
		IsRandomlyAdded = null,
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_hunting_greenwood_schrats";
		this.m.Name = "The Heart of the Woods (Legendary)";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
		this.m.DescriptionTemplates = [
			"They say that Schrats are the lost souls of the forest, yet this contract sounds like something more. Something far older, something far more terrible.",
			"A malevolent presence lurks in the heart of the forest, its dark aura spreading like a poison through the trees and soil.",
			"Some locals talk about the heart of the forest is if it were alive, or perhaps a deity to be worshiped.",
		];
		this.m.IsRandomlyAdded = ::Math.rand(1, 100) <= 5;
	}

	function getBanner()
	{
		return "ui/banners/factions/banner_legend_s";
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 1800 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 10)
		{
			this.m.Payment.Completion = 0.9;
			this.m.Payment.Advance = 0.1;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Hunt down what kills people in the woods around " + this.Contract.m.Home.getName()
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 20)
				{
					this.Flags.set("IsDirewolves", true);
				}
				else if (r <= 25)
				{
					this.Flags.set("IsGlade", true);
				}
				else if (r <= 30)
				{
					this.Flags.set("IsWoodcutter", true);
				}

				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				this.Contract.spawnEnemies();
				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					this.Contract.setScreen("Victory");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsBanterShown") && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 1000) <= 1 && this.Flags.get("StartTime") + 10.0 <= this.Time.getVirtualTimeF())
				{
					local tileType = this.World.State.getPlayer().getTile().Type;

					if (tileType == this.Const.World.TerrainType.Forest || tileType == this.Const.World.TerrainType.LeaveForest || tileType == this.Const.World.TerrainType.AutumnForest)
					{
						this.Flags.set("IsBanterShown", true);
						this.Contract.setScreen("Banter");
						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (!this.Flags.get("IsEncounterShown"))
				{
					this.Flags.set("IsEncounterShown", true);

					if (this.Flags.get("IsDirewolves"))
					{
						this.Contract.setScreen("Direwolves");
					}
					else
					{
						this.Contract.setScreen("Encounter");
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return to " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success");
					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_31.png[/img]{ %employer% greets you at the front door of his keep and invites you in. %SPEECH_ON%We\'re glad you could come trapper. When I received word there was a Schrat hunter in town I sent for you at once. Folks keep going missing in the woods and I\'ve no recourse in getting them back. I\'ve heard tales of trees on the move before, but this time is worse. We sent axemen in to take out the treemen before, but these ones just will not stay dead. They seem to glow with a life force, and each swing of our axes just makes these trees grow stronger. I understand you have fought them before, and I am sure your axes are sharp, but this contract is different. If you manage to return with your life, and without theirs, I will reward you handsomely for your efforts.%SPEECH_OFF% }",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Interested for sure. | Let\'s talk pay. | Let\'s talk crowns. | This is going to cost you. | A wild chase through the forest, then? Count me in. | The %companyname% can help, for the right price.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This doesn\'t sound like our kind of work. | This sounds too dangerous. | I don\'t think so. | I say no. We are mercenaries, not lumberjacks.}",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Banter",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_128.png[/img]{As you trek through the woods, you begin to notice strange details. The plants here seem to be more vibrant and alive than in any forest you\'ve seen. The forest floor is lush with clover and moss, a wild variety of flowers fill the air with their scent. Thick clouds of insects hang in the air, and everywhere you see animals running into the undergrowth. Something powerful has stirred the life force of the woods, and your men are very clearly intruders on the life filled wilderness. Knowing you are hunting trees, you treat each branch and root with suspicion, even the smallest sapling could turn against you at any moment. }",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Watch where you step.",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Encounter",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_heartwood.png[/img]{The undergrowth has grown thick and hard to walk through, a tangle of roots, vines and branches. Your men hack through the wood, sending shudders reverberating through the forest and birds squaking off into the air. Suddenly one of the branches rears back as you strike it in half. The leafy bough pulls away as a nearby trunk turns to face you, revealing a glowing face made from the gnarled burls of wood. The eyes seem to dance with a playful green fire and its other branches turn towards you, ready to strike. }",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Prepare for battle!",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Direwolves",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_heartwood_ritual.png[/img]{You spot pairs of green eyes glowing in the distance. No doubt a sight of the schrats themselves, and so you order your men to clamber toward them quietly.\n\nCresting a hill you find the trunk of one tree is surrounded by a group of beautiful women. They have laid out offerings before the tree, taken off their clothes and they are chanting softly while dancing naked in the dappled light filtering through the canopy. Your arrival has not gone unnoticed as the schrat leans forward with a seemingly ancient crooning. The women at its root turn and hiss insults at you, schriveling into hags as they shout. You\'re not sure what to make of such arboreal allegiance, but those hags will die at the feet of %companyname% .}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Charge!",
					function getResult()
					{
						this.Contract.addUnitsToEntity(this.Contract.m.Target, this.Const.World.Spawn.HexenAndMore, 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/legend_heartwood_dead.png[/img]{The schrats are slain, their arboreal remains now resembling little more than ordinary trees. You carve trophies and evidence for a return to %employer%. | You stare at a felled tree and then at a felled schrat. Between the two you see almost no difference, which makes you ponder about all those supposedly dead trees you\'ve been hopping over your whole life. Not one to dwell on such matters, you order the company take trophies as proof of the battle and ready a return to %employer%. | The schrats are felled, each draped against the rest of the forest foliage like brawlers resting between rounds. You walk up beneath the roots of one and get a good look at it, but now it appears no different than any other tree around. You order the company to take what trophies they can to show %employer%.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "It\'s done.",
					function getResult()
					{
						if (this.Flags.get("IsGlade") && this.World.Assets.getStash().hasEmptySlot())
						{
							return "Glade";
						}
						else if (this.Flags.get("IsWoodcutter") && this.World.Assets.getStash().hasEmptySlot())
						{
							return "DeadWoodcutter";
						}
						else
						{
							return 0;
						}
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Glade",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/legend_heartwood_dead.png[/img]{As you are departing the battlefield, %randombrother% remarks that the surrounding area looks rather ripe. You turn around to see that he is indeed correct: a beautiful crop of trees served host to the schrats, presumably chosen for good reason. And if the schrats took it for a good home, then it surely means the wood is very fine. You order the men to make use of this quality glade and chop as many trees down as time and energy permits. The harvested timber is very fine indeed.\n\n It begins to rain as you depart the impromptu lumbermill.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Back to %townname%!",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				local item = this.new("scripts/items/trade/quality_wood_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				item = this.new("scripts/items/trade/quality_wood_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				item = this.new("scripts/items/trade/quality_wood_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				item = this.new("scripts/items/trade/quality_wood_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "DeadWoodcutter",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/legend_heartwood_dead.png[/img]{Just as you are departing, a glint catches your eye. You turn around and come to one of the schrats\' trunk. An axe is embedded in the wood. Moss has long since overgrown the handle, and yet the metal of the tool is without error, not a smidge of rust upon it. Scraping the moss away, you uncover wooden fingertips still at full grip. Tracing the fingers ends at the tree trunk where the wrist becomes a vein of wood. You follow that along to a wooden face with a twisted maw, like a face of brown wax melted by time alone. The frame of a helmet twists around the face and there\'s a chest plate cresting below like the reservoir of a deerchaser.\n\nYou shake your head and retrieve the axe, breaking it free and throwing the wooden fingers off its handle. The misshapen face blankly observes your theft, its stare preserved in the very annihilation from which it is eons removed. You do not dwell on the sight and return to the company with the axe.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Back to %townname%!",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				local item;
				local r = this.Math.rand(1, 5);

				if (r == 1)
				{
					item = this.new("scripts/items/weapons/woodcutters_axe");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/weapons/hand_axe");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/weapons/fighting_axe");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/weapons/greataxe");
				}
				else if (r == 5)
				{
					item = this.new("scripts/items/weapons/legend_infantry_axe");
				}

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain a " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_85.png[/img]{As you carry the still pulsating schrat head into town, a crowd begins to form around you. Children run up to touch the head, one reaches out to touch and a thorn grows out to meet their finger. The heartwood is not yet fully dead, and seems to regrow where you strike it, perhaps there is some way to make use of this endless regrowth.  Just then %employer% pushes their way through the crowd and cries out %SPEECH_ON% Huzzah! Our heroes have slain the wood spirits and avenged our fallen family. Bring them food and wine, tend their wounds, start the music, tonight we feast!%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "A successful hunt.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/beer_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_rations_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/medicine_item"));
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of living trees");
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Killed the heart of the forest");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
	}

	function spawnEnemies() {
		local disallowedTerrain = [];
		for( local i = 0; i < this.Const.World.TerrainType.COUNT; i++ ) {
			if (i == this.Const.World.TerrainType.Forest || i == this.Const.World.TerrainType.LeaveForest || i == this.Const.World.TerrainType.AutumnForest)
				continue;
			disallowedTerrain.push(i);
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local mapSize = this.World.getMapSize();
		local x = this.Math.max(3, playerTile.SquareCoords.X - 11);
		local x_max = this.Math.min(mapSize.X - 3, playerTile.SquareCoords.X + 11);
		local y = this.Math.max(3, playerTile.SquareCoords.Y - 11);
		local y_max = this.Math.min(mapSize.Y - 3, playerTile.SquareCoords.Y + 11);
		local numWoods = 0;

		while (x <= x_max) {
			while (y <= y_max) {
				local tile = this.World.getTileSquare(x, y);
				if (tile.Type == this.Const.World.TerrainType.Forest || tile.Type == this.Const.World.TerrainType.LeaveForest || tile.Type == this.Const.World.TerrainType.AutumnForest)
					numWoods = ++numWoods;
				y++;
			}
			x++;
		}

		local tile = this.getTileToSpawnLocation(playerTile, numWoods >= 12 ? 6 : 3, 11, disallowedTerrain);
		local party= this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Heartwood Schrats", false, this.Const.World.Spawn.LegendGreenwoodSchrat, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("A creature of bark and wood, blending between trees and shambling slowly, its roots digging through the soil.");
		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(0.85);

		for( local i = 0; i < 2; i++ ) {
			local nearTile = this.getTileToSpawnLocation(playerTile, 4, 7, disallowedTerrain);
			if (nearTile != null)
				this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, 0.85);
		}

		this.m.Target = this.WeakTableRef(party);
		party.getSprite("banner").setBrush("banner_beasts_01");
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setPivot(this.m.Home);
		roam.setMinRange(5);
		roam.setMaxRange(10);
		roam.setNoTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Forest, true);
		roam.setTerrain(this.Const.World.TerrainType.SnowyForest, true);
		roam.setTerrain(this.Const.World.TerrainType.LeaveForest, true);
		roam.setTerrain(this.Const.World.TerrainType.AutumnForest, true);
		c.addOrder(roam);
		return party;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Target.getTile())]
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/disappearing_villagers_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(3);
			}
		}
	}

	function onIsValid()
	{
		local sumLevels = 0;
		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			sumLevels += bro.getLevel();
			if (!bro.getSkills().hasPerk(this.m.Perk))
				continue;

			local stats = this.Const.LegendMod.GetFavoriteEnemyStats(bro, this.m.ValidTypes);
			if (stats.Strength >= this.m.MinStrength)
				return true;
		}

		return this.m.IsRandomlyAdded && sumLevels > this.m.LevelSumRequiredForRandomSpawn;
	}

	function onSerialize( _out )
	{
		if (this.m.Target != null && !this.m.Target.isNull())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}
		_out.writeBool(this.m.IsRandomlyAdded);
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}
		this.m.IsRandomlyAdded = _in.readBool();
		this.contract.onDeserialize(_in);
	}

});
