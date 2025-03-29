::mods_hookExactClass("contracts/contracts/roaming_beasts_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Tooth and Tail";
		this.m.DescriptionTemplates = [
			"Fell beasts have been preying on the citizens of %s. Folk are afraid to leave their homes.",
			"Roaming beasts prowl the outskirts of %s, attacking travelers and livestock.",
			"Outlandish tales are being told of fell creatures attacking folk around %s.",
			"Rumor is that weird beastlings have been devouring livestock and even people around %s.",
			"The gnawed bones of deceased travelers are starting to pile up around %s.",
			"A cursed pack of fell beasts appear to have developed a taste for human flesh.",
			"%s seeks mercenaries and beastmasters to confront the wild threats in its lands.",
			"Some kind of unnatural beasts have been haunting the local countryside.",
			"Ferocious beasts have reportedly been attacking folk on the road to %s.",
			"Being devoured by a pack of savage beasts was not high on your list of things to do today.",
		];
	}

	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Offer")
			{
				s.end <- function ()
				{
					this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
					local r = this.Math.rand(1, 100);
					if (r <= 5 && this.World.Assets.getBusinessReputation() > 500)
					{
						this.Flags.set("IsHumans", true);
					}
					else
					{
						// Use our own settlement-based randomization system because the Vanilla approach was bugged and overly favoured Ghouls
						this.Flags.set(::RoamingBeastsContractWeights.rollEnemyBySettlement(this.Contract.getHome().get()), true);
					}

					local playerTile = this.World.State.getPlayer().getTile();
					local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 10);
					local party;

					if (this.Flags.get("IsHumans"))
					{
						party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Direwolves", false, this.Const.World.Spawn.BanditsDisguisedAsDirewolves, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getMinibossModifier());
						party.setDescription("A pack of ferocious direwolves on the hunt for prey.");
						party.setFootprintType(this.Const.World.FootprintsType.Direwolves);
						this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Direwolves, 0.75);
					}
					else if (this.Flags.get("IsVermes"))
					{
						party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Direwolves", false, this.Const.World.Spawn.BanditVermes, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getMinibossModifier());
						party.setDescription("A pack of ferocious direwolves on the hunt for prey.");
					}
					else if (this.Flags.get("IsGhouls"))
					{
						party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Nachzehrers", false, this.Const.World.Spawn.Ghouls, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getMinibossModifier());
						party.setDescription("A flock of scavenging nachzehrers.");
						party.setFootprintType(this.Const.World.FootprintsType.Ghouls);
						this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Ghouls, 0.75);
					}
					else if (this.Flags.get("IsSpiders"))
					{
						party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Webknechts", false, this.Const.World.Spawn.Spiders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getMinibossModifier());
						party.setDescription("A swarm of webknechts skittering about.");
						party.setFootprintType(this.Const.World.FootprintsType.Spiders);
						this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Spiders, 0.75);
					}
					else
					{
						party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Direwolves", false, this.Const.World.Spawn.Direwolves, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getMinibossModifier());
						party.setDescription("A pack of ferocious direwolves on the hunt for prey.");
						party.setFootprintType(this.Const.World.FootprintsType.Direwolves);
						this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Direwolves, 0.75);
					}

					party.setAttackableByAI(false);
					party.setFootprintSizeOverride(0.75);
					this.Contract.m.Target = this.WeakTableRef(party);
					party.getSprite("banner").setBrush("banner_beasts_01");
					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local roam = this.new("scripts/ai/world/orders/roam_order");
					roam.setPivot(this.Contract.m.Home);
					roam.setMinRange(2);
					roam.setMaxRange(8);
					roam.setAllTerrainAvailable();
					roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
					roam.setTerrain(this.Const.World.TerrainType.Shore, false);
					roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
					c.addOrder(roam);
					this.Contract.m.Home.setLastSpawnTimeToNow();
					this.Contract.setScreen("Overview");
					this.World.Contracts.setActiveContract(this.Contract);
				}
				s.update <- function ()
				{
					if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
					{
						if (this.Flags.get("IsHumans"))
						{
							this.Contract.setScreen("CollectingProof");
							this.World.Contracts.showActiveContract();
						}
						else if (this.Flags.get("IsVermes"))
						{
							this.Contract.setScreen("CollectingVermes");
							this.World.Contracts.showActiveContract();
						}
						else if (this.Flags.get("IsGhouls"))
						{
							this.Contract.setScreen("CollectingGhouls");
							this.World.Contracts.showActiveContract();
						}
						else if (this.Flags.get("IsSpiders"))
						{
							this.Contract.setScreen("CollectingSpiders");
							this.World.Contracts.showActiveContract();
						}
						else
						{
							this.Contract.setScreen("CollectingPelts");
							this.World.Contracts.showActiveContract();
						}

						this.Contract.setState("Return");
					}
					else if (!this.Flags.get("IsWorkOfBeastsShown") && this.World.getTime().IsDaytime && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 9000) <= 1)
					{
						this.Flags.set("IsWorkOfBeastsShown", true);
						this.Contract.setScreen("WorkOfBeasts");
						this.World.Contracts.showActiveContract();
					}
				}
			}
			if (s.ID == "Return")
			{
				s.update <- function ()
				{
					if (this.Contract.isPlayerAt(this.Contract.m.Home))
					{
						if (this.Flags.get("IsHumans"))
						{
							this.Contract.setScreen("Success2");
						}
						else if (this.Flags.get("IsVermes"))
						{
							this.Contract.setScreen("Success5");
						}
						else if (this.Flags.get("IsGhouls"))
						{
							this.Contract.setScreen("Success3");
						}
						else if (this.Flags.get("IsSpiders"))
						{
							this.Contract.setScreen("Success4");
						}
						else
						{
							this.Contract.setScreen("Success1");
						}

						this.World.Contracts.showActiveContract();
					}
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		this.m.Screens.push({
			ID = "Success5",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You find %employer% resting on %their_employer% laurels. %They_employer% stands and pulls %their_employer% pants up, a servant quickly retrieving a bucket from whence %they_employer% was sitting. The poor servant quickly rushes out of the room. %employer% points at the rat head dangling from your hand.%SPEECH_ON%That is absolutely disgusting. %randomname%, give the %companyname% their pay. %reward% crowns, was it?%SPEECH_OFF% | You place the rat head onto %employer%\'s desk. For some reason, fluids still issue from its neck, dribbling down the side of the oak and no doubt staining it. The %person_employer% leans back, tenting %their_employer% fingers on %their_employer% belly.%SPEECH_ON%Man sized rats? And what else, ghosts?%SPEECH_OFF%The %person_employer% snickers to %themselves_employer%.%SPEECH_ON%Nothing is too difficult for you, sellsword. Best not mention this to anyone. %SPEECH_OFF%%They_employer% snaps %their_employer% fingers and a servant comes up, handing you a satchel of %reward% crowns. | Between the battle and walking to %employer%\'s place, the maw of the Rat became filled with flies, its tongue replaced by a formless, throbbing black ball that\'s more buzz than bite. %employer% takes one look at it and puts a cloth to %their_employer% mouth.%SPEECH_ON%Yes, I get it, take it away, please. Make sure no one else sees it%SPEECH_OFF%%They_employer% waves one of his guards over and you are handed a satchel of %reward% crowns. | A steely eyed %employer% leans forward to get a good look at the Rat head you\'ve brought in.%SPEECH_ON%That is quite the sight, mercenary. I wish you\'d never brought it though.%SPEECH_OFF%%They_employer% leans back.%SPEECH_ON%Leave it on my desk, I\'ll make sure it disapears.%SPEECH_OFF%%They_employer% snaps his fingers and a servant comes to give you %reward% crowns. | You bring the Rat head to %employer% who stares at it for a long time.%SPEECH_ON%That reminds me of someone. I can\'t quite put my finger on it, and I\'m not sure I should. We must keep this secret from escaping. Excuse me, sellsword, I borrow your time without paying for it. Servant, give the %companyname% their money!%SPEECH_OFF%You are rewarded as promised. | %employer% takes the Rat head and holds it up. A few mewling cats seemingly appear out of nowhere, circling beneath it like buzzards would overhead. %They_employer% throws it into the fire nearby and the cats wail, seemingly crying at the loss of a meal.%SPEECH_ON%Good work, sellsword. %reward% crowns, as promised. Let\'s keep this between us%SPEECH_OFF% | You put a Rat head on %employer%\'s table. %They_employer% looks up from a dinner plate, glances at the head, then at you.%SPEECH_ON%I was eating, sellsword.%SPEECH_OFF%The silverware clatters as the disgusted %person_employer% shoves the plate aside. A servant whisks the food away for destruction. %employer% takes a satchel out and puts it on the table.%SPEECH_ON% I\'ll make that heresy disapear, %reward_completion% crowns as was promised.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "A successful hunt.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of infection");
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
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
				s.Text = "[img]gfx/ui/events/event_43.png[/img]{While you wait for %employer% to explain what %they_employer% needs your services for, you contemplate on how silent and eerie the whole settlement was when you first arrived. %employer% raises %their_employer% voice %SPEECH_ON%This place is cursed by the gods and haunted by unearthly beasts! They come in the night with glowing red eyes and take lives at their whim. Most of our cattle is dead and I fear that once there are no more, we are next to be torn apart. The other day we sent our strongest lads out to find and kill the beasts but we haven\'t heard of them since.%SPEECH_OFF%%They_employer% sighs deeply.%SPEECH_ON%Follow the tracks %direction% and hunt down and kill those creatures so that we can live in peace again! We are not wealthy, but all chipped in to pay for your services.%SPEECH_OFF% | %employer%\'s looking out %their_employer% window when you find %them_employer%. There\'s a goblet in %their_employer% hand - and there\'s nothing but silence outside. %They_employer% turns to you, almost somber.%SPEECH_ON%When you came here, did you realize how quiet it was?%SPEECH_OFF%You remark that you did, but you\'re a sellsword who looks the part. It\'s just what you are accustomed to. %employer% nods and takes a drink.%SPEECH_ON%Ah, of course. Unfortunately, it isn\'t that people are afraid of you. Not this time. We have had people being attacked these past weeks. Beasts of some sort are on the loose, we know not what they are, but only who they take. We\'ve pleaded with our lord, of course, but he has done nothing to help us...%SPEECH_OFF%%Their_employer% next drink is a long one. When %they_employer% finishes, %they_employer% turns to you, empty cup in hand.%SPEECH_ON%Would you go hunt these monsters down? Please, sellsword, help us.%SPEECH_OFF% | %employer%\'s listening to the talk of a few peasants when you find %them_employer%. When they see you, they quickly depart, leaving the man with a satchel in hand. %They_employer% holds it up.%SPEECH_ON%There\'s crowns in here. Crowns that those people are giving me to give someone, anyone, to help us. People are disappearing, sellsword, and when they are found they\'re... not just dead, but... mangled. Mutilated. Everyone is too scared to go anywhere.%SPEECH_OFF%%They_employer% stares into the sack, then looks to you.%SPEECH_ON%I do hope you are interested in this task.%SPEECH_OFF% | You find %employer% reading a scroll. %They_employer% throws the paper at you and asks you to read off the names. The handwriting is difficult, but not moreso than the names themselves. You stop and apologize, stating you are not from these parts. The man nods and takes the scroll back.%SPEECH_ON%Tis alright, sellsword. If you were wondering, those were the names of men, women, and children who have passed in the last week.%SPEECH_OFF%Last week? There were a lot of names on that list. The %person_employer%, seeming to read you, nods somberly.%SPEECH_ON%Aye, we are in a bad way. So many lives lost. We believe this to be the work of foul creatures, beasts beyond our ability to reason. Obviously, we\'d like you to go find and destroy them. Would you be interested in such a task, mercenary?%SPEECH_OFF% | %employer%\'s got a few dogs at %their_employer% feet, all tuckered out with their tongues lolling.%SPEECH_ON%They\'ve spent the past few days hunting for missing folks. Folks that are seemingly disappearing to the gods know where.%SPEECH_OFF%%They_employer% leans down and pets one of the hounds, scratching it behind the ear. Usually, a dog would respond to that, but the poor thing barely even responds.%SPEECH_ON%The folks don\'t know what I know, though, which is that people ain\'t just disappearing... they\'re being taken. Horrible beasts are afoot, sellsword, and I need you to go after them. Hell, maybe you\'ll even find someone or two of the townsfolk, though I doubt it.%SPEECH_OFF%One of the mutts lets out a long, tired wheeze almost as if on cue. | %employer%\'s got a satchel with a scroll attached, but the name written on the paper is not yours. %They_employer% weighs it carefully, the lumps of coin curving about %their_employer% fingers, their chink and chanks muted. %They_employer% turns to you.%SPEECH_ON%You recognize that name?%SPEECH_OFF%You shake your head. The %person_employer% continues.%SPEECH_ON%A week ago we sent the famed %randomnoble% %direction% of here to go hunt down some foul beasts that have been terrorizing the town and surrounding farmsteads for weeks. Do you know why this satchel has remained in my ownership?%SPEECH_OFF%You shrug and answer.%SPEECH_ON%Because he hasn\'t returned?%SPEECH_OFF%%employer% nods and sets the satchel down. %They_employer% sits on the edge of his table.%SPEECH_ON%Correct. Because he has not returned. Now, why do you think that is? I think it\'s because he\'s dead, but let\'s not be so negative. I think it\'s because the beasts out there require more. I think they require someone like you, sellsword. Would you be willing to help us now that this nobleman has failed?%SPEECH_OFF% | %employer% takes a book from his shelf. When %they_employer% sets it on his table, dust or maybe even ash plume outward. %They_employer% opens it up, thumbing slowly from page to page.%SPEECH_ON%Do you believe in monsters, sellsword? I\'m asking honestly, as I believe you\'ve had a better walk-about of this world than I.%SPEECH_OFF%You nod and speak.%SPEECH_ON%More than just a belief, yes.%SPEECH_OFF%The man thumbs another page. %They_employer% looks up at you.%SPEECH_ON%Well, we believe monsters have come to %townname%. We believe that\'s why people are going missing. Understand where this is going? I need you to find these \'make believe\' creatures and kill them like any other. Are you interested?%SPEECH_OFF%}";
			}
			if (s.ID == "CollectingVermes")
			{
				s.Text = "[img]gfx/ui/events/event_131.png[/img]{The fight over, you walk to a dead infected peasant and take a knee. A pool of poison is still dripping from the peasant\'s teeth. Instead of admiring the dental failures at hand, you instead take out a knife and saw its head off, ripping through a very tough outer layer of skin before, surprisingly, easily cutting through the muscles and tendons. You raise the head up and order the %companyname% follow suit. %employer% will be expecting some proof, after all. | The peasants\'s dead body looks more rat than man as it lays flat and unmoving. Flies are already coupling inside its mouth, sowing life on the frothy remains of death. You order %randombrother% to take its head, for %employer% will be expecting proof. | Dead peasants are scattered about. You take a knee beside one and look at its mouth. Whatever was in its lungs is still issuing forth, a wheeze burping out. Putting a cloth to your nose, you use the other hand to chop away at its neck with a blade, cutting off the head and holding it up. You order a few brothers to follow suit for %employer% will be expecting proof. | A dead infected peasant is an interesting specimen to behold. You can\'t help but wonder where it falls on the natural spectrum. Half rat and half man, these things are the thing of child\'s nightmares. You order the %companyname% to start collecting the heads of the foul things for %employer% will surely be wanting proof.}";
			}
			if (s.ID == "CollectingGhouls")
			{
				s.Text = "[img]gfx/ui/events/event_131.png[/img]{The fight over, you walk to a dead Nachzehrer and take a knee. Were it not for a gate of ill-shapen teeth, you could easily fit your head into the beast\'s oversized maw. Instead of admiring the dental failures at hand, you instead take out a knife and saw its head off, ripping through a very tough outer layer of skin before, surprisingly, easily cutting through the muscles and tendons. You raise the head up and order the %companyname% follow suit. %employer% will be expecting some proof, after all. | The Nachzehrers\'s dead body looks more rock than beast as it lays flat and unmoving. Flies are already coupling inside its mouth, sowing life on the frothy remains of death. You order %randombrother% to take its head, for %employer% will be expecting proof. | Dead Nachzehrers are scattered about. You take a knee beside one and look at its mouth. Whatever was in its lungs is still issuing forth, a wheeze burping out. Putting a cloth to your nose, you use the other hand to chop away at its neck with a blade, cutting off the head and holding it up. You order a few brothers to follow suit for %employer% will be expecting proof. | A dead Nachzehrer is an interesting specimen to behold. You can\'t help but wonder where it falls on the natural spectrum. Shaped like crude men, muscled like some beastly thing, and its head is gnarled with features born out of a wildman\'s nightmares. You order the %companyname% to start collecting the heads of the foul things for %employer% will surely be wanting proof.}";
			}
			if (s.ID == "Success2")
			{
				s.Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% welcomes your return.%SPEECH_ON%I\'ve already heard the, I suppose, splendid news. I can believe it, though. A bunch of brigands playing dress up. Wolves in... wolf clothing?%SPEECH_OFF%%They_employer% grins at you, expecting a laugh at his cheesy joke. You shrug. %They_employer% shrugs, too.%SPEECH_ON%Ah, well. Your payment, %reward_completion% crowns, is waiting for you outside. I will tell the people of %townname% that the monsters they fear are but men.%SPEECH_OFF% | You return with the costumes of the foolish brigands. %employer% tilts the disguises left to right.%SPEECH_ON%Interesting. They\'re very well done. I\'d almost say the brigands were clever here.%SPEECH_OFF%%They_employer% picks up one of the masks and looks just about ready to try it on, then pauses as though %they_employer% shouldn\'t do this with an audience. %They_employer% puts it back down and smiles at you.%SPEECH_ON%Well, anyway, sellsword... good work. You\'ll have %reward_completion% crowns waiting for you outside with one of %townname%\'s councilmen. %They_employer%\'ll be looking out for you. Now, the people of %townname% can bury our dead and finally be at peace.%SPEECH_OFF% | %employer% reels in laughter at your reveal.%SPEECH_ON%Men? It was only men?%SPEECH_OFF%You nod, but try and get the man back on track.%SPEECH_ON%They killed a lot of peasants and they were still a dangerous lot.%SPEECH_OFF%Your employer nods.%SPEECH_ON%Of course, of course! I didn\'t mean to belittle anything or anyone. Don\'t dare assume things of me, sellsword, those are my friends and neighbors dying out there! Anyway, you did what I asked of you and for that I am very grateful.%SPEECH_OFF%%They_employer% hands over a satchel of crowns. You count %reward_completion% inside before making your leave. The %person_employer% hollers out to you.%SPEECH_ON%Surely you understand trying to find humor in this horrible world, right? Because it is I who went to the funerals of all those slain. I will not go into the grave with a frown on my face, no matter how hard this damned place tries to force it on me.%SPEECH_OFF% | You show %employer% the evidence of the mischievous brigands. %They_employer% picks through the lumps of disguises, rubbing crusty blood off his fingers.%SPEECH_ON%That is the blood of men alright. Are you sure that they weren\'t just having fun playing pretend and the real monsters are still out there?%SPEECH_OFF%You purse your lips and explain that they attacked you with very not-pretend weapons. %employer% nods, seemingly understanding, though a little suspicious.%SPEECH_ON%Well, I suppose I could just wait and see if the monsters return. If they do, well, a man betrayed makes for a mighty fine monster in and of itself, wouldn\'t you agree?%SPEECH_OFF%You just tell the man to pay you and wait and see if he should be so untrusting. %They_employer% nods, giving you %reward_completion% crowns and seeing you off.%SPEECH_ON%I truly do hope you are telling the truth, mercenary. %townname% could use a reprieve from the horrors that is constantly lashing out from this damned world.%SPEECH_OFF% | %employer% runs a finger along the edge of a disguise.%SPEECH_ON%The fur is soft to the touch. Very real...%SPEECH_OFF%%They_employer% looks up at you.%SPEECH_ON%I have to wonder if they killed the original monsters, and then... decided to wear their pelts? Why, though? Do you think they were cursed?%SPEECH_OFF%You shrug and answer.%SPEECH_ON%All I can say is that they had the guise of monsters, and the cruelty of them as well. They attacked us and paid for it. Have any of your locals spotted any creatures in awhile?%SPEECH_OFF%The man brings out a satchel of %reward_completion% crowns and slides it over to you.%SPEECH_ON%No, they haven\'t. In fact, they\'re starting to venture out again. I don\'t mean down the roads, but leaving the safety of their front doors is a big step for many! You\'ve definitely brought us peace, sellsword, and for that we thank you.%SPEECH_OFF%}";
			}
			if (s.ID == "Success3")
			{
				s.Text = "[img]gfx/ui/events/event_04.png[/img]{You find %employer% resting on %their_employer% laurels. %They_employer% stands and pulls %their_employer% pants up, a servant quickly retrieving a bucket from whence %they_employer% was sitting. The poor servant quickly rushes out of the room. %employer% points at the Nachzehrer head dangling from your hand.%SPEECH_ON%That is absolutely disgusting. %randomname%, give the %companyname% their pay. %reward% crowns, was it?%SPEECH_OFF% | You place the Nachzehrer head onto %employer%\'s desk. For some reason, fluids still issue from its neck, dribbling down the side of the oak and no doubt staining it. The %person_employer% leans back, tenting %their_employer% fingers on %their_employer% belly.%SPEECH_ON%Nachzehrers? And what else, ghosts?%SPEECH_OFF%The %person_employer% snickers to %themselves_employer%.%SPEECH_ON%Nothing is too difficult for you, sellsword.%SPEECH_OFF%%They_employer% snaps %their_employer% fingers and a servant comes up, handing you a satchel of %reward% crowns. | Between the battle and walking to %employer%\'s place, the maw of the Nachzehrer became filled with flies, its tongue replaced by a formless, throbbing black ball that\'s more buzz than bite. %employer% takes one look at it and puts a cloth to %their_employer% mouth.%SPEECH_ON%Yes, I get it, take it away, please.%SPEECH_OFF%%They_employer% waves one of %their_employer% guards over and you are handed a satchel of %reward% crowns. | A steely eyed %employer% leans forward to get a good look at the Nachzehrer head you\'ve brought in.%SPEECH_ON%That is quite the sight, mercenary. I\'m happy you have brought it to me.%SPEECH_OFF%%They_employer% leans back.%SPEECH_ON%Leave it on my desk. Maybe I can scare the children with it. The little gits are getting too used to fineries methinks.%SPEECH_OFF%%They_employer% snaps his fingers and a servant comes to give you %reward% crowns. | You bring the Nachzehrer head to %employer% who stares at it for a long time.%SPEECH_ON%That reminds me of someone. I can\'t quite put my finger on it, and I\'m not sure I should. Excuse me, sellsword, I borrow your time without paying for it. Servant, give the %companyname% their money!%SPEECH_OFF%You are rewarded as promised. | %employer% takes the Nachzehrer head and holds it up. A few mewling cats seemingly appear out of nowhere, circling beneath it like buzzards would overhead. %They_employer% throws it out the window and the felines go running.%SPEECH_ON%Good work, sellsword. %reward% crowns, as promised.%SPEECH_OFF% | You put a Nachzehrer head on %employer%\'s table. %They_employer% looks up from a dinner plate, glances at the head, then at you.%SPEECH_ON%I was eating, sellsword.%SPEECH_OFF%The silverware clatters as the disgusted %person_employer% shoves the plate aside. A servant whisks the food away, probably to try and eat it himself. %employer% takes a satchel out and puts it on the table.%SPEECH_ON%%reward_completion% crowns as was promised.%SPEECH_OFF%}";
			}
			if (s.ID == "Success4")
			{
				s.Text = "[img]gfx/ui/events/event_04.png[/img]{You enter %employer%\'s office carrying the dead spider on your back. The %person_employer% screams and %their_employer% chair squalls as it flings back across the floor. %They_employer% jumps to %their_employer% feet and draws a butterknife off %their_employer% desk. You throw the dead webknecht from your shoulder and it clatters on its back. The townsman slowly comes forward. %They_employer% sheathes the butterknife in a loaf of bread and shakes %their_employer% head.%SPEECH_ON%By the old gods, you nearly gave me a heart attack.%SPEECH_OFF%Nodding, you tell the %person_employer% it required more than a big boot to squash these beasts. %They_employer% nods back.%SPEECH_ON%Of course, sellsword, of course! Your payment of %reward_completion% crowns is right there in the corner. And, please, take that ungodly thing with you when you leave.%SPEECH_OFF% | Cats hiss and flee the second you step into %employer%\'s room. A few dogs, always the sort for a mystery, run about your legs and sniff the spider carcass, their noses crinkling and pulling away but always coming back for more. The townsman is writing notes and %they_employer% can hardly believe %their_employer% eyes. %They_employer% sets %their_employer% quill pen down.%SPEECH_ON%Is that a giant spider?%SPEECH_OFF%You nod. %They_employer% smiles and picks %their_employer% quill pen back up.%SPEECH_ON%Perhaps I should have suggested you bring a very big shoe. Your payment of %reward_completion% crowns is there in the satchel. Go on, take it. It\'s all there. And you can leave the corpse. I\'d like to get a closer look at the creature.%SPEECH_OFF% | %employer% is hosting a birthday party when you enter %their_employer% room with a giant dead spider and fling the corpse across the floor. Its bristly hairs hiss as they scratch across the stone and its eight legs scuttle upside down like some furniture of horror and it strays sideways and pops off the corner of a bookshelf and flips onto its toes and prongs there as though ready to pounce. Chaos breaks out as everyone screams and runs out the door or bails from the nearest open window, a litter of colorful confetti playfully twirling in their wake. The townsman stands alone amongst the emptied space and purses %their_employer% lips.%SPEECH_ON%Truly, sellsword, was that necessary?%SPEECH_OFF%You nod and tell %them_employer% that hiring you was necessary and that paying you will still be very necessary. The %person_employer% shakes %their_employer% head and gestures with a fake donkey tail to the corner of the room.%SPEECH_ON%Your satchel\'s over there with %reward_completion% crowns, as agreed upon. Now get that awful thing out of here and tell those fine folks the reveries need not be over.%SPEECH_OFF% | You don\'t think you can fit the spider corpse into %employer%\'s room, so instead you slap it against %their_employer% window from the outside. You hear a horrified scream and the clatter of falling furniture. A moment later the adjacent window is thrown open. The townsman leans out.%SPEECH_ON%Oh very rich, sellsword, very rich! May the old gods serve you a thousand years of idle time for that one!%SPEECH_OFF%Nodding, you ask about your pay. %They_employer% begrudgingly tosses you a satchel.%SPEECH_ON%%reward_completion% crowns is in there. Now take that awful thing and go!%SPEECH_OFF%}";
			}
		}
	}

	o.onPrepareVariables = function ( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_helpful = [];
		local candidates_bro1 = [];
		local candidates_bro2 = [];
		local helpful;
		local bro1;
		local bro2;

		foreach( bro in brothers )
		{
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn) && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.OffendedByViolence) && !bro.getSkills().hasTrait(::Legends.Trait.Bright) && bro.getBackground().getID() != "background.hunter")
			{
				candidates_helpful.push(bro);
			}

			if (!bro.getSkills().hasTrait(::Legends.Trait.Player))
			{
				candidates_bro1.push(bro);

				if (!bro.getBackground().isBackgroundType(this.Const.BackgroundType.OffendedByViolence) && bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
				{
					candidates_bro2.push(bro);
				}
			}
		}

		if (candidates_helpful.len() != 0)
		{
			helpful = candidates_helpful[this.Math.rand(0, candidates_helpful.len() - 1)];
		}
		else
		{
			helpful = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		if (candidates_bro1.len() != 0)
		{
			bro1 = candidates_bro1[this.Math.rand(0, candidates_bro1.len() - 1)];
		}
		else
		{
			bro1 = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		if (candidates_bro2.len() > 1)
		{
			do
			{
				bro2 = candidates_bro2[this.Math.rand(0, candidates_bro2.len() - 1)];
			}
			while (bro2.getID() == bro1.getID());
		}
		else if (brothers.len() > 1)
		{
			do
			{
				bro2 = brothers[this.Math.rand(0, brothers.len() - 1)];
			}
			while (bro2.getID() == bro1.getID());
		}
		else
		{
			bro2 = bro1;
		}

		_vars.push([
			"helpfulbrother",
			helpful.getName()
		]);
		_vars.push([
			"bro1",
			bro1.getName()
		]);
		_vars.push([
			"bro2",
			bro2.getName()
		]);
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
	}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(this.m.Home.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}
});
