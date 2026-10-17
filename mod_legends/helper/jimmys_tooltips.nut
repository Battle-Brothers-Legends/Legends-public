::Legends.JimmysTooltips <- {};

local ItemImagePaths = [];

local items_directory = "gfx/";
foreach (_, directory in ::IO.enumerateFiles(items_directory + "ui/items/")) {
	ItemImagePaths.push(directory.slice(items_directory.len()) + ".png");
}

local function colorizeLootChance(_value) {
	return (_value > 0 ? "[color=%positive%]" : "[color=%negative%]") + "(" + _value + "%)[/color]";
}

local function checkForIcon(toAdd, _item) {
	if (_item.getIcon() == "" || _item == "ui/items/" && ItemImagePaths.find(toAdd + _item.getIcon()) == null) {
		local slot = _item.getSlotType();
		if (slot == ::Const.ItemSlot.Body) {
			return "ui/icons/armor_body.png";
		} else if (slot == ::Const.ItemSlot.Head) {
			return "ui/icons/armor_head.png";
		} else {
			return "ui/items/supplies/legend_placeholder.png";
		}
	} else {
		return toAdd + _item.getIcon();
	}
}

local function getItemIconPaths(_item) {
	local paths = [];
	local baseIcon = checkForIcon("ui/items/", _item);
	paths.push(baseIcon);

	local slot = _item.getSlotType();
	if (slot == ::Const.ItemSlot.Body || slot == ::Const.ItemSlot.Head) {
		if (_item.getUpgrades().len() > 0) {
			foreach (u in _item.m.Upgrades) {
				if (u != null && u.getIcon() != "" && u.getIcon().find("rune_sigils") == null) {
					paths.push("ui/items/" + u.getIcon());
				}
			}
		}
	}
	return paths;
}

local function getExpectedArmorDamage(_skill, _target) {
	if (_skill == null || !::MSU.isKindOf(_skill, "skill") || !_skill.isAttack()) {
		return null;
	}

	local p = _skill.factoringOffhand(_skill.getContainer().buildPropertiesForUse(_skill, _target));
	local d = _target.getSkills().buildPropertiesForDefense(_skill.getContainer().getActor(), _skill);
	local critical = 1.0 + p.getHitchance(::Const.BodyPart.Head) / 100.0 * (p.DamageAgainstMult[::Const.BodyPart.Head] - 1.0);
	local armor = _target.getArmor(::Const.BodyPart.Head) * (p.getHitchance(::Const.BodyPart.Head) / 100.0) + _target.getArmor(::Const.BodyPart.Body) * (::Math.max(0, p.getHitchance(::Const.BodyPart.Body)) / 100.0);
	local armorDamage = ::Math.min(armor, p.getArmorDamageAverage()) * (d.DamageReceivedArmorMult * d.DamageReceivedTotalMult);

	if (_skill.isRanged()) {
		armorDamage *= p.RangedDamageMult * d.DamageReceivedRangedMult;
	} else {
		armorDamage *= p.MeleeDamageMult * d.DamageReceivedMeleeMult;
	}

	return {
		ArmorDamage = armorDamage,
		Properties = p
	};
};

