this.legend_hunting_basilisks_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Beastslayer = null,
		Target = null,
		Dude = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_hunting_basilisks";
		this.m.Name = "Basilisk Infestation";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DescriptionTemplates = [
			"An ominous clucking floats across the fields at dawn. Locals tell tales of a bloodthirsty beast standing taller than a man.",
			"Underestimate these giant chickens at your peril. A single one can either kill or feed an entire company.",
			"With eyes that shine like burning coals and a bawk that chills the blood, a basilisk is not to be trifled with.",
			"The thick plumage provides formidable protection against weapons and spells, making it a challenging adversary.",
			"Powerful pecks and thrashing wings create a whirlwind of destruction that can quickly incapacitate unwary adventurers.",
			"Beware the deceptively agile movements, for its powerful talons can shred armor and flesh alike with ease.",
			"The reports could be dismissed as a fever dream, if not for the corpses left behind.",
		];
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 490 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"Hunt down basilisks in the woods around " + this.Contract.m.Home.getName()
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

				if (r <= 10)
				{
					if (this.Contract.getDifficultyMult() >= 0.9)
					{
						this.Flags.set("IsExtraLoot", true);
					}
				}
				else if (r <= 20)
				{
					this.Flags.set("IsSurvivor", true);
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
					if (this.Flags.get("IsExtraLoot") && this.World.Assets.getStash().hasEmptySlot())
					{
						this.Contract.setScreen("ExtraLoot");
					}
					else if (this.Flags.get("IsSurvivor") && this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
					{
						this.Contract.setScreen("Survivor");
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
			Text = "[img]gfx/ui/events/event_43.png[/img]{%employer% sinks into their chair and stares through you. Peasants with pitchforks swan around outside, voices are raised beyond the window and then start to dissipate moments later. %employer% runs their hands through their hair and meets your gaze. %SPEECH_ON%I have been in talks with the leaders of that mob outside for the best part of the day. Their crops are trampled, stolen or half eaten in their fields. Some even say their livestock has gone missing.%SPEECH_OFF% They rise from the chair and move towards the window. %SPEECH_ON%They want me to replace everything they lost, Sellsword. But the best I can do is put an end to it. Some of these madmen claim chickens larger than a man swallowed their lambs whole. I don\'t care who or what has been doing this, but make sure you put an end to it.%SPEECH_OFF% %employer% turns to face you. %SPEECH_ON%Do I have your interest, Sellsword?%SPEECH_OFF% | A group of men leave a much finer building than any of them could possibly claim ownership to combined, they are dressed in clothes clearly not worn often, the fine cloth contrasting horribly against their sun-blotched skin and calloused hands. They move past %companyname% spitting curses and fighting amongst themselves. You enter the building and there %employer% sits, sipping wine and leafing through parchment papers. They speak to you without acknowledging your presence. %SPEECH_ON%I don\'t doubt you saw that miserable bunch that just left. Those simple fools claim that a giant chicken swallowed their dog whole and trampled their crops. Tosh! To me, Sellsword, it sounds like your standard corpse-eater or perhaps some kind of elaborate brigand scheme to frighten us.%SPEECH_OFF% They move some papers into a new pile and produce a bag of crowns from a draw, seemingly with rehearsed effort. Their tone becomes more moody and disapproving. %SPEECH_ON%I keep a rainy day fund for these things, whatever the problem is - fix it and it\'s yours.%SPEECH_OFF%}", // 1-3 more needed
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{How many crowns can you muster? | Let\'s talk pay. | Let\'s talk crowns.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{I\'d prefer to hunt smaller chickens.}",
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
		this.m.Screens.push({ //flavour
			ID = "Banter",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_25.png[/img]{You smell it before you see it, but you still almost trip over the half decomposed carcass of a giant bird. %randombrother% is not so lucky, and trips over the wing to disturb a flurry of flies and worms. %SPEECH_ON%Farkin\' \'ell%SPEECH_OFF% As they brush the slime from their boots, you notice the sheer size of this monster and the pointed beak which is still sharp enough cut your hand on. The eyes have been picked out and the feathers are ruined - what meat remains has spoiled here in the heat on the forest floor. | %companyname% trapises further into the woods, part of the land far from the eyes and care of men. A large nest, much larger than that of what you are hunting, lies in a ditch below a thick treeline. Bones of large animals and men litter the nest and surrounding area - some remains are crushed or torn apart while others are only missing hands or feet. %randombrother% picks through the remains %SPEECH_ON%Lizard nest. Not what we\'re here for, long gone by the looks of things...%SPEECH_OFF% You noticed some eggs within the nest differ slightly in size and shape. | You come across a ditch that is filled with a stagnant pool of filth and remains. Various corpses of both animal and man litter this place, some obviously dragged dead while others were more more alive.}",
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
			],
			function start()
			{
			// TODO there's no _event in contracts! - chopeks
//				if (_event.m.Beastslayer != null)
//				{
//					this.Options.push({
//						Text = "%beastslayer% is an expert in these things.",
//						function getResult( _event )
//						{
//							return "beastslayer";
//						}
//					});
//				}
			}
		});
//		this.m.Screens.push({ //lore
//			ID = "beastslayer",
//			Title = "The Beastslayer Speaks...",
//			Text = "[img]gfx/ui/events/event_122.png[/img]{%beastslayer% pokes through the remains...} {%SPEECH_ON%These things are pure evil. And I don\'t mean that lightly. I could spin you a yarn \'bout how man is the real monster and such but it\'d be farkin\' nonsense. I\'ve seen \'knechts with better table manners than a noble and farmers with more balls than\' a giant. We\'re as bad as them and they\'re as bad as us. But these \'lisks invade \'wurm nests and eat their eggs, then lay their own in \'em and let the stupid lizard take care of it while it falls off a cliff or eats a child or somethin\'. All I\'m sayin\' is I won\'t hesitate killing these devils when\' we find \'em.%SPEECH_OFF% | %SPEECH_ON%Look at this poor fark here%SPEECH_OFF% The slayer pokes through human remains with their boot, the figure is barely covered in rags and even as a skeleton, looks in unimaginable agony - twisted this way and that like the tree roots around them. %SPEECH_ON%He\'s got egg shell where his stomach should be, looks like he tried to eat one of the eggs. I haven\'t seen it myself but apparently the eggs taste rotten and smell just as bad. Must\'ve been a wildman or maybe a slave on the run to be this desperate. Probably went rotten from the inside himself and had a slow death here.%SPEECH_OFF% | %SPEECH_ON% Back in %randomtownname% I spent time in the tavern with two farmers who saw one of these things hatch on their own farm. Swore it hatched from a rotten egg and within a day it was trying to kill the other hatchlings. Considering the man was eight cups deep before I even sat down I wouldn\'t put much faith in it. Some think they\'re hatched by toads, snakes or even roosters when people aren\'t looking. What I do know is they\'re vermin. Plain and simple.%SPEECH_OFF%}\n\n{With this said, you should get back to the hunt.}",
//			Image = "",
//			List = [],
//			Options = [
//				{
//					Text = "Good to know.",
//					function getResult()
//					{
//						local xp = this.Math.rand (9, 43); //Query: can the player exploit this to farm xp? I think this event will keep triggering? - Luft
//						foreach( bro in playerRoster )		//Follow up: now that I think about it, if they are willing to lose gold per day in exchange for rabble-tier xp maybe they deserve it. Plus there's no free beastslayer so they'd need to pay at least this background for this event to MAYBE fire multiple times and drip feed them xp. - Luft
//						{
//							bro.addXP(xp);
//							bro.updateLevel();
//						}
//						return 0;
//					}
//				}
//			],
//			function start( _event )
//			{
//				this.Characters.push(_event.m.Beastslayer.getImagePath());
//			}
//		});
		this.m.Screens.push({ //battle
			ID = "Encounter",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_44.png[/img]{Breaking through the brush, you are met with absolute bedlam from the beasts - who are currently chasing one another around their nests and occasionally engaging in acts of opportunistic murder of their smaller kind. The smell is a mixture of a butcher\'s market and tavern vomit. Some of the larger and battle-scarred basilisks have no concern of their surroundings and are safety tucked in their nests woven of branches, bones and filth. Some eggs have hatched recently while others appear to be smashed or crushed. Whatever the case, these monsters have been here for some time and will be more than willing to defend their nests. | Traversing a slope downwards, you fall into a shallow puddle of mud and filth. As you crawl out, you snap a femur of a deer carcass strewn out at the pool\'s edge.\n\n For a moment, the woods fall silent. Then in the distance you feel long and heavy strides becoming louder each second... | You make an effort to move through the mire of filth left behind by these animals, you wish it were mud, but the smell would suggest otherwise. %randombrother% falls into a deeper patch and lets out a curse as they recover. After a moment, the forest comes alive with shrieking and calling all around you. Whatever element of surprise you had is gone now...}",
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
		this.m.Screens.push({ //post battle
			ID = "Victory",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_128.png[/img]{The cackling and screams die down as the remaining basilisks retreat into the woods, tackling and attacking each other to create distractions as they go. Feathers, gore and the wafting smell of warm birdshit assaults your senses. You didn\'t get all of them, but you\'d like to think that their descendants of those that got away will tell stories of how you massacred their ancestors.\n\n You make extra effort to burn the nests and smash the eggs for good measure.}",
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
		this.m.Screens.push({ //post battle item loot - get extra feathers
			ID = "ExtraLoot",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_128.png[/img]{With the battle over, the screeching dies down and %companyname% finishes off the wounded basilisks. Some of them are barely ruined at all, and provide some additional feathers. They look valuable and you wonder if you could fashion something out of them...}",
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
				local item = this.new("scripts/items/misc/legend_basilisk_feathers_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}

		});
		this.m.Screens.push({ //post battle bro hire
			ID = "Survivor",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_128.png[/img]{After the noise of battle dies down and the smell rises, you notice a discarded and broken bow stamped into the mud at the edge of the nest clearing. A smaller basilisk has met it\'s end courtesy of several arrows firmly placed in it\'s skull. A tree branch cracks and above you, a hunter in tattered clothes and various wounds smiles down upon you as if they were a mocking, filthy angel. %SPEECH_ON%Much faster then they look, eh?%SPEECH_OFF% The tree they have claimed is pocked with deep gouges and claw marks from every angle, only abruptly ending a few feet up the trunk. The anger of each strike is so fierce that it almost seems as if the objective was to bring the tree itself down. %SPEECH_ON%Got the smaller one but that only made the bigger ones more angry. Meat is good if you know where to cut and there\'s plenty of it... say, you got room for one more?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to the company!",
					function getResult()
					{
						this.World.getPlayerRoster().add(this.Contract.m.Dude);
						this.World.getTemporaryRoster().clear();
						this.Contract.m.Dude.onHired();
						this.Contract.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "You\'ll have to find your luck elsewhere.",
					function getResult()
					{
						this.World.getTemporaryRoster().clear();
						this.Contract.m.Dude = null;
						return 0;
					}

				}
			],
			function start()
			{
				local roster = this.World.getTemporaryRoster();
				this.Contract.m.Dude = roster.create("scripts/entity/tactical/player");
				this.Contract.m.Dude.setStartValuesEx([
					"hunter_background"
				]);

				if (!this.Contract.m.Dude.getSkills().hasTrait(::Legends.Trait.FearBeasts) && !this.Contract.m.Dude.getSkills().hasTrait(::Legends.Trait.HateBeasts))
				{
					::Legends.Traits.remove(this.Contract.m.Dude, ::Legends.Trait.Fearless);

					::Legends.Traits.grant(this.Contract.m.Dude, ::Legends.Trait.FearBeasts);
				}

				this.Contract.m.Dude.getBackground().m.RawDescription = "You found %name% cornered by basilisks in the woods where the hunter quickly became the hunted and climbed a tree to survive. While they jest about the situation with everyone else, you can\'t help but notice a simmering anger whenever they see a coup of chickens.";
				this.Contract.m.Dude.addLightInjury();
				this.Contract.m.Dude.getBackground().buildDescription(true);
				this.Contract.m.Dude.worsenMood(0.5, "Almost consumed alive by basilisks");

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).setArmor(this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).getArmor() * 0.33);
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).setArmor(this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).getArmor() * 0.33);
				}

				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_85.png[/img]{%employer% greets you as you enter the room. While they remain solemn their nose suggests otherwise. A decorated servant stands by with a bag of crowns, this is almost a ceremony of sorts. %SPEECH_ON%Well done Sellsword! We all appreciate you ridding us of these...what did you call them, Wellington?%SPEECH_OFF% The steward looks at %employer% sheepishly. %SPEECH_ON%Cockatrices, Sir.%SPEECH_OFF% Two guards look at one another at the doorway almost out of your view, grinning ear-to-ear. %SPEECH_ON%Thank you for your expertise here, Sellsword!%SPEECH_OFF% Before you can correct them, a coin bag arrives in your hands and you are quickly escorted out of the hall. A servant rapidly cleans the filth left in %companyname%\'s wake.\n\n Some of the peasants bring you food and drink as further thanks before you leave.}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of basilisks");
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
				local food;
				local r = this.Math.rand(1, 3);

				if (r == 1)
				{
					food = this.new("scripts/items/supplies/bread_item");
				}
				else if (r == 2)
				{
					food = this.new("scripts/items/supplies/pickled_mushrooms_item");
				}
				else if (r == 3)
				{
					food = this.new("scripts/items/supplies/roots_and_berries_item");
				}

				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "You gain " + food.getName()
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_beastslayer = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.beast_slayer" || bro.getBackground().getID() == "background.legend_guildmaster")
			{
				candidates_beastslayer.push(bro);
			}
		}

		if (candidates_beastslayer.len() != 0)
		{
			this.m.Beastslayer = candidates_beastslayer[this.Math.rand(0, candidates_beastslayer.len() - 1)];
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Target.getTile())]
		]);

		_vars.push([
			"beastslayer",
			this.m.Beastslayer ? this.m.Beastslayer.getNameOnly() : ""
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/disappearing_villagers_situation"));
		}
	}

	function spawnEnemies() {
		local disallowedTerrain = [];
		for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i ) {
			if (i == this.Const.World.TerrainType.Forest || i == this.Const.World.TerrainType.LeaveForest || i == this.Const.World.TerrainType.AutumnForest)
				continue;
			disallowedTerrain.push(i);
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local mapSize = this.World.getMapSize();
		local x = this.Math.max(3, playerTile.SquareCoords.X - 9);
		local x_max = this.Math.min(mapSize.X - 3, playerTile.SquareCoords.X + 9);
		local y = this.Math.max(3, playerTile.SquareCoords.Y - 9);
		local y_max = this.Math.min(mapSize.Y - 3, playerTile.SquareCoords.Y + 9);
		local numWoods = 0;

		while (x <= x_max) {
			while (y <= y_max) {
				local tile = this.World.getTileSquare(x, y);
				if (tile.Type == this.Const.World.TerrainType.Forest || tile.Type == this.Const.World.TerrainType.LeaveForest || tile.Type == this.Const.World.TerrainType.AutumnForest)
					numWoods++;
				y++;
			}
			x++;
		}

		local tile = this.getTileToSpawnLocation(playerTile, numWoods >= 12 ? 6 : 3, 9, disallowedTerrain);
		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Basilisks", false, this.Const.World.Spawn.LegendBasiliskLOW, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("A stampede of basilisks hunting for food");
		party.setFootprintType(this.Const.World.FootprintsType.Basilisks);
		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(1.10);

		for( local i = 0; i < 2; i = ++i ) {
			local nearTile = this.getTileToSpawnLocation(playerTile, 4, 5);
			if (nearTile != null)
				this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Basilisks, 0.75);
		}

		this.m.Target = this.WeakTableRef(party);
		party.getSprite("banner").setBrush("banner_beasts_01");
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setNoTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Forest, true);
		roam.setTerrain(this.Const.World.TerrainType.LeaveForest, true);
		roam.setTerrain(this.Const.World.TerrainType.AutumnForest, true);
		roam.setMinRange(1);
		roam.setMaxRange(1);
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

		this.m.Beastslayer = null;
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

