::mods_hookExactClass("events/events/glutton_gets_fat_event", function(o) {
	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;

		if (this.World.Assets.getFood() < 100)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			//If any bros fulfill the below requirements, this event will not apply/trigger to them
			if (bro.getFlags().get("IsSpecial") || bro.getFlags().get("IsPlayerCharacter") || bro.getBackground().getID() == "background.legend_puppet" || bro.getBackground().getID() == "background.legend_donkey")
				continue;

			if (bro.getLevel() >= 3 && bro.getSkills().hasSkill("trait.gluttonous") && !bro.getSkills().hasSkill("trait.fat"))
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Glutton = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}
})
