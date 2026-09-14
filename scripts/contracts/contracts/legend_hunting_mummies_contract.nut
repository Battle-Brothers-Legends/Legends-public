this.legend_hunting_mummies_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.hunting_mummies";
		this.m.Name = "The Ancient Dead";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DescriptionTemplates = [
			"The fleshed dead have been seen roaming the desert, their purpose long since lost to the sands of time.",
			"Amongst the shifting sands, the embalmed dead wander aimlessly, their mummified forms driven by an insatiable thirst for the life they lost centuries ago.",
			"In the desolate wastes of the desert, the embalmed dead rise from ancient tombs, their preserved forms shuffling endlessly beneath the scorching sun.",
			"Beneath the burning sun, the embalmed dead roam the desert wastes, their empty eyes fixed on the horizon as they obey a long-forgotten command.",
			"In the desolate expanse of the desert, the embalmed dead march in silent procession, their mummified forms a grim reminder of the ancient curses that lie buried beneath the sand.",
			"The desert holds secrets best left undisturbed, for the embalmed dead have recently risen from their ancient tombs to stalk the sands once more.",
			"Travelers in the desert face a grave threat: the embalmed dead, risen from their ancient crypts to haunt the dunes and prey upon the living with their cursed touch.",
		];
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 600 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
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
					"Hunt down the dead that roam the desert around " + this.Contract.m.Home.getName()
				];
				this.Contract.setScreen("Task");
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

					if (tileType == this.Const.World.TerrainType.Desert)
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
			Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% sits at a newly furnished table of gold and acacia, every facet is intricately hand carved and detailed, the corners are inlaid with gold and small jewels. On the surface however is more contradictory — a severed arm, roughly cut at the elbow, flops lifelessly on the ornate table.\n %employer% is surrounded by equally curious men who poke and prod at the limb like a child would poke at a dead dog with a stick. One of the servants taps the Vizier on the shoulder, where he promptly recomposes himself to seem as uninterested as possible in the diseased meat that is now emitting bile across his table.%SPEECH_ON%Now Crownling — I do have something quite special for you today. The fleshed dead have been seen in the desert, attacking my land and my servants. They are rarity around here, and one we feel should be dealt with immediately.%SPEECH_OFF%\n %employer% pyramids his fingers and leans back further into his chair, possibly to get as far away from the stench of the quickly festering arm. %employer% coughs and signals a servant to finish. The servant clears their throat and struggles the breathe %SPEECH_ON%On the authority of the...%SPEECH_OFF% He stops and coughs violently, taking a few steps away from the arm that is now dripping bile on the table while a guard carefully skewers it with his spear and takes it away at the full length of it.\n The servant recomposes himself and decides to skip to the important part. %SPEECH_ON%...you will be compensated with %reward% crowns.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{I\'m interested, go on. | Hunting down an enemy like this doesn\'t come cheap. | This is going to cost you. | Hunting the dead in the desert. What is there not to like. | The %companyname% can help, for the right price.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This doesn\'t sound like our kind of work. | I won\'t lead the men on a wild goose chase through the desert. | I don\'t think so. | I say no. The men prefer known enemies of flesh and blood.}",
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
			Text = "[img]gfx/ui/events/event_161.png[/img]{While tracking footprints across the sands you come upon another set of tracks, considerably more frantic and less purposeful than the ones you have followed thus far. The second set of tracks lead to a half dozen ancient grain silos constructed from mud brick and dry beams of wood.\n\n These structures have been here for some time and are clearly abandoned, signs of fire dot the foundations of where other buildings once stood. In the distance you hear a loud wailing — akin to a spirit or a dozen children crying.\n\n On the approach you notice a conscript covered in blood and gibbering incoherently, still wearing tattered armour and holding their spear as if they were about to fall from a high place. Suddenly noticing your presence the soldier jumps to his feet, hitting their head on the roof of the silo. They scream in pain and roll out of the doorway, bellowing to be left alone.\n\n Panic overtakes them and they thrust at you with their spear — you deftly dodge the clumsy thrust and push them. With a loud snap their spine and skull shatters on the soft sand — killing them near instantly.\n You are losing precious time and the sand is covering the more important set of tracks — you assemble a crude cairn for the body beneath the old silos and move on.\n\n As you leave, the mud brick monoliths stand silent, watching. Perhaps thankful for the company you have left them.}",
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
			Text = "[img]gfx/ui/events/event_153.png[/img]{After the long journey you finally arrive at the group of undead you have been tracking, curiously, the dead are covered in glistening gold and bronze. Swimming around in circles at the base of a dune the group has clearly become distracted by something nearby or have lost their intended target a few hours ago.\n\n An uneasy feeling builds in your stomach as one by one, the dead form up into a fighting line. Now motionless and attentive, the dead stand ready with their mantles, ear rings and adornments, a size too large, shifting loosely in the wind from their desiccated remains.\n\n A better decorated corpse lets out a mournful howl and the column of dried skin and gold begins to advance.}",
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
			Text = "[img]gfx/ui/events/event_160.png[/img]{As the last of the embalmed are slain their jewelry jingles and chimes as they fall into the soft sand. A nauseating feeling comes over you, as if you have not slept for months or had water for days, your skin feels thinner and your bones creak and pull away at one another. After a few moments the feeling passes and your strength returns.\n\n Your concern now shifts to the dozen or so corpses littering the battlefield. The Vizier wanted proof and you will provide it with more than a mere arm. You find the most resplendent embalmed slumped in a pile and take off the head with a few precise cuts, headdress and all.\n Strapping it to your belt you begin to make the long journey home with your new prize — but not before taking some of the jewelry for the trouble.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "It\'s done.",
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
			Text = "[img]gfx/ui/events/event_162.png[/img]{You stride into the Vizier\'s main chamber, dutifully placing the head on the table where the arm once sat. A servant in the far corner with a stained rag lets out a miserable sigh and exits the room. The Vizier inspects the head closely from their seat. %SPEECH_ON%It is done?%SPEECH_OFF% You nod in response.\n At another corner of the room, guards and servants briefly intermingle, swapping money and curses alike. %SPEECH_ON%I have not seen anything like this before crownling — but if the threat is dealt with then you may leave with your reward.%SPEECH_OFF% He motions you to leave and a servant hurriedly drops a pouch of crowns in your hands. A thought crosses your mind that the gold from the headdress was likely worth double than what you were paid.\n Meanwhile, a guard approaches the head and skewers it through the eye socket with their spear, carrying it off to the next room.\n As you begin to leave, you hear a loud curse and a dull thud of flesh on a hard floor, followed by girlish screams of nobles. You take the time to count your coins while eavesdropping on the dramatic events in the next room, then leave once you are satisfied with both.}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Rid the city of the dead");
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
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/terrified_villagers_situation"));
		}
	}

	function spawnEnemies() {
		local disallowedTerrain = [];
		for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i ) {
			if (i == this.Const.World.TerrainType.Desert)
				continue;
			disallowedTerrain.push(i);
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local mapSize = this.World.getMapSize();
		local tile = this.getTileToSpawnLocation(playerTile, 8, 12, disallowedTerrain);
		local party;
		party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).spawnEntity(tile, "Embalmed", false, this.Const.World.Spawn.MummiesPatrol, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("Glints of gold and heavy steps serve as a warning to all.");
		party.setFootprintType(this.Const.World.FootprintsType.Undead);
		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(0.75);

		for( local i = 0; i < 1; i = ++i ) {
			local nearTile = this.getTileToSpawnLocation(playerTile, 5, 10, disallowedTerrain);
			if (nearTile != null)
				this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.UndeadFootprints, this.Const.World.FootprintsType.Undead, 0.75);
		}

		this.m.Target = this.WeakTableRef(party);
		local nearestUndead = this.getNearestLocationTo(this.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements());
		party.getSprite("banner").setBrush(nearestUndead.getBanner());
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setPivot(this.m.Home);
		roam.setMinRange(8);
		roam.setMaxRange(12);
		roam.setNoTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Desert, true);
		c.addOrder(roam);
		return party;
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.setAttackableByAI(true);
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
		return true;
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

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		this.contract.onDeserialize(_in);
	}

});

