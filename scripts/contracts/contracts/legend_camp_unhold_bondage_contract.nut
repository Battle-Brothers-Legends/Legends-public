this.legend_camp_unhold_bondage_contract <- this.inherit("scripts/contracts/legend_camp_contract", {
	m = {
		Target = null,
		IsPlayerAttacking = true
	},

	function create() {
		this.legend_camp_contract.create();
		this.m.Type = "contract.legend_camp_unhold_bondage_contract";
		this.m.Name = "Capture Unhold";
		this.m.EmployerFaction = ::Legends.CampContracts.EmployerFaction.Barbarians;
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = ::Math.rand(95, 125) * 0.01;
		this.m.DescriptionTemplates = [
			"Friendly barbarian tribe seeks unhold line-breakers. This should be interesting.",
			"Local barbarian warlord in the market for a personal unhold. Alive, preferably...",
		];
		this.m.Payment.ItemPool = [
			[50, "loot/bone_figurines_item"],
			[30, "loot/bead_necklace_item"],
			[20, "loot/valuable_furs_item"],
			[10, "loot/looted_valuables_item"]
		];
	}

	function isVisible() {
		// exclude bottom half of the map, there's no unholds there anyway, nor barbs
		local currentTile = ::World.State.getPlayer().getTile();
		if (currentTile.SquareCoords.Y < ::World.getMapSize().Y * 0.5)
			return false;
		return true;
	}

	function start() {
		this.m.Payment.Pool = 800 * this.getPaymentMult() * ::Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (::Math.rand(1, 100) <= 10) {
			this.m.Payment.Completion = 0.9;
			this.m.Payment.Advance = 0.1;
		} else {
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates() {
		this.m.States.push({
			ID = "Offer",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					"Equip provided nets",
					"Hunt and capture at least one unhold"
				];

				if (::Math.rand(1, 100) <= ::Const.Contracts.Settings.IntroChance) {
					this.Contract.setScreen("Intro");
				} else {
					this.Contract.setScreen("Task");
				}
			}

			function end() {
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = ::Math.rand(1, 100);

				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				this.Contract.spawnEnemies();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);

				local count = ::Math.rand(1, 3);
				while (count--) {
					::World.Assets.getStash().add(::new("scripts/items/tools/legend_unhold_throwing_net"));
				}
			}

		});
		this.m.States.push({
			ID = "Running",
			function start() {
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull()) {
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update() {
				if (this.Flags.getAsInt("CapturedUnholds") > 0) {
					local target = this.Contract.m.Target;
					if (target != null) {
						::World.EntityManager.onWorldEntityDestroyed(target, false);
						target.onCombatLost();
					}
					this.Contract.m.Target = null;
				}
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive()) {
					this.Contract.setScreen("AfterBattle");
					this.World.Contracts.showActiveContract();
					if (this.Flags.getAsInt("CapturedUnholds") > 0) {
						this.Contract.setState("Return");
					} else {
						this.Contract.setState("Chase");
					}
				}
			}

			function onTargetAttacked(_dest, _isPlayerAttacking) {
				if (!this.Flags.get("IsEncounterShown")) {
					this.Flags.set("IsEncounterShown", true);
					this.Contract.setScreen("Encounter");
					this.World.Contracts.showActiveContract();
				} else {
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}
		});
		this.m.States.push({
			ID = "Chase",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					"Wait for your employer to contact you."
				];
				this.Contract.spawnRevengeEnemies();
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull()) {
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update() {
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive()) {
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked(_dest, _isPlayerAttacking) {
				if (!this.Flags.get("IsBarbEncounterShown")) {
					this.Flags.set("IsBarbEncounterShown", true);
					this.Contract.setScreen("BarbEncounter");
					this.World.Contracts.showActiveContract();
				} else {
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}
		});
		this.m.States.push({
			ID = "Return",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					"Wait for your employer to contact you."
				];
			}

			function update() {
				this.Contract.setScreen("Success");
				this.World.Contracts.showActiveContract();
			}

		});
	}

	function createScreens() {
		this.importScreens(::Const.Contracts.NegotiationItemsOnly());
		this.importScreens(::Const.Contracts.Overview);

		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{Sat around the fire in camp, the sudden appearance of a barbarian warrior in full armour sends the company into a scramble. Some grab weapons, others holler for others to come quick, and you reach for your sword as the barbarian puts their hands to their side, gesturing calm. Equally as surprising as their sudden appearance in the middle of camp, they speak directly to you in fluent, albeit strained common tongue.%SPEECH_ON%Fear not, captain. I am here as a messenger only. My tribe has an offer for you, an opportunity to enrich us both. Besides, if you kill me, my tribe will know, and your company will not survive the night.%SPEECH_OFF%Well then. More of the company pours in, confused as to how and why a barbarian is directly addressing the captain of a mercenary company which often profits through the slaughter of their kin. You match their gesture of calm, lowering your sword back to its sheath. A nod and reassuring look to the company shows your interest in the unusual proposal.%SPEECH_ON%Unholds, you call them. We need them. War comes, our tribe is depleted, and we need more of the giantkin to fight against our enemies. We would give you our means, you would capture them and deliver them to us. Your reward would be great.%SPEECH_OFF%One of the men scoffs at the notion, another proclaims their scepticism. The barbarian looks sincere, and the opportunity could be lucrative – if you survive the ordeal. Carefully, you respond...}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{ What can you offer us? | We can do this – for the right price. | Subduing unholds won\'t come cheap. }",
					function getResult() {
						return "Negotiation";
					}

				},
				{
					Text = "{ The risks are too high - we refuse. | We aren\'t equipped for such a task. | We kill unholds, not capture them. Count us out. }",
					function getResult() {
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			]
		});

		this.m.Screens.push({
			ID = "Encounter",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{Your employer\'s tip paid off – a pack of bumbling unholds presents itself as you follow their messy tracks. Hunched around the carcass of a [deer/wolf/horse], the lumbering giants tear pieces of their meal and appear eager to feast. If you squinted just right, they would resemble some amongst the company. The unhold\'s session of fine dining is cut short however when one spots your company and jumps up with a holler. Like a flock of bulbous sheep, the rest burst into a noisy display of dominance and posture up to defend their meal, or perhaps to make a new one of you. Ordering the company into formation, you address the men as the beasts break into a feverish dash towards you. | A colossal pile of steaming unhold shit announces your quarry is close, and the looming silhouette ahead all but confirms what your eyes and nose suggested. A pack of unholds ahead chortle amongst themselves, their brutish grunting and snorting unmistakable, even at this distance. One confidently scratches its behind, then sniffs its soiled hand, stopping in shock when it spots you and the company awkwardly looking on in mixed amusement and disgust. Its surprise is short lived however, as it calls out to the others with a cruel roar that makes your throat sore just by hearing it. Forming up, the company braces for the coming wave of muscle and malice. | Unholds are far from subtle beasts, and just by following a trail of fresh carnage and beastly merriment, you discover the unholds your employer directed you to capture. They\'re apparently deep in a session of play-fighting, their weapons consisting of pulped human corpses and the malformed mass of what appears to be a cow as they club and slap each other. One clumsy movement later, and one of their man-clubs had been sundered in two, a shrill vocalisation betraying frustration at the loss of their toy. Soon enough, one spots you and points, the rest of the pack exploding with a sick sense of anticipation for a new addition to their flesh-arsenal. You order the company into formation as the beasts close in.}",
			Image = "",
			List = [],
			Options = [{
				Text = "{ Remember, we need one alive! Charge! | Attack! Subdue them! | Remember our contract - weaken, then capture them! }",
				function getResult() {
					this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
					return 0;
				}
			}]
		});

		this.m.Screens.push({
			ID = "BarbEncounter",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{Your barbarian employer approaches, war party in tow. Quickly assessing your company and scowling at the noticeable lack of a trapped unhold, the leader stops his men and shouts across to you.%SPEECH_ON%We had a deal, [i]leigumaðr[/i]. You have failed your end, and for that you must die.%SPEECH_OFF%A fair enough logic, at least from a savage perspective. You order the company to form ranks as your employer-made-enemy charges, seeking to right your wrong through copious violence and bloodshed. | The sound of barbarian merriment alerts you to your employer\'s return. When your company and the lack of its unhold cargo come into view, their sounds of celebration are quickly snuffed out. A few quiet moments pass, the savage host perhaps deciding what to do next whilst your men nervously look on. The all too familiar blare of a barbarian war horn shatters the silence, and the once amicable band of northern raiders breaks into a murderous charge. With a sigh, you order the company into battle formation. | Drums and horns herald the arrival of a barbarian war party. For a moment, you wonder if another barbarian host other than your employer is in the area, but such hopes are crushed when you see %employer% leading the warband. It\'s clear they know you could not capture the unhold they requested, and have come to give you your just reward. Brandishing a skull, your employer throws it into the earth and crushes it underfoot, seemingly a signal for the host to charge. You order the company into fighting formation as the barbarians come to claim your skull as some ritual compensation.}",
			Image = "",
			List = [],
			Options = [{
				Text = "{ To battle! | To arms! | Fight, men! }",
				function getResult() {
					this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
					return 0;
				}
			}]
		});

		this.m.Screens.push({
			ID = "AfterBattle",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_113.png[/img]{The giant falls under the punishment of the company and the strange barbarian nets that glom to their fleshy form. What was only moments ago a violently animated and bloodthirsty avatar of chaos had now been transformed into a sad mass of whimpering flesh and bone. What fight was in the beast appears to have been drained from them through whatever poison the nets are coated with; you order the company to quickly haul the giant into the rough metal cage the barbarians provided, taking good care not to dislodge the net from it. One of the men responsible for casting the strange traps examines some of the slimey poison on their hands, shivers, then quickly wipes it onto their legs. | You\'d be forgiven for thinking the giantkin dead upon inspecting it: its muscles appear loose and free, its body splayed across the floor in a puddle of flesh and fur. Only when you lock eyes with the beast do you confirm it still lives, the nets having an almost supernatural effect on the behemoths as it appears helpless to stand against you. What poisons the barbarians wield you do not know, but the sight of an unhold rendered limp from one of their poisoned nets is enough to instil unease in all present. Remembering your contract, you order the men to drag the beast and hitch it to the wagon, taking care to keep the glossy net away from any open wounds... | After the ferocious battle, you\'re frankly shocked to confirm the unhold had survived the carnage and was now politely sat on the floor covered in the barbarian netting. It appears almost between consciousness and sleep, its head fighting to stay upright, and the confusion in its once malevolent face speaking to the efficacy of the barbarian tradition of unhold taming. You watch as some of the beast\'s wounds quicken before you, and half expect it to kick back into a violent rage, but it remains dormant. %brother% approaches.%SPEECH_ON%I don\'t like that, captain. It was fighting for its life not a moment past, and now look at it. It\'s not right...%SPEECH_OFF%Maybe, maybe not. Regardless, we have a contract to fulfil, and pondering the place of unholds in our world and the barbarian\'s wont help us complete it. You order the giant prepared for transport.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = " { Time to get paid. | Our employer awaits. | Onwards, we have a \'package\' to deliver. }",
					function getResult() {
						return 0;
					}
				}
			],
			function start() {
				if (this.Flags.getAsInt("CapturedUnholds") == 0) {
					this.Text = "[img]gfx/ui/events/event_113.png[/img]{Well, the unholds are dead, but your employer didn\'t want dead: they wanted the beasts alive, and all you have to show is a quickly cooling pile of giant corpses. Some of the men loiter about, exchanging awkward glances, perhaps considering the fallout when the barbarians learn of this fuck up. After a moment, some begin to hack apart the beasts for trophies, if only to distract themselves from the northmen\'s wrath which will no doubt manifest soon. | As the last unhold goes down, the cheer of the company is quickly replaced with apprehension and uncertainty. The beasts are dead, much to your dismay and the coming fury of your barbarian employer. With no living giants to take back, you can expect an icy reception, and the men know it. For now, you encourage them to strip the unholds for trophies, trying to make a good event out of such a mess. | Chunks of giant flesh and bone dot the field of battle, which on any other day would spell a tremendous victory for the company. Today however, it spells a disastrous cock-up: you had a contract with your employer to capture one of the unholds – alive. Though the men pick through the mess of corpses for mementos, you doubt they can restore the beasts to life. You have no doubt however that there will be a reckoning from your employer, but for now, all you can do is rest.}";
					this.Options = [
						{
							Text = "{ Blast it! Let\'s get out of here! | Well, shit. We should leave. | That could have gone better... }",
							function getResult() {
								return 0;
							}
						}
					];
				}
			}
		});

		this.m.Screens.push({
			ID = "Success",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{The barbarian host rises at the sight of the bound and caged unhold. Several of the more hardened warriors approach and measure the specimen brought before them; %employer% is amongst those brave enough to examine the beast up close, ducking and bobbing around the metal prison to confirm its quality. A sudden explosion of stunted rage sends some of the men reeling, earning laughs from the seasoned barbarians. Though the beast strains against its restraints, it quickly abandons its efforts, resigning against the bars with a huff. %SPEECH_ON%Good work, [i]leigumaðr[/i]. I can see its spirit is still strong, despite your violent work. You have earned your price.%SPEECH_OFF%%employer% gestures to a chest containing your agreed upon pay: a collection of barbarian trinkets and artefacts of the north that should sell for a crown or two somewhere warmer. Looking back at the unhold, you can almost sense sadness and mourning in its vacant eyes, but it closes them with a sigh before you can be sure. | The company leads the unhold with a system of prodding spears, ropes, and nets towards the barbarian employer. Their unfamiliarity with such a task is apparent, and for once you\'re relieved to see barbarian trappers and handlers approach to take over wrangling the beast. The handover is thankfully bloodless, most eyes fixed on the placated yet ever-hazardous unhold mere feet beside you. %employer% however remains fixed on you, a stoic yet visibly satisfied nod tells you the job is done, and they gesture a thrall to hand over your reward. \nInside an odd smelling sack of unknown leather, you count your prize of an assortment of barbarian treasures and baubles. You add the valuables to inventory, making sure to discretely discard the strange sack they came with. | Not long after the unhold is subdued and an uneasy peace restored to the battlefield, a swarm of barbarians descend upon the scene of your beast wrangling. For a moment you expect the whole situation was a trap to weaken and lure the company to their doom, but %employer% quickly sweeps those fears away with a broad smile and open arms.%SPEECH_ON%Good fight, outsider. My tribe enjoyed your performance, as did I...%SPEECH_OFF%They produce a fine box of carved bone and gold, and begin counting out your reward- a collection of barbarian curios as stand-in for crowns. Brushing away what you can only explain as an ivory phallus from the box, the barbarian leader quickly passes you your reward, perhaps hoping to distract from the growing confusion. Beside, you feel the burning hatred of the captured unhold sear your flesh as their life is traded for trinkets.%SPEECH_ON%Now. Begone, and hope my new trophy does not recognise you when we next meet.%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [{
				Text = "A successful hunt.",
				function getResult() {
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
					this.World.Contracts.finishActiveContract();
					return 0;
				}
			}],
			function start() {
				this.List.extend(::Legends.EventList.addItems(this.Contract.m.Payment.Items, ::World.Assets.getStash()));
			}
		});

		this.m.Screens.push({
			ID = "Failure",
			Title = "After battle...",
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{With the company scattered or dead, the unholds content themselves with laughing at your truly embarrassing performance. Some of the beasts point and make rough vocalisations, others bounce around in a sick dance, clapping their hands together as the company retreats to lick their wounds. When you spot a barbarian scout shaking their head at your sorry display of soldiery, you realise the contract is all but forfeit, and that your employer is soon to be aware of your failure to capture one of the beasts. | While simple beasts, the giants pack a mean punch, and the company simply couldn\'t withstand their onslaught. With the company having pulled back, it\'s clear to the tailing barbarian host that you aren\'t up for the task of wrangling unholds. The hollers and grating laughter of your victorious foes punctuates the mood, and you\'re frankly grateful they\'re happy to send your men off with a beastly chorus instead of a renewed assault. | It seemed simple, to slap a few nets on some bumbling beasts and call it a day. The harsh realities of such a task however dashed any notions of ease as the company is routed from the battlefield, bruised and battered by the unhold menace. On your retreat, the laughter of spectating barbarians almost matches the giants for their cruelty, with it being clear your employer saw everything in spectacular detail.}",
			Image = "",
			List = [],
			Options = [{
				Text = "{ Blast it! Let\'s get out of here! | Well, shit. We should leave. | That could have gone better... }",
				function getResult() {
					this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractFail);
					this.World.Contracts.finishActiveContract();
					return 0;
				}
			}]
		});

	}

	function spawnEnemies() {
		local playerTile = this.World.State.getPlayer().getTile();
		local tile = this.getTileToSpawnLocation(playerTile, 6, 12, [
			::Const.World.TerrainType.Mountains,
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Tundra
		]);
		local nearTile = this.getTileToSpawnLocation(playerTile, 1, 3);
		local party;
		party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Unholds", false, ::Const.World.Spawn.Unhold, ::Math.rand(95, 115) * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("One or more lumbering giants.");
		party.setAttackableByAI(false);
		party.getFlags().set("IsUnholds", true);
		::Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, 0.85);
		this.m.Target = this.WeakTableRef(party);
		party.getSprite("banner").setBrush("banner_beasts_01");
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setPivot(this.m.Home);
		roam.setMinRange(2);
		roam.setMaxRange(8);
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Shore, false);
		roam.setTerrain(this.Const.World.TerrainType.Forest, false);
		roam.setTerrain(this.Const.World.TerrainType.LeaveForest, false);
		roam.setTerrain(this.Const.World.TerrainType.SnowyForest, false);
		roam.setTerrain(this.Const.World.TerrainType.AutumnForest, false);
		c.addOrder(roam);
		return party;
	}

	function spawnRevengeEnemies() {
		local playerTile = ::World.State.getPlayer().getTile();
		local tile = this.getTileToSpawnLocation(playerTile, 6, 12, [
			::Const.World.TerrainType.Mountains,
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Tundra
		]);
		local nearTile = this.getTileToSpawnLocation(playerTile, 4, 8);
		local party;
		party = ::World.FactionManager.getFactionOfType(::Const.FactionType.Barbarians).spawnEntity(tile, "Barbarians", false, ::Const.World.Spawn.BarbarianHunters, ::Math.rand(105, 135)  * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("A warband of your barbarian employer.");
		party.setMovementSpeed(::Const.World.MovementSettings.Speed * 2.0);
		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(0.85);

		this.m.Target = this.WeakTableRef(party);

		local c = party.getController();
		c.getBehavior(::Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(::Const.World.AI.Behavior.ID.Attack).setEnabled(true);
		local intercept = ::new("scripts/ai/world/orders/intercept_order");
		intercept.setTarget(::World.State.getPlayer());
		c.addOrder(intercept);
		return party;
	}

	function onPrepareVariables(_vars) {

	}

	function onClear() {
		if (!this.m.IsActive)
			return;

		if (this.m.Target != null && !this.m.Target.isNull()) {
			this.m.Target.getSprite("selection").Visible = false;
			this.m.Target.setOnCombatWithPlayerCallback(null);
		}

		local id = "tool.legend_unhold_throwing_net";
		local items = ::World.Assets.getStash().getItems();
		foreach (i, item in items) {
			if (item != null && item.getID() == id) {
				items[i] = ::new("scripts/items/tools/throwing_net");
			}
		}
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			local item = bro.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
			if (item != null && item.getID() == id) {
				bro.getItems().unequip(item);
				bro.getItems().equip(::new("scripts/items/tools/throwing_net"))
			}

			local itemsInBag = bro.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag);
			foreach (item in itemsInBag) {
				if (item != null && item.getID() == id) {
					bro.getItems().removeFromBag(item);
					bro.getItems().addToBag(::new("scripts/items/tools/throwing_net"));
				}
			}
		}
	}

	function onSerialize(_out) {
		if (this.m.Target != null && !this.m.Target.isNull()) {
			_out.writeU32(this.m.Target.getID());
		} else {
			_out.writeU32(0);
		}
		this.contract.onSerialize(_out);
	}

	function onDeserialize(_in) {
		local target = _in.readU32();
		if (target != 0) {
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}
		this.contract.onDeserialize(_in);
	}

});
