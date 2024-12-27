::ModJimmysTooltips.modTacticalTooltip <- function( tooltip, _targetedWithSkill, _entity )
{
	if(::ModJimmysTooltips.Mod.ModSettings.getSetting("DefaultTooltip").getValue()) {
		return tooltip;
	}

	if (tooltip.len() < 3) {
		return tooltip;
	}

	local shownPerks = {};
	local stackEffects = function ( effects )
	{
		local stacks = {};

		foreach( _, effect in effects )
		{
			local name = effect.getName();

			if (name in stacks)
			{
				stacks[name] += 1;
			}
			else
			{
				stacks[name] <- 1;
			}
		}

		return stacks;
	};
	local pushSectionName = function ( items, title, startID, icon = "")
	{
		if (items.len() && title)
		{
			local ret = {
				id = startID,
				type = "text",
				text = "[u][size=14]" + title + "[/size][/u]"
			};

			if (icon.len() > 0)
				ret.icon <- icon;

			tooltip.push(ret);
		}
	};
	local isPerk = @( _, _skill ) _skill.isType(this.Const.SkillType.Perk)
	local isInjury = @( _, _skill ) _skill.isType(this.Const.SkillType.TemporaryInjury);
	local isTextRow = @( _, row ) ("type" in row) && row.type == "text";

	local pushSection = function ( items, title, startID,filter = 0, prependIcon = "", stackInOneLine = false)
	{
		if (!items)
		{
			return;
		}

		if (filter == 1)
		{
			items = items.filter(isPerk);
		}
		else if (filter == 2)
		{
			items = items.filter(function ( i, item )
			{
				return !isPerk(i, item);
			});
		}

		local stacks = {};

		if (stackInOneLine)
		{
			stacks = stackEffects(items);
			local newItems = [];
			local added = {};

			foreach( i, item in items )
			{
				local name = item.getName();

				if (!(name in added))
				{
					newItems.push(item);
					added[name] <- 1;
				}
			}

			items = newItems;
		}

		pushSectionName(items, title, startID);
		startID = startID + 1;

		foreach( i, item in items )
		{
			local name = item.getName();
			local text = name;

			// debug for if there is a null entry so that the tt wont crash
			if(name == null && text == null){
				// ::logInfo("weird NULL issue for perk tooltips");
				::logWarning("There is a somthing with a null name: ");
				local id = item.getID();
				local desc = item.getDescription();
				local type = item.getType();
				::logInfo("id of the thing: " + id);
				::logInfo("description of the thing: " + desc);
				::logInfo("type of the thing: " + type);
				continue;
			}

			if (filter != 0)
			{
				shownPerks[name] <- 1;
			}

			if (stackInOneLine && stacks[name] > 1)
			{
				text = text + (" [color=" + this.Const.UI.Color.NegativeValue + "]" + "x" + stacks[name] + "[/color]");
			}

			if(title == "Ammo" && this.isKindOf(_entity, "player")){
				tooltip.push({
					id = startID + i,
					type = "text",
					icon = checkForIcon(prependIcon, item),
					text = text + " Ammo: " + item.getAmmo() + " / " + item.getAmmoMax()
				});
			} else if (title == "Ammo" && !this.isKindOf(_entity, "player"))
			{
				tooltip.push({
					id = startID + i,
					type = "text",
					icon = checkForIcon(prependIcon, item),
					text = text + " " + "Ammo: infinite"
				});
			}
			else{
				tooltip.push({
					id = startID + i,
					type = "text",
					icon = checkForIcon(prependIcon, item),
					text = text
				});
			}
		}
	};
	local removeDuplicates = function ( items )
	{
		if (!items)
		{
			return items;
		}

		return items.filter(function ( i, item )
		{
			return !(item.getName() in shownPerks);
		});
	};
	local getPlural = function ( items )
	{
		if (!items)
		{
			return "";
		}

		return items.len() > 1 ? "s" : "";
	};
	local patchedPerkIcons = {};
	patchedPerkIcons[this.Const.Strings.PerkName.BatteringRam] <- "ui/settlement_status/settlement_effect_13.png";
	local getRealPerkIcon = function ( perk )
	{
		local realPerk = this.Const.Perks.findById(perk.getID());

		if (realPerk)
		{
			return realPerk.Icon;
		}

		local name = perk.getName();

		if (name in patchedPerkIcons)
		{
			return patchedPerkIcons[name];
		}

		return perk.getIcon();
	};

	if(::ModJimmysTooltips.Mod.ModSettings.getSetting("ProgressBarValues").getValue()){

		if (!this.isKindOf(_entity, "player"))
		{
			local _type = "progressbar";

			foreach( i, row in tooltip )
			{
				if (("type" in row) && row.type == _type && ("id" in row) && "icon" in row)
				{
					if (row.id == 5 && row.icon == "ui/icons/armor_head.png")
					{
						row.text <- "" + _entity.getArmor(this.Const.BodyPart.Head) + " / " + _entity.getArmorMax(this.Const.BodyPart.Head) + "";
					}
					else if (row.id == 6 && row.icon == "ui/icons/armor_body.png")
					{
						row.text <- "" + _entity.getArmor(this.Const.BodyPart.Body) + " / " + _entity.getArmorMax(this.Const.BodyPart.Body) + "";
					}
					else if (row.id == 7 && row.icon == "ui/icons/health.png")
					{
						row.text <- "" + _entity.getHitpoints() + " / " + _entity.getHitpointsMax() + "";
					}
					else if (row.id == 9 && row.icon == "ui/icons/fatigue.png")
					{
						row.text <- "" + _entity.getFatigue() + " / " + _entity.getFatigueMax() + "";
					}
				}
			}
		}
	}

	local pushRemainingAP = function ()
	{
		local turnsToGo = this.Tactical.TurnSequenceBar.getTurnsUntilActive(_entity.getID());
		local remainingAP = _entity.m.IsTurnDone || turnsToGo == null ? 0 : _entity.getActionPoints();
		tooltip.push({
			id = 10,
			type = "progressbar",
			icon = "ui/icons/action_points.png",
			value = remainingAP,
			valueMax = _entity.getActionPointsMax(),
			text = "" + _entity.getActionPoints() + " / " + _entity.getActionPointsMax() + "",
			style = "action-points-slim"
		});
	};

	/*
	if (_targetedWithSkill != null && this.isKindOf(_targetedWithSkill, "skill"))
	{
		local tile = this.getTile();

		if (tile.IsVisibleForEntity && _targetedWithSkill.isUsableOn(tile))
		{
			tooltip.push({
				id = 2048,
				type = "hint",
				icon = "ui/icons/mouse_right_button.png",
				text = "Expand tooltip"
			});
			return tooltip;
		}
	}
	*/

	if (!::Tactical.Entities.getFlags().get("ModJimmysTooltips_ShowLootChance"))
	{
		local statusEffects = _entity.getSkills().query(this.Const.SkillType.StatusEffect | this.Const.SkillType.TemporaryInjury, false, true);
		local count = tooltip.len() - statusEffects.len();

		if (statusEffects.len() && count > 0)
		{
			if (tooltip[count].text == statusEffects[0].getName())
			{
				tooltip.resize(count);
				pushRemainingAP();
				statusEffects = statusEffects.filter(function ( _, item )
				{
					return !isInjury(_, item);
				});
				statusEffects = removeDuplicates(statusEffects);
				pushSection(statusEffects, null, 100, 2, "", true);
				local injuries = _entity.getSkills().query(this.Const.SkillType.TemporaryInjury, false, true);

				foreach( i, injury in injuries )
				{
					local children = injury.getTooltip().filter(function ( _, row )
					{
						return isTextRow(_, row);
					});
					local addedTooltipHints = [];
					injury.addTooltipHint(addedTooltipHints);
					addedTooltipHints = addedTooltipHints.filter(function ( _, row )
					{
						return isTextRow(_, row);
					});
					local added_count = addedTooltipHints.len();

					if (added_count)
					{
						children.resize(children.len() - added_count);
					}

					local isUnderIronWill = function ()
					{
						local pattern = this.regexp("Iron Will");

						foreach( _, row in addedTooltipHints )
						{
							if (("text" in row) && pattern.search(row.text))
							{
								return true;
							}
						}

						return false;
					}();
					local injuryRow = {
						id = 133 + i,
						type = "text",
						icon = injury.getIcon(),
						text = injury.getName()
					};

					if (!isUnderIronWill)
					{
						injuryRow.children <- children;
					}
					else
					{
						injuryRow.text += "[color=" + this.Const.UI.Color.PositiveValue + "]" + " (Iron Will)[/color]";
					}

					tooltip.push(injuryRow);
				}

				statusEffects = removeDuplicates(statusEffects);
				pushSection(statusEffects, "Status perks", 150, 1);
			}
			else
			{
				foreach( _, row in tooltip )
				{
					if (("type" in row) && row.type == "text" && "text" in row)
					{
						shownPerks[row.text] <- 1;
					}
				}
			}
		}
		else if (!statusEffects.len())
		{
			pushRemainingAP();
		}

		local activePerks = _entity.getSkills().query(this.Const.SkillType.Active, false, true);
		activePerks = removeDuplicates(activePerks);
		pushSection(activePerks, "Usable perks", 200, 1);
		local thresholdToCompact = 0;
		local perks = _entity.getSkills().query(this.Const.SkillType.Perk, false, true);
		perks = removeDuplicates(perks);
		pushSectionName(perks, "Perks", 300);

		if (perks.len() < thresholdToCompact)
		{
			foreach( i, perk in perks )
			{
				tooltip.push({
					id = 301 + i,
					type = "text",
					icon = getRealPerkIcon(perk),
					text = perk.getName()
				});
			}
		}
		else
		{
			local texts = "";

			foreach( _, perk in perks )
			{
				local name = perk.getName();

				if (name && name.len() > 1)
				{
					texts = texts + ("[color=" + this.Const.UI.Color.NegativeValue + "]" + name.slice(0, 1) + "[/color]" + name.slice(1) + ", ");
				}
			}

			if (texts.len() > 2)
			{
				texts = texts.slice(0, -2);
			}

			tooltip.push({
				id = 301,
				type = "text",
				icon = "ui/icons/perks.png",
				text = texts
			});
		}

		local mainhand = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if(::ModJimmysTooltips.Mod.ModSettings.getSetting("Items").getValue()){
			if(mainhand != null){
				local name = mainhand.getName();
				//::logInfo(name);
				pushSectionName(mainhand, "Equiped Items:", 400);
				if(mainhand.isItemType(this.Const.Items.ItemType.Ammo)){
					tooltip.push({
						id = 401,
						type = "text",
						icon = checkForIcon("ui/items/", mainhand),
						text = name + " " + mainhand.getAmmo() + " / " + mainhand.getAmmoMax()
					});
				}
				else{
					tooltip.push({
						id = 401,
						type = "text",
						icon = checkForIcon("ui/items/", mainhand),
						text = name + " " + mainhand.getCondition() + " / " + mainhand.getConditionMax()
					});
				}
			}

			local offhand = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			if(offhand != null){
				local name = offhand.getName();
				// ::logInfo(name);
				if(offhand.isItemType(this.Const.Items.ItemType.Ammo)){
					tooltip.push({
						id = 421,
						type = "text",
						icon = checkForIcon("ui/items/", offhand),
						text = name + " " + offhand.getAmmo() + " / " + offhand.getAmmoMax()
					});
				}
				else{
					tooltip.push({
						id = 421,
						type = "text",
						icon = checkForIcon("ui/items/", offhand),
						text = name + " " + offhand.getCondition() + " / " + offhand.getConditionMax()
					});
				}
			}

			local items = _entity.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag);
			foreach (item in items){
				local name = item.getName();
				// ::logInfo(name);
				pushSectionName(item, "Bags", 430);
				if(item.isItemType(this.Const.Items.ItemType.Ammo)){
					tooltip.push({
						id = 431,
						type = "text",
						icon = checkForIcon("ui/items/", item),
						text = name + " " + item.getAmmo() + " / " + item.getAmmoMax()
					});
				}
				else{
					tooltip.push({
						id = 431,
						type = "text",
						icon = checkForIcon("ui/items/", item),
						text = name + " " + item.getCondition() + " / " + item.getConditionMax()
					});
				}
			}
		}

		local accessories = _entity.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Accessory);
		pushSection(accessories, "Accessory", 600, 0, "ui/items/");

		local ammos = _entity.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Ammo);
		pushSection(ammos, "Ammo", 700, 0, "ui/items/");

		if(_targetedWithSkill == null && ::ModJimmysTooltips.Mod.ModSettings.getSetting("Skills").getValue() && mainhand != null){
			local skills = mainhand.getSkills();
			local startID = 500;
			foreach (skill in skills){
				local skillID = skill.getID(); // todo it shows it in log, remove when problem with tooltips is gone - chopeks
				if(skill.isUsable()){
					pushSectionName(skill, skill.getName(), startID, "" + skill.getIcon());
					tooltip.extend(skill.noDescriptionDefaultTooltip(startID));
					startID = startID + 10;
				}
			}
		}

		local itemsOnGround = _entity.getTile().Items;
		pushSection(itemsOnGround, "Item" + getPlural(itemsOnGround) + " on ground", 700, 0, "ui/items/", true);
	}
	else
	{
		pushSectionName("ModJimmysTooltips_ShowLootChance", "Chance to loot equipment:", 700);
		tooltip.top().type = "hint"; // move this to hint to separate as sections
		tooltip.extend(::ModJimmysTooltips.modGetEquipmentLootChance(_entity, _targetedWithSkill, 700));
	}

	if(::ModJimmysTooltips.Mod.ModSettings.getSetting("Stats").getValue()){
		local properties = _entity.getCurrentProperties();
		tooltip.push({
			id = 600,
			type = "hint",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]"+properties.getMeleeSkill()+"[/color] Melee Skill"
		});
		tooltip.push({
			id = 601,
			type = "hint",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]"+properties.getMeleeDefense()+"[/color] Melee Defense"
		});
		tooltip.push({
			id = 602,
			type = "hint",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]"+properties.getRangedSkill()+"[/color] Ranged Skill"
		});
		tooltip.push({
			id = 603,
			type = "hint",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]"+properties.getRangedDefense()+"[/color] Ranged Defense"
		});
		tooltip.push({
			id = 604,
			type = "hint",
			icon = "ui/icons/initiative.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]"+_entity.getInitiative()+"[/color] Initiative"
		});
		tooltip.push({
			id = 605,
			type = "hint",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]"+_entity.getBravery()+"[/color] Resolve"
			divider = "bottom" // add a diviver
		});
	}

	if (!::Tactical.Entities.getFlags().get("ModJimmysTooltips_ShowLootChance"))
		tooltip.push({
			id = 606,
			type = "hint",
			icon = "ui/skin/icon_wait.png",
			text = "Press \""
			+ ::MSU.System.Keybinds.KeybindsByMod[::ModJimmysTooltips.ID].rawget("updateTooltip").getKeyCombinations()
			+ "\" key to show the chance to loot equipment"
		});
	else
		tooltip.push({
			id = 606,
			type = "hint",
			icon = "ui/skin/icon_wait.png",
			text = "Press \""
			+ ::MSU.System.Keybinds.KeybindsByMod[::ModJimmysTooltips.ID].rawget("updateTooltip").getKeyCombinations()
			+ "\" key to show the default tooltip"
		});

	return tooltip;
};

