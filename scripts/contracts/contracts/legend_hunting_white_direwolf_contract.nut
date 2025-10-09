this.legend_hunting_white_direwolf_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = true,
		MinStrength = 10, // player needs to earn 10% of bonus (not including base 5% bonus) for this contract to be valid
		Perk = ::Legends.Perk.LegendFavouredEnemyDirewolf,
		ValidTypes = this.Const.LegendMod.FavoriteDirewolf,
		LevelSumRequiredForRandomSpawn = 50,
		IsRandomlyAdded = null,
	},
	function setEnemyType( _t )
	{
		this.m.Flags.set("EnemyType", _t);
	}

	function getBanner()
	{
		return "ui/banners/factions/banner_legend_s";
	}

	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_hunting_white_direwolf";
		this.m.Name = "Hunting the white wolf (Legendary)";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
		this.m.DescriptionTemplates = [
			"Northern tribal folklore speaks of the White Wolves, beings of pure malice who will one day devour both men and gods alike.",
			"Many consider white wolves to be myth, a campfire tale of the supernatural to scare new travelers with.",
			"In traditional folklore tales, white wolves are always supernatural beings who herald doom.",
		];
		this.m.IsRandomlyAdded = ::Math.rand(1, 100) <= 5;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 1000 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"Hunt down the White Wolf around " + this.Contract.m.Home.getName()
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
					this.Flags.set("IsDriveOff", true);
				}

				if (r <= 70)
				{
					this.Flags.set("IsSignsOfAFight", true);
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
					if (this.Flags.get("IsSignsOfAFight"))
					{
						this.Contract.setScreen("SignsOfAFight");
					}
					else
					{
						this.Contract.setScreen("Victory");
					}

					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsBanterShown") && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 1000) <= 1 && this.Flags.get("StartTime") + 10.0 <= this.Time.getVirtualTimeF())
				{
					this.Flags.set("IsBanterShown", true);
					this.Contract.setScreen("Banter");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsDriveOff") && !this.Flags.get("IsEncounterShown"))
				{
					this.Flags.set("IsEncounterShown", true);
					local bros = this.World.getPlayerRoster().getAll();
					local candidates = [];

					foreach( bro in bros )
					{
						if (bro.getBackground().getID() == "background.houndmaster" || bro.getBackground().getID() == "background.wildman" || bro.getBackground().getID() == "background.beast_slayer" || bro.getBackground().getID() == "background.legend_muladi" || bro.getBackground().getID() == "background.legend_ranger" || bro.getBackground().getID() == "background.legend_vala" || bro.getBackground().getID() == "background.legend_commander_ranger" || bro.getSkills().hasPerk(::Legends.Perk.LegendFavouredEnemyDirewolf))
						{
							candidates.push(bro);
						}
					}

					if (candidates.len() == 0)
					{
						this.World.Contracts.showCombatDialog(_isPlayerAttacking);
					}
					else
					{
						this.Contract.m.Dude = candidates[this.Math.rand(0, candidates.len() - 1)];
						this.Contract.setScreen("DriveThemOff");
						this.World.Contracts.showActiveContract();
					}
				}
				else if (!this.Flags.get("IsEncounterShown"))
				{
					this.Flags.set("IsEncounterShown", true);
					this.Contract.setScreen("Encounter");
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
					if (this.Flags.get("IsDriveOffSuccess"))
					{
						this.Contract.setScreen("SuccessPeaceful");
					}
					else
					{
						this.Contract.setScreen("Success");
					}

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
			Text = "[img]gfx/ui/events/event_31.png[/img]{When you arrive at %employer%\'s keep the sky is dark and the mood is ominous, you hear howling in the distance. The populace is on edge and everyone keeps looking over their shoulders for an unseen assailant.%SPEECH_ON%Thank the gods you came!%SPEECH_OFF% A booming voice echoes around the courtyard and a man in resplendent finery claps his hands together as he shuffles down the stairs towards you %SPEECH_ON%The wolves are at our door, without a word of a lie. They grow bolder by the day, just this morning one crept into the town and took off with a toddler. Her mother is distraught and the villagers are terrified, they demanded I do something. I have already sent half my men out, but only a handful have returned, each burdened with having seen their friends feasted upon.%SPEECH_OFF% %employer% quietens his voice, only now realising the whole town is listening in. %SPEECH_ON%I know you have fought wolves before sellsword, but these are different. They are led by the king of the wolves, the legendary white wolf himself. He is huge, vicious, and cunning beyond measure. Each week he gathers more wolf packs under his rule, driving them into a rabid fervor while orchestrating their campaign of terror. %SPEECH_OFF% %employer% looks around sheepishly, as if scared his words are about to manifest in flesh. %SPEECH_ON% A task like this can not be entered into lightly, others have tried and failed, the reward has grown large. If you should succeed, you will be rich my friend. Are you up to the deed?%SPEECH_OFF% }",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Fighting the king of the wolves won\'t come cheap. | The %companyname% can help for the right price. | How many crowns are we talking about? | How large is the reward?}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This doesn\'t sound like our kind of work. | This won\'t be worth the risk. | I won\'t go off to die like the others}",
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
			Text = "[img]gfx/ui/events/event_75.png[/img]{%randombrother% has been intently scanning for tracks, with an urgency you cannot place. At last he speaks %SPEECH_ON% My grandmother told me stories of the Wolf King when I was a child. She said he is half human from eating human brains, he walks on two legs, wears armor and even understand speech. It was meant to make me do my chores, but it only ever gave me nightmares. He can\'t be real, can he? %SPEECH_OFF%.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We are about to find out.",
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
			Text = "[img]gfx/ui/events/legend_white_wolf.png[/img]{You stop in your tracks, the hairs on the back of your neck bristling. You feel something watching you and turn to see wolves emerging from the tree line at full charge. The Wolf King has found you. }",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Charge!",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "DriveThemOff",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_white_wolf.png[/img]{Tracking quietly you come over a small hill and look down on a large group of wolves in a clearing. The wind is on your face, so they have not caught your sent. You crouch low and creep forward to get a better view. To your amazement you see two white wolves. Each is leading a pack, and they are arrayed on either side of the clearing, with the two leaders in the middle. It appears as if some kind of parlay is underway, played out in a complex series of movements, growls and sniffs. Their stances feel as if they may start fighting at any moment, but then after one last sniff they face up, and to your amazement they bow to each other. With that the show is over, and one of the packs turns and leaves.  No sooner has the second pack left, than you notice %shouter% walking down the hill in front of you calmly and deliberately, making no attempt to hide and looking straight at the White Wolf.  }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Attack them!",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				},
				{
					Text = "%shouter% knows how to handle this.",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "DriveThemOffSuccess";
						}
						else
						{
							return "DriveThemOffFailure";
						}
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "DriveThemOffSuccess",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_white_wolf.png[/img]{Against your better judgment, you let it play out. %shouter% reaches the clearing and then bows down to the ground in front of the white wolf. Unbelievably the white wolf bows as well and the two of them begin growling and sniffing each other. %shouter% lets out a series of crooning hums, like a drawn out melodic growl that seems to entrance the wolves. %shouter% uses the moment of calm to do the most foolhardy thing you have ever seen. %shouter% drops trousers and pisses onto the head of the white wolf. In that moment the whole scene changes, the white wolf rolls onto its back and wimpers, and the rest of the pack turn and disapear into the woods.  }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We still need to catch the other wolf",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
				local item = this.new("scripts/items/accessory/legend_white_wolf_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				this.Contract.m.Dude.improveMood(2.0, "Managed to tame a white wolf");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[this.Contract.m.Dude.getMoodState()],
					text = this.Contract.m.Dude.getName() + this.Const.MoodStateEvent[this.Contract.m.Dude.getMoodState()]
				});
			}

		});
		this.m.Screens.push({
			ID = "DriveThemOffFailure",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_white_wolf.png[/img]{Against your better judgment, you let it play out. %shouter% reaches the edge of the clearing and begins to make some bizarre crooning noises like an injured dog. The white wolf tilts it\'s head for a moment quizically, before letting out a howl and charging towards %shouter%. The wolf grabs %shouter% in its jaws, shakes them viciously before throwing shouter back towards the wolves. If that weren\'t bad enough, just then you notice the other wolf pack returning, it looks like you\'ll be fighting two wolf kings. }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "",
					function getResult()
					{
						this.Contract.addUnitsToEntity(this.Contract.m.Target, this.Const.World.Spawn.LegendWhiteDirewolf, 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, false);
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
				local injury1;
				local injury2;

				if (this.Math.rand(1, 100) <= 90)
				{
					injury1 = this.Contract.m.Dude.addInjury(this.Const.Injury.BluntBody);
					injury2 = this.Contract.m.Dude.addInjury(this.Const.Injury.BluntBody);
				}
				else
				{
					injury1 = this.Contract.m.Dude.addInjury(this.Const.Injury.BluntBody);
					injury2 = this.Contract.m.Dude.addInjury(this.Const.Injury.BluntHead);
				}

				this.List.push({
					id = 10,
					icon = injury2.getIcon(),
					text = this.Contract.m.Dude.getName() + " suffers " + injury1.getNameOnly() + " and " + injury2.getNameOnly()
				});
				this.Contract.m.Dude.worsenMood(1.0, "Failed to sing to the wolves");

				if (this.Contract.m.Dude.getMoodState() <= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[this.Contract.m.Dude.getMoodState()],
						text = this.Contract.m.Dude.getName() + this.Const.MoodStateEvent[this.Contract.m.Dude.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/legend_white_wolf_dead.png[/img]{The white wolf lays mangled, upon a pile of wolf carcasses. You begin skinning the body, that head will make a lovely hat.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Time to get paid.",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SignsOfAFight",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/legend_white_wolf_dead.png[/img]{With the beasts slain, you take a moment to rest. One of your mercenaries asks you: %SPEECH_ON%So if you just killed the king of the wolves, does that make you the new king?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "If only it worked that way",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%employer% seems surprised when you return. %SPEECH_ON%Could it be? Have you slain the White Wolf? %SPEECH_OFF%  You show him the bloody wolf pelt and he stares in disbelief.  %SPEECH_ON% The reign of terror is over! This demands a celebration! Tonight, for the first time in many moons, we shall drink and be merry! %SPEECH_OFF%  He gestures to his servants who cheer as one, then begin tending to your wounds, bringing over drinks, food, and a small chest full of crowns. }",
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
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_venison_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/medicine_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/loot/ancient_gold_coins_item"));
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of the white wolf");
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Saviour of the lands");
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
		local playerTile = this.World.State.getPlayer().getTile();
		local tile = this.getTileToSpawnLocation(playerTile, 6, 12, [
			this.Const.World.TerrainType.Mountains
		]);
		local nearTile = this.getTileToSpawnLocation(playerTile, 4, 8);
		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "White Wolf Pack", false, this.Const.World.Spawn.LegendWhiteDirewolf, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("The wolf pack of the legendary White Wolf.");
		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(0.75);
		this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, 0.75);
		this.m.Target = this.WeakTableRef(party);
		party.getSprite("banner").setBrush("banner_beasts_01");
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(true);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setPivot(this.m.Home);
		roam.setMinRange(2);
		roam.setMaxRange(16);
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Shore, false);
		c.addOrder(roam);
		return party;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"shouter",
			this.m.Dude != null ? this.m.Dude.getName() : ""
		]);
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
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
