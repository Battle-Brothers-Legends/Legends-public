::mods_hookExactClass("contracts/contracts/raid_caravan_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Many a merchant has been sacrificed as a pawn in the deadly political games played between the Noble Houses.",
			"Sometimes the most unfortunate accidents can occur on the road.",
			"Political rivals do seem to have the odd habit of vanishing on the road these days...",
			"Avaricious or ambitious nobles are a far greater threat to merchant safety then mere brigands.",
			"Double-crossing a merchant to confound a political rival is a favorite pastime of nobility.",
			"When you kill him sellsword, tell him it was nothing personal, just business.",
		];
	}

	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Offer")
			{
				o.end <- function ()
				{
					this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
					local r = this.Math.rand(1, 100);
					this.Flags.set("Survivors", 0);

					if (r <= 10)
					{
						this.Flags.set("IsBribe", true);
						this.Flags.set("Bribe1", this.Contract.beautifyNumber(this.Contract.m.Payment.Pool * (this.Math.rand(70, 150) * 0.01)));
						this.Flags.set("Bribe2", this.Contract.beautifyNumber(this.Contract.m.Payment.Pool * (this.Math.rand(70, 150) * 0.01)));
					}
					else if (r <= 15)
					{
						if (this.Contract.getDifficultyMult() >= 1.0)
						{
							this.Flags.set("IsSwordmaster", true);
						}
					}
					else if (r <= 20)
					{
						if (this.Contract.getDifficultyMult() >= 1.0)
						{
							this.Flags.set("IsUndeadSurprise", true);
						}
					}
					else if (r <= 25)
					{
						this.Flags.set("IsWomenAndChildren", true);
					}
					else if (r <= 35)
					{
						this.Flags.set("IsCompromisingPapers", true);
					}

					local enemyFaction = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse"));
					local best_start = this.World.getEntityByID(this.Flags.get("InterceptStart"));
					local best_dest = this.World.getEntityByID(this.Flags.get("InterceptDest"));

					local spawnParty = this.Const.World.Spawn.NobleCaravan;
					local r = this.Math.rand(1, 100);
					if (r > 75)
					{
						spawnParty = this.Const.World.Spawn.Mercenaries;
					}
					else if (r > 50)
					{
						spawnParty = this.Const.World.Spawn.MixedNobleCaravan;
					}
					local party = enemyFaction.spawnEntity(best_start.getTile(), "Caravan", false, this.Const.World.Spawn.NobleCaravan, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getMinibossModifier());
					party.getSprite("base").Visible = false;
					party.getSprite("banner").setBrush(enemyFaction.getBannerSmall());
					party.setMirrored(true);
					party.setVisibleInFogOfWar(true);
					party.setImportant(true);
					party.setDiscovered(true);
					party.setDescription("A caravan with armed escorts transporting something worth protecting between settlements.");
					party.setFootprintType(this.Const.World.FootprintsType.Caravan);
					party.getFlags().set("IsCaravan", true);
					party.setAttackableByAI(false);
					party.getFlags().add("ContractCaravan");
					this.Contract.m.Target = this.WeakTableRef(party);
					this.Contract.m.UnitsSpawned.push(party);
					party.getLoot().Money = this.Math.rand(50, 100);
					party.getLoot().ArmorParts = this.Math.rand(0, 10);
					party.getLoot().Medicine = this.Math.rand(0, 2);
					party.getLoot().Ammo = this.Math.rand(0, 20);
					local r = this.Math.rand(1, 6);

					if (r == 1)
					{
						party.addToInventory("supplies/bread_item");
					}
					else if (r == 2)
					{
						party.addToInventory("supplies/roots_and_berries_item");
					}
					else if (r == 3)
					{
						party.addToInventory("supplies/dried_fruits_item");
					}
					else if (r == 4)
					{
						party.addToInventory("supplies/ground_grains_item");
					}
					else if (r == 5)
					{
						party.addToInventory("supplies/pickled_mushrooms_item");
					}

					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local move = this.new("scripts/ai/world/orders/move_order");
					move.setDestination(best_dest.getTile());
					move.setRoadsOnly(true);
					local despawn = this.new("scripts/ai/world/orders/despawn_order");
					c.addOrder(move);
					c.addOrder(despawn);
					this.Contract.setScreen("Overview");
					this.World.Contracts.setActiveContract(this.Contract);
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
			if (s.ID == "WomenAndChildren1")
			{
				s.Options = [
					{
						Text = "We\'re paid to leave no one alive, so that\'s what we\'ll do. (Decrease Moral Reputation)",
						function getResult()
						{
							this.World.Assets.addMoralReputation(-5);
							return "WomenAndChildren2";
						}

					},
					{
						Text = "To hell with it - let them leave. (Increase Moral Reputation)",
						function getResult()
						{
							this.World.Assets.addMoralReputation(2);
							this.Flags.set("Survivors", this.Flags.get("Survivors") + 3);
							this.Contract.setState("Return");
							return 0;
						}

					}
				]
			}
		}
	}
});