local function getItemLootChance(_entity, _item, _targetedWithSkill = null) {
	local text = "";
	if (_entity.isAlliedWithPlayer() || (::Tactical.State.getStrategicProperties() != null && ::Tactical.State.getStrategicProperties().IsArenaMode)) {
		return text;
	}

	local expectedDamage = getExpectedArmorDamage(_targetedWithSkill, _entity);

	if (_item.isNamed()) {
		text += colorizeLootChance(100);
	} else {
		switch (_item.getSlotType()) {
			case ::Const.ItemSlot.Mainhand:
				if (_item.m.AmmoMax == 0 && (_item.m.Condition >= 12 || _item.m.ConditionMax <= 1)) {
					// is normal weapon
					text += colorizeLootChance(90);
				} else if (_item.m.Ammo > 0 && (_item.getCurrentSlotType() != ::Const.ItemSlot.Bag || _item.m.Ammo < _item.m.AmmoMax)) {
					// is throwing weapon
					text += colorizeLootChance(90);
				} else {
					text += colorizeLootChance(0);
				}
				break;

			case ::Const.ItemSlot.Offhand:
				if (!_item.isItemType(::Const.Items.ItemType.Shield)) {
					// normal weapons in offhand, shouldn't we do the same as mainhand in this case? is it just tooltip?
					text += colorizeLootChance(100);
				} else if (_item.m.Condition >= 6 && _item.m.Condition / _item.m.ConditionMax >= 0.25) {
					text += colorizeLootChance(90);
				} else {
					text += colorizeLootChance(0);
				}
				break;

			case ::Const.ItemSlot.Ammo:
				text += colorizeLootChance(_item.getCurrentSlotType() != ::Const.ItemSlot.Bag ? 66 : 0);
				break;

			case ::Const.ItemSlot.Body:
				local condition = _item.getRepair(), conditionMax = _item.getRepairMax();
				local isValid = condition > 10 && condition / conditionMax >= 0.2;
				local conditionExpected = condition;

				if (expectedDamage != null) {
					conditionExpected -= expectedDamage.ArmorDamage;
				}

				if (condition != conditionExpected) {
					local chance = isValid ? 100 : 0;

					if (!(conditionExpected > 10 && conditionExpected / conditionMax >= 0.2)) {
						chance = ::Math.max(0, chance * 0.01 * expectedDamage.Properties.getHitchance(::Const.BodyPart.Head));
					}

					text += colorizeLootChance(::Math.min(95, chance));
				} else {
					text += colorizeLootChance(isValid ? 95 : 0);
				}
				break;

			case ::Const.ItemSlot.Head:
				local condition = _item.getRepair(), conditionMax = _item.getRepairMax();
				local isValid = condition >= 5 && condition / conditionMax >= 0.2;
				local conditionExpected = condition;

				if (expectedDamage != null) {
					conditionExpected -= expectedDamage.ArmorDamage;
				}

				if (condition != conditionExpected) {
					local chance = isValid ? 70 : 0;

					if (!(conditionExpected > 30 && conditionExpected / conditionMax >= 0.25)) {
						chance = ::Math.max(0, chance * 0.01 * expectedDamage.Properties.getHitchance(::Const.BodyPart.Body));
					}

					text += colorizeLootChance(::Math.min(95, chance));
				} else {
					text += colorizeLootChance(isValid ? 70 : 0);
				}
				break;

			default:
				// accessory and bag
				text += colorizeLootChance(0);
		}
	}
	return text;
}

local function stackEffects(_effects) {
	local stacks = {};
	foreach (_, effect in _effects) {
		local name = effect.getName();
		if (name in stacks) {
			stacks[name] += 1;
		} else {
			stacks[name] <- 1;
		}
	}
	return stacks;
};

local function addTitle(title, startID, icon = "") {
	local ret = {
		id = startID,
		type = "text",
		text = "[u][size=14]" + title + "[/size][/u]"
	};

	if (icon.len() > 0) {
		ret.icon <- icon;
	}

	return ret;
};

local function getPlural(items) {
	return (!items ? "" : items.len() > 1 ? "s" : "");
};

local function pushSection(_tooltip, _entity, _shownPerks, _items, _title, _startID, _filter = 0, _prependIcon = "", _stackInOneLine = false) {
	if (!_items) {
		return;
	}

	local isPerk = @(_, _skill) _skill.isType(::Const.SkillType.Perk);
	if (_filter == 1) {
		_items = _items.filter(isPerk);
	} else if (_filter == 2) {
		_items = _items.filter(@(_idx, _item)(!isPerk(_idx, _item)));
	}

	local stacks = {};
	if (_stackInOneLine) {
		stacks = stackEffects(_items);
		local newItems = [];
		local added = {};

		foreach (_, item in _items) {
			local name = item.getName();
			if (!(name in added)) {
				newItems.push(item);
				added[name] <- 1;
			}
		}
		_items = newItems;
	}

	if (_items.len() > 0 && _title) {
		_tooltip.push(addTitle(_title, _startID));
	}
	_startID += 1;

	foreach (i, item in _items) {
		local name = item.getName();
		local text = name;

		if (name == null && text == null) {
			::logDebug("Error: Tooltip with a null name in tooltips. (id + " + item.getID() + ", description: " + item.getDescription() + ")");
			continue;
		}

		if (_filter != 0) {
			_shownPerks[name] <- 1;
		}

		if (_stackInOneLine && stacks[name] > 1) {
			text += (" [color=%negative%]" + "x" + stacks[name] + "[/color]");
		}

		if ("Stacks" in item.m) {
			text += (" [color=%negative%]" + "x" + item.m.Stacks + "[/color]");
		}

		if ("TurnsLeft" in item.m) {
			text += " " + ::Legends.S.inlineIcon("turns_left") + item.m.TurnsLeft;
		}

		local itemRow = {
			id = _startID + i,
			type = "text",
			icon = checkForIcon(_prependIcon, item),
			text = text
		};

		if (_title == "Ammo") {
			itemRow.text += " Ammo: " + (::isKindOf(_entity, "player") ? (item.getAmmo() + " / " + item.getAmmoMax() + " " + ::Legends.S.inlineIcon("ammo")) : "infinite");
		}

		_tooltip.push(itemRow);

		if (::Tactical.Entities.getFlags().get("JimmysTooltips_ShowExpandedDescriptions") && ::MSU.isKindOf(item, "skill")) {
			local extraDesc = item.getActorHoverTooltip(::Tactical.TurnSequenceBar.getActiveEntity(), (_stackInOneLine ? stacks[name] : 1));
			if (extraDesc != null) {
				_tooltip.push({
					id = _startID + i,
					type = "text",
					icon = "ui/perks/none.png"
					text = extraDesc
				});
			}
		}
	}
};

