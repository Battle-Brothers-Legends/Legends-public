::mods_hookExactClass("contracts/contracts/decisive_battle_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"The nobles are gathering their forces for a decisive battle against a feuding rival house. That includes sellswords. On both sides.",
			"War has ravaged the realm, yet both sides are still eager to spend their coin on a bigger, bloodier battle.",
			"The stage is set for a great battle between the warring noble houses. Mercenaries are being sought on both sides.",
			"Amidst the maelstrom of battle, the destinies of noble houses and mercenary companies alike are forged.",
			"They say the skalds will sing songs about this upcoming great battle. With luck you might just survive it to hear them.",
			"Steel clashes and blood spills as the warring noble houses meet for a final confrontation.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "InterceptSupplies")
			{
				s.start <- function ()
				{
					local startTile = this.World.getEntityByID(this.Flags.get("InterceptSuppliesStart")).getTile();
					local destTile = this.World.getEntityByID(this.Flags.get("InterceptSuppliesDest")).getTile();
					local enemyFaction = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse"));
					local party = enemyFaction.spawnEntity(startTile, "Supply Caravan", false, this.Const.World.Spawn.NobleCaravan, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getMinibossModifier());
					party.getSprite("base").Visible = false;
					party.getSprite("banner").setBrush(this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getBannerSmall());
					party.setMirrored(true);
					party.setVisibleInFogOfWar(true);
					party.setImportant(true);
					party.setDiscovered(true);
					party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");
					party.setFootprintType(this.Const.World.FootprintsType.Caravan);
					party.getFlags().set("IsCaravan", true);
					party.setAttackableByAI(false);
					party.getFlags().add("ContractSupplies");
					this.Contract.m.Destination = this.WeakTableRef(party);
					this.Contract.m.UnitsSpawned.push(party);
					party.getLoot().Money = this.Math.rand(50, 100);
					party.getLoot().ArmorParts = this.Math.rand(0, 10);
					party.getLoot().Medicine = this.Math.rand(0, 2);
					party.getLoot().Ammo = this.Math.rand(0, 20);

					// yes world economy
					if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
					{
						switch(this.Math.rand(1, 6))
						{
						case 1:
							party.addToInventory(this.new("scripts/items/supplies/bread_item"));
							break;

						case 2:
							party.addToInventory(this.new("scripts/items/supplies/roots_and_berries_item"));
							break;

						case 3:
							party.addToInventory(this.new("scripts/items/supplies/dried_fruits_item"));
							break;

						case 4:
							party.addToInventory(this.new("scripts/items/supplies/ground_grains_item"));
							break;

						case 5:
							party.addToInventory(this.new("scripts/items/supplies/pickled_mushrooms_item"));
							break;
						}
					}
					// no world economy
					else
					{
						switch(this.Math.rand(1, 6))
						{
						case 1:
							party.addToInventory("supplies/bread_item");
							break;

						case 2:
							party.addToInventory("supplies/roots_and_berries_item");
							break;

						case 3:
							party.addToInventory("supplies/dried_fruits_item");
							break;

						case 4:
							party.addToInventory("supplies/ground_grains_item");
							break;

						case 5:
							party.addToInventory("supplies/pickled_mushrooms_item");
							break;
						}
					}

					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local move = this.new("scripts/ai/world/orders/move_order");
					move.setDestination(destTile);
					move.setRoadsOnly(true);
					local despawn = this.new("scripts/ai/world/orders/despawn_order");
					c.addOrder(move);
					c.addOrder(despawn);
				}
			}
			if (s.ID == "Task")
			{
				s.Title = "The Battle";
			}
		}
	}
});
