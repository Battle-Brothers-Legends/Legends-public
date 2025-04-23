::mods_hookExactClass("ambitions/ambitions/allied_nobles_ambition", function(o)
{
	o.onReward = function ()
	{
		local allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);
		local banner = 1;

		foreach( a in allies )
		{
			local f = this.World.FactionManager.getFaction(a);

			if (f != null && f.getType() == this.Const.FactionType.NobleHouse && f.getPlayerRelation() >= 90.0)
			{
				banner = f.getBanner();
				break;
			}
		}

		local item;
		local stash = this.World.Assets.getStash();

		item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.faction_helm, banner]]);
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});


		item = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.heraldic_armor, null, banner],
		]);
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
		item = this.new("scripts/items/shields/faction_heater_shield");
		item.setFaction(banner);
		item.setVariant(2);
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
		item = this.new("scripts/items/shields/faction_heater_shield");
		item.setFaction(banner);
		item.setVariant(2);
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
		item = this.new("scripts/items/shields/faction_kite_shield");
		item.setFaction(banner);
		item.setVariant(2);
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
		item = this.new("scripts/items/shields/faction_kite_shield");
		item.setFaction(banner);
		item.setVariant(2);
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
	}
});
