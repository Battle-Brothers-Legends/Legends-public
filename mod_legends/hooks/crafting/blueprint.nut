::mods_hookBaseClass("crafting/blueprint", function ( o )
{
	while(!("ID" in o.m)) o=o[o.SuperName];

	o.m.PreviewSkills <- [];
	o.m.Enchanter <- false;
	o.m.Type <- this.Const.Items.ItemType.None;
	o.m.CraftMultiplier <- 1.0;

	o.getItemType <- function ()
	{
		return this.m.Type;
	}
	o.getCostForCraft <- function  ()
	{
		return getCost() * this.m.CraftMultiplier;
	}

	o.getIcon = function ()
	{
		if (::Legends.S.oneOf(this.m.PreviewCraftable.getIcon(), "layers/named_icon_glow.png", "layers/legendary_icon_glow.png"))
			return this.m.PreviewCraftable.m.Icon;
		return this.m.PreviewCraftable.getIcon();
	}

	o.getTooltipForComponent = function ( _idx )
	{
		if (_idx > this.m.PreviewComponents.len() - 1)
		{
			this.logError("Out of bound error on blueprint :: " + this.m.ID);
			return null;
		}

		return this.m.PreviewComponents[_idx].Instance.getTooltip();
	}

	o.getTooltipForSkill <- function ( _idx )
	{
		foreach( c in this.m.PreviewSkills )
		{
			foreach( s in c.Instances )
			{
				if (s.getID() == _idx)
				{
					return s.getTooltip();
				}
			}
		}

		return null;
	}


	o.getTooltipForComponent = function ( _idx )
	{
		if (_idx > this.m.PreviewComponents.len() - 1)
		{
			this.logError("Out of bound error on blueprint :: " + this.m.ID);
			return null;
		}

		return this.m.PreviewComponents[_idx].Instance.getTooltip();
	}

	o.getTooltipForSkill <- function ( _idx )
	{
		foreach( c in this.m.PreviewSkills )
		{
			foreach( s in c.Instances )
			{
				if (s.getID() == _idx)
				{
					return s.getTooltip();
				}
			}
		}

		return null;
	}

	o.init = function ( _comps )
	{
		foreach( i in _comps )
		{
			local c = this.new(i.Script);
			local pc = {
				Name = i.Script,
				Num = i.Num,
				Instance = c
			};

			if ("LegendsArmor" in i)
			{
				pc.LegendsArmor <- i.LegendsArmor;
			}

			this.m.PreviewComponents.push(pc);
		}
	}

	o.initSkills <- function ( _skills )
	{
		foreach( i in _skills )
		{
			local C = [];

			foreach( s in i.Scripts )
			{
				C.push(this.new(s));
			}

			this.m.PreviewSkills.push({
				Instances = C
			});
		}
	}

	o.requirementsMet <- function ( _ids )
	{
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			foreach( id in _ids )
			{
				if (bro.getSkills().hasSkill(id))
				{
					return true;
				}
			}
		}

		return false;
	}

	o.isPartlyCraftable <- function ()
	{
		local itemsMap = this.World.Assets.getStash().getNumItemsMap(true);

		foreach( c in this.m.PreviewSkills )
		{
			local ids = [];

			foreach( s in c.Instances )
			{
				ids.push(s.getID());
			}

			if (!this.requirementsMet(ids))
			{
				return false;
			}
		}

		foreach( c in this.m.PreviewComponents )
		{
			local num = 0;

			if (c.Instance.getID() in itemsMap)
			{
				num = itemsMap[c.Instance.getID()];
			}

			if (num >= c.Num)
			{
				return true;
			}
		}

		return false;
	}

	o.isCraftable = function ()
	{
		local itemsMap = this.World.Assets.getStash().getNumItemsMap(true);

		foreach( c in this.m.PreviewComponents )
		{
			local num = 0;

			if (c.Instance.getID() in itemsMap)
			{
				num = itemsMap[c.Instance.getID()];
			}

			if (num < c.Num)
			{
				return false;
			}
		}

		foreach( c in this.m.PreviewSkills )
		{
			local ids = [];

			foreach( s in c.Instances )
			{
				ids.push(s.getID());
			}

			if (!this.requirementsMet(ids))
			{
				return false;
			}
		}

		return true;
	}

	o.isQualified = function ()
	{
		if (this.m.Enchanter)
		{
			return false;
		}

		if (this.m.TimesCrafted >= 1)
		{
			return true;
		}

		if (::Legends.Mod.ModSettings.getSetting("ShowBlueprintsWhen").getValue() == "Always") return true;
		if (::Legends.Mod.ModSettings.getSetting("ShowBlueprintsWhen").getValue() == "One Ingredient Available") return this.isPartlyCraftable();

		return this.isCraftable();
	}

	o.isQualifiedEnchant <- function ()
	{
		if (this.m.Enchanter)
		{
			return true;
		}

		return false;
	}

	o.getUIData = function ()
	{
		if (this.m.PreviewCraftable.m.ID == "shield.heater_shield" || this.m.PreviewCraftable.m.ID == "shield.kite_shield" || this.m.PreviewCraftable.m.ID == "shield.legend_tower_shield")
		{
			this.m.PreviewCraftable.onPaintInCompanyColors();
		}
		else if (this.m.PreviewCraftable.m.ID == "shield.faction_kite_shield" || this.m.PreviewCraftable.m.ID == "shield.heater_kite_shield")
		{
			this.m.PreviewCraftable.setFaction(1);
		}
		local ret = {
			ID = this.getID(),
			Name = this.getName(),
			Description = this.getDescription(),
			ImagePath = this.getIcon(),
			LargeImagePath = this.getIconLarge() != null ? this.getIconLarge() : this.getIcon(),
			Ingredients = this.getIngredients(),
			Cost = this.getCost(),
			IsCraftable = this.isCraftable(),
			Type = this.getItemType()
		};
		if ("Variants" in this.m && this.m.Variants > 0)
		{
			ret.Variants <- this.m.Variants;
			ret.ItemPath <- this.IO.scriptFilenameByHash(this.m.PreviewCraftable.ClassNameHash); //this.m.PreviewCraftable;
		}
		else
		{
			ret.Variants <- 0;
			ret.ItemPath <- 0;
		}
		ret.isAmountShown <- this.m.PreviewCraftable.isAmountShown();
		if(this.m.PreviewCraftable.isAmountShown()) ret.Amount <- this.m.PreviewCraftable.getAmountString();
		return ret;
	}

	o.getIngredients = function ()
	{
		local ret = [];
		local itemsMap = {};

		foreach( item in this.World.Assets.getStash().getItems() )
		{
			if (item == null)
			{
				continue;
			}

			if (!(item.getID() in itemsMap))
			{
				itemsMap[item.getID()] <- 0;
			}
			if ("Uses" in item.m) itemsMap[item.getID()] = itemsMap[item.getID()] + item.m.Uses;
			else itemsMap[item.getID()] = itemsMap[item.getID()] + 1;
		}

		foreach( c in this.m.PreviewSkills )
		{
			foreach( s in c.Instances )
			{
				ret.push({
					InstanceID = s.getID(),
					ImagePath = s.getIconColored(),
					IsMissing = !this.requirementsMet([
						s.getID()
					]),
					IsSkill = 1
				});
			}
		}

		foreach( i, c in this.m.PreviewComponents )
		{
			local num = 0;

			if (c.Instance == null)
			{
				local name = "";

				if (c.Name != null)
				{
					name = c.Name;
				}

				this.logInfo("ERROR, blueprint instance is null. item name = " + name);
				continue;
			}

			if (c.Instance.getID() in itemsMap)
			{
				num = itemsMap[c.Instance.getID()];
			}

			ret.push({
				InstanceID = i,
				ImagePath = c.Instance.getIcon(),
				IsMissing = c.Num > num,
				Num = c.Num,
				InvTotal = num,
				IsSkill = 0
			});
		}

		return ret;
	}

	o.craft = function ()
	{
		if (!this.isQualified())
		{
			return;
		}

		this.updateAchievement("IMadeThis", 1, 1);
		local stash = this.World.Assets.getStash();
		local hasAlchemist = this.World.Retinue.hasFollower("follower.alchemist");

		foreach( c in this.m.PreviewComponents )
		{
			for( local j = 0; j < c.Num; j = j )
			{
				local item = stash.getItemByID(c.Instance.getID());

				if (!hasAlchemist || item.getMagicNumber() > 25)
				{
					if ("Uses" in item.m && item.m.Uses > 1)
					{
						item.m.Uses -= 1;
					}
					else
					{
						stash.remove(item);
					}
				}
				else
				{
					item.setMagicNumber(this.Math.rand(1, 100));
				}

				j = ++j;
			}
		}

		++this.m.TimesCrafted;
		this.onCraft(stash);
	}

	o.enchant <- function ( _bonus )
	{
		if (!this.isQualifiedEnchant())
		{
			return;
		}

		local stash = this.World.Assets.getStash();

		foreach( c in this.m.PreviewComponents )
		{
			for( local j = 0; j < c.Num; j = j )
			{
				stash.removeByID(c.Instance.getID());
				j = ++j;
			}
		}

		++this.m.TimesCrafted;
		this.onEnchant(stash, _bonus);
	}

	o.onEnchant <- function ( _stash, _bonus )
	{
	}
});
