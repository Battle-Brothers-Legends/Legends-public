::mods_hookExactClass("contracts/contracts/drive_away_barbarians_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Wildlings at the Gates";
		this.m.DescriptionTemplates = [
			"A northern ice tribe has settled nearby. These barbarians and their savage pagan ways are not welcome here.",
			"Every dawn brings new challenges to a barbarian camp. Today, it\'s your mercenary company cresting the horizon.",
			"In a barbarian camp, the fire of battle is ever burning. Hopefully just like their camp will be later today.",
			"Barbarians live by their own code of honor, much like sellswords, whose code can be changed for the right price.",
			"The shadow of barbarian invasion darkens this town\'s doorstep.",
			"Not much is known about the northern ice tribes, as they tend to kill everyone they come into contact with.",
		];
	}

	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Task")
			{
				s.Name = "Wildlings at the Gates";
				s.Text = "[img]gfx/ui/events/event_20.png[/img]{%employer% sighs as he pushes a scrap of paper toward you. It is a list of crimes. You nod, observing that it is quite a lot of wrongdoing. The man nods back.%SPEECH_ON%T\'was an affair of a mere criminal I\'d spiff a constable or maybe a bounty hunter. But I\'ve brought you here sellsword because this is the work of barbarians. All that they\'ve done, all that is listed there, I need done to them. They\'ve a village %direction% from here. I need you to pay them a visit and show that while we live with hearths and civilization, the spark of the wild has not left us yet, and that barbarian actions will be met with barbaric retribution. Understand?%SPEECH_OFF%You now notice that the page of crimes is smattered with stricken feather tips, as though the one writing it got increasingly upset by its cataloging. | A group of local knights are in the room with %employer%. They regard you plainly, as though you were a dog who had pushed the door open and moseyed in. %employer% reaches down from his chair and retrieves a scroll and throws it your way.%SPEECH_ON%Barbarians left that for me when I went to make sense of a nearby farmstead that was obliterated.%SPEECH_OFF%The paper has runic drawings and what look like depictions of a hanging. %employer% nods.%SPEECH_ON%They massacred the farmers, the men anyway. The old gods know what came of the women. Go %direction% of here, sellsword, and find the barbarians responsible. You\'ll be paid handsomely for their outright, total, and complete annihilation.%SPEECH_OFF% | %employer% is looking rather bugged when you enter the room. He states that %townname% used to have good relations with the barbarians to the north.%SPEECH_ON%But I suppose I was just fooling myself to think we could stay on even terms with those savages.%SPEECH_OFF%He states they have been attacking caravans, murdering travelers, and attacking homesteads.%SPEECH_ON%So I\'ll treat them in kind. Go %direction% of here and slaughter their village whole. You keen to doing that?%SPEECH_OFF% | %employer% laughs when you enter the room.%SPEECH_ON%Not having a joke at your expense, sellsword, only at that cruel congruity of seeking a mercenary for prompt and total erasure of barbarians. You see, just %direction% of here stands a tribe of bearskin wearin\' arsefucks that have been scalping and axing traders and travelers. I won\'t stand for it. Partly because they\'re in the wrong, but especially because I have the coin to pay someone of your ill manners to take care of it for me.%SPEECH_OFF%He laughs to himself again. You get the feeling this man has never put a sword in any breathing being.%SPEECH_ON%So what say you, sellsword, interested in slaughtering some savages?%SPEECH_OFF% | When you enter %employer%\'s room he is staring at a dog\'s head. A steady leak from the neck drips over the table\'s edge. The man is rubbing one of the ears.%SPEECH_ON%Who kills a man\'s dog, cuts off its head, and fucking sends it to him?%SPEECH_OFF%You imagine someone with a hated enemy, but say nothing. %employer% nods at one of his servants and the dog\'s head is taken away. He looks to you now.%SPEECH_ON%Savages to the %direction% did this. First they started in on the merchants and homesteaders, raping and pillaging as the barbarians do. So I sent a response, killed a few of theirs, and this is what I get in return. Well, no more of these whoresons. I want you to go their village and annihilate them to the last.%SPEECH_OFF%You almost ask if that would include the destruction of their dogs. | You find %employer% with a dirtied and mudslaked woman sat beside his chair. Her hair is matted and her flesh stricken with all manner of punishment. She sneers at you as if it was all your doing. %employer% kicks her over.%SPEECH_ON%Don\'t mind this wench, sellsword. We caught her and her friends raiding the granary. Killed the lot of the savages, I\'d say we spared her for the fun of it but beating on her is about as fun as doing it to a dog. Her mannishness just steals the joy.%SPEECH_OFF%He kicks her again and she snarls back.%SPEECH_ON%See? Well, I have news! We have located the stain she came from and I have every intention of burning it to the ground. That\'s where you come in. The barbarian village is %direction% of here. Stomp it out and you\'ll be paid very well.%SPEECH_OFF%The woman doesn\'t know what is being said, but some slack in her stare seems to indicate she\'s beginning to understand why a man of your sort walked through that door in the first place. %employer% grins.%SPEECH_ON%You interested or do I have to find a man of meaner character?%SPEECH_OFF% | %employer% has a crowd of peasants in his room. More of them than any man of his station would be comfortable with in such proximity, but they surprisingly don\'t seem to be interested in lynching him. Seeing you, %employer% calls you forward.%SPEECH_ON%Ah, finally! Our answer is here! Sellsword, the barbarians %direction% of here have been pillaging nearby villages and raping anything with a hole. We\'re sick of it and frankly I don\'t want some mangy savage cock anywhere near my arse no more than the next man.%SPEECH_OFF%The crowd of peons jeers, one man yelling out that the barbarians {cut the head off his mother | also murdered his pet goats | stole all his dogs, the bastards | ate the liver of his youngest son}. %employer% nods.%SPEECH_ON%Aye. Aye, men, aye! And so I say, sellsword, that you plot a path to the barbarians\' village and treat them to measured, appropriate, civilized justice.%SPEECH_OFF% | %employer% waves you into his room. He\'s holding a firepoke, a scalp hanging off its tip.%SPEECH_ON%The northern barbarians sent me this today. It was stuck to its messenger, a man they took the eyes and tongue out of. Such is their nature, these savages, to speak to me without a word. And so I have a feeling I shall return the favor with your help, sellsword. Go %direction% of here, find their little village, and burn it to the ground.%SPEECH_OFF%The scalp unsticks from the firepoke and slaps against the stone floor with a wet slap. | %employer% reluctantly welcomes you in, as is one is wont to do when the world has pressed them into needing a mercenary. He speaks succinctly.%SPEECH_ON%The barbarians have a village %direction% of here from which they are sending raiding parties. They rape, they pillage, they are nothing but insects and varmints in the shape of men. I want them all gone, to the very last. Are you willing to take on this task?%SPEECH_OFF% | %employer%\'s got a cat in his lap, but as you draw near you realize it\'s just the head and he\'s simply been thumbing a delimbed tail around with his thumb. He purses his lips.%SPEECH_ON%The barbarian savages did this. They also raped and pillaged a number of surrounding farmsteads and they hung a pair of twin infants from a tree, but this...%SPEECH_OFF%His palms open up and the cat\'s head rolls out and hits the stone floor with a matted clap.%SPEECH_ON%No more. I want you to go %direction% of here and find the village those savages call home and do unto it what they have done unto us!%SPEECH_OFF%}";
				
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "TheDuel3")
			{
				// cycling through the list of options and hooking by Text is clunky and will cause issues for translators so i just completely replaced it
				s.Options = [
					{
						Text = "We will stay true to our word and leave you in peace. (Increase Moral Reputation)",
						function getResult()
						{
							this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
							this.World.Assets.addMoralReputation(5);
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "Failed to destroy a barbarian encampment threatening " + this.Contract.m.Home.getName());
							this.World.Contracts.finishActiveContract(true);
							return 0;
						}

					},
					{
						Text = "Everyone, charge! (Decrease Moral Reputation)",
						function getResult()
						{
							this.World.Assets.addMoralReputation(-3);
							this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
							return 0;
						}

					}
				]
			}
			if (s.ID == "Survivors2")
			{
				s.Text = "[img]gfx/ui/events/event_145.png[/img]{You unsheathe your sword and lower the blade toward the man, the corpses in the tent blurring along its metal curvature, and the surviving barbarian\'s face blobbing at the tip. He grins and grips the edges, sheathing it in his huge hands. Blood drips steadily from his palms.%SPEECH_ON%Death, killing, no dishonor. For us both. Yes?%SPEECH_OFF%Nodding, you push the blade into his chest and sink him back to the floor. The weight of him on the sword is like a stone and when you unstick him the corpse claps back against the pile of corpses. Sheathing the sword, you tell the company to round up what goods they can and to ready a return to %employer%.} \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation decreases slightly";
			}
			if (s.ID == "Survivors3")
			{
				s.Text = "[img]gfx/ui/events/event_145.png[/img]{You unsheathe your blade halfway, hold it long enough that the savage sees it, then you slam it back into the scabbard. Nodding, you ask.%SPEECH_ON%Understand?%SPEECH_OFF%The barbarian stands up, briefly slumping against the tent\'s post. You turn and hold your hand out to the tent flap. He nods.%SPEECH_ON%Aye, I know.%SPEECH_OFF%He stumbles out and into the light and away into the northern wastes, his shape tottering side to side, shrinking, and is then gone. You tell the company to get ready to return to %employer% for some well-earned pay.} \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation increases slightly";
			}
		}
	}

	o.onSerialize = function ( _out )
	{
		//_out.writeI32(0);

		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	o.onDeserialize = function ( _in )
	{
		//_in.readI32();
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}
});