local function removeDuplicates(_shownPerks, _items) {
	return (!_items ? _items : _items.filter(@(_, item) ! (item.getName() in _shownPerks)));
};

local function addProgressBars(_tooltip, _entity) {
	if (::Legends.Mod.ModSettings.getSetting("ProgressBarValues").getValue() && !_entity.isPlayerControlled()) {
		foreach (_, row in _tooltip) {
			if (("type" in row) && row.type == "progressbar" && ("id" in row) && "icon" in row) {
				if (row.id == 5 && row.icon == "ui/icons/armor_head.png") {
					row.text <- "" + _entity.getArmor(::Const.BodyPart.Head) + " / " + _entity.getArmorMax(::Const.BodyPart.Head) + "";
				} else if (row.id == 6 && row.icon == "ui/icons/armor_body.png") {
					row.text <- "" + _entity.getArmor(::Const.BodyPart.Body) + " / " + _entity.getArmorMax(::Const.BodyPart.Body) + "";
				} else if (row.id == 7 && row.icon == "ui/icons/health.png") {
					row.text <- "" + _entity.getHitpoints() + " / " + _entity.getHitpointsMax() + "";
				} else if (row.id == 9 && row.icon == "ui/icons/fatigue.png") {
					row.text <- "" + _entity.getFatigue() + " / " + _entity.getFatigueMax() + "";
				}
			}
		}
	}
}

local function addStatusEffects(_tooltip, _entity, _shownPerks) {
	local statusEffects = _entity.getSkills().query(::Const.SkillType.StatusEffect | ::Const.SkillType.TemporaryInjury, false, true);
	local count = _tooltip.len() - statusEffects.len();

	local pushRemainingAP = function () {
		local turnsToGo = ::Tactical.TurnSequenceBar.getTurnsUntilActive(_entity.getID());
		local remainingAP = _entity.m.IsTurnDone || turnsToGo == null ? 0 : _entity.getActionPoints();
		_tooltip.push({
			id = 10,
			type = "progressbar",
			icon = "ui/icons/action_points.png",
			value = remainingAP,
			valueMax = _entity.getActionPointsMax(),
			text = "" + _entity.getActionPoints() + " / " + _entity.getActionPointsMax() + "",
			style = "action-points-slim"
		});
	};

	if (statusEffects.len() && count > 0) {
		if (_tooltip[count].text == statusEffects[0].getName()) {
			_tooltip.resize(count);
			pushRemainingAP();
			local isInjury = @(_, _skill) _skill.isType(::Const.SkillType.TemporaryInjury);
			local isTextRow = @(_, row)("type" in row) && row.type == "text";
			statusEffects = removeDuplicates(_shownPerks, statusEffects.filter(@(_, item)(!isInjury(_, item))));
			pushSection(_tooltip, _entity, _shownPerks, statusEffects, "Status effects", 100, 2, "", true);

			local injuries = _entity.getSkills().query(::Const.SkillType.TemporaryInjury, false, true);
			foreach (i, injury in injuries) {
				local children = injury.getTooltip().filter(@(_, row)(isTextRow(_, row)));
				local addedTooltipHints = [];
				injury.addTooltipHint(addedTooltipHints);
				addedTooltipHints = addedTooltipHints.filter(@(_, row)(isTextRow(_, row)));
				local added_count = addedTooltipHints.len();

				if (added_count) {
					children.resize(children.len() - added_count);
				}

				local isUnderIronWill = (function () {
					local pattern = this.regexp("Iron Will");

					foreach (_, row in addedTooltipHints) {
						if (("text" in row) && pattern.search(row.text)) {
							return true;
						}
					}

					return false;
				})();

				local injuryRow = {
					id = 133 + i,
					type = "text",
					icon = injury.getIcon(),
					text = injury.getName()
				};

				if (!isUnderIronWill) {
					injuryRow.children <- children;
				} else {
					injuryRow.text += "[color=%positive%]" + " (Iron Will)[/color]";
				}

				_tooltip.push(injuryRow);
			}

			statusEffects = removeDuplicates(_shownPerks, statusEffects);
			pushSection(_tooltip, _entity, _shownPerks, statusEffects, null, 150, 1);
		} else {
			foreach (_, row in _tooltip) {
				if (("type" in row) && row.type == "text" && "text" in row) {
					_shownPerks[row.text] <- 1;
				}
			}
		}
	} else if (!statusEffects.len()) {
		pushRemainingAP();
	}
}

