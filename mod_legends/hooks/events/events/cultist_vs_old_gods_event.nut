::mods_hookExactClass("events/events/cultist_vs_old_gods_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img] You step off to the side, letting the mercenaries hash out their differences as folk with great differences do. Fists for arguments, the follower of the old gods makes a case, battering the cultist again and again. But the sellsword with the scarred head only grins in return. Eyes puffing up, the lids purpled and puckering over eyes. Yet, still, the grin, and there is bloody laughter spewing out of a reddened mouth.%SPEECH_ON%Such darkness! Davkul is most pleased!%SPEECH_OFF%With an anxious look, %oldgods% steps off %cultist% and backs away. Rubbing his bloodied knuckles, realizing a few may have broken in the seemingly one-sided scuffle. But it\'s the cultist\'s words that hurt most of all.%SPEECH_ON%Man isn\'t tempted by the darkness, he is called to it! Lost without it! Gleeful in its return!%SPEECH_OFF%Almost afraid to look back, %oldgods% hurries away as the cultist remains behind, laughing and chuckling on the grass, nobody daring to get near.";
				s.Options[0].Text = "I didn\'t know %oldgods% could get so angry.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_03.png[/img] The way things are going, you\'ve hardly a mercenary to spare. Just as fists are about to start flying, you step in between the two and put an end to it. You tell %oldgods% they are better than this, and you tell %cultist% nothing, for the cultist is almost bowled over in fits of laughter. Pointing, grinning madly.%SPEECH_ON%The light steps in, but darkness is patient. Davkul awaits you all.%SPEECH_OFF%";
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local cultist_candidates = [];

		foreach( bro in brothers )
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist))
				cultist_candidates.push(bro);

		if (cultist_candidates.len() == 0)
			return;

		local oldgods_candidates = [];

		foreach( bro in brothers )
			if (bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.flagellant" || bro.getBackground().getID() == "background.pacified_flagellant" || bro.getBackground().getID() == "background.monk_turned_flagellant")
				oldgods_candidates.push(bro);

		if (oldgods_candidates.len() == 0)
			return;

		this.m.Cultist = cultist_candidates[this.Math.rand(0, cultist_candidates.len() - 1)];
		this.m.OldGods = oldgods_candidates[this.Math.rand(0, oldgods_candidates.len() - 1)];
		this.m.Score = (cultist_candidates.len() + oldgods_candidates.len()) * 5;
	}
})
