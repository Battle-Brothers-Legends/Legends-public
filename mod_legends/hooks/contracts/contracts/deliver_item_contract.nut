::mods_hookExactClass("contracts/contracts/deliver_item_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"A valuable cargo requires express, armed delivery. Discretion preferred.",
			"Complete the delivery, claim your payment. Sounds so simple.",
			"Secure the package, fulfill the contract, collect your fee.",
			"Get paid for the armed delivery of this crucial item.",
			"\'Deliver with maximum security.\' You have to wonder what kind of item demands such lengths.",
			"Handle with care, deliver securely, enjoy the payout. Sounds easy enough.",
			"From pickup to drop-off, prioritize security, earn your pay.",
			"Make sure the package arrives intact to secure your compensation.",
			"Secure the package, ensure safe delivery, earn your reward.",
			"Guard the item closely, hand only to its intended recipient to fulfill the contract.",
			"Navigate dangerous roads, fulfill the contract, and get paid.",
		];
	}

	o.setup = function ()
	{
		local settlements = this.World.EntityManager.getSettlements();
		local candidates = [];

		foreach( s in settlements )
		{
			if (s.getID() == this.m.Home.getID())
			{
				continue;
			}

			if (!s.isDiscovered() || s.isMilitary())
			{
				continue;
			}

			if (!s.isAlliedWithPlayer())
			{
				continue;
			}

			if (this.m.Home.isIsolated() || s.isIsolated() || !this.m.Home.isConnectedToByRoads(s) || this.m.Home.isCoastal() && s.isCoastal())
			{
				continue;
			}

			local d = this.m.Home.getTile().getDistanceTo(s.getTile());

			if (d < 15 || d > 100)
			{
				continue;
			}

			if (this.World.getTime().Days <= 10)
			{
				local distance = this.getDistanceOnRoads(this.m.Home.getTile(), s.getTile());
				local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed, false);

				if (this.World.getTime().Days <= 5 && days >= 2)
				{
					continue;
				}

				if (this.World.getTime().Days <= 10 && days >= 3)
				{
					continue;
				}
			}

			candidates.push(s);
		}

		if (candidates.len() == 0)
		{
			this.m.IsValid = false;
			return;
		}

		this.m.Destination = this.WeakTableRef(candidates[this.Math.rand(0, candidates.len() - 1)]);
		local distance = this.getDistanceOnRoads(this.m.Home.getTile(), this.m.Destination.getTile());
		local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed, false);

		local modrate = this.World.State.getPlayer().getBarterMult();

		if (days >= 2 || distance >= 40)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		}

		this.m.Payment.Pool = this.Math.max(75, distance * (4.0 + modrate) * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentLightMult());
		//	local modBonus = distance * modrate * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentLightMult();
		//	this.Contract.m.BulletpointsObjectives.push("You gain + " modrate " crowns due to your bartering skills");

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Distance", distance);
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task") {
				s.Text = "[img]gfx/ui/events/event_112.png[/img]{%employer% shoves a sizeable crate into your hands before %they_employer% or you even says a word.%SPEECH_ON%Look at that, the cargo I need delivering has already found someone to ship it off! What wonder!%SPEECH_OFF%%They_employer% drops the theatrics.%SPEECH_ON%I need that taken to %objective% where a %person_recipient% by the name of %recipient% is waiting for it. It may look small, but I\'m willing to pay good crowns to be sure it gets there safe and sound. You interested? Or is it a little too heavy for your arms?%SPEECH_OFF% | You find %employer% closing a box up. %They_employer% quickly glances up, as though %they're_employer% been caught with his pants down.%SPEECH_ON%Sellsword! Thank you for coming.%SPEECH_OFF%%They_employer% locks the latches with a few quick snaps. Then %they_employer% pats the crate a few times, even leans on it as though it needed one more, fat latch.%SPEECH_ON%This here cargo has to be delivered safely to %objective%. A %person_recipient% by the name of %recipient% is waiting for it. I do not believe the task will be easy, as the cargo is rather precious to certain people who\'d go to great lengths to acquire it, which is why I\'m turning to a man of your... experiences. Are you interested in doing this for me?%SPEECH_OFF% | As you enter %employer%\'s room %they_employer% and one of %their_employer% servants are nailing a box shut.%SPEECH_ON%Good seeing you, sellsword. One moment, please. No, idiot, hold the nail that way! I know I hit your thumb before, but I won\'t do it again.%SPEECH_OFF%%Their_employer% servant reluctantly holds a nail while the %person_employer% hammers it home. Finished, %they_employer% wipes the sweat off %their_employer% brow and looks to you.%SPEECH_ON%I need this here crate delivered to %objective% about %days% %direction% by road. It\'s going to %recipient%, you know. %Them_employer%. Alright, maybe you don\'t know %them_employer%. What I do know is that this may not ordinarily be your line of work, but I\'m willing to pay some serious crowns for you to see it through. That\'s your real business, right? Earning some crowns?%SPEECH_OFF% | %employer% folds %their_employer% hands together when %they_employer% sees you.%SPEECH_ON%This might be a strange question, but how interested are you in making a delivery for me?%SPEECH_OFF%You explain that, for the right price, such a journey would be a welcome departure from the usual killing and dying that goes on around you. The %person_employer% claps %their_employer% hands together.%SPEECH_ON%Excellent! Unfortunately, I don\'t expect it to be quite like that. It\'s of enough import to garner unsavory attention, which is why I\'m looking to hire sellswords in the first place. It\'s going to %objective%, %days% or so %direction% of here by road, where a %person_recipient% by the name of %recipient% is waiting for it to fall into %their_recipient% hands. So, you see, this won\'t be the \'departure\' you speak of, but it can be a fine payday if you\'re interested.%SPEECH_OFF% | %employer%\'s men are standing around a bit of cargo. Their employer shoos them away when %they_employer% sees you.%SPEECH_ON%Welcome, welcome. Good seeing you. I\'m in need of armed guards to have this here package delivered to a %person_recipient% by the name of %recipient% in %objective%. I reckon it\'s about %days% of travel for a company as yours. How interested would you be in doing that for me?%SPEECH_OFF% | %employer%\'s got %their_employer% feet up on %their_employer% table when you enter. %They_employer% puts %their_employer% hands behind %their_employer% head, looking a little too relaxed for your tastes.%SPEECH_ON%Good tidings, captain. What say you take a leave from all that killing and dying.%SPEECH_OFF%%They_employer% raises an eyebrow at your response, which is precisely none at all.%SPEECH_ON%Huh, I figured you\'d jump on that opportunity. No matter, it was a lie: I need you to take a certain package to %recipient%, a fellow residing in %objective%. This cargo has undoubtedly garnered some ill-intentioned eyes which is why I need your men watching it for me. If you\'re interested, which you should be, let\'s talk numbers.%SPEECH_OFF% | %employer% welcomes you, waving you in.%SPEECH_ON%Very well, now that you\'re here, would you please shut the door behind you?%SPEECH_OFF%One of the %person_employer%\'s guards pokes his head around the corner. You smile as you slowly shut him out. Turning around, you find %employer% walking toward a window. %They_employer% stares out as %they_employer% talks.%SPEECH_ON%I need something... it\'s a, uh, well you don\'t need to know what it is. I need this \'something\' delivered to a fellow called %recipient%. %Person_recipient%\'s waiting for it in %objective%. It\'s important that it actually gets there, important enough for an armed escort for %days% of travel, which is why I\'m turning to you and your company. What say you, mercenary?%SPEECH_OFF% | Dim candles barely light the room enough for you to see, it\'s %employer% sitting behind %their_employer% desk while %their_employer% shadows dance on the walls by the tune of flickering lights.%SPEECH_ON%Would you lend your swords to me if I paid you good coin? I need {a small chest | something dear to me | something valuable} delivered safely to %recipient% in %objective%, about %days% of travel %direction% of here. Men have killed each other over this, so you must be ready to defend it with your life.%SPEECH_OFF%%They_employer% takes a pause, measuring your response.%SPEECH_ON%I will write a sealed letter with instructions to pay you as you deliver the item to my contact in %objective%. What say you?%SPEECH_OFF% | A servant bids you to wait for %employer%, who, he says, will be right with you. And so you wait, and wait, and wait. And finally, as you are about to leave for the second time, %employer% throws open the doors and rushes towards you.%SPEECH_ON%Who\'s this, again? The mercenary?%SPEECH_OFF%%Their_employer% assistant nods and %employer% sets on a smile.%SPEECH_ON%Oh most fortuitous to have you in %townname%, good captain!\n\nIt is imperative that some precious commodities of mine reach %objective% as safely and quickly as possible. You are precisely who I need, for no common brigand would dare attack you and your men.\n\nYes, I\'d like to hire you for escort. Make sure the items are delivered to %recipient%, no detours of course. Can we come to an understanding?%SPEECH_OFF%}";
			}
			if (s.ID == "Thieves1") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]{You raise up from a nap and turn over, looking for the package as though it were a lover. But she\'s not there and neither is the cargo. Quickly getting to your feet, you begin ordering the men to attention. %randombrother% runs up and says %they're_randombrother% tracked some footprints leading off from the site. | While taking a rest, you hear a disturbance somewhere in the camp. You rush to it to find %randombrother% face down in the dirt, rubbing the back of %their_randombrother% head.%SPEECH_ON%Sorry sir, I was taking a piss, and then they went on ahead and took it out of me. Also, they stole the package.%SPEECH_OFF%You tell %them_randombrother% to repeat that last part.%SPEECH_ON%Goddamn thieves have stolen the goods!%SPEECH_OFF%Time to track those bastards down and get it back. | Naturally, it wouldn\'t be an ordinary trip. No, this world is too shite for that to be the case. It appears thieves have taken off with the cargo. Luckily, they\'ve left a hell of a lot of evidence, namely footprints and dragmarks from toting the package around. They should be easy to find... | Just once you\'d like to have a nice walk from one town to the next. Instead, your agreement with %employer% has attracted trouble once again. Thieves, somehow, managed to sneak into the camp and make off with the cargo. The good news is that they didn\'t manage to sneak back out: you\'ve found their footprints and they won\'t be hard to follow.}";
			}
			if (s.ID == "EnragingMessage1") {
				s.Text = "{The cemetery is layered in fog - that or a thick miasma given off by the dead. Wait... that IS the dead! To arms! | You eye a tombstone with a mound of soil unearthed at its base. Blots of mud lead away like a crumb trail. There are no shovels... no men... As you follow the lead, you come across a band of undead moaning and groaning... now staring at you with insatiable hunger... | A man lingers deep in the rows of tombstones. He seems to be wavering, as though ready to pass out. %randombrother% comes to your side and shakes %their_randombrother% head.%SPEECH_ON%That\'s no man, sir. There\'s undead afoot.%SPEECH_OFF%Just as %They_randombrother% finishes talking, the stranger in the distance slowly turns and there in the light reveals he\'s missing half his face. | You come to find many of the graves are emptied. Not just emptied, but unearthed from below. This is not the work of graverobbers...}";
			}
			if (s.ID == "EvilArtifact1") {
				s.Text = "[img]gfx/ui/events/event_55.png[/img]{While on the move, you notice that something else is moving, too: the cargo. The lid on it is jumping around and there\'s a strange glow emerging from its sides. %randombrother% approaches, looks at it, then looks at you.%SPEECH_ON%Should we open it, sir? Or I can take it and throw it in the closest pond because none of that right there is alright.%SPEECH_OFF%You jab the %person_randombrother% and ask if %they're_randombrother% scared. | Moving along the paths, you begin to hear a low hum emanating from the package %employer% had given you. %randombrother% is standing beside it, poking it with a stick. You slap %them_randombrother% back. %They_randombrother% explains himself.%SPEECH_ON%Sir, there\'s something that ain\'t right with the cargo we\'re tugging...%SPEECH_OFF%You take a good look at it. There\'s a faint color brimming at the edges of the lid. As far as you know, fire can\'t breathe in such a space, and the only thing else that glows in the dark are the moons and the stars. You worry that curiosity is starting to get the better of you... | The cargo rests in the wagon beside you, jostling about to the tilts and turns of the paths. Suddenly, it begins to hum and you swear you saw the lid float upward for just a second. %randombrother% glances over.%SPEECH_ON%You alright, sir?%SPEECH_OFF%Just as %They_randombrother% finishes talking, the lid explodes outward, a swirl of colors, mist, ash, fiery heat and brutish cold. You throw your arms up, shielding yourself, and when you take a peek through your elbows the package is completely still, the lid back on. You exchange a glance with the sellsword, then both of you stare at the cargo. This might be a little more than an ordinary delivery... | A low hum emanates from nearby. Thinking a bee hive nearby, you instinctively duck, only to realize the sound is coming from the cargo %employer% had handed you. The lid atop the container is rattling side to side, jostling the latches and nails that are supposed to keep it there. %randombrother% looks a little frightened.%SPEECH_ON%Let\'s just leave it here. That thing ain\'t right.%SPEECH_OFF%}";
			}
			if (s.ID == "EvilArtifact2") {
				s.Text = "[img]gfx/ui/events/event_73.png[/img]{Curiosity gets the best of you. Slowly you start prying at the lid. %randombrother% takes a step back and protests.%SPEECH_ON%I think we should leave it alone, sir. I mean c\'mon, look at it.%SPEECH_OFF%Ignoring %them_randombrother%, you tell the men it\'s going to be alright, and then you lift the lid up.\n\n It isn\'t alright. The explosion knocks you off your feet. Horrible shapes and shrieks swirl all around you. The men instinctively arm themselves as the piloted specters spear into the earth. There the ground lifts in mounds, and there, too, the earth begins to groan. You watch as hands shoot forth, dragging decrepit bodies from their pit. The dead live again and surely they mean to add to their ranks! | Against anyone\'s best judgment, you pry the cargo open. At first, there is nothing. It\'s just an empty box. %randombrother% nervously laughs.%SPEECH_ON%Well... I guess that\'s it then.%SPEECH_OFF%But that can\'t be it, can it? Why would %employer% have you delivering an empty container unless -- \n\n You wake up to a ringing slowly fading from your ears. Turning over, you see that the box has completely evaporated, a flurry of snowy sawdust all that remains of it. %randombrother% rushes over, picking you up and dragging you toward the rest of the company. They point, their mouths moving, shouting...\n\n A mob of well-armed men are... shuffling your way? As you get a better sight of them, you realize that they are armed with old wooden shields painted with odd spiritual rites, and their armor is of shapes and sizes you have never seen before, as though they were crafted by men just learning the trade, yet still well learned in what they had learned thus far. These are like ancients... the first men. | %randombrother% shakes %their_randombrother% head as you go to pick up the lid. With some effort, it\'s pried open and you quickly step back, expecting the worst. But there\'s nothing. Not even a sound comes out of the box. You take a sword and rattle it around in the empty box, looking for a secret compartment or something. %randombrother% laughs.%SPEECH_ON%Hey, we\'re just delivering a bunch of air! And to think I thought that damned thing was too heavy!%SPEECH_OFF%Just then, the box lifts briefly into the air, spins, and smashes itself into the ground. It breaks perfectly, noiselessly, and with no wasted movements, every piece of wood laid against the grass like ancient stoneworks. An incorporeal shape leers up from the splintered rites, grinning as it twists.%SPEECH_ON%Oh humans, it is truly good to see you again.%SPEECH_OFF%The voice is like ice down your back. You watch as the specter shoots into the sky then slams back down, spearing into the very earth. Not a second passes before the ground is erupting as bodies begin to clamber out. | The box magnetizes you. Without hesitation, you crank the cargo open and take a look inside. You smell before you see - a horrid stench overwhelming you almost to the point of blindness. One of the men pukes. Another retches. When you look back at the box, blackened tendrils of smoke are sifting out of it, stretching long and far, probing the ground as they go. When they find what they\'re looking for, they dive into the earth, yanking up bones of dead men like a lure would a fish. | Ignoring the worries of a few of the men, you bust the package open. A pile of heads are to be found, their glowing eyes flickering awake. Their jaws crackle open, shifting from unmoved states to rattle in laughter. You quickly close the box, but a force pushes it back open. You struggle with it, %randombrother% and a few others trying to help, but it\'s almost as if the utterly silent winds of a storm are pushing back against you.\n\nA bare moment later, you\'re all thrown back, the lid of the crate soaring into the sky, ushered upward by a gust of blackened souls. They zip around, combing the earth, then collectively position opposite the %companyname%. There you watch in horror as the incorporeal begins to take shape, the foggy mists of souls hardening into the very real bones of souls lost long ago. And, of course, they come armed, the crackling jawbones still clattering with hollow laughter.}";
			}
			if (s.ID == "Success1")	{
				s.Text = "[img]gfx/ui/events/event_20.png[/img]{%recipient%\'s waiting for you as you enter the town. %They_recipient% hurriedly takes the cargo off your hands.%SPEECH_ON%Oh, ohhh I did not think you would get here.%SPEECH_OFF%%Their_recipient% grubby fingers dance along the chest carrying the cargo. %They_recipient% turns around and barks an order to one of his men. They step forward and hand you a satchel of crowns. | Finally, you\'ve made it. %recipient% is standing there in the middle of the road, %their_recipient% hands clasped over %their_recipient% stomach, a slick grin on %their_recipient% cheeky face.%SPEECH_ON%Sellsword, I was not sure you\'d make it.%SPEECH_OFF%You lug the cargo up and hand it over.%SPEECH_ON%Oh yeah, and why do you say that?%SPEECH_OFF%The %person_recipient% takes the box and hands it off to a robed man who quickly hurries away with it tucked under an arm. %recipient% laughs as %They_recipient% hands you a satchel of crowns.%SPEECH_ON%The roads are rough these days, are they not?%SPEECH_OFF%You understand %they're_recipient% making small talk, anything to get your attention off the cargo you just handed over. Whatever, you got your pay, that\'s good enough for you. | %recipient% welcomes you and a few of %their_recipient% men hurry over to take the cargo. %They_recipient% claps you on the shoulders.%SPEECH_ON%I take it your journey went well?%SPEECH_OFF%You spare %them_recipient% the details and inquire about your pay.%SPEECH_ON%Bah, a sellsword through and through. %randomname%! Get this man what he deserves!%SPEECH_OFF%One of %recipient%\'s bodyguards walks over and hands you a small chest of crowns. | After some looking, a man asks who you\'re looking for. When you say %recipient%, he points you out toward a nearby paddock where a %person_recipient% is strutting about on a rather opulent looking horse.\n\n You walk on over and the %person_recipient% rears the steed and asks if that\'s the cargo %employer% sent. You nod.%SPEECH_ON%Leave it there at your feet. I\'ll come and get it.%SPEECH_OFF%You don\'t, instead asking about your pay. The %person_recipient% sighs and whistles to a bodyguard who hurries over.%SPEECH_ON%See to it that this sellsword gets the pay he deserves.%SPEECH_OFF%Finally, you put the crate on the ground and make your leave.} ";
				s.Options = [
					{
						Text = "Crowns well deserved.",
						function getResult()
						{
							this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
							this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());

							local playerRoster = this.World.getPlayerRoster().getAll();
							local xp = this.Contract.m.Payment.getOnCompletion() * 0.25;
							foreach( bro in playerRoster )
							{
									bro.addXP(xp);
									bro.updateLevel();
							}
							if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
							{
								this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Delivered some cargo");
							}
							else
							{
								this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Delivered some cargo");
							}

							local recipientFaction = this.Contract.m.Destination.getFactionOfType(this.Const.FactionType.Settlement);

							if (recipientFaction != null)
							{
								recipientFaction.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess * 0.5, "Delivered some cargo");
							}

							this.World.Contracts.finishActiveContract();
							return 0;
						}

					}
				];
				local start = s.start;
				s.start <- function ()
				{
					start();
					this.Contract.m.Home.setResources(this.Contract.m.Home.getResources() + this.Contract.m.Home.getResources() * 0.05); // Gain 5% settlement wealth for this contract
				}
			}
			if (s.ID == "Success2")
			{
				s.Text = "[img]gfx/ui/events/event_163.png[/img]{%SPEECH_START%Ah, the Crownling.%SPEECH_OFF%The voice comes from a nearby alley. Usually that means you\'re about to have some coin lifted off ya, but instead find a man offering you gold.%SPEECH_ON%I am %recipient%, and that package belongs to me. Send %employer% my regards, or don\'t, I don\'t care.%SPEECH_OFF%The %person_recipient% steals away and is gone just as soon as %they_recipient% came. | %recipient% is a squat %person_recipient% and %they_recipient% carries the Vizier\'s emblem and signage as though it were as heavy as the crate you just brought him.%SPEECH_ON%I\'ve given the Vizier much, and what does he use to repay me? A Crownling\'s sweat. May the Gilder blink when gazing upon that man\'s future.%SPEECH_OFF%You say nothing to this, in part because you wonder if it is a \'test\' to see if you\'ll agree with him and turn yourself out to be an enemy of the ever majestic Vizier. The %person_recipient% stares at you for a moment, then shrugs and continues.%SPEECH_ON%I have your payment here. The coin is all accounted for, though I will not take offense if you wish to count it yourself. Ah, I see you already are. Good. See? It\'s all there. Now run along little Crownling.%SPEECH_OFF% | You find %recipient% holding court over a small throng of children. %They_recipient% quickly singles you and teaches them a lesson about keeping to their studies lest they end up like you. After the kids are dismissed, the %person_recipient% comes over with a satchel of crowns.%SPEECH_ON%My men told me you had arrived and that the material was still in good standing. Here is your motley payment, Crownling.%SPEECH_OFF% | You enter %recipient%\'s home where the package is finally dropped off and whisked away by servants. Staring at you from a comfortable looking chair, %recipient% asks if your journey went well. You state that idle talk does not fill your pockets and then inquire about your pay. The %person_recipient% raises an eyebrow.%SPEECH_ON%Ah, have I offended the Crownling with my kind, civilized sensibilities? How dare I. Well then, your pay is in the corner and it is in full as agreed upon.%SPEECH_OFF% | %recipient% is pontificating about the nature of birds to a mirror. When %they_recipient% sees you in the reflection, %they_recipient% turns around and speaks as though nothing unusual had been going on at all.%SPEECH_ON%A Crownling. Of course the Vizier sends a Crownling. I like to imagine you did not dare profane the materials of the crate with your eyes, but I can\'t even trust such professionalism out of your sort. But you can expect it of me: your payment is in the corner, and in full.%SPEECH_OFF%}";
				s.Options = [
					{
						Text = "Crowns well deserved.",
						function getResult()
						{
							this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
							this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());

							local playerRoster = this.World.getPlayerRoster().getAll();
							local xp = this.Math.round(this.Const.Combat.GlobalXPMult * this.Contract.m.Payment.getOnCompletion() * 0.25);
							foreach( bro in playerRoster )
							{
								bro.addXP(xp);
								bro.updateLevel();
							}

							if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
							{
								this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Delivered some cargo");
							}
							else
							{
								this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Delivered some cargo");
							}

							local recipientFaction = this.Contract.m.Destination.getFactionOfType(this.Const.FactionType.Settlement);

							if (recipientFaction != null)
							{
								recipientFaction.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess * 0.5, "Delivered some cargo");
							}

							this.World.Contracts.finishActiveContract();
							return 0;
						}

					}
				];
				s.start <- function ()
				{
					local xpGained = this.Math.round(this.Contract.m.Payment.getOnCompletion() * 0.25 * this.Const.Combat.GlobalXPMult);
					this.Characters.push(this.Tactical.getEntityByID(this.Contract.m.RecipientID).getImagePath());
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns and [color=" + this.Const.UI.Color.PositiveEventValue + "]" + xpGained + "[/color] Experience"
					});
					this.Contract.m.Home.setResources(this.Contract.m.Home.getResources() + this.Contract.m.Home.getResources() * 0.05); // Gain 5% settlement wealth for this contract
				}
			}
		}
	}
});
