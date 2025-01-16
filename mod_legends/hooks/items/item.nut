::mods_hookBaseClass("items/item", function ( o )
{
	while(!("ItemType" in o.m)) o=o[o.SuperName];

	o.m.OldID <- "";
	o.m.MedicinePerDay <- 0;
	o.m.IsToBeRepairedQueue <- 0;
	o.m.IsToBeSalvagedQueue <- 0;
	o.m.RuneVariant <- 0;
	o.m.RuneBonus1 <- 0;
	o.m.RuneBonus2 <- 0;
	o.m.IsToBeSalvaged <- false;
	o.m.ResourceValue <- 0;
	o.m.Type <- -1;
	o.m.OriginSettlementID <- 0; // the Settlement ID where the item was originally produced
	o.m.TradeHistorySettlementIDs <- []; // an array of Settlement IDs to track the item's trade history
	o.m.LastTransactionPrice <- null;
	o.m.IsQueryingSellPrice <- 0;
	o.m.IsQueryingBuyPrice <- 0;

	local setSold = o.setSold;
	o.setSold = function (_f) {
		setSold(_f);
		this.m.IsSold = _f;
	}

	local setBought = o.setBought;
	o.setBought = function (_f) {
		setBought(_f);
		this.m.IsBought = _f;
	}

	o.getOldInstanceID <- function ()
	{
		return this.m.OldID;
	}

	o.getIconOverlay = function ()
	{
		return [""];
	}

	o.getIconLargeOverlay = function ()
	{
		return [""];
	}

	o.getType <- function ()
	{
		return this.m.Type;
	}

	o.isDroppedAsLoot = function ()
	{
		return this.m.IsDroppedAsLoot || this.isNamed();
	}

	o.isToBeRepaired = function ()
	{
		return this.m.IsToBeRepaired;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	o.isToBeRepairedQ <- function ()
	{
		return this.m.IsToBeRepairedQueue;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	o.isToBeSalvaged <- function ()
	{
		return this.m.IsToBeSalvaged;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	o.isToBeSalvagedQ <- function ()
	{
		return this.m.IsToBeSalvagedQueue;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	o.setToBeRepaired = function ( _r, _idx = 0 )
	{
		if (_r && this.getRepair() == this.getRepairMax())
		{
			this.m.IsToBeRepairedQueue = 0;
			return false;
		}

		this.m.IsToBeRepaired = _r;
		this.m.IsToBeRepairedQueue = _idx;
		return true;
	}

	o.setToBeSalvaged <- function ( _r, _idx )
	{
		if (_r && this.getRepair() <= 0)
		{
			this.m.IsToBeSalvagedQueue = 0;
			return false;
		}

		this.m.IsToBeSalvaged = _r;
		this.m.IsToBeSalvagedQueue = _idx;
		return true;
	}

	o.canBeSalvaged <- function ()
	{
		return ((this.getItemType() & this.Const.Items.ItemType.Weapon) != 0) || (this.getItemType() & this.Const.Items.ItemFilter.Armor) != 0
	}

	o.getRepair <- function ()
	{
		return this.Math.floor(this.m.Condition);
	}

	o.getRepairMax <- function ()
	{
		return this.Math.floor(this.m.ConditionMax);
	}

	o.getRawValue <- function ()
	{
		return this.m.Value;
	}

	o.setArmor <- function ( _a )
	{
		this.setCondition( _a)
	}

	o.onRepair <- function ( _a)
	{
		this.setArmor(_a);
		return 0;
	}

	o.setTransactionPrice <- function (_price) {
		this.m.LastTransactionPrice = _price;
		if (_price == null) {
			this.m.IsSold = false;
			this.m.IsBought = false;
		}
	}

	o.getBuyPrice = function ()
	{
		local itemID = this.getID();
		if (this.isSold())
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()]));
		}
		else
		{
			return this.Math.ceil(this.getValue() * this.getPriceMult());
		}
	}

	o.getSellPrice = function ()
	{
		local itemID = this.getID();
		if (this.isBought())
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.floor(this.getValue() * this.getSellPriceMult() * this.Const.World.Assets.BaseSellPrice * this.World.State.getCurrentTown().getSellPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
		}
		else
		{
			return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice);
		}
	}

	o.setGarbage <- function ()
	{
		this.m.IsGarbage = true;
	}

	o.onUnequip = function ()
	{
		this.clearSkills();
		if (this.m.Container != null && ("getSkills" in this.getContainer().getActor())) this.getContainer().getActor().getSkills().update();
	}

	o.onEquip = function ()
	{
		if (this.m.Container != null)
		{
			if (this.m.Container.getActor() != null) this.m.LastEquippedByFaction = this.m.Container.getActor().getFaction();
			if ("getSkills" in this.getContainer().getActor()) this.getContainer().getActor().getSkills().update();
		}
		if (this.isRuned())
		{
			this.onEquipRuneSigil();
		}

		if (this.isToBeSalvaged())
		{
			this.setToBeSalvaged(false, 0);
		}
	}

	o.onEquipRuneSigil <- function ()
	{
		switch (this.m.RuneVariant)
		{
			case 1:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_power"));
				break;

			case 2:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_accuracy"));
				break;

			case 3:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_feeding"));
				break;

			case 4:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_poison"));
				break;

			case 5:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_bleeding"));
				break;

			case 6:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_unbreaking"));
				break;

			case 11:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSH_clarity"));
				break;

			case 12:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSH_bravery"));
				break;

			case 13:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSH_luck"));
				break;

			case 21:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSA_endurance"));
				break;

			case 22:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSA_safety"));
				break;

			case 23:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSA_resilience"));
				break;

			case 31:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSS_defense"));
				break;

			case 32:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSS_radiance"));
				break;

			default:
				break;
		}
	}

	o.getRuneSigilTooltip <- function ()
	{
		switch (this.m.RuneVariant)
		{
			case 1:
				return "This item has the power of the rune sigil of Power:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Damage inflicted.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "[/color] Max damage.";
				break;

			case 2:
				return "This item has the power of the rune sigil of Accuracy:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Melee skill.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "%[/color] Ranged skill.";
				break;

			case 3:
				return "This item has the power of the rune sigil of Feeding:\n[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus1 + "%[/color] of inflicted health damage recovers fatigue.";
				break;

			case 4:
				return "This item has the power of the rune sigil of Poison:\n[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus1 + "[/color] turn(s) of poison applied, with a strength of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus2 + "[/color]. Lowers action points and initiative.";
				break;

			case 5:
				return "This item has the power of the rune sigil of Bleeding:\n[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus1 + "[/color] bleed damage every turn for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus2 + "[/color] turn(s).";
				break;

			case 6:
				return "This item has the power of the rune sigil of Unbreaking:\n[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus1 + "[/color] to [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus2 + "[/color] durability restored on every kill.";
				break;

			case 11:
				return "This item has the power of the rune sigil of Clarity:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "[/color] Vision.\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "%[/color] Experience gain.";
				break;

			case 12:
				return "This item has the power of the rune sigil of Bravery:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Resolve.\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "[/color] Resolve at all morale checks.";
				break;

			case 13:
				return "This item has the power of the rune sigil of Luck:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] chance to have any attacker require two successful attack rolls in order to hit.";
				break;

			case 21:
				return "This item has the power of the rune sigil of Endurance:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "[/color] Fatigue recovery per turn.\n[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.RuneBonus2 + "%[/color] Fatigue cost and effects multiplier.";
				break;

			case 22:
				return "This item has the power of the rune sigil of Safety:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Hitpoints.\n[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.RuneBonus2 + "%[/color] Damage received.";
				break;

			case 23:
				return "This item has the power of the rune sigil of Resilience:\n[color=" + this.Const.UI.Color.PositiveValue + "]Immune[/color] to stuns, knockbacks and grabs.";
				break;

			case 31:
				return "This item has the power of the rune sigil of Defense:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Melee defense.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "%[/color] Ranged defense.";
				break;

			case 32:
				return "This item has the power of the rune sigil of Radiance:\n[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.RuneBonus1 + "%[/color] to all adjacent enemies\' Melee skill.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.RuneBonus2 + "%[/color] to all adjacent enemies\' Melee defense.";
				break;

			default:
				return "This item is inscribed with a rune sigil, even though it shouldn't have been: please report this bug.";
				break;
		}
	}

	o.setRuneBonus <- function ( _bonus = false)
	{
		local bonus = 0;
		local bonus2 = 0;
		switch (this.m.RuneVariant)
		{
			case 1:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9);
					bonus2 = this.Math.rand(3, 9);
				}
				else
				{
					bonus = this.Math.rand(3, 6);
					bonus2 = this.Math.rand(3, 6);
				}
				break;

			case 2:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9);
					bonus2 = this.Math.rand(3, 9);
				}
				else
				{
					bonus = this.Math.rand(3, 6);
					bonus2 = this.Math.rand(3, 6);
				}
				break;

			case 3:
				if (_bonus)
				{
					bonus = this.Math.rand(2, 6);
				}
				else
				{
					bonus = this.Math.rand(2, 4);
				}
				break;

			case 4:
				if (_bonus)
				{
					bonus = this.Math.rand(1, 3);
					bonus2 = this.Math.rand(3, 9);
				}
				else
				{
					bonus = this.Math.rand(1, 2);
					bonus2 = this.Math.rand(3, 9);
				}
				break;

			case 5:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9);
					bonus2 = this.Math.rand(1, 3);
				}
				else
				{
					bonus = this.Math.rand(3, 6);
					bonus2 = this.Math.rand(1, 2);
				}
				break;

			case 6:
				if (_bonus)
				{
					bonus2 = this.Math.rand(3, 9);
					bonus = this.Math.rand(1, 3);
				}
				else
				{
					bonus2 = this.Math.rand(3, 6);
					bonus = this.Math.rand(1, 2);
				}
				break;

			case 11:
				if (_bonus)
				{
					bonus = this.Math.rand(0, 2);
					bonus2 = this.Math.rand(3, 9);
				}
				else
				{
					bonus = this.Math.rand(0, 1);
					bonus2 = this.Math.rand(3, 6);
				}
				break;

			case 12:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9);
					bonus2 = this.Math.rand(1, 5);
				}
				else
				{
					bonus = this.Math.rand(3, 6);
					bonus2 = this.Math.rand(1, 3);
				}
				break;

			case 13:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9);
				}
				else
				{
					bonus = this.Math.rand(3, 6);
				}
				break;

			case 21:
				if (_bonus)
				{
					bonus = this.Math.rand(0, 3);
					bonus2 = this.Math.rand(3, 9);
				}
				else
				{
					bonus = this.Math.rand(0, 1);
					bonus2 = this.Math.rand(3, 6);
				}
				break;

			case 22:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9);
					bonus2 = this.Math.rand(3, 9);
				}
				else
				{
					bonus = this.Math.rand(3, 6);
					bonus2 = this.Math.rand(3, 6);
				}
				break;

			case 23:
				break;

			case 31:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9);
					bonus2 = this.Math.rand(3, 9);
				}
				else
				{
					bonus = this.Math.rand(3, 6);
					bonus2 = this.Math.rand(3, 6);
				}
				break;

			case 32:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 12);
					bonus2 = this.Math.rand(3, 12);
				}
				else
				{
					bonus = this.Math.rand(3, 9);
					bonus2 = this.Math.rand(3, 9);
				}
				break;

			default:
				break;
		}
		this.setRuneBonus1(bonus);
		this.setRuneBonus2(bonus2);
	}

	o.updateRuneSigilToken <- function ()
	{
		switch (this.m.RuneVariant)
		{
			case 1:
				this.m.Name = "Weapon Rune Sigil: Power";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 2:
				this.m.Name = "Weapon Rune Sigil: Accuracy";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 3:
				this.m.Name = "Weapon Rune Sigil: Feeding";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 4:
				this.m.Name = "Weapon Rune Sigil: Poison";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 5:
				this.m.Name = "Weapon Rune Sigil: Bleeding";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 6:
				this.m.Name = "Weapon Rune Sigil: Unbreaking";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 11:
				this.m.Name = "Helmet Rune Sigil: Clarity";
				this.m.Description = "An inscribed rock that can be attached to a character\'s helmet.";
				this.m.Icon = "rune_sigils/rune_stone_2.png";
				this.m.IconLarge = "rune_sigils/rune_stone_2.png";
				break;

			case 12:
				this.m.Name = "Helmet Rune Sigil: Bravery";
				this.m.Description = "An inscribed rock that can be attached to a character\'s helmet.";
				this.m.Icon = "rune_sigils/rune_stone_2.png";
				this.m.IconLarge = "rune_sigils/rune_stone_2.png";
				break;

			case 13:
				this.m.Name = "Helmet Rune Sigil: Luck";
				this.m.Description = "An inscribed rock that can be attached to a character\'s helmet.";
				this.m.Icon = "rune_sigils/rune_stone_2.png";
				this.m.IconLarge = "rune_sigils/rune_stone_2.png";
				break;

			case 21:
				this.m.Name = "Armor Rune Sigil: Endurance";
				this.m.Description = "An inscribed rock that can be attached to a character\'s armor.";
				this.m.Icon = "rune_sigils/rune_stone_3.png";
				this.m.IconLarge = "rune_sigils/rune_stone_3.png";
				break;

			case 22:
				this.m.Name = "Armor Rune Sigil: Safety";
				this.m.Description = "An inscribed rock that can be attached to a character\'s armor.";
				this.m.Icon = "rune_sigils/rune_stone_3.png";
				this.m.IconLarge = "rune_sigils/rune_stone_3.png";
				break;

			case 23:
				this.m.Name = "Armor Rune Sigil: Resilience";
				this.m.Description = "An inscribed rock that can be attached to a character\'s armor.";
				this.m.Icon = "rune_sigils/rune_stone_3.png";
				this.m.IconLarge = "rune_sigils/rune_stone_3.png";
				break;

			case 31:
				this.m.Name = "Shield Rune Sigil: Defense";
				this.m.Description = "An inscribed rock that can be attached to a character\'s shield.";
				this.m.Icon = "rune_sigils/rune_stone_4.png";
				this.m.IconLarge = "rune_sigils/rune_stone_4.png";
				break;

			case 32:
				this.m.Name = "Shield Rune Sigil: Radiance";
				this.m.Description = "An inscribed rock that can be attached to a character\'s shield.";
				this.m.Icon = "rune_sigils/rune_stone_4.png";
				this.m.IconLarge = "rune_sigils/rune_stone_4.png";
				break;

			default:
				this.m.Name = "Unknown Rune Sigil: Error";
				this.m.Description = "An inscribed rock that cannot be attached to a character\'s equipment.";
				this.m.Icon = "rune_sigils/legend_vala_rune_sigil_blank.png";
				this.m.IconLarge = "rune_sigils/legend_vala_rune_sigil_blank.png";
				break;
		}
	}

	o.setRuneVariant <- function (_rune)
	{
		this.m.RuneVariant = _rune;
	}

	o.getRuneVariant <- function ()
	{
		return this.m.RuneVariant;
	}

	o.setRuneBonus1 <- function (_mult)
	{
		this.m.RuneBonus1 = _mult;
	}

	o.getRuneBonus1 <- function ()
	{
		return this.m.RuneBonus1;
	}

	o.setRuneBonus2 <- function (_mult)
	{
		this.m.RuneBonus2 = _mult;
	}

	o.getRuneBonus2 <- function ()
	{
		return this.m.RuneBonus2;
	}

	o.isRuned <- function ()
	{
		if (this.m.RuneVariant > 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	o.updateRuneSigil <- function ()
	{
		// local iconLargeParts = split(this.m.IconLarge, "/");
		// local iconParts = split(this.m.Icon, "/");
		// local text = ""
		// if(this.m.IconLarge.find("runed_") == null) {
		// 	for (local i = 0; i < iconLargeParts.len(); i = ++i)
		// 	{
		// 		if (i == iconLargeParts.len() - 1)
		// 		{
		// 			text = text + "runed_" + iconLargeParts[i]
		// 		} else {
		// 			text = text + iconLargeParts[i] + "/";
		// 		}
		// 	}
		// 	this.m.IconLarge = text;
		// }
		// if(this.m.Icon.find("runed_") == null) {
		// 	text = ""
		// 	for (local i = 0; i < iconParts.len(); i = ++i)
		// 	{
		// 		if (i == iconParts.len() - 1)
		// 		{
		// 			text = text + "runed_" + iconParts[i]
		// 		} else {
		// 			text = text + iconParts[i] + "/";
		// 		}
		// 	}
		// 	this.m.Icon = text;
		// }
		if (this.m.Name.find("(Runed)") == null)
		{
			this.m.Name =  this.m.Name + "[color=" + this.Const.UI.Color.RuneColor + "] (Runed)[/color]";
		}
	}

	o.onNewDay <- function ()
	{
	}

	o.getMedicinePerDay <- function ()
	{
		return this.m.MedicinePerDay;
	}

	o.getUpgrades <- function ()
	{
		return [];
	}

	o.getLootLayers <- function ()
	{
		return [this];
	}

	o.getResourceValue <- function ()
	{
		return this.m.ResourceValue;
	}

	o.isNamed <- function ()
	{
		if (this.isItemType(this.Const.Items.ItemType.Named))
		{
			return true;
		}

		if (this.isItemType(this.Const.Items.ItemType.Legendary))
		{
			return true;
		}

		return false
	}


	o.onPaint <- function ( _color )
	{
	}

	o.getOriginSettlementID <- function ()
	{
		return this.m.OriginSettlementID;
	}

	o.getOriginSettlement <- function ()
	{
		return ::World.getEntityByID(this.m.OriginSettlementID);
	}

	o.getTradeHistorySettlementIDs <- function ()
	{
		return this.m.TradeHistorySettlementIDs;
	}

	o.getTradeHistorySettlements <- function ()
	{
		return this.m.TradeHistorySettlementIDs.map(function(id){return ::World.getEntityByID(id)});
	}

	o.setOriginSettlementID <- function ( _id )
	{
		this.m.OriginSettlementID = _id;
	}

	o.setOriginSettlement <- function ( _settlement )
	{
		this.setOriginSettlementID( _settlement.getID());
	}

	o.addSettlementIDToTradeHistory <- function ( _id )
	{
		if (_id != this.getOriginSettlementID() && (this.m.TradeHistorySettlementIDs.len() < 1 || _id != this.m.TradeHistorySettlementIDs[this.m.TradeHistorySettlementIDs.len()-1]))
		{
			this.m.TradeHistorySettlementIDs.push(_id);
		}
	}

	o.addSettlementToTradeHistory <- function ( _settlement )
	{
		this.addSettlementIDToTradeHistory(_settlement.getID());
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		onSerialize(_out);
		_out.writeString(this.getInstanceID()); //Need old ID for saved formations
		_out.writeU8(this.m.RuneVariant);
		_out.writeBool(this.m.IsToBeSalvaged);
		_out.writeU16(this.m.IsToBeRepairedQueue);
		_out.writeU16(this.m.IsToBeSalvagedQueue);
		_out.writeU8(this.m.RuneBonus1);
		_out.writeU8(this.m.RuneBonus2);
		_out.writeI32(this.m.OriginSettlementID);
		::MSU.Utils.serialize(this.m.TradeHistorySettlementIDs, _out);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
		this.m.OldID = _in.readString();
		this.m.RuneVariant = _in.readU8();
		this.m.IsToBeSalvaged = _in.readBool();
		this.m.IsToBeRepairedQueue = _in.readU16();
		this.m.IsToBeSalvagedQueue = _in.readU16();
		this.m.RuneBonus1 = _in.readU8();
		this.m.RuneBonus2 = _in.readU8();
		this.m.OriginSettlementID = _in.readI32();
		this.m.TradeHistorySettlementIDs = ::MSU.Utils.deserialize(_in);
		this.updateVariant();
	}
});
