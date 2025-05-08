::mods_hookExactClass("contracts/contracts/defend_holy_site_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Southern soldiers are approaching a place sacred to the Old Gods. A sense of unease ripples through the local populace.",
			"The faith demands you must defend a revered holy place. You demand you must be paid.",
			"The Old Gods welcome invaders into their holy sites, as blood is a most pleasing offering to them.",
			"The faithful are quite literally whipping themselves into a frenzy at the prospect of losing a holy site to the South. This should pay well.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Preparation3")
			{
				s.start <- function ()
				{
					for( local i = 0; i < 2; i = ++i )
					{
						local r = this.Math.rand(1, 12);
						local item;

						switch(r)
						{
						case 1:
							item = this.new("scripts/items/weapons/oriental/saif");
							break;

						case 2:
							item = this.new("scripts/items/tools/throwing_net");
							break;

						case 3:
							item = this.new("scripts/items/weapons/oriental/polemace");
							break;

						case 4:
							item = this.new("scripts/items/weapons/ancient/broken_ancient_sword");
							break;

						case 5:
							item = this.Const.World.Common.pickArmor([
								[1, ::Legends.Armor.Ancient.ancient_mail],
							]);
							break;

						case 6:
							item = this.new("scripts/items/supplies/ammo_item");
							break;

						case 7:
							item = this.new("scripts/items/supplies/armor_parts_item");
							break;

						case 8:
							item = this.new("scripts/items/shields/ancient/tower_shield");
							break;

						case 9:
							item = this.new("scripts/items/loot/ancient_gold_coins_item");
							break;

						case 10:
							item = this.new("scripts/items/loot/silver_bowl_item");
							break;

						case 11:
							item = this.new("scripts/items/weapons/wooden_stick");
							break;

						case 12:
							local helmet = [
								[1, ::Legends.Helmet.Southern.spiked_skull_cap_with_mail]
							];
							item = this.Const.World.Common.pickHelmet(helmet);
							break;
						}

						if (item.getConditionMax() > 1)
						{
							item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 50) * 0.01));
						}

						this.World.Assets.getStash().add(item);
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You gain " + item.getName()
						});
					}

					local amount = this.Math.rand(10, 30);
					this.World.Assets.addArmorParts(amount);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_supplies.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] Tools and Supplies."
					});
				}
			}
			if (s.ID == "Task")
			{
				s.Title = "Defend Holy Site";
			}
		}
	}

	local spawnEnemy = o.spawnEnemy;
	o.spawnEnemy = function () {
		local f = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyID"));
		local party = spawnEnemy();
		party.getLoot().Money = this.Math.rand(100, 300);
		party.getLoot().ArmorParts = this.Math.rand(10, 35);
		party.getLoot().Medicine = this.Math.rand(5, 15);
		party.getLoot().Ammo = this.Math.rand(10, 40);
		local r = this.Math.rand(1, 4);
		local arr = ["trade/silk_item", "trade/silk_item", "trade/incense_item", "trade/spices_item"];
		for(local i = 0; i < this.Math.round(r/2); i++) //adds either 1 silk, 1 silk, 2 incense, 2 spices
			party.addToInventory(arr[r-1]);
		return party;
	}
});
