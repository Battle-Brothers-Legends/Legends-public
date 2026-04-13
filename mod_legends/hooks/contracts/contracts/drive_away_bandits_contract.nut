::mods_hookExactClass("contracts/contracts/drive_away_bandits_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Brigand Stronghold";
		this.m.DescriptionTemplates = [
			"A brigand stronghold is nearby, attracting all manner of thieves, vagrants and murderers.",
			"A delightful group of companions have set-up in a nearby ruin. They attack all who travel the road.",
			"Tensions are starting to rise as a nearby brigand stronghold grows in power.",
			"Every soul in a brigand stronghold knows the value of a sharp blade and a quick wit. Be wary.",
			"In a brigand stronghold, fear reigns supreme and trust is a rare commodity.",
			"Survival is harsh in a brigand gang, where every day brings new dangers. Today, that danger is you.",
			"Brigand raiders have been humiliating the region. You are being hired to eradicate them.",
			"\'Steal from the rich, give to the poor.\' An interesting idea for sure, until the rich inevitably hire a sellsword company to kill you.",
			"Obliterate the stronghold, earn your pay.",
			"Crush the stronghold, claim your bounty. What could go wrong?",
		];
	}

	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Running")
			{
				s.onDestinationAttacked = function ( _dest, _isPlayerAttacking = true )
				{
					if (this.Flags.get("IsRobberBaronPresent"))
					{
						if (!this.Flags.get("IsAttackDialogTriggered"))
						{
							this.Flags.set("IsAttackDialogTriggered", true);
							this.Contract.setScreen("AttackRobberBaron");
							this.World.Contracts.showActiveContract();
						}
						else if (!this.Flags.get("IsRobberBaronDead"))
						{
							local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
							properties.Music = this.Const.Music.BanditTracks;
							properties.Entities.push({
								ID = this.Const.EntityType.BanditLeader,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/bandit_leader",
								Faction = _dest.getFaction(),
								Callback = this.onRobberBaronPlaced.bindenv(this)
							});
							properties.EnemyBanners.push(this.Contract.m.Destination.getBanner());
							this.World.Contracts.startScriptedCombat(properties, true, true, true);
						}
					}
					else
					{
						this.World.Contracts.showCombatDialog();
					}
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		::Legends.Screens.hook(this, "Survivors2", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_22.png[/img]{Altruism is for the naive. You have the prisoners slaughtered. | You recall how many times brigands slew hapless merchants. The thought is barely out of your mind when you give the order to have the prisoners executed. They pipe up a brief protest, but it is cut short by swords and spears. | You turn away.%SPEECH_ON%Through their necks. Make it quick.%SPEECH_OFF%The mercenaries follow the order and you soon here the gargling of dying men. It is not quick at all. | You shake your head \'no\'. The prisoners cry out, but the men are already upon them, hacking and slashing and stabbing. The lucky ones are decapitated before they can even realize the immediacy of their own demise. Those with some fight in them suffer to the very end. | Mercy requires time. Time to look over your shoulder. Time to wonder if it was the right decision. You\'ve no time. You\'ve no mercy. The prisoners are executed and that takes little time at all.} \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation decreases slightly";
		});
		::Legends.Screens.hook(this, "Survivors3", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_22.png[/img]{There\'s been enough killing and dying today. You let the prisoners go, taking their arms and armor before sending them off. | Clemency for thieves and brigands doesn\'t come often, so when you let the prisoners go they practically kiss your feet as though they were attached to a god. | You think for a time, then nod.%SPEECH_ON%Mercy it is. Take their equipment and cut them loose.%SPEECH_OFF%The prisoners are let go, leaving behind what arms and armor they had with them. | You have the brigands strip to their skivvies - if they even have them - then let the men go. %randombrother% rummages through what equipment is left behind as you watch a group of half-naked men hurry away.} \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation increases slightly";
		});
		::Legends.Screens.hook(this, "Success1", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_04.png[/img]{You return to %townname% and talk to %employer%. The details of your journey are simple: you killed the brigands. %They_employer% nods, smiling tersely before handing over your payment as agreed upon.%SPEECH_ON%Good work, men. Those brigands were giving us plenty of trouble.%SPEECH_OFF% | %employer% opens the door for you as you get to his home. %They_employer%\'s got a satchel in hand and holds it up.%SPEECH_ON%I take it by your return that the brigands are dead?%SPEECH_OFF%You nod. The %person_employer% heaves the satchel your way. You tell %them_employer% you could be lying. %employer% shrugs.%SPEECH_ON%Could be, but word travels fast for those who bite the hands that feed. Good work, sellsword. Unless you\'re lying of course, then I\'ll come find you.%SPEECH_OFF% | %employer% grins as you enter %their_employer% room and lay a sacked head on %their_employer% desk.%SPEECH_ON%You need not stain my fineries to show you\'ve completed the task, sellsword. I\'ve already gotten news of your success - the birds in these lands do travel fast, don\'t they? Your payment is in the corner.%SPEECH_OFF% | As you finish your report, %employer% wipes %their_employer% forehead with a handkerchief.%SPEECH_ON%Really, they\'re all dead then? Boy... you have no idea how much you\'ve lifted off my shoulders, sellsword. No idea at all! Your crowns, as promised.%SPEECH_OFF%%They_employer% sets a satchel on %their_employer% desk and you quickly take it. All is there, as promised. | %employer% sips %their_employer% goblet and nods.%SPEECH_ON%You know, I don\'t take kindly to your sort, but you did a good job, mercenary. %randomname% reported to me, before you even got here, that all the brigands had been slain. It was some mighty fine work by the way %they_employer% describes it. And, well...%SPEECH_OFF%%They_employer% heaves a satchel onto the desk.%SPEECH_ON%Here\'s some mighty fine pay, as promised.%SPEECH_OFF% | %employer% leans back in %their_employer% chair, folding %their_employer% hands over %their_employer% lap.%SPEECH_ON%Sellswords don\'t sit right with many folks, I suppose on the account of y\'all killing and destroying whole villages on a shortchanged whim, but I\'ll admit you\'ve done good.%SPEECH_OFF%%They_employer% nods to a corner of the room where a wooden chest lays unopened.%SPEECH_ON%It\'s all there, but I won\'t be offended if you need to count it.%SPEECH_OFF%You do count it, and it is indeed all there. | %employer%\'s desk is blanketed in dirtied and unfurled scrolls. %They_employer%\'s smiling warmly over them as if %they_employer%\'s crooning over a pile of treasure.%SPEECH_ON%Trade deals! Trade deals everywhere! Happy farmers! Happy families! Everyone\'s happy! Ah, it\'s good to be me. And, of course, it\'s good to be you, sellsword, because your pockets just got a little bit heavier!%SPEECH_OFF%The %person_employer% tosses a small purse your way, then another and another.%SPEECH_ON%I would\'ve paid with a larger satchel, but I just like doing that.%SPEECH_OFF%%They_employer% cheekily tosses another purse which you casually catch with the sort of unamused aplomb of a man who still has fresh blood on his sword.}";
		});
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
