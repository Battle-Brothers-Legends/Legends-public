this.legend_shuckster_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {
		Dude = null,
		Catcher = null
	},

	function create() {
		this.encounter.create();
		this.m.Type = "encounter.legend_shuckster";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Cooldown = 90.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "A",
			Title = "A Desperate Time",
			Text = "[img]gfx/ui/events/event_92.png[/img]{The drought has turned %settlement% into a withered husk of itself. Crops have curled into ash and the peasantry looks like gaunt specters shuffling through the dust, their faces caved with hunger. As you try to come to a decision whether to make a stop or to simply push on forward, a sudden commotion in the town square draws your attention.\n\nA %person_dude% draped in bizarre clothing, laden with clinking talismans and tattered silks is hollering promises of salvation.%SPEECH_ON%The sky weeps, but it has forgotten how to shed its tears! I, the great %dude%, shall bring rain forth!%SPEECH_OFF%%They_dude% shakes %their_dude% wooden bowl and the desperate locals bring whatever coppers and family heirlooms they own.\n\nTaking the offerings, %they_dude% begins a frenzied, erratic dance, chanting in a language that sounds suspiciously like gibberish mixed with coughing. %They_dude% throws handfuls of sparkling dust into the dry air and drops to %their_dude% knees, throwing %their_dude% arms toward the cloudless sky.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's see if this buffoonery actually works.",
					function getResult(_event) {
						return ::Math.rand(1, 100) <= 10 ? "Rain" : "Drought";
					}
				},
				{
					Text = "I can already see where this goes. Time to leave.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				if(::World.Assets.getOrigin().getID() == "scenario.manhunters"){
					_event.m.Dude.setStartValuesEx([::Legends.Background.Slave]);
				} else {
					_event.m.Dude.setStartValuesEx([::Math.rand(1, 100) <= 90 ?::Legends.Background.Thief : ::Legends.Background.Thief]); // this is the spot where we make the "rare" option a druid or a herbalist or whatever we want him to be and perhaps with the conjure rain skill for fun
				}
			}
		});
		this.m.Screens.push({
			ID = "Rain",
			Title = "A Miracle?",
			Text = "[img]gfx/ui/events/event_36.png[/img]{For a long, agonizing moment nothing happens and the crowd begins to murmur, their desperate hope slowly turning into anger. But then... a shadow falls over the plaza.\n\nA sudden, booming crack of thunder catches everyone unawares. Fat, heavy drops of water begin to smack against the parched earth, turning the dust into mud. Within moments, a torrential downpour washes over the settlement. The peasants erupt into cheers, weeping and dancing in the mud. The rainmaker looks just as surprised as you are, staring at %their_dude% own hands in utter disbelief before quickly puffing his chest out and taking a deep bow.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Well, I'll be damned.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				local town = ::Legends.S.getClosestSettlement();
				town.removeSituationByID("situation.draught");
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "The drought in " + town.getName() + " has ended"
				});
			}

		});
		this.m.Screens.push({
			ID = "Drought",
			Title = "The Dance Continues",
			Text = "[img]gfx/ui/events/event_41.png[/img]{The sky remains a harsh, unyielding blue. The sun beats down with mocking intensity.\n\nThe rainmaker stands up, dusts %their_dude% knees and resumes the dance, a nervous sweat breaking out across %their_dude% brow.%SPEECH_ON%Ah, the spirits are... stubborn today. Give them time!%SPEECH_OFF%%They_dude% stammers, slowly inching toward an alleyway. The crowd's murmurs turn into a low, dangerous growl. Hoes and pitchforks are gripped with intensity. The shuckster realizes %their_dude% luck has run dry, clutches %their_dude% heavy bowl of coppers tightly, and makes a mad dash for %their_dude% life.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "After %them_dude%!",function getResult(_event) {
						return ::Math.rand(1, 100) <= 75 ? "CompanyCatch" : "CompanyFail";
					}
				},
				{
					Text = "Let's see how the locals handle this.",function getResult(_event) {
						return ::Math.rand(1, 100) <= 50 ? "LocalsCatch" : "LocalsFail";
					}
				},
				{
					Text = "Not our problem. Time to leave.",
					getResult = @(_event)"DroughtRetreat"
				}
			],

			function start(_event) {
				if (_event.m.Catcher != null) {
					this.Options.push({
						Text = "%catcher% has a way with fleeing prey...",
						getResult = @(_event)"CompanyCatch"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "DroughtRetreat",
			Title = "A Hurried Retreat",
			Text = "[img]gfx/ui/events/event_75.png[/img]{You decide a starving, furious mob is not something the company needs today. You quietly signal the men to back away into the side streets. You are almost in the clear when several of the peasants turn their furious glares toward your company. They spit at their feet, hurling insults and shaking their makeshift weapons at you. Clearly they won't be particularly happy to deal with outsiders for a while. You leave the settlement, leaving them to their misery.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's get out of here.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				::Legends.S.getClosestSettlement().getFactionOfType(::Const.FactionType.Settlement).addPlayerRelation(::Const.World.Assets.RelationMinorOffense, "Blamed their woes during a drought on you");
			}
		});
		this.m.Screens.push({
			ID = "LocalsCatch",
			Title = "Mob Justice",
			Text = "[img]gfx/ui/events/event_14.png[/img]{The rainmaker doesn't make it far. %Their_dude% elaborate robes snag on a broken cart, and the mob descends upon %them_dude% like a pack of starved hounds. You watch with grim detachment as the furious peasants exact their toll. It is not a clean or quiet affair. By the time they step back, panting and covered in blood, there is little more left of the shuckster than a broken pile of rags and meat.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A harsh world.",function getResult(_event) {
						return ::Math.rand(1, 100) <= 25 ? "LocalsCatchRain" : "LocalsCatchDrought";
					}
				}
			],

			function start(_event) {}
		});
		this.m.Screens.push({
			ID = "LocalsCatchRain",
			Title = "Blood in the Valley",
			Text = "[img]gfx/ui/events/event_36.png[/img]{As the mob slowly walks away from the ruined corpse, a shadow falls over the village.\n\nA violent thunderclap shakes the earth, and heavy drops of rain begin to pour from the sky, washing the blood from the cobblestones, soaking the peasants and your company alike. The mob falls silent, their fury replaced by superstitious feelings of awe dread. Several drop to their knees in the mud, staring at the sky.\n\nPerhaps the gods didn't want a dance. They wanted a sacrifice.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Uncanny.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				local town = ::Legends.S.getClosestSettlement();
				town.removeSituationByID("situation.draught");
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "The drought in " + town.getName() + " has ended"
				});
			}
		});
		this.m.Screens.push({
			ID = "LocalsCatchDrought",
			Title = "Misplaced Anger",
			Text = "[img]gfx/ui/events/event_43.png[/img]{The %person_dude% is dead, but the sky remains an unyielding blue. The mob's bloodlust however, has been stoked rather than sated. A gaunt man with a rusted sickle points a bloody finger directly at your company.%SPEECH_ON%They rode into town just as %they_dude% did! They're in on it! They came to laugh at our suffering!%SPEECH_OFF%The accusation hangs heavily in the air and the starving mob doesn't need much rousing. The crowd starts forward, makeshift weapons raised.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fall back! We're leaving!",
					getResult = @(_event)"DroughtRetreat2"
				},
				{
					Text = "Let's give the rabble a lesson.",
					getResult = @(_event)"DroughtFight"
				}
			],

			function start(_event) {}
		});
		this.m.Screens.push({
			ID = "DroughtRetreat2",
			Title = "A Hurried Retreat",
			Text = "[img]gfx/ui/events/event_75.png[/img]{You decide a starving, furious mob is not something the company needs today. You hurriedly signal the men to back away. The peasants spit at their feet, hurling insults and shaking their makeshift weapons at you. Clearly they won't be particularly happy to deal with outsiders for a while. You leave the settlement, leaving them to their misery.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let's get out of here.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				::Legends.S.getClosestSettlement().getFactionOfType(::Const.FactionType.Settlement).addPlayerRelation(::Const.World.Assets.RelationMinorOffense, "Blamed their woes during a drought on you");
			}
		});
		this.m.Screens.push({
			ID = "LocalsFail",
			Title = "Misplaced Anger",
			Text = "[img]gfx/ui/events/event_43.png[/img]{What the rainmaker lacked in %their_dude% supposed craft, %they_dude% certainly doesn't in nimbleness and flight of feet. %They_dude% dodges grabbing hands and vaults a fence to disappear between the buildings. The mob howls in frustration. Denied their victim, the starving, furious crowd searches for anyone to vent their frustrations upon.%SPEECH_ON%Outsiders! They're all the same! Bleeding us dry!%SPEECH_OFF%One voice shrieks. Suddenly, stones and crude farming tools are being brandished in the direction of the company.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fall back! We're leaving!",
					getResult = @(_event)"DroughtRetreat2"
				},
				{
					Text = "Let's give the rabble a lesson.",
					getResult = @(_event)"DroughtFight"
				}
			],

			function start(_event) {}
		});
		this.m.Screens.push({
			ID = "DroughtFight",
			Title = "A Bloody Lesson",
			Text = "[img]gfx/ui/events/event_141.png[/img]{You refuse to be chased off by a pack of half-starved peasants. You order the men into formation, and the resulting brawl is short and brutal. You don't use the edges of your blades, mostly relying on fists and the flat of your weapons, but the peasants give back almost as good as they take.\n\n Eventually, they break, groaning, leaving with bruised ribs. The men gather whatever crude implements they dropped in their haste to flee. You spit a curse at the town and order your battered men to march on.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I knew it would end up like this.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				::Legends.S.getClosestSettlement().getFactionOfType(::Const.FactionType.Settlement).addPlayerRelation(::Const.World.Assets.RelationMajorOffense, "Brawled with the local peasantry");

				//add light wounds and brawl injuries
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (::Math.rand(1, 100) <= 33) {
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + " suffers light wounds"
						});

						if (::Math.rand(1, 100) <= 10) {
							local injury = bro.addInjury(::Const.Injury.Brawl);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " suffers " + injury.getNameOnly()
							});
						}
					}
				}

				// add 3 random peasant weapons
				for (local i = 0; i < 3; i++) {
					local item = ::new("scripts/items/weapons/" + (::Const.GetWeaponAndTree(::Const.RandomizedCharacterInfo[::Const.EntityType.Peasant].WeaponsAndTrees))[0][0]);
					::World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
			}
		});
		this.m.Screens.push({
			ID = "CompanyCatch",
			Title = "Cornered",
			Text = "[img]gfx/ui/events/event_70.png[/img]{The rainmaker darts into an alley, but finds %themselves_dude% staring down the cold steel of %randombrother%. %dude% crashes to %their_dude% knees, throwing up %their_dude% hands in surrender as the roar of the angry mob can be heard from behind.%SPEECH_ON%Mercy! Please! I'm just trying to survive! I'm just a %person_dude% with a hungry belly!%SPEECH_OFF%%They_dude% pleads, trembling violently.\n\nThe mob is just around the corner. You have mere seconds to decide what to do with the scammer.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hand %them_dude% over to the peasants.",
					getResult = @(_event)"SurrenderTheShuckster"
				},
				{
					Text = "Stand your ground. We're keeping %them_dude%.",
					getResult = @(_event)"DefendTheShuckster"
				}
			],

			function start(_event) {}
		});
		this.m.Screens.push({
			ID = "CompanyFail",
			Title = "A Slippery Fish",
			Text = "[img]gfx/ui/events/event_20.png[/img]{You order your men to fan out and cut off the rainmaker's escape, but %they're_dude% like a greased pig. %They_dude% slips through a gap in a rotting fence, scrambles over a low rooftop, and completely vanishes into the parched countryside. The mob howls in frustration behind you, but there is noone to vent their rage upon. The drought remains, as does the misery.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "%They're_dude% gone.",
					getResult = @(_event)0
				}
			],

			function start(_event) {}
		});
		this.m.Screens.push({
			ID = "SurrenderTheShuckster",
			Title = "The Death of a Shuckster",
			Text = "[img]gfx/ui/events/event_14.png[/img]{You step aside and shove the weeping %person_dude% toward the angry crowd. The seeming leader of the mob, grateful for your assistance in dispensing justice, offers a nod before falling upon the charlatan. It is a gruesome, bloody spectacle as they tear the false rainmaker limb from limb.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "%They_dude% earned that.",function getResult(_event) {
						return ::Math.rand(1, 100) <= 25 ? "LocalsCatchRain" : "SurrenderDrought";
					}
				}
			],

			function start(_event) {
				::Legends.S.getClosestSettlement().getFactionOfType(::Const.FactionType.Settlement).addPlayerRelation(::Const.World.Assets.RelationFavor, "Helped the mob catch a scammer");
				//::World.Assets.addMoralReputation(-1);
			}
		});
		this.m.Screens.push({
			ID = "SurrenderDrought",
			Title = "Justice?",
			Text = "[img]gfx/ui/events/event_79.png[/img]{The %person_dude% is dead, and the sky remains clear. The mob's bloodlust has been entirely quenched on the charlatan. They disperse slowly back to their homes, dragging what family heirlooms they were able to recover with them. You gather your men and depart the town.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Time to move on.",
					getResult = @(_event)0
				}
			],

			function start(_event) {}
		});
		this.m.Screens.push({
			ID = "DefendTheShuckster",
			Title = "A Life for a Life",
			Text = "[img]gfx/ui/events/event_141.png[/img]{You order your men into formation. When the peasants realize you intend to deny them their justice, a fight breaks out.\n\nThe resulting brawl is ugly. Your men use the flat of their blades and fists against farming tools and stones. Eventually, the battered mob breaks and scatters, but even as they retreat, they don't spare you their words.\n\nYou grab the trembling rainmaker by the scruff of %their_dude% neck.%SPEECH_ON%You owe us your life. The question is, how are you going to pay for it?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We might yet make a %sibling_dude% out of you.",
					function getResult(_event) {
						_event.m.Dude.getBackground().m.RawDescription = "You saved %name% from a lynching. With nowhere else to go, the charlatan decided to put %their% talents to use as a mercenary.";
						return "RecruitTheShuckster";
					}
				},
				{
					Text = "Get out of here before I change my mind.",
					getResult = @(_event) "ReleaseTheShuckster"
				}
			],

			function start(_event) {
				this.Options.Text[0] = ::World.Assets.getOrigin().getID() == "scenario.manhunters" ? "Keep %them_dude% chained, lest %they_dude% tries running again." : "We might yet make a %sibling_dude% out of you.";
				::Legends.S.getClosestSettlement().getFactionOfType(::Const.FactionType.Settlement).addPlayerRelation(::Const.World.Assets.RelationMajorOffense, "You brawled with the local peasantry to protect a scammer");

				//add light wounds and brawl injuries
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (::Math.rand(1, 100) <= 33) {
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + " suffers light wounds"
						});

						if (::Math.rand(1, 100) <= 10) {
							local injury = bro.addInjury(::Const.Injury.Brawl);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " suffers " + injury.getNameOnly()
							});
						}
					}
				}

				// add 3 random peasant weapons
				for (local i = 0; i < 3; i++) {
					local item = ::new("scripts/items/weapons/" + (::Const.GetWeaponAndTree(::Const.RandomizedCharacterInfo[::Const.EntityType.Peasant].WeaponsAndTrees))[0][0]);
					::World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
			}
		});

		this.m.Screens.push({
			ID = "RecruitTheShuckster",
			Title = "New Blood",
			Text = "[img]gfx/ui/events/event_92.png[/img]{%dude% vigorously nods, not realizing the grim fate that may be awaiting %them_dude%.%SPEECH_ON%Yes! Yes, a thousand times yes! My life is yours, captain! I promise you won't regret your decision!%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We'll see about that.",function getResult(_event) {
						::World.getPlayerRoster().add(_event.m.Dude);
						::World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}
				}
			],

			function start(_event) {
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
				local items = _event.m.Dude.getItems();
				local armor = items.getItemAtSlot(::Const.ItemSlot.Body);
				if (armor != null) {
					items.unequip(armor);
				}
				armor = ::new("scripts/items/legend_armor/cloth/legend_armor_robes_wizard");
				armor.setVariant(5);
				items.equip(armor);
				local helmet = items.getItemAtSlot(::Const.ItemSlot.Head);
				if (helmet != null) {
					items.unequip(helmet);
				}
				::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.Weasel);
			}
		});
		this.m.Screens.push({
			ID = "ReleaseTheShuckster",
			Title = "A Grateful Charlatan",
			Text = "[img]gfx/ui/events/event_04.png[/img]{The %person_dude% looks at you, stunned. %They_dude% drops to %their_dude% knees and presses a frantic kiss to your gauntlet.%SPEECH_ON%Thank you! The gods truly bless you, sir! I will sing praises of your company from here to the furthest corners of the world!%SPEECH_OFF%%They_dude% presses a small pouch of crowns into your hand before scrambling off into the dust.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What a curious day.",function getResult(_event) {
						::World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}
				}
			],

			function start(_event) {
				local money = ::Math.rand(50, 150);
				::World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + ::Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
				});
				//::World.Assets.addMoralReputation(1);
			}
		});
	}

	function onPrepare() {
		local candidates = [];
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			if (bro.getBackground().getID() == ::Legends.Backgrounds.getID(::Legends.Background.Manhunter) || bro.getSkills().hasPerk(::Legends.Perk.LegendMasteryNets))	{
				candidates.push(bro);
			}
		}

		if (candidates.len() > 0) {
			this.m.Catcher = candidates[this.Math.rand(0, candidates.len() - 1)];
		}
	}

	function onPrepareVariables( _vars )
    {
        _vars.push([
            "catcher",
            this.m.Catcher != null ? this.m.Catcher.getNameOnly() : ""
        ]);
		_vars.push([
            "dude",
            this.m.Dude != null ? this.m.Dude.getNameOnly() : ""
        ]);
    }

	function isValid(_settlement) {
		if (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion") {
			return false;
		}

		if (_settlement.isSouthern()) {
			return false;
		}

		if (!_settlement.hasSituation("situation.draught")) {
			return false;
		}

		if (!::World.getTime().IsDaytime) {
			return false;
		}

		if (::World.getPlayerRoster().getSize() >= ::World.Assets.getBrothersMax()) {
			return false;
		}

		return !this.isOnCooldown();
	}

	function onClear() {
		this.m.Dude = null;
		this.m.Catcher = null;
	}
})
