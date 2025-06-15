this.legend_hunting_skin_ghouls_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = false,
		MinStrength = 10, // player needs to earn 10% of bonus (not including base 5% bonus) for this contract to be valid
		Perk = ::Legends.Perk.LegendFavouredEnemyGhoul,
		ValidTypes = this.Const.LegendMod.FavoriteGhoul,
		LevelSumRequiredForRandomSpawn = 50,
		IsRandomlyAdded = null,
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_hunting_skin_ghouls";
		this.m.Name = "Hunger Pangs (Legendary)";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
		this.m.DescriptionTemplates = [
			"Corpse-eaters... always wretched, malevolent, yet predictable. However there is an intelligence being hinted in these disturbing reports that gives you pause.",
			"Skin ghouls are abominations of nature, their pallid forms and insatiable hunger for flesh making them a terror to encounter.",
			"Skin ghouls are cursed beings, their rotting flesh and ravenous appetites make them a gruesome sight to behold.",
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
		this.m.Payment.Pool = 1200 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"Hunt down skin ghouls around " + this.Contract.m.Home.getName()
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
					this.Flags.set("IsBanterShown", true);
					this.Contract.setScreen("Banter");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (!this.Flags.get("IsEncounterShown"))
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
			Text = "[img]gfx/ui/events/legend_skin_ghoul.png[/img]{The exterior of %employer%\'s grand manse near the centre of town looks as though it\'s seen better days, crusty old paint flaking off some of the walls and ancient sunbleached ivy having long since reclaimed some others. Approaching the front entrance, one of his household guard stops you to give you the once over, grinning toothlessly. %SPEECH_ON%Ohhh, yer %employer%\'s latest meat for the thresher I take it, by the looks of ya. Eh? Heheh. Get ye on in, then. Might be ye\'ll have more luck than the last lot. Hyeheh.%SPEECH_OFF% He carries on chuckling to himself annoyingly as you head inside. On entering, it strikes you that the exterior of the huge house was likely left to rot intentionally – probably to distract from the immense wealth collected indoors, with everything from paintings to door handles gilded and polished, and every wall adorned with fine oak paneling and expensive ornaments. A bit garish for your taste. The housemaster orders a nervous little servant boy to take you to %employer%. You accompany the boy up three overly large flights of carpeted stairs to an engraved wooden door where he knocks once, tepidly, to no response. He knocks again, a little harder this time, and you hear %employer%\'s muffled voice furiously bellow through the door, %SPEECH_ON%WHAT?%SPEECH_OFF% The door bursts open and %employer%, a corpulent red-faced man clothed in very fine linens of the extra-large variety, storms through the door and roars at the flinching servant boy. %SPEECH_ON%Boy, I am NOT to be interrupted at my work. IF I am to be interrupted, which I am NOT, the signal that the knock is of importance is to knock THRICE. Do you know what THRICE means? It means THREE. THREE knocks if the knock is one of importance. Do you understand?%SPEECH_OFF% The boy, looking on the verge of tears, mumbles %SPEECH_ON%Yessir, yes, yes sir, sorry sir,%SPEECH_OFF% and quickly scurries off. %employer% regards you with an ugly frown, sizing you up. His face softens a little when he notices the knock was, in fact, of importance. %SPEECH_ON%Ah ... the mercenaries I ordered. Mm. Very good.%SPEECH_OFF% He thumbs over his shoulder, gesturing you enter the room, a large and well-lit study filled with trophies and clutter. Every shelf and surface is covered in papers, notes, coins, quills and inks. %SPEECH_ON%There is … an issue. With employees of mine.%SPEECH_OFF% He clears his throat. %SPEECH_ON%Ex-employees, I should perhaps say, since they\'ve been torn to a thousand ribbons and eaten, by what I am told is the most numerous and fearsome lot of devouring beasts these parts have seen in memory.%SPEECH_OFF% He opens his bureau and pulls out a roll of parchment. He unfurls it and presents it to you. It\'s a rather scary-looking sketch of a huge horned Nachzehrer, its maw open to bare its enormous jagged fangs. %SPEECH_ON%Know you this sight?%SPEECH_OFF% he asks, the parchment beginning to shake with anger in his fat fingers. You tell him you know it, more or less. %SPEECH_ON%Well, this monster and its foul friends are costing my … operation. Costing my operation very dearly. It cannot continue and must be dealt with. With extreme expedition. It is not a small matter and I am prepared to compensate extremely well the one who accepts this opportunity from me. Will it be you?%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Accepting your \'opportunity\' could cost my company dearly as well. What will you pay? | It appears you can afford it. Let\'s talk money. | About that \'compensation\'...}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This doesn\'t sound like our kind of work.}",
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
			Text = "[img]gfx/ui/events/event_25.png[/img]{You stumble across a dead farmer with its flesh ripped to pieces. %randombrother% crouches and runs and inspects the corpse. %SPEECH_ON%This is clearly the work of a skin ghoul. They\'re close...%SPEECH_OFF% | %randombrother% spits and nods.%SPEECH_ON%Alright. We\'re close. Rather, they\'re close. %SPEECH_OFF%Well that\'s good. Time for the men to find these monsters. }",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Keep your eyes peeled.",
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
			Text = "[img]gfx/ui/events/legend_skin_ghoul.png[/img]{The horde of skin ghouls suddenly turn as one. They let out a screech unlike anything you\'ve ever heard before. Claws raised before them, the began to swarm towards the company.}",
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
			ID = "Victory",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/legend_skin_ghoul_dead.png[/img]{The last of the skin ghouls is dealt with. You nod at the company\'s good work then order the men to gather weapons and tend to the wounded, glad these beasts have been vanquished. }",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Let\'s be done with this, we have crowns to collect.",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_85.png[/img]{%employer% meets you at the town entrance and there\'s a crowd of folks beside him. He welcomes you warmly, stating he had a scout following you who saw the whole battle unfold. After he hands you your reward, the townsfolk come forward one by one, many of which are reluctant to stare a sellsword in the eyes, but they offer a few gifts as thanks for relieving them of the skin ghoul horrors. | You have to track down %employer%, ultimately finding the man in a stable livery with a peasant girl. He bolts upward from the hay, startling the horses which whinny and stamp their hooves. Half-dressed, the man states he already has your pay and forks it over. Eyeing you eyeing the girl, he then starts to grab whatever\'s in reach, including from the saddlebags of stabled mounts, and hands them over.%SPEECH_ON%The, uh, townsfolk also sought to pitch in. You know, as thanks.%SPEECH_OFF%Right. For further \'thanks\' you ask if he\'ll give you whatever\'s in a nearby satchel. | %employer% welcomes you back with a great clap and rub of his hands, as though you\'d just brought in a turkey and not the horrifying evidence of your victory. After paying you the agreed reward, you hear some surprising news. The mayor states that the estate of a lost townsman could not be properly divvied up and, as further thanks, you\'re free to take what\'s left of it.}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of skin ghouls");
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
		local tile = this.getTileToSpawnLocation(playerTile, 5, 10);
		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Skin Ghouls", false, this.Const.World.Spawn.LegendSkinGhouls, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("A horde of terrorizing skin ghouls.");
		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(0.75);

		for( local i = 0; i < 2; i++ ) {
			local nearTile = this.getTileToSpawnLocation(playerTile, 4, 5);
			if (nearTile != null)
				this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, 0.75);
		}

		this.m.Target = this.WeakTableRef(party);
		party.getSprite("banner").setBrush("banner_beasts_01");
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setMinRange(2);
		roam.setMaxRange(8);
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Shore, false);
		roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
		c.addOrder(roam);
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
