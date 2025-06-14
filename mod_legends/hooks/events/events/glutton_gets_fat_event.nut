::mods_hookExactClass("events/events/glutton_gets_fat_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_14.png[/img] You find %glutton% helping %themselves_glutton% to a third helping of food. That\'s far too much and so you demand that it be %their_glutton% last. Another mercenary joins in, mocking the %person_glutton% for %their_glutton% habits. The glutton, enraged, slams %their_glutton% food down and stands up. %Their_glutton% stomach however, sways at a different pace than the rest of %them_glutton% and the rather fattened %person_glutton% goes down in a heap of flailing limbs. While the rest of the company has a laugh, you can\'t help but wonder if the sellsword really has gotten too fat.";
			}
		}
	}

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

			if (bro.getLevel() >= 3 && bro.getSkills().hasTrait(::Legends.Trait.Gluttonous) && !bro.getSkills().hasTrait(::Legends.Trait.Fat))
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Glutton = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Glutton.getGender(), "glutton");
	}
})
