::mods_hookExactClass("events/events/shady_character_offers_map_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_41.png[/img]%peddler% the peddler steps forward, hands out just like the traveling merchant\'s had been. Apparently this is a common tactic amongst honest thieves.%SPEECH_ON%Sir, sir, please. Come on. That price is outrageous.%SPEECH_OFF%The merchant\'s face sours.%SPEECH_ON%There is nothing outrageous about it, I promise you.%SPEECH_OFF%But your peddler persists.%SPEECH_ON%Clearly there is something outrageous, because I just said so, did I not?%SPEECH_OFF%The merchant nods. The peddler continues.%SPEECH_ON%So we\'ve decided to not purchase it at your original asking price. That much is clear. So, friend, I think we will purchase it for %newcost%. That is fair to all parties involved, and surely a fine businessman such as yourself can see a deal! We\'re hardly businessmen ourselves, but we know that\'s a good deal!%SPEECH_OFF%The merchant scratches his chin, then nods.%SPEECH_ON%Alright, that price is fair.%SPEECH_OFF%";
			}
			if (s.ID == "F") {
				s.Text = "[img]gfx/ui/events/event_41.png[/img]While you\'re talking to the merchant, %thief% the thief sidles up next to you, appearing rather interested in the conversation. %thief% glances at you. You do a double take. %thief% grins and nods. You quickly eye the salesman then glance back at the thief and nod. The merchant is in the middle of his sales pitch and sees none of this. He keeps talking, but you hear little of it. You just know to keep nodding for a merchant such as he only tells you things you want to hear anyway.\n\n The thief slips around the back and drops a weapon into the mud.%SPEECH_ON%Clumsy me.%SPEECH_OFF% %thief% bends down, pauses, there\'s a motion you can hardly detect, and then %thief%\'s upright again. %thief% gives you a wink. You tell the merchant you appreciate the offer, but you\'ll have to pass. When he\'s gone, %thief% presents you with the map and grins.%SPEECH_ON%They say the best things in life are free.%SPEECH_OFF%";
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.World.getTime().IsDaytime)
			return;

		if (this.World.getTime().Days < 10)
			return;

		if (this.World.Assets.getMoney() <= 1500)
			return;

		if (this.World.State.getEscortedEntity() != null)
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
			return;

		local bases = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
		local candidates_location = [];

		foreach( b in bases )
			if (!b.getLoot().isEmpty() && !b.getFlags().get("IsEventLocation"))
				candidates_location.push(b);

		if (candidates_location.len() == 0)
			return;

		this.m.Location = candidates_location[this.Math.rand(0, candidates_location.len() - 1)];
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_peddler = [];
		local candidates_thief = [];
		local candidates_historian = [];

		foreach( bro in brothers )
			if (bro.getBackground().getID() == "background.historian" || bro.getSkills().hasPerk(::Legends.Perk.LegendScholar))
				candidates_historian.push(bro);
			else if (bro.getBackground().getID() == "background.thief")
				candidates_thief.push(bro);
			else if (bro.getBackground().getID() == "background.peddler")
				candidates_peddler.push(bro);

		if (candidates_historian.len() != 0)
			this.m.Historian = candidates_historian[this.Math.rand(0, candidates_historian.len() - 1)];

		if (candidates_thief.len() != 0)
			this.m.Thief = candidates_thief[this.Math.rand(0, candidates_thief.len() - 1)];

		if (candidates_peddler.len() != 0)
			this.m.Peddler = candidates_peddler[this.Math.rand(0, candidates_peddler.len() - 1)];

		this.m.Cost = this.Math.rand(6, 14) * 100;
		this.m.Score = 7;
	}
})
