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
		local i = this.Math.rand(1, 11); //No shields or daggers. Also no potentially overpowered weapons at this stage in the game like greatswords, 2h cleavers, 2h hammers, throwing weapons, etc.

		if (i == 1)
		{
			item = this.new("scripts/items/weapons/named/named_axe");
		}
		else if (i == 2)
		{
			item = this.new("scripts/items/weapons/named/named_warhammer");
		}
		else if (i == 3)
		{
			item = this.new("scripts/items/weapons/named/named_cleaver");
		}
		else if (i == 4)
		{
			item = this.new("scripts/items/weapons/named/named_crossbow");
		}
		else if (i == 5)
		{
			item = this.new("scripts/items/weapons/named/named_flail");
		}
		else if (i == 6)
		{
			item = this.new("scripts/items/weapons/named/named_warbrand");
		}
		else if (i == 7)
		{
			item = this.new("scripts/items/weapons/named/named_greatsword");
		}
		else if (i == 8)
		{
			item = this.new("scripts/items/weapons/named/named_mace");
		}
		else if (i == 9)
		{
			item = this.new("scripts/items/weapons/named/named_spear");
		}
		else if (i == 10)
		{
			item = this.new("scripts/items/weapons/named/named_sword");
		}
		else if (i == 11)
		{
			item = this.new("scripts/items/weapons/named/named_warbow");
		}

		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
	}
});
