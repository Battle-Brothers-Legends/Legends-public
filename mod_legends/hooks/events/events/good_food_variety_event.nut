::mods_hookExactClass("events/events/good_food_variety_event", function(o) {
	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();
		local hasBros = false;

		foreach( bro in brothers ) {
			if (bro.getSkills().hasTrait(::Legends.Trait.Spartan) || bro.getFlags().get("IsSpecial") || bro.getFlags().get("IsPlayerCharacter") || bro.getBackground().getID() == "background.legend_puppet" || bro.getBackground().getID() == "background.legend_donkey")
				continue;

			hasBros = true;
			break;
		}

		if (!hasBros)
			return;

		local stash = this.World.Assets.getStash().getItems();
		local food = [];

		foreach( item in stash ) {
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
				if (food.find(item.getID()) == null)
					food.push(item.getID());
		}

		if (food.len() < 4)
			return;

		this.m.Score = 10;
	}
})