local function colorizeInRed( _text )
{
	return "[color=" + ::Const.UI.Color.NegativeValue + "]" + _text + "[/color]"
};
local function colorizeInGreen( _text )
{
	return "[color=" + ::Const.UI.Color.PositiveValue + "]" + _text + "[/color]"
}

::ModJimmysTooltips.modGetEquipmentLootChance <- function( _entity, _targetedWithSkill = null, _startID = 0 )
{
	if (_entity.isAlliedWithPlayer() || (::Tactical.State.getStrategicProperties() != null && ::Tactical.State.getStrategicProperties().IsArenaMode))
		return [{
			id = _startID,
			type = "hint",
			text = colorizeInRed("Can\'t loot any equipment from this entity")
			divider = "bottom" // add a diviver
		}];

	local tooltip = [], expectedDamage;

	if (_targetedWithSkill != null && ::MSU.isKindOf(_targetedWithSkill, "skill") && _targetedWithSkill.isAttack())
		expectedDamage = ::ModJimmysTooltips.getExpectedArmorDamage(_targetedWithSkill, _entity);

	foreach (i, _item in _entity.getItems().getAllItems())
	{
		if (!_item.m.IsDroppedAsLoot)
			continue;

		local ret = {
			id = _startID,
			type = "hint",
			icon = checkForIcon("ui/items/", _item),
			text = _item.getName()
		};

		switch(_item.getSlotType())
		{
		case ::Const.ItemSlot.Mainhand:
			tooltip.push(::ModJimmysTooltips.modGetWeaponLootChance(ret, _item));
			break;

		case ::Const.ItemSlot.Offhand:
			tooltip.push(::ModJimmysTooltips.modGetOffhandLootChance(ret, _item));
			break;

		case ::Const.ItemSlot.Ammo:
			tooltip.push(::ModJimmysTooltips.modGetAmmoLootChance(ret, _item));
			break;

		case ::Const.ItemSlot.Body:
			tooltip.push(::ModJimmysTooltips.modGetBodyArmorLootChance(ret, _item, expectedDamage));
			break;

		case ::Const.ItemSlot.Head:
			tooltip.push(::ModJimmysTooltips.modGetHeadArmorLootChance(ret, _item, expectedDamage));
			break;

		case ::Const.ItemSlot.Accessory:
		case ::Const.ItemSlot.Bag:
			if (!::ModJimmysTooltips.modGetStandardLootChance(ret, _item))
				ret.text += colorizeInRed(" (0%)");

			tooltip.push(ret);
			break;

		default:
			ret.text += colorizeInRed(" (0%)");
			tooltip.push(ret);
		}

		++_startID;
	}

	if (tooltip.len() > 0)
		tooltip.top().divider <- "bottom"; // add a diviver

	return tooltip;
}

