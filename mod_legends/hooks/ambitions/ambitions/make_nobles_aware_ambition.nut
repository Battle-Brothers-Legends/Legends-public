::mods_hookExactClass("ambitions/ambitions/make_nobles_aware_ambition", function(o) 
{
	o.onReward = function ()
	{
		local item;
		local stash = this.World.Assets.getStash();
		local item = this.Math.rand(1, 11); //No shields or daggers. Also no potentially overpowered weapons at this stage in the game like greatswords, 2h cleavers, 2h hammers, throwing weapons, etc.

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

		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/special.png",
			text = "Nobles will now give you contracts"
		});

		if (!this.World.Assets.getOrigin().isFixedLook())
		{
			if (this.World.Assets.getOrigin().getID() == "scenario.southern_quickstart")
			{
				this.World.Assets.updateLook(14);
			}
			else
			{
				this.World.Assets.updateLook(2);
			}
		}
	}

	o.onUpdateScore = function ()
	{
		if (this.World.Ambitions.getDone() < 2 && !this.World.Assets.getOrigin().getID() == "scenario.legends_noble")
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 800)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.battle_standard").isDone() && !this.World.Assets.getOrigin().getID() == "scenario.legends_noble")
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() >= 1050 && this.World.FactionManager.isGreaterEvil() || !this.World.Assets.getOrigin().getID() == "scenario.legends_noble")
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 10;
	}

});