local function addImmunities(_tooltip, _entity) {
	local immunities = "";
	foreach (property, effectName in ::Legends.Effects.Immunities) {
		if (property in _entity.getCurrentProperties() && _entity.getCurrentProperties()[property]) {
			immunities += (immunities.len() ? ", " : "") + ("[color=%negative%]" + effectName.slice(0, 1) + "[/color]" + effectName.slice(1));
		}
	}
	if (immunities.len()) {
		_tooltip.push(addTitle("Immunities", 250));
		_tooltip.push({
			id = 199,
			type = "text",
			icon = "ui/icons/immunity.png",
			text = immunities
		});
	}
}

local function addPerks(_tooltip, _entity, _shownPerks) {
	local activePerks = removeDuplicates(_shownPerks, _entity.getSkills().query(::Const.SkillType.Active, false, true));
	pushSection(_tooltip, _entity, _shownPerks, activePerks, "Usable perks", 200, 1);

	//local thresholdToCompact = 0;
	local perks = removeDuplicates(_shownPerks, _entity.getSkills().query(::Const.SkillType.Perk, true, true));
	if (perks.len()) {
		_tooltip.push(addTitle("Perks", 300));

		/*if (perks.len() < thresholdToCompact) { //non compact perks to be moved to page 2?
			foreach (i, perk in perks) {
				tooltip.push({
					id = 301 + i,
					type = "text",
					icon = ::Const.Perks.findById(perk.getID()).Icon,
					text = perk.m.Name
				});
			}
		} else {*/

		local perksText = "";
		foreach (_, perk in perks) {
			local name = perk.m.Name;
			perksText += (perksText.len() ? ", " : "") + ("[color=%negative%]" + name.slice(0, 1) + "[/color]" + name.slice(1));
		}

		_tooltip.push({
			id = 301,
			type = "text",
			icon = "ui/icons/perks.png",
			text = perksText
		});
		//}
	}
}

local function addItems(_tooltip, _entity, _shownPerks, _targetedWithSkill) {
	local getItemTooltip = function (_id, _item) {
		local text = _item.makeName() + " ";
		if (_item.isItemType(::Const.Items.ItemType.Ammo) || ("getAmmoMax" in _item && _item.getAmmoMax() > 0)) {
			text += _item.getAmmo() + " / " + _item.getAmmoMax() + " " + ::Legends.S.inlineIcon("ammo") + " ";
		}
		if (_entity.isPlayerControlled()) {
			if (_item.getConditionMax() > 1) {
				text += _item.getCondition() + " / " + _item.getConditionMax() + " ";
			}
		} else {
			if (_item.isItemType(::Const.Items.ItemType.Shield)) {
				text += _item.getCondition() + " / " + _item.getConditionMax() + " ";
			}
			if (_item.m.IsDroppedAsLoot) {
				text += getItemLootChance(_entity, _item, _targetedWithSkill);
			}
		}

		local iconPaths = getItemIconPaths(_item);
		return {
			id = _id,
			type = "text",
			icon = iconPaths[0],
			icons = iconPaths,
			text = text
		};
	}

	_tooltip.push(addTitle("Equipped Items:", 400));
	local mainhand = _entity.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
	if (::Legends.Mod.ModSettings.getSetting("Items").getValue()) {
		if (mainhand != null) {
			_tooltip.push(getItemTooltip(401, mainhand));
		}

		local offhand = _entity.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (offhand != null) {
			_tooltip.push(getItemTooltip(421, offhand));
		}
	}

	if (!_entity.isPlayerControlled()) {
		local bodyArmor = _entity.getItems().getItemAtSlot(::Const.ItemSlot.Body);
		if (bodyArmor != null) {
			_tooltip.push(getItemTooltip(441, bodyArmor));
		}

		local headArmor = _entity.getItems().getItemAtSlot(::Const.ItemSlot.Head);
		if (headArmor != null) {
			_tooltip.push(getItemTooltip(461, headArmor));
		}
	}

	local items = _entity.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag);
	if (items.len()) {
		_tooltip.push(addTitle("Bags", 430));
		foreach (item in items) {
			_tooltip.push(getItemTooltip(481, item));
		}
	}

	local accessories = _entity.getItems().getAllItemsAtSlot(::Const.ItemSlot.Accessory);
	pushSection(_tooltip, _entity, _shownPerks, accessories, "Accessory", 600, 0, "ui/items/");

	local ammo = _entity.getItems().getAllItemsAtSlot(::Const.ItemSlot.Ammo);
	pushSection(_tooltip, _entity, _shownPerks, ammo, "Ammo", 700, 0, "ui/items/");

	local itemsOnGround = _entity.getTile().Items;
	pushSection(_tooltip, _entity, _shownPerks, itemsOnGround, "Item" + getPlural(itemsOnGround) + " on the ground", 700, 0, "ui/items/", true);
}