::ModJimmysTooltips.checkForIcon <- function (toAdd, _item)
{
	if(_item.getIcon() == "" || _item == "ui/items/" && ::ModJimmysTooltips.ItemImagePaths.find(toAdd + _item.getIcon()) == null)
		return "ui/items/supplies/legend_placeholder.png";
	else
		return toAdd + _item.getIcon();
}

::ModJimmysTooltips.modGetStandardLootChance <- function( _tooltip, _item, _isArmor = false )
{
	if (!_isArmor && _item.isNamed()) {
		_tooltip.text += colorizeInGreen(" (100%)");
		return true;
	}
	else if (_isArmor && _item.isNamed()) {
		_tooltip.text += colorizeInGreen(" (100%)");
		return true;
	}

	return false;
}

::ModJimmysTooltips.modGetWeaponLootChance <- function( _tooltip, _item )
{
	if (::ModJimmysTooltips.modGetStandardLootChance(_tooltip, _item))
		return _tooltip;

	if (_item.m.AmmoMax == 0 && (_item.m.Condition >= 12 || _item.m.ConditionMax <= 1)) // is normal weapon
		_tooltip.text += colorizeInGreen(" (90%)");
	else if (_item.m.Ammo > 0 && (_item.getCurrentSlotType() != ::Const.ItemSlot.Bag || _item.m.Ammo < _item.m.AmmoMax)) // is throwing weapon
		_tooltip.text += colorizeInGreen(" (90%)");
	else
		_tooltip.text += colorizeInRed(" (0%)");

	return _tooltip;
}

