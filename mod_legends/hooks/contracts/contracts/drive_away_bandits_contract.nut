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
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Survivors2")
			{
				s.Text = "[img]gfx/ui/events/event_22.png[/img]{Altruism is for the naive. You have the prisoners slaughtered. | You recall how many times brigands slew hapless merchants. The thought is barely out of your mind when you give the order to have the prisoners executed. They pipe up a brief protest, but it is cut short by swords and spears. | You turn away.%SPEECH_ON%Through their necks. Make it quick.%SPEECH_OFF%The mercenaries follow the order and you soon here the gargling of dying men. It is not quick at all. | You shake your head \'no\'. The prisoners cry out, but the men are already upon them, hacking and slashing and stabbing. The lucky ones are decapitated before they can even realize the immediacy of their own demise. Those with some fight in them suffer to the very end. | Mercy requires time. Time to look over your shoulder. Time to wonder if it was the right decision. You\'ve no time. You\'ve no mercy. The prisoners are executed and that takes little time at all.} \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation decreases slightly";
			}
			if (s.ID == "Survivors3")
			{
				s.Text = "[img]gfx/ui/events/event_22.png[/img]{There\'s been enough killing and dying today. You let the prisoners go, taking their arms and armor before sending them off. | Clemency for thieves and brigands doesn\'t come often, so when you let the prisoners go they practically kiss your feet as though they were attached to a god. | You think for a time, then nod.%SPEECH_ON%Mercy it is. Take their equipment and cut them loose.%SPEECH_OFF%The prisoners are let go, leaving behind what arms and armor they had with them. | You have the brigands strip to their skivvies - if they even have them - then let the men go. %randombrother% rummages through what equipment is left behind as you watch a group of half-naked men hurry away.} \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation increases slightly";
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