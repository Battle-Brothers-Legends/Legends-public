this.legend_find_slave_after_battle_event <- this.inherit("scripts/events/event", {
	m = {
		LastCombatID = 0,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legend_find_slave_after_battle";
		this.m.Title = "After the battle...";
		this.m.IsSpecial = true;
		local BanditBarbarian1 = "It is fairly uncommon to find prisoners in bandit camps, and rarer still for those prisoners to be barbarians from the north, yet here on such specimen stands before you. You doubt this one was captured with little effort, given the strangled guard lying by their feet. Freeing the barbarian, you wonder if there is a place in the %companyname%.";
		local BanditBarbarian2 = "A wide eyed and exceptionally disheveled human hides in the corner of the camp. Seeing you, the form cowers and makes a series of whooping sounds and grunts. Clearly a prisoner, but judging by that physique, perhaps a warrior hides within. Should you take the wildling into the company, or free them back to the wilds?";
		local BanditBarbarian3 = "You\'re not sure what possessed the bandits to take a barbarian prisoner, nor how both parties survived long enough for you to encounter them, but here the barbarian stands. You see a face is twisted in a crazed rage, but shoulders slumped and eyes showing the cold endured only by those in chains. Perhaps a good fit for the company?";
		this.m.Screens.push({
			ID = "Bandits",
			Text = "[img]gfx/ui/events/event_53.png[/img]{" + BanditBarbarian1 + " | " + BanditBarbarian2 + " | " + BanditBarbarian3 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Join us!",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.improveMood(2.0, "Was rescued from captivity");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "Be free, friend.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_barbarian_background"
				]);
				local text1 = "{%name% lived in the wilds for many years, eking out an existence in the harsh northern hinterlands. | Captured as a child in a barbarian raid, %name% was raised by the northern savages as a thrall. The child never forgot town though, resolving to escape and return to true home. One day, they did just that. | %name% was a skilled hunter for the tribe. One particularly harsh winter, the life in the hinterlands seemed to all but disappear, and the barbarian had to venture further and further in search of food.}";
				local text2 = "{Bandits found %name% on the road. | While cutting through a thicket, %name% stumbled into the middle of a brigand camp. | While hiding from wild animals in the forest, %name% encountered creatures far more dangerous: raiders.}";
				local text3 = "{Easily overwhelmed, %name% was captured, humiliated, and forced to do menial labor for the outlaws. | The outlaws tricked %name% into giving up possessions as a toll, then subdued the barbarian when %name% fight back. As punishment, and for their own amusement, they took %name% prisoner, who was forced to maintain their camp. | The outlaws surrounded and knocked %name% out. When conciousness returned, hands and feet were already bound, and from then on %name% was forced to clean up after the highwaymen, pitch and teardown their tents, and handle any task they didn\'t feel like doing.}";
				local text4 = "{%name%\'s captivity came to an abrupt end, however, when you arrived at the camp and slew the captors. | Then one day the %companyname% attacked the camp, and %name% was left without a gaoler. | Forced, that is, until a group of mercenaries showed up and slew the brigands to a man.}";
				local text5 = "{Now free, %name% fights for you. | In gratitude, %name% joined the company and now fights for you. | Former life thrown into disarray, %name% now fights for you, finding comfort in the company of folk who\'ve endured similar trials of their own.}";
				local vars = [
					[
						"companyname",
						this.World.Assets.getName()
					],
					[
						"name",
						_event.m.Dude.getNameOnly()
					]
				];
				_event.m.Dude.getBackground().m.RawDescription = this.buildTextFromTemplate(text1 + " " + text2 + " " + text3 + " " + text4 + " " + text5, vars);
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		local BanditSoutherner1 = "As an institution, slavery holds little grip outside of the southern deserts, but as a practice it knows few borders. The southerner before you clearly learned that lesson the hard way. It seems the lure of free labor to handle camp duties was enough for the brigands to set aside more northern sensibilities. Now that the captors are dead, you wonder if the slave would find life as a sellsword more suitable than menial labor.";
		local BanditSoutherner2 = "Of all the bonds that bring out the fear and ugliness and hatred in man, cultural disparity is perhaps the most powerful. Nothing elicits quite the same repulsion as that which is foreign. It is sadly little surprise, then, when you find a southerner chained and gagged in the corner of the raider\'s camp. The color of skin, the timbre of voice, way of life, religion, all of them combined must have made an appearance so alien that even slavery seemed mundane and appropriate to the highwaymen.\n\nThe slave\'s muffled cries cut your pontification short. Freeing the prisoner, you wonder if joining %companyname% might be a kinder fate.";
		local BanditSoutherner3 = "A southerner comes running at you from out of nowhere and prostrates before you. Before you can say a word the stranger begins thanking you profusely and proclaiming your arrival to be a work of the Gilder. You manage to glean from this babbling that the stranger was held by the brigands as a prisoner and forced to do their nasty duties around camp against. As you calm the situation down, you wonder if there is thanks enough to fight for the %companyname%.";
		this.m.Screens.push({
			ID = "BanditsSoutherner",
			Text = "[img]gfx/ui/events/legend_slave_southern.png[/img]{" + BanditSoutherner1 + " | " + BanditSoutherner2 + " | " + BanditSoutherner3 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Join us!",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.improveMood(2.0, "Was rescued from captivity");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "Be free, friend.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_southern_background"
				]);
				local text1 = "{A merchant by trade, %name% was tasked with leading a caravan to the north to sell incense and silks. | %name% was a nomad of the south, living outside the influence of the viziers. After being exiled from the tribe for some unknown transgression, the southerner traveled north. | A conscript in one of the many regiments of the south, %name% was tasked with guarding a caravan headed north.}";
				local text2 = "{Brigands found %name% on the road, the battle was over and %name% made captive in a land far from home. | The bandits caught %name% off guard. The southerner struggled valiantly, but in the end %name% was bested and taken prisoner. | All was going smoothly until an impassable roadblock forced %name% to take a detour. This led to discovery by highwaymen, and one swift, brutal fight later, %name% became their prisoner.}";
				local text3 = "{The northerners ridiculed and mocked %name% incessantly, and when they got bored of that forced %name% to do demeaning work for them. | The outlaws hoped to ransom %name%, not realizing the southerner lacked such importance. In the meantime, they put %name% to work hauling loot and supplies from their raids, overworking the southerner constantly. | In part to humiliate, and in part because they needed the help, they quickly forced %name% to handle menial labor for their camp.}";
				local text4 = "{Captivity ended as suddenly as it started when the %companyname% raided the encampment and slew the raiders. | The brigands got their comeuppance, in the form of the %companyname% attacking the camp. The outlaws didn\'t last long. | You freed %name% when you assaulted the bandit\'s camp with the %companyname%.}";
				local text5 = "{Owing you a debt of gratitude, %name% now fights for you. | Not having any place to go back to, %name% decided to join the company. | Seeing this plight, you offered to let %name% join the company, an opportunity gladly accepted.}";
				local vars = [
					[
						"companyname",
						this.World.Assets.getName()
					],
					[
						"name",
						_event.m.Dude.getNameOnly()
					]
				];
				_event.m.Dude.getBackground().m.RawDescription = this.buildTextFromTemplate(text1 + " " + text2 + " " + text3 + " " + text4 + " " + text5, vars);
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		local BarbBarbarianText1 = "One of the survivors stands grimly before you. %name% reminds you of a slave you once saw in a gladiator match. This barbarian has the expression, the look of a dead man kindled to life only by the prospect of venting rage on another in combat. You don\'t know the particulars of the situation, but it\'s clear there is no allegiance held to dead fellows. Maybe they\'d be willing to join the %companyname%? It might be a kinder fate with you than that gladiator met in the ring.";
		local BarbBarbarianText2 = "In one a corner of the camp, you find a barbarian with bound hands sitting cross-legged in a cage. You ask how the giant ended up jailed. The barbarian\'s head jerks towards the corpses of the camp\'s former inhabitants.%SPEECH_ON%Not one of them.%SPEECH_OFF%He grunts. It seems there\'s little love lost between the barbarian and the men you slew, at least. Perhaps you could convince the northerner to join the %companyname%?";
		local BarbBarbarianText3 = "You don\'t know much about thralls or the inner workings of barbarian culture, but you do know those of the slave caste are usually the first thrust in combat. It is curious, then, to see one of the northerners alive in a cage before you, rather than dead on the battlefield. You don\'t know what circumstances led to one being left here while the rest fought, but maybe if the savages didn\'t want this thrall fighting for them, that means you should seek allegiance for yourself?";
		this.m.Screens.push({
			ID = "Barbarians",
			Text = "[img]gfx/ui/events/event_53.png[/img]{" + BarbBarbarianText1 + " | " + BarbBarbarianText2 + " | " + BarbBarbarianText3 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Join us!",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.improveMood(2.0, "Was rescued from captivity");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "Be free, friend.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_barbarian_background"
				]);
				local text1 = "{%name% was once chief of their own tribe, until an ambitious rival usurped the role. To complete the humiliation, %name% was forced into thralldom. | Chosen by the Old Gods, %name% was sent out from the village to prove martial skills in combat. %name% found his match in another tribe, however, and was defeated, broken, and made a thrall. | %name% was born a thrall, forced to fight for his freedom for as long as memories go back.}";
				local text2 = "{%name% struggled against captors constantly, unwilling to accept that fate, but those efforts brought the barbarian only to death\'s door, not freedom. That tenacity may well be what kept the northerner alive, as the tribe felt such tenacity would be wasted on a death outside of battle. | As a member of the slave caste %name% was thrust into combat after combat, but no matter what accomplishments were achieived, there was never acceptance by the rest of the barbarians. %name% could never come to accept them, either. | Years of brutal combat and abuse eventually left %name% but a shadow of a human, downtrodden and hopeless, but unable to truly accept death. %name% knew the ancestor\'s would not take this pitiful human, but saw no hope of proving worth as a thrall, either.}";
				local text3 = "One particularly egregious transgression, however, left the tribe unable to bear %name%\'s presence further. %name% was thrown in a cage and left there to be sacrificed next day, in the hopes that death would appease the Old Gods. In a twist of fate, this separation from the rest of the tribe saved %name%\'s life, as the %companyname% descended upon the camp and slew the savages wholesale.";
				local text4 = "{Freed by your intervention, the barbarian now seeks to prove themself in battle under the company banner. | Seeing your arrival as a sign from the gods, %name% agreed to fight for you as a sellsword. | With captors slain and life as a thrall over, %name% now fights for you to seek redemption in the eyes of the ancestors.}";
				local vars = [
					[
						"companyname",
						this.World.Assets.getName()
					],
					[
						"name",
						_event.m.Dude.getNameOnly()
					]
				];
				_event.m.Dude.getBackground().m.RawDescription = this.buildTextFromTemplate(text1 + " " + text2 + " " + text3 + " " + text4, vars);
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		local BarbNorthernerText1 = "Towards the rear of the camp you find a bloody altar strewn with body parts and gore. Nearby you see a pen filled with the sad remains of captives who were spared the savage\'s rituals only to die from starvation, cold, or other tortures. Through some miraculous - or cruel - twist of fate, one among the prisoners still lives. The husk of a human barely acknowledges your presence, darkly muttering and staring at the ground.\n\nYou tell the pitiful figure you might be able to take them on in the %companyname%, although that might mean fighting barbarians like these ones. The figure doesn\'t say anything, but gives you a strange look and stands up. The spirit seems willing, at least.";
		local BarbNorthernerText2 = "Scouring the savage\'s camp, you find and free a person held captive, or what\'s left of one. The barbarians are evidently not kind to their prisoners. The prisoner is unable to form words to describe the experience, but thanks you for freedom and offers to fight for you in return. Maybe with some time to recover, you\'ll find that the bedraggled appearance belies skill as a fighter?";
		local BarbNorthernerText3 = "The din of battle fading, you hear a truly impressive tirade of profanity coming from further in the camp. The sound leads you to a prisoner thrashing and struggling against the ropes binding hands and feet, all the while howling and wailing and cursing with language that would make hardened killers blush. Noticing you, the prisoner frantically inchworms closer.\n\nOi! You there! Thank the Old Gods, some educated folk at last! Quick, get me out of these ropes so I can go throttle those savages, those filthy beasts, those, those, those farkin whoresons! Quickly now, they\'ll get away!%SPEECH_OFF%You say the barbarians have already been slain and the raving prisoner breaks into an unintelligible stream of muttered insults and invectives. While you wouldn\'t want those words with you in a contract negotiation, you can\'t deny the spirit to fight. Maybe that could put it to use in the %companyname%?";
		this.m.Screens.push({
			ID = "BarbariansNortherner",
			Text = "[img]gfx/ui/events/legend_slave_northern.png[/img]{" + BarbNorthernerText1 + " | " + BarbNorthernerText2 + " | " + BarbNorthernerText3 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Join us!",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.improveMood(2.0, "Was rescued from captivity");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "Be free, friend.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_background"
				]);
				local text1 = "{%name% was once a scribe in an isolated northern abbey who spent days leisurely poring over tomes and sorting collections. | %name% grew up in one of the many small hamlets that dot the northern hinterlands. | Originally a lumberjack, %name% was content to spend life in the beautiful forests of the north.}";
				local text2 = "{But that idyllic life was shattered when barbarians raided the village, stole all the valuables, and kidnapped as many as they could carry back with them. | Life in those lands is a harsh one, however, and while prepared for many of the dangers, %name% was not prepared enough for the barbarian raiders that sacked the town and took captives. | Thinking them a misunderstood and largely inconsequential people, %name% rarely paid heed to the fearmongering about the barbarians of the north. While traveling to a nearby town, however, %name% came face-to-face with the savages, and found them just as dangerous as the rumors held. %name% was beaten senseless, tossed in a sack, and taken back to their village.}";
				local text3 = "{%name% was deemed too weak to be put into combat like the other thralls. Instead, put to work with more menial labor. On a good day, that meant tending to sacrificial livestock or cleaning gore out of the savage\'s ritual altars. On a bad day, used as a plaything by the men - or worse, by the women - for whatever cruelty or humiliation they felt like passing the time with. | %name% was made a thrall, and was told that this was a great honor for one not born in the barbarian tribes. In practice, however, this meant being forced into blood-curdling combat against other tribes, insane hunts to capture unholds for the beastmasters, and a life of misery, imprisonment, and ridicule at the hands of the freemen. | One of the tribe elders took an interest in %name% as an interpreter. Whenever the tribe had fresh captives from the surrounding area, %name% was made to explain their fate to them. It was cruel, heart-wrenching work, but disobedience had brutal consequences. %name% just counted lucky stars to not be a thrall. It is still hard to talk about what was done to them when they failed to comply.}";
				local text4 = "{The slave had given up hope of ever escaping this new life when a mercenary band - yours, specifically - stormed the tribe\'s camp and slew the barbarians. | The slave lost track of time in captivity. Only knowing that one day the %companyname% raided the tribe, and fate took another twist. | It was ultimately you who freed the slave when you ordered the company to wage war against the northmen. One brutal fight later, and %name% was a captive no longer.}";
				local text5 = "{Now %name% fights for you and the company, glad to see days as a slave in the past. | Unable to return to that old life after what was endured, %name% now seeks solace fighting with the company. | The slave decided to join you and seek a new life as a sellsword, and has been with the company since.}";
				local vars = [
					[
						"companyname",
						this.World.Assets.getName()
					],
					[
						"name",
						_event.m.Dude.getNameOnly()
					]
				];
				_event.m.Dude.getBackground().m.RawDescription = this.buildTextFromTemplate(text1 + " " + text2 + " " + text3 + " " + text4 + " " + text5, vars);
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		local NomadSouthernerText1 = "Inside one of the nomad\'s tents, you find a miserable looking form tidying the place up. Taking this person to be their slave, you say that the nomads are dead and all are free to go, but a sad face only looks at the floor glumly in response.%SPEECH_ON%My debt to the Gilder has not yet been paid. Where am I to go?%SPEECH_OFF%Angrily, you pull the slave to their feet and say that debt can be paid anywhere, and without chains. After a moment your words seem to sink in and you see tears of joy form in the slave\'s eyes as the weight of freedom sinks in, but you know they did have a point. There\'s not many opportunities out there for a former slave. Perhaps there might be a place in the %companyname%?";
		local NomadSouthernerText2 = "A slave, naked save for a few rags, walks up to you.%SPEECH_ON%You slew these men, yes? You have my thanks. I was unjustly captured by them and forced into slavery, but with their deaths I am finally free. I admit I am not sure where to go now, but the fact that I may walk there on unfettered feet is joyous enough.%SPEECH_OFF%As the slave turns to leave, you wonder if they might prefer life in the %companyname% to braving the deserts alone.";
		local NomadSouthernerText3 = "You enter one of the nomads tents and are greeted with a most curious sight. A half naked human, wide-eyed in surprise, stands frozen over the body of a dead nomad. A leg of lamb hangs from their mouth by a sinewy thread, the meat dangerously close to falling. The figure glances down their nose at it, then at you, then at the nomad corpse, then at this precarious meal again. You say they\'d better grab the food before its wasted, and the slave practically melts in relief and complies. You gather that the nomads captured this wretch as a slave, clearly they\'d attempted to use the confusion of the battle to escape - had just killed the guard and was grabbing provisions when you walked in. You think so, anyhow - mouthfuls of lamb did abilities as a storyteller no favors.\n\nRegardless of table manners, it remains clear that the slave is if nothing else able to kill for survival. Might those skills be put to better use in the %companyname%?";
		this.m.Screens.push({
			ID = "Nomads",
			Text = "[img]gfx/ui/events/legend_slave_northern.png[/img]{" + NomadSouthernerText1 + " | " + NomadSouthernerText2 + " | " + NomadSouthernerText3 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Join us!",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.improveMood(2.0, "Was rescued from captivity");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "Be free, friend.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_southern_background"
				]);
				local text1 = "{A conscript in one of the many regiments of the south, %name% was always proud of work. Despite the mandatory nature of service, %name% always felt that protecting the holy city-state was the mandate of the Gilder more than the Vizier. That devotion went unnoticed by the officers, however, who sent the soldier on a doomed scouting mission to ferret out nomads hiding in the ocean of sand outside the city. | %name% used to be a treasure hunter, plumbing the depths of the myriad ruins and detritus of the old empire buried in the sands. One day a sandstorm blew them off-course while hunting for a famed library of old. Not to be deterred, %name%  pressed on after the storm died down, determined to not let the search be in vain. | %name% was a manhunter in a past life, ironically enough.  Making a comfortable living hunting down deserters, convicts, and escaped slaves, until one day they strayed too deep into the desert while hunting a quarry.}";
				local text2 = "{It was the nomads who proved the more able hunters, however, catching the fighter by surprise and knocking them out in one fell swoop. | Isolated and unprepared to go so far afield, however, the fighter collapsed under the burning sun. %name% awoke, already the nomad\'s captive. | If %name% felt like a hunter, however, the nomads that suddenly appeared all around cured the notion. %name% certainly felt like prey while being subdued and bound.}";
				local text3 = "{The outlaws declared %name% Indebted and forced to serve them. A deep ire, fueled by that former station, led to escape attempts and fighting back against the captors. As the beatings grew more brutal and the work more cruel, however, the ire turned to resignation. | They made %name%  their slave. At first the ignobility gnawed, but malnourishment, abuse, and the bite of the lash eventually ground %name% down into nothing but a cold, empty husk of a person. | Enslaved by the outlaws, %name% was outraged by this fate and tried to escape. They stuffed the escapee in a box for a week as punishment. Gradually, rage cooled and an empty despair settled in.}";
				local text4 = "Seeing a new captive suffer the same fate, however. rekindled the rage. %name%  vowed then and there to become free and to fight against any who would enable such slavery.";
				local text5 = "{When the %companyname% raided the nomad camp and freed the slaves, %name% knew it was a chance to help make things right. | A group of escaped slaves - your group of escaped slaves, specifically - felled the nomads in battle, and %name% knew then that the place was with them. | %name% saw the opportunity to make good on this newfound resolve when the %companyname% attacked and defeated the captors.}";
				local text6 = "%name% \'s been a part of the company since.";
				local vars = [
					[
						"companyname",
						this.World.Assets.getName()
					],
					[
						"name",
						_event.m.Dude.getNameOnly()
					]
				];
				_event.m.Dude.getBackground().m.RawDescription = this.buildTextFromTemplate(text1 + " " + text2 + " " + text3 + " " + text4 + " " + text5 + " " + text6, vars);
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		local NomadNorthernerText1 = "A crazed looking prisoner, feet bound in chains, comes galloping out of the camp yelling something about divine retribution, and how the old gods were looking out for the faithful. The slave starts kicking at a nomad\'s corpse and you quickly move to calm things down before it get out of hand. After you explain the situation, the slave delivers a final kick to the nearest body and explains being taken prisoner by the nomads and forced into slavery. Perhaps with captors gone, the righteous might find a place in the %companyname%?";
		local NomadNorthernerText2 = "A pitiful looking northerner hobbles out of one of the nomad\'s tents.%SPEECH_ON%Did you kill them? The desert people, I mean. If so, you have my thanks. Those bastards killed my comrades and took me prisoner. Said I owed some kind of debt to that devil they worship, the \'guilter\' or whatever stupid name they gave it. Farkin\' southerners...%SPEECH_OFF% The swearing trails off, cold eyes taking in the carnage of the battle with an unusual calm. If someone can keep that cool in front of living enemies as well as dead ones, they might just have a successful career as a sellsword. Perhaps you should take this one into the %companyname%?";
		local NomadNorthernerText3 = "Surveying the battlefield, you see one of the surviving nomads limp into a tent. Giving chase, you enter the tent and find the outlaw about to kill a northerner chained to a post inside. Drawing your sword, you swiftly cut down the would-be executioner. Through all of this, the captive remains calmly seated, taking in his gaoler\'s death and your own entrance like a fine wine. You tell the slave their composure is impressive, given the situation.%SPEECH_ON%I have not wasted the solitude of captivity. Just as I know I am part of The Great Plan, I knew I would not die here.%SPEECH_OFF%You don\'t much care for religious fanatics, but this fanatic\'s coolness in the face of death is impressive. You wonder if they might do well applying that iron will to mercenary work.";
		local NomadNorthernerText4 = "Surveying the battlefield, you see one of the surviving nomads limp into a tent. Giving chase, you enter the tent and find the outlaw about to kill a northerner chained to a post inside. Drawing your sword, you swiftly cut down the would-be executioner. Through all of this, the captive remains calmly seated, taking in his gaoler\'s death and your own entrance like a fine wine. You tell the slave their composure is impressive, given the situation.%SPEECH_ON%I have not wasted the solitude of captivity. Just as I know I am part of The Great Plan, I knew I would not die here.%SPEECH_OFF%You don\'t much care for religious fanatics, but this fanatic\'s coolness in the face of death is impressive. You wonder if they might do well applying that iron will to mercenary work.";
		this.m.Screens.push({
			ID = "NomadsNortherner",
			Text = "[img]gfx/ui/events/event_53.png[/img]{" + NomadNorthernerText1 + " | " + NomadNorthernerText2 + " | " + NomadNorthernerText3 + " | " + NomadNorthernerText4 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Join us!",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.improveMood(2.0, "Was rescued from captivity");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "Be free, friend.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_background"
				]);
				local text1 = "{%name% was a hunter in a past life, tracking down dangerous beasts that threatened the village. | Once a monk, %name% was always struck by wanderlust and always volunteered for any tasks that lead outside the cloistered abbey. | A courier by trade, %name% always enjoyed seeing the world and tried to take the scenic route whenever possible.}";
				local text2 = "{One day that wandering ventured too far, however, and %name%  as confronted with a danger not prepared for: nomads from the southern deserts. Some terse words and a short scuffle saw %name% taken prisoner by the outlaws. | %name%\'s travels lead to the south, encountering a group of nomads who decided %name%\'s true purpose in life was to be their slave. Swiftly knocked out, captured, and taken back to their camp, life was never the same. | Wandering into the southern steppe turned out to be a little too far afield, however. Nomads captured %name% in a raid and took the wanderer with them, forced into slavery.}";
				local text3 = "{%name%\'s captors explained fate politely and with patience, but their kindness ended there. The slave won\'t speak of the hardships, but the scars do the talking. | Subject to the full measure of ignobility and hardship of being treated as a thing, %name% turned to meditation for solace. It seems inner peace was found, which is good considering the physical hardships evidenced by outer appearance. | %name% was given a crash course in southern religion and made to understand debt to the Gilder, which he would be paid off by serving these new captors. Eduring the sun\'s cruel gaze and the lash\'s cruel bite in equal measure.}";
				local text4 = "{Things stayed that way for longer than the slave cares to remember, until one day the %companyname% arrived and defeated the nomads in combat. | It was the %companyname% that gave freedom, slaying the masters and ending the slave\'s captivity. | %name% spent months planning an escape, and was about to spring the plan when guards caught the slave stealing supplies. That explains the bruises when you attacked the nomads.}";
				local text5 = "{In gratitude, %name% now fights with you. | Unsure how to return to that past life, if possible at all, for now %name%\'s trying the mercenary life. | With nowhere else to go, %name% joined the company.}";
				local vars = [
					[
						"companyname",
						this.World.Assets.getName()
					],
					[
						"name",
						_event.m.Dude.getNameOnly()
					]
				];
				_event.m.Dude.getBackground().m.RawDescription = this.buildTextFromTemplate(text1 + " " + text2 + " " + text3 + " " + text4 + " " + text5, vars);
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		local UndeadSlaveText1 = "A person steps into open practically wearing the surrounding graveyard. All of manner of dirt, grime, and gore cling to the figure - a forearm gripped ankle, a nachzehrer horn held loosely in hands dripping with blackened blood, and you swear you can see a faint blue shimmer. The freed one slowly approaches and politely greets you, calmly explaining they were held captive for some time. Hours ago, captors decided usefulness was outlived and left their slave here to die. The captive held out against the graveyard\'s inhabitants as best as possible, then you showed up.\n\nYou\'re not sure you buy that story, but the clinging viscera does give a hint of credibility, and if nothing else points to remarkable resilience. Maybe this survivor would be a useful addition to the %companyname%?";
		local UndeadSlaveText2 = "Seemingly from nowhere, a person with bound hands approaches you. The slave makes a pathetic whimpering sound and holds hands out towards you begging you to cut them free. You do so. The captive must surely have quite the story to tell, but it\'s evident from the scars that dot the naked body and the lack of fat on those bones that captivity has taken quite some time. Perhaps in exchange for freedom and a reliable meal, this survivor would be willing to join the %companyname%?";
		local UndeadSlaveText3 = "A figure runs out from behind a gravestone yelling and raving madly. You almost cut it down in surprise, but the person gets near and throws themself at your feet and starts sobbing out thanks. It takes several minutes for the pitiful moans to calm down enough to form coherent sentences. The words speak of dark things, of profane experiments performed on both the living and the dead by a man in black. The captive before you is the sole survivor, escaping the fate of the others by hiding under a pile of corpses deemed too rotten to be of use. That part of the tale, at least, is lent credence by appearance.\n\nWhile the survivor is thoroughly wretched and obviously abused, they clearly have resourcefulness and tenacity that would serve well in a mercenary outfit. Perhaps there is a place in the %companyname%?";
		this.m.Screens.push({
			ID = "Undead",
			Text = "[img]gfx/ui/events/legend_slave_undead.png[/img]{" + UndeadSlaveText1 + " | " + UndeadSlaveText2 + " | " + UndeadSlaveText3 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Join us!",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						local r = this.Math.rand(0, 99);

						if (r == 1)
						{
							::Legends.Perks.grant(_event.m.Dude, ::Legends.Perk.LegendGruesomeFeast);
						}

						if (r == 2)
						{
							::Legends.Perks.grant(_event.m.Dude, ::Legends.Perk.LegendInventorAnatomy);
						}

						if (r == 3)
						{
							_event.m.Dude.getSkills().add(this.new("scripts/skills/injury_permanent/traumatized_injury"));
						}

						if (r == 4)
						{
							::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.FearUndead);
						}

						if (r == 5)
						{
							::Legends.Perks.grant(_event.m.Dude, ::Legends.Perk.LegendRaiseUndead);
						}

						if (r == 6)
						{
							::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.HateUndead);
						}

						if (r == 7)
						{
							::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.CultistFanatic);
						}

						// if (r == 8)
						// {
						// 	_event.m.Dude.getSkills().add(this.new("scripts/skills/traits/legend_deathly_spectre_trait"));
						// }

						if (r == 8)
						{
							::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.Paranoid);
						}

						if (r == 9)
						{
							::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendUndeadKiller);
						}

						if (r == 10)
						{
							::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.Fearless);
						}

						if (r == 11)
						{
							::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.Deathwish);
						}

						if (r == 12)
						{
							::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.Mad);
						}

						if (r == 13)
						{
							::Legends.Perks.grant(_event.m.Dude, ::Legends.Perk.LegendSpecBandage);
						}

						if (r == 14)
						{
							::Legends.Perks.grant(_event.m.Dude, ::Legends.Perk.LegendFavouredEnemyZombie);
						}

						_event.m.Dude.improveMood(2.0, "Was rescued from captivity");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "Be free, friend.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				local cultureResult = this.Math.rand(1, 4);
				local vars = [
					[
						"companyname",
						this.World.Assets.getName()
					],
					[
						"name",
						_event.m.Dude.getNameOnly()
					]
				];
				local backgroundText1 = "";
				local backgroundText2 = "";
				local backgroundText3 = "{%name% was made to assist in the madman\'s depraved experiments. Sometimes this simply meant hauling corpses, but often meant far worse. You recall the terrified glances %name% sometimes gives village girls and decide not to pry further. | A curiosity for their physique, %name% was studied, prodded, poked, sometimes even cut open. | %name% was forced to compete with the madman\'s undead minions in strange, esoteric feats of physical prowess or martial prowess.}";
				local backgroundText4 = "{One day, however, the opportunity to escape arose, and the captive took it without hesitation. The %companyname% wiped the camp clean, and with nowhere else to go the survivor now fights for you. | It was you who gave the chance for freedom, when you stormed the lair and slew its inhabitants. Seeing it the obvious choice, the slave decided to fight for you.}";

				if (cultureResult == 4)
				{
					_event.m.Dude.setStartValuesEx([
						"slave_southern_background"
					]);
					backgroundText1 = "{%name% claims to have once been an assassin of one of the southern guilds. Tasked with killing a man accused of using foul magic to bring the dead to unnatural life. The assassin tracked the target to his lair and was poised to strike. | A nomad whose tribe was massacred by a necromancer, %name% traveled far and wide in search of revenge. Eventually finding the lair of the man responsible, all that remained was to storm the redoubt and kill its inhabitant. | %name% was originally a manhunter. One day tasked with hunting down a particularly dangerous escapee: a necromancer responsible for the destruction - and subsequent resurrection - of an entire regiment. Undeterred, %name% accepted and tracked the sorcerer to his lair in the wilds.}";
					backgroundText2 = "{It was a trap. Before the attacker could react, the %name% was surrounded by once-dead men.  The fight was bravely fought, but was eventually overwhelmed by their numbers. When %name% awoke, it was in the necromancer\'s prison. | For all that preparedness, however, the plan failed to notice the hands clawing out of the ground underneath until it was too late. The fleshy automatons that arose bound and tied , and the hunter was soon the necromancer\'s captive. | While charging in, however, the attacker was surprised to find not just the necromancer, but a host of rotting corpses surrounding as well. %name% fought, but their numbers were too great. The greated horror, was not being killed, but instead captured.}";
				}
				else if (cultureResult == 3)
				{
					_event.m.Dude.setStartValuesEx([
						"slave_barbarian_background"
					]);
					backgroundText1 = "{A wildling who abandoned society long ago, %name% was content to live out the rest of life in the forests of the wild. But one day alien creatures began to roam the woods, things that should be dead, things that should not be at all. The wildling searched for the source and found a sorcerer\'s lair on the periphery of the wilds. | Tasked by the elder\'s to purge the Untoward, %name% travelled the lands putting the undead back in the ground. Always hunting for the Source, one day the search yielded fruit - a profane lair where a man in black robbed men of their deaths. | Originally a barbarian from the north, %name%\'s returned from a hunting trip to find the village utterly devastated, victims of an undead incursion. Swearing vengeance, the wildling tracked the cursed creatures down and slew them one by one, until only the mastermind behind them remained.}";
					backgroundText2 = "{The necromancer acted first - hired ruffians kidnapped %name% in the night, and in the morning awoke a prisoner. | But %name%\'s nemesis took the initiative, and as the wildling approached grasping hands sprung from the ground and restrained. A cloaked figure, glowing red eyes, and then nothingness.  %name% came to, already in chains. | But the necromancer was not caught unaware. As the wildling charged in bravely to slay the foe, dead men in armor appeared from all around and held the wildling down. %name% was chained, rage unspent and mission unfulfilled.}";
				}
				else
				{
					_event.m.Dude.setStartValuesEx([
						"slave_background"
					]);
					backgroundText1 = "{%name% was a witchhunter, known for the singlemindedness of the crusade against the hexen and their dark crafts. Rumors of strange magic and terrorized townspeople saw hunts lead him further and further into the wilderness. | While priests are not usually known for their investigative tendencies, %name% nonetheless was thrust into the inquisitor\'s role when when the village dead began rising from their graves. | A simple farmer, %name%\'s life was an inauspicious one, until one day people from the village started disappearing and %name% left to find them.}";
					backgroundText2 = "But the search turned up something more sinister than expected - a necromancer performing profane experiments on both living and dead. %name% tried to run, but grasping hands and rotting bodies blocked the path, and %name% was knocked out and taken prisoner.";
				}

				_event.m.Dude.getBackground().m.RawDescription = this.buildTextFromTemplate(this.text1 + " " + this.text2 + " " + this.text3 + " " + this.text4, vars);
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function isValid()
	{
		if (!this.Const.DLC.Desert)
		{
			return false;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.legend_escaped_slaves")
		{
			return;
		}

		if (!this.World.Statistics.getFlags().get("FindCaptivePostBattle"))
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("LastCombatID") <= this.m.LastCombatID)
		{
			return;
		}

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 5.0 || this.World.Statistics.getFlags().getAsInt("LastCombatResult") != 1)
		{
			return false;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return false;
		}

		local f = this.World.FactionManager.getFaction(this.World.Statistics.getFlags().getAsInt("LastCombatFaction"));

		if (f == null)
		{
			return false;
		}

		if (f.getType() != this.Const.FactionType.Zombies && f.getType() != this.Const.FactionType.Bandits && f.getType() != this.Const.FactionType.Barbarians && f.getType() != this.Const.FactionType.OrientalCityState && f.getType() != this.Const.FactionType.OrientalBandits)
		{
			return false;
		}

		this.m.LastCombatID = this.World.Statistics.getFlags().get("LastCombatID");
		return true;
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		local f = this.World.FactionManager.getFaction(this.World.Statistics.getFlags().getAsInt("LastCombatFaction"));

		if (f.getType() == this.Const.FactionType.Bandits)
		{
			if (this.Math.rand(1, 100) <= 40)
			{
				return "Bandits";
			}
			else
			{
				return "BanditsSoutherner";
			}
		}
		else if (f.getType() == this.Const.FactionType.Barbarians)
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				return "Barbarians";
			}
			else
			{
				return "BarbariansNortherner";
			}
		}
		else if (f.getType() == this.Const.FactionType.OrientalBandits)
		{
			if (this.Math.rand(1, 100) <= 60)
			{
				return "Nomads";
			}
			else
			{
				return "NomadsNortherner";
			}
		}
		else if (f.getType() == this.Const.FactionType.Zombies)
		{
			return "Undead";
		}
	}

	function onClear()
	{
		this.m.Dude = null;
	}

	function onSerialize( _out )
	{
		this.event.onSerialize(_out);
		_out.writeU32(this.m.LastCombatID);
	}

	function onDeserialize( _in )
	{
		this.event.onDeserialize(_in);
		this.m.LastCombatID = _in.readU32();
	}

});