::ModJimmysTooltips.modGetOffhandLootChance <- function( _tooltip, _item )
{
	if (::ModJimmysTooltips.modGetStandardLootChance(_tooltip, _item))
		return _tooltip;

	if (!_item.isItemType(::Const.Items.ItemType.Shield)) // is normal weapon
		_tooltip.text += colorizeInGreen(" (100%)");
	else if (_item.m.Condition >= 6 && _item.m.Condition / _item.m.ConditionMax >= 0.25)
		_tooltip.text += colorizeInGreen(" (90%)");

	return _tooltip;
}

::ModJimmysTooltips.modGetAmmoLootChance <- function( _tooltip, _item )
{
	if (::ModJimmysTooltips.modGetStandardLootChance(_tooltip, _item))
		return _tooltip;

	if (_item.getCurrentSlotType() != ::Const.ItemSlot.Bag) // is normal weapon
		_tooltip.text += colorizeInGreen(" (66%)");
	else
		_tooltip.text += colorizeInRed(" (0%)");

	return _tooltip;
}

::ModJimmysTooltips.modGetBodyArmorLootChance <- function( _tooltip, _item, _expectedDamage = null )
{
	if (::ModJimmysTooltips.modGetStandardLootChance(_tooltip, _item, true))
		return _tooltip;

	local condition = _item.getRepair(), conditionMax = _item.getRepairMax();
	local isValid = condition > 10 && condition / conditionMax >= 0.2;
	local conditionExpected = condition;

	if (_expectedDamage != null)
		conditionExpected -= _expectedDamage.ArmorDamage;

	if (condition != conditionExpected)
	{
		local chance = 0;

		if (isValid)
			chance += 100;

		if (!(conditionExpected > 10 && conditionExpected / conditionMax >= 0.2))
			chance = ::Math.max(0, chance * 0.01 * _expectedDamage.Properties.getHitchance(::Const.BodyPart.Head));

		if (chance > 0)
			_tooltip.text += colorizeInGreen(" (" + ::Math.min(95, chance) + "%)");
		else
			_tooltip.text += colorizeInRed(" (0%)");
	}
	else if (isValid)
		_tooltip.text += colorizeInGreen(" (95%)");
	else
		_tooltip.text += colorizeInRed(" (0%)");

	return _tooltip;
}

