this.legend_hunting_redback_webknechts_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = false,
		MinStrength = 10, // player needs to earn 10% of bonus (not including base 5% bonus) for this contract to be valid
		Perk = ::Legends.Perk.LegendFavouredEnemySpider,
		ValidTypes = this.Const.LegendMod.FavoriteSpider,
		LevelSumRequiredForRandomSpawn = 50,
		IsRandomlyAdded = null,
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_hunting_redback_webknechts";
		this.m.Name = "Hunting Redback Webknechts (Legendary)";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
		this.m.DescriptionTemplates = [
			"The woods are poisoned. The way is blocked. Scuttling horrors chitter in the dark. There is something odd at work here.",
			"Bloated red bodies and gaping maws skitter through the darkness, hungry for blood.",
			"Monstrous forms of red chitin haunt the dark, driven by an insatiable hunger to constantly feed.",
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
		this.m.Payment.Pool = 900 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"Hunt down Redback Webknechts in the woods around " + this.Contract.m.Home.getName()
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
						this.Flags.set("IsOldArmor", true);
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
					if (this.Flags.get("IsOldArmor") && this.World.Assets.getStash().hasEmptySlot())
					{
						this.Contract.setScreen("OldArmor");
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
			Text = "[img]gfx/ui/events/event_31.png[/img]{As you approach the keep of %employer% you pass through a courtyard filled with broken down carts and barking dogs pulling at their chains, a guard in a stained jerkin sits drinking on the stair, he nods you past. When you enter the keep itself you hear children yelling at each other, before a nasal woman\'s voice cuts through their chatter.%SPEECH_ON%Oi! you lot knock it off, we\'ve got company%SPEECH_OFF% The children protest a little but calm down. A large man waves you over, he is sitting topless by a fireplace eating a large hunk of meat, that has spilled juices on his huge hairy belly %SPEECH_ON%You came then? I thought maybe you were as weak as the rest of them spider hunters. Well I guess you\'ve heard then, we\'ve got a nest of them big black blighters. They are drawn in by the midden, that pile of filth has bugs the size of my fist and the spiders love it. I told the guards to clean it out, but they must have been mistaken for bugs, because none came back. %SPEECH_OFF%  He wipes his mouth with a hairy arm and takes a huge swig from an ale cask before burping loudly.  %SPEECH_ON%These ain\'t ordinary spiders mind you, a single bite could fell a giant. I know it is a big job, and I\'m prepared to pay you well for it. Interested? %SPEECH_OFF%  | You find %employer% behind the main keep, stretched out on his back under a catapult. You don\'t think he could have seen you from under there, but while still tinkering away he calls out. %SPEECH_ON%Ah, the spider hunter, just the one I wanted to see. We have a bit of a nasty problem.%SPEECH_OFF% He slides out from under the catapult and you see his uncovered chest is smeared with dirt, he pats the device affectionately. %SPEECH_ON%Not the kind of problem Bertha here can fix %SPEECH_OFF%. He pulls a robe over his shoulders and continues as he walks you back to the keep. %SPEECH_ON%We have had spiders in these parts for a long time, absolute bastards if they get a hold on you, but easy enough for the boys to scare off. Recently though we have been visited by spiders of a different kind. Giant black things with a huge gash of red upon their back. A single bite has enough poison enough to fell a knight. I hear you are the one for the job and I am prepared to pay handsomely. Are you interested? %SPEECH_OFF% }",
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
			Text = "[img]gfx/ui/events/event_25.png[/img]{You stumble across a dead cow with its flesh sucked to its very bones, yet its hide does not carry any sign of being sundried. %randombrother% crouches and runs a finger among a number of puncture wounds, but recoils in pain.%SPEECH_ON%It burns! This is clearly the work of a webknecht, no doubt to it, but with poison that burns to the touch. I\'d say they poisoned it and then fed upon its paralyzed body. And a fresh corpse means they\'re close...%SPEECH_OFF% | You find a webbed corpse leaning against a lone tree. You slash the filaments away. An old woman\'s body slips out and crumples to the ground. Its face is tight to the bone, a pallid skull with the eyeballs peeking from deep in the sockets. The tongue is equally receded and there\'s hardly a nose at all. %randombrother% spits and nods.%SPEECH_ON%Alright. We\'re close. Rather, they\'re close. If it\'s solace to you folks, the woman died prior to this here state of being. Redback Webknechts bring poison with their puncturing and no one would stand to survive it long.%SPEECH_OFF%Well that\'s good. Time for the men to find these monsters. }",
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
			Text = "[img]gfx/ui/events/legend_redback.png[/img]{The nest of webknechts is a pit of earth wreathed in white. At its rim are thin filaments which list about at even the slightest suggestion of a breeze. Marching your company inward, the webbing begins to take a sort of civilized shape, as though you were walking in from wintery hinterland, the recency of its creation apparent in its tight trappings: deer, dogs, man-sized cocoons which show no sign of life, all bound snug in the hangars of white silos and planes like morsels lost upon a pale rug. A black shadow saunters up behind the veiled domicile, coming to the fore with its legs squatting defilade, its head crouched beyond them as though the foul cretin were gated by its own stride. A human hand sucks in and out from its mandibles like some macabre pacifier. You\'ve come to the right place. | The webknecht nest is silent and the clatter of the company\'s arrival seems apocryphal, with the chink and clink of metals distinctly sharp in their trespass.\n\n You find a man hanging upside down from a tree, his whole body cocooned save his face which is stretched and pulled by the filaments. He asks you cut his eyelids free of the webbing which you oblige. His lids slowly close, the crust of the dry eyes crackling closed for the first time in possibly days. But then they snap open and the man screams. The cocoon bubbles at his waist and rips apart, a sputtering of tiny black spiders flooding out. The man\'s body jolts violently around as the swarm consumes him, his gargled screams rife with the skittering of spiderlings which fill his lungs and which he coughs out in dying fits. Horrified, you step back only to see a throng of much larger spiders emerging from around the trees! | The nest is an easy spot, a stretch of winterscape where there\'s no cold, the white webbing patchy and listing from every tree, every copse, every inch of the place. You march the company right in, weapons drawn, and there you come across the wrapped bodies, their centers blown open and blackened, a spawn of spiderlings sucking on the organs.\n\n  Staring up, you see red eyes flare between the branches of the surrounding trees, the whole arachnidian arboretum come alive, its wardens perched there amongst the brush with their squatted legs indistinguishable from the branches, the enemy hiding in plain sight. You damn near shit yourself when a supposed tree unfolds entirely, every wooden stalk but a spider leg, the arborous sleight descending on the company chittering and chamfering for a bite!}",
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
			Text = "[img]gfx/ui/events/legend_redback_dead.png[/img]{The last of the redbacks is dealt with, its legs gating itself in as though to eternally clutch at the weapon which had slain it. You nod at the company\'s good work then order the whole place torched. Fires rapidly run the length of the webs, breaking bridges of filament apart and sending fiery doom to their connectors. The whole nest is consumed in the inferno and somewhere deep in its bedding you hear the shrill cry of spiderlings set alight. | You step close to the last of the redbacks and stare at its grisly maw. It carries a vicious set of mandibles for a sort of gum guard, the mouth itself a slit lined with razor sharp teeth pointed counter-current as to shred anything that tried to escape.\n\n You order the whole nest put to the torch. As the flames rise, there comes the cry of spiderlings somewhere in their warrens. | You ready a return to %employer%, but first have the nest torched entirely. The company stands before the flames listening to the shrill cries of spiderlings and at times laughing at the little mites scuttling around like tiny fireballs on legs. | The spiders defeated, you have the whole godsforsaken place burned and ready a return to %employer%. As the fires rise, tiny spiderlings come running out with their bodies aflame like fireflies in the night. A few sellswords take up an impromptu game of seeing who can squash the most, an affair which ends with a particularly ambitious spiderling almost setting a mercenary\'s pants alight.}",
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
			ID = "OldArmor",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/legend_redback_dead.png[/img]{With the webknechts dispatched you have the company briefly search the creatures\' nest, though the mercenaries are ordered to never wander alone. You muck about as well, %randombrother% at your side. Together, you spot a tree that is remarkably untouched by the webs. As you circle around, you find a knight\'s corpse leaning against its trunk. His hand rests atop a broken sword\'s pommel, the other hand is missing altogether, nothing but sleeve at the wrist with the mutilated arm couched at his belly. The corpse rests in a nest of its own making, a thicket of what look like spoiled rhubarb stalks and decayed carapaces, the broken bodies caverned and smelling of poison. %randombrother% nods.%SPEECH_ON%That\'s a right shame. I\'d wager he would have made a sound addition to the %companyname%, whoever he was.%SPEECH_OFF%Indeed, it has all the look of a great fighter\'s end. You\'ve mind to bury him, but you\'ve no time. You tell %randombrother% to fetch what he can from the corpse and to ready a return to %employer%.}",
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
				local item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.mail_hauberk],
					[1, ::Legends.Armor.Standard.coat_of_scales]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain a " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Survivor",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/legend_redback_dead.png[/img]{The battle over, you find a man dangling by webbing attached to his feet. Half of his body is bound in the filaments and more dangle from his hip like a shredded dress. Seems the spiders deserted him upon the %companyname%\'s arrival. He smiles at the sight of you.%SPEECH_ON%Hey there. Mercenaries ain\'t ya? Yeah I see it. You\'ve no mind being here lest it was coin that brought ya, and you fought like bastards that\'d been bet on. Absolute savages.%SPEECH_OFF%You ask the man what you\'ll get for cutting him down. He turns his head up, his whole body then starting to swing about and at times twist him away from you entirely. He speaks, either to you or to whichever direction he\'s facing.%SPEECH_ON%Aye, good question! Well, you may not see it here and now, but I\'m a sellsword m\'self, and wouldn\'t you know that my company and its captain all been done stringed up and consumed whole by them spiders! Cut me down and I\'ve nowhere else better to go then your company. That is, if you\'d have me.%SPEECH_OFF%You have the man cut free and debate what to do before returning to %employer%.}",
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
					"swordmaster_background"
				]);

				if (!this.Contract.m.Dude.getSkills().hasTrait(::Legends.Trait.FearBeasts) && !this.Contract.m.Dude.getSkills().hasTrait(::Legends.Trait.HateBeasts))
				{
					::Legends.Traits.remove(this.Contract.m.Dude, ::Legends.Trait.Fearless);
					::Legends.Traits.grant(this.Contract.m.Dude, ::Legends.Trait.FearBeasts);
				}

				this.Contract.m.Dude.getBackground().m.RawDescription = "You found %name% dangling from a tree, the sellsword the last survivor of a mercenary band sent to kill redback webknechts. He joined the company after you rescued him.";
				this.Contract.m.Dude.getBackground().buildDescription(true);
				this.Contract.m.Dude.worsenMood(0.5, "Lost his previous company to webknechts");
				this.Contract.m.Dude.worsenMood(0.5, "Almost consumed alive by webknechts");

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
			Text = "[img]gfx/ui/events/event_85.png[/img]{%employer% meets you at the town entrance and there is a crowd of folks beside him. He welcomes you warmly, stating he had a scout following you who saw the whole battle unfold. After he hands you your reward, the townsfolk come forward one by one, many of which are reluctant to stare a sellsword in the eyes, but they offer a few gifts as thanks for relieving them of the webknecht horrors. | You have to track down %employer%, ultimately finding the man in a stable livery with a peasant girl. He saws upward from the hay, startling the horses which whinny and stamp their feet. Half-dressed, the man states he already has your pay and forks it over. Eyeing you eyeing the girl, he then starts to grab whatever\'s in reach, including from the saddlebags of stabled mounts, and hands them over.%SPEECH_ON%The, uh, townsfolk also sought to pitch in. You know, as thanks.%SPEECH_OFF%Right. For further \'thanks\' you ask if he\'ll give you whatever\'s in a nearby satchel. | %employer% welcomes you back with a great clap and rub of his hands, as though you\'d just brought in a turkey and not the horrifying evidence of your victory. After paying you the agreed reward, you hear some surprising news. The mayor states that the estate of a lost townsman could not be properly divvied up and, as further thanks, you\'re free to take what\'s left of it.}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of webknechts");
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
					food = this.new("scripts/items/supplies/cured_venison_item");
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

	function spawnEnemies() {
		local disallowedTerrain = [];

		for (local i = 0; i < this.Const.World.TerrainType.COUNT; i++) {
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
				if (tile.Type == this.Const.World.TerrainType.Forest || tile.Type == this.Const.World.TerrainType.LeaveForest || tile.Type == this.Const.World.TerrainType.AutumnForest) {
					numWoods = ++numWoods;
					numWoods = numWoods;
				}
				y++;
			}
			x++;
		}

		local tile = this.getTileToSpawnLocation(playerTile, numWoods >= 12 ? 6 : 3, 9, disallowedTerrain);
		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Redback Webknechts", false, this.Const.World.Spawn.LegendRedbackSpider, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("A swarm of redback webknechts skittering about.");
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
		roam.setNoTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Forest, true);
		roam.setTerrain(this.Const.World.TerrainType.LeaveForest, true);
		roam.setTerrain(this.Const.World.TerrainType.AutumnForest, true);
		roam.setMinRange(1);
		roam.setMaxRange(1);
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