local function addStats(_tooltip, _entity) {
	if (::Legends.Mod.ModSettings.getSetting("Stats").getValue()) {
		local properties = _entity.getCurrentProperties();
		_tooltip.push({
			id = 600,
			type = "hint",
			icon = "ui/icons/melee_skill.png",
			text = "[color=%positive%]" + properties.getMeleeSkill() + "[/color] Melee Skill"
		});
		_tooltip.push({
			id = 601,
			type = "hint",
			icon = "ui/icons/melee_defense.png",
			text = "[color=%positive%]" + properties.getMeleeDefense() + "[/color] Melee Defense"
		});
		_tooltip.push({
			id = 602,
			type = "hint",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=%positive%]" + properties.getRangedSkill() + "[/color] Ranged Skill"
		});
		_tooltip.push({
			id = 603,
			type = "hint",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=%positive%]" + properties.getRangedDefense() + "[/color] Ranged Defense"
		});
		_tooltip.push({
			id = 604,
			type = "hint",
			icon = "ui/icons/initiative.png",
			text = "[color=%positive%]" + _entity.getInitiative() + "[/color] Initiative"
		});
		_tooltip.push({
			id = 605,
			type = "hint",
			icon = "ui/icons/bravery.png",
			text = "[color=%positive%]" + _entity.getBravery() + "[/color] Resolve"
		});
		_tooltip.push({
			id = 606,
			type = "hint",
			icon = "ui/icons/fatigue.png",
			text = "[color=%positive%]" + properties.FatigueRecoveryRate + "[/color] Fatigue Recovery per Turn"
			divider = "bottom" // add a divider
		});
	}
}

local function addEnemySkills(_tooltip, _entity, _targetedWithSkill) {

	local mainhand = _entity.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
	if (_targetedWithSkill == null && ::Legends.Mod.ModSettings.getSetting("Skills").getValue() && mainhand != null) {
		local skills = _entity.getSkills().query(::Const.SkillType.Active);
		local startID = 500;
		foreach (skill in skills.filter(@(_, _skill)(_skill.getContainer() != null && _skill.getContainer().getActor() != null && _skill.isUsable()))) {
			_tooltip.push(addTitle(skill.getName(), startID, "" + skill.getIcon()));
			_tooltip.extend(skill.noDescriptionDefaultTooltip(startID));
			startID += 10;
		}
	}
}

::Legends.JimmysTooltips.modTacticalTooltip <- function (_tooltip, _targetedWithSkill, _entity) {
	if (::Legends.Mod.ModSettings.getSetting("DefaultTooltip").getValue() || _tooltip.len() < 3) {
		return _tooltip;
	}

	addProgressBars(_tooltip, _entity);

	local shownPerks = {};

	if (!::Tactical.Entities.getFlags().get("JimmysTooltips_ShowExpandedDescriptions")) {
		addStatusEffects(_tooltip, _entity, shownPerks);
		addImmunities(_tooltip, _entity);
		addPerks(_tooltip, _entity, shownPerks);
		addItems(_tooltip, _entity, shownPerks, _targetedWithSkill);
	} else {
		addStatusEffects(_tooltip, _entity, shownPerks);
		//addEnemySkills(_tooltip, _entity, _targetedWithSkill); incomplete feature, missing icons etc.
	}

	addStats(_tooltip, _entity);

	_tooltip.push({
		id = 607,
		type = "hint",
		icon = "ui/skin/icon_wait.png",
		text = "Press \"" + ::MSU.System.Keybinds.KeybindsByMod[::Legends.ID].rawget("updateTooltip").getKeyCombinations() + "\" key to show the " + (::Tactical.Entities.getFlags().get("JimmysTooltips_ShowExpandedDescriptions") ? "default tooltip" : "expanded effect descriptions")
	});

	return _tooltip;
};