::ModJimmysTooltips.modGetHeadArmorLootChance <- function( _tooltip, _item, _expectedDamage = null )
{
	if (::ModJimmysTooltips.modGetStandardLootChance(_tooltip, _item, true))
		return _tooltip;

	local condition = _item.getRepair(), conditionMax = _item.getRepairMax();
	local isValid = condition > 30 && condition / conditionMax >= 0.25;
	local conditionExpected = condition;

	if (_expectedDamage != null)
		conditionExpected -= _expectedDamage.ArmorDamage;

	if (condition != conditionExpected)
	{
		local chance = 0;

		if (isValid)
			chance += 70;

		if (!(conditionExpected > 30 && conditionExpected / conditionMax >= 0.25))
			chance = ::Math.max(0, chance * 0.01 * _expectedDamage.Properties.getHitchance(::Const.BodyPart.Body));

		if (chance > 0)
			_tooltip.text += colorizeInGreen(" (" + ::Math.min(95, chance) + "%)");
		else
			_tooltip.text += colorizeInRed(" (0%)");
	}
	else if (isValid)
		_tooltip.text += colorizeInGreen(" (70%)");
	else
		_tooltip.text += colorizeInRed(" (0%)");

	return _tooltip;
}

::ModJimmysTooltips.getExpectedArmorDamage <- function( _skill, _target )
{
	local actor = _skill.getContainer().getActor();
	local p = _skill.factoringOffhand(_skill.getContainer().buildPropertiesForUse(_skill, _target));
	local d = _target.getSkills().buildPropertiesForDefense(actor, _skill);
	local critical = 1.0 + p.getHitchance(::Const.BodyPart.Head) / 100.0 * (p.DamageAgainstMult[::Const.BodyPart.Head] - 1.0);
	local armor = _target.getArmor(::Const.BodyPart.Head) * (p.getHitchance(::Const.BodyPart.Head) / 100.0) + _target.getArmor(::Const.BodyPart.Body) * (::Math.max(0, p.getHitchance(::Const.BodyPart.Body)) / 100.0);
	local armorDamage = this.Math.min(armor, p.getArmorDamageAverage()) * (d.DamageReceivedArmorMult * d.DamageReceivedTotalMult);

	if (_skill.isRanged())
		armorDamage = armorDamage * (p.RangedDamageMult * d.DamageReceivedRangedMult);
	else
		armorDamage = armorDamage * (p.MeleeDamageMult * d.DamageReceivedMeleeMult);

	return {
		ArmorDamage = armorDamage,
		Properties = p
	};
};
