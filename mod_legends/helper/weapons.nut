if (!("Weapons" in ::Legends)) {
    ::Legends.Weapons <- {};
}

::Legends.Weapons.findPrimaryAttackSkill <- function (_actor, _weapon) {
    if (_actor == null || _weapon == null) {
        return null;
    }

    local bestSkill = null;
    local bestAPCost = 9999;

    local actorSkills = _actor.getSkills();
    foreach (skill in _weapon.m.SkillPtrs) {
        if (skill == null || skill.isGarbage()) {
            continue;
        }

        // Ensure skill has a container so validation methods like `isUsable()` don't crash.
        // Needed when wielding two different weapons with the same skill (e.g. dagger + knife).
        if (skill.getContainer() == null || !("getActor" in skill.getContainer())) {
            skill.setContainer(actorSkills);
        }

        // Use same validation code as Attack of Opportunity
        if (!skill.isActive()
            || !skill.isAttack()
            || !skill.isTargeted()
            || skill.isIgnoredAsAOO()
            || skill.isDisabled()
            || !skill.isUsable()
            || skill.getMinRange() > 1
            || skill.isRanged())
        {
            continue;
        }

        local apCost = skill.getActionPointCost();
        if (apCost < bestAPCost) {
            bestSkill = skill;
            bestAPCost = apCost;
        }
    }

    if (bestSkill == null) {
        ::logWarning("findPrimaryAttackSkill: no valid skill for weapon " + _weapon.getID());
    }

    return bestSkill;
}

// Returns true if the skill belongs to the item equipped in the mainhand.
::Legends.Weapons.isMainHandSkill <- function (_actor, _skill) {
    return ::Legends.Weapons.isSlotSkill(_actor, _skill, ::Const.ItemSlot.Mainhand);
}

// Returns true if the skill belongs to the item equipped in the offhand.
::Legends.Weapons.isOffHandSkill <- function (_actor, _skill) {
    return ::Legends.Weapons.isSlotSkill(_actor, _skill, ::Const.ItemSlot.Offhand);
}

// Returns true if the skill belongs to the item equipped in the given slot.
::Legends.Weapons.isSlotSkill <- function (_actor, _skill, _slot) {
    if (_actor == null || _skill == null || _skill.m.Item == null || _slot == null) {
        return false;
    }
    local items = _actor.getItems();
    local item = items.getItemAtSlot(_slot);
    return item != null && _skill.m.Item.getInstanceID() == item.getInstanceID();
}

// Returns true if dual wielding weapons not covered by Ambidextrous.
::Legends.Weapons.isDualWielding <- function (_actor) {
    if (_actor == null) {
        return false;
    }
    local items = _actor.getItems();
    local mh = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
    local oh = items.getItemAtSlot(::Const.ItemSlot.Offhand);
    return mh != null
        && oh != null
        && mh.isItemType(::Const.Items.ItemType.Weapon)
        && oh.isItemType(::Const.Items.ItemType.Weapon);
}

// Returns true if dual wielding weapons of the given type.
::Legends.Weapons.isDualWieldingWeaponType <- function (_actor, _weaponType) {
    if (!::Legends.Weapons.isDualWielding(_actor)) {
        return false;
    }
    local items = _actor.getItems();
    local mh = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
    local oh = items.getItemAtSlot(::Const.ItemSlot.Offhand);
    return mh.isWeaponType(_weaponType) && oh.isWeaponType(_weaponType);
}

::Legends.Weapons.Named <- {};
::Legends.Weapons.Named.randomizeRanges <- {
    Condition          = [110, 140],
    RegularDamage      = [110, 130],
    ArmorDamageMult    = [10, 30],
    ChanceToHitHead    = [10, 20],
    DirectDamageAdd    = [8, 16],
    StaminaModifier    = [50, 80],
    ShieldDamage       = [150, 200],
    AmmoMax            = [1, 3],
    AdditionalAccuracy = [5, 15],
    FatigueOnSkillUse  = [1, 3],
    MeleeDefense       = [130, 150],
    RangedDefense      = [130, 150],
    ConditionShield    = [150, 200],
    StaminaModifierShield    = [60, 90],
};

::Legends.Weapons.Named.HighlightNamedRoll <- {
	ConditionMax = {
		Icon = "ui/icons/asset_supplies_named.png",
		Text = "",
        function isRightTooltip(_tooltip, _properties, _isShield = false) {
            local range = _isShield ? ::Legends.Weapons.Named.randomizeRanges.ConditionShield : ::Legends.Weapons.Named.randomizeRanges.Condition;
			local bVal = _properties.ConditionMax;
			this.Text = " [color=%positiveLighter%]["+::Math.round(bVal * range[0] * 0.01) + " to " + ::Math.round(bVal * range[1] * 0.01)+"][/color]";
			return _tooltip.id == 4	&& _tooltip.type == "progressbar" && _tooltip.icon == "ui/icons/asset_supplies.png";
		}
	},

	RegularDamage = {
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
			return null;
		}
	},

	RegularDamageMax = {
		Icon = "ui/icons/regular_damage_named.png",
        Text = "",
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
			local range = ::Legends.Weapons.Named.randomizeRanges.RegularDamage;
			local bMin = _properties.RegularDamage;
			local bMax = _properties.RegularDamageMax;
			this.Text = ::Legends.Weapons.Named.wrapTooltip(::Math.round(bMin * range[0] * 0.01) + "-" + ::Math.round(bMin * range[1] * 0.01) + " to " + ::Math.round(bMax * range[0] * 0.01) + "-" + ::Math.round(bMax * range[1] * 0.01));
			return _tooltip.id == 4 && _tooltip.icon == "ui/icons/regular_damage.png";
		}
	},

	DirectDamageMult = {
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
			return null;
		}
	},

	DirectDamageAdd = {
		Icon = "ui/icons/direct_damage_named.png",
        Text = "",
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
			local range = ::Legends.Weapons.Named.randomizeRanges.DirectDamageAdd;
			local bVal = _properties.DirectDamageMult * 100;
			this.Text = ::Legends.Weapons.Named.wrapTooltip((bVal + range[0]) + "% - " + (bVal + range[1]) + "%");
			return _tooltip.id == 64 && _tooltip.icon == "ui/icons/direct_damage.png";
		}
	},

	ArmorDamageMult = {
		Icon = "ui/icons/armor_damage_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
            local range = ::Legends.Weapons.Named.randomizeRanges.ArmorDamageMult;
			local bVal = _properties.ArmorDamageMult * 100;
			this.Text = ::Legends.Weapons.Named.wrapTooltip((bVal + range[0]) + "% - " + (bVal + range[1]) + "%");
			return _tooltip.id == 5 && _tooltip.icon == "ui/icons/armor_damage.png";
		}
	},

	ShieldDamage = {
		Icon = "ui/icons/shield_damage_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
            local range = ::Legends.Weapons.Named.randomizeRanges.ShieldDamage;
			local bVal = _properties.ShieldDamage;
			this.Text = ::Legends.Weapons.Named.wrapTooltip(::Math.round(bVal * range[0] * 0.01) + " to " + ::Math.round(bVal * range[1] * 0.01));
			return _tooltip.id == 6 && _tooltip.icon == "ui/icons/shield_damage.png";
		}
	},

	ChanceToHitHead = {
		Icon = "ui/icons/chance_to_hit_head_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
            local range = ::Legends.Weapons.Named.randomizeRanges.ChanceToHitHead;
			local bVal = _properties.ChanceToHitHead;
			this.Text = ::Legends.Weapons.Named.wrapTooltip((bVal + range[0]) + "% - " + (bVal + range[1]) + "%");
			return _tooltip.id == 9 && _tooltip.icon == "ui/icons/chance_to_hit_head.png";
		}
	},

	AdditionalAccuracy = {
		Icon = "ui/icons/hitchance_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
            local range = ::Legends.Weapons.Named.randomizeRanges.AdditionalAccuracy;
			local bVal = _properties.AdditionalAccuracy;
			this.Text = ::Legends.Weapons.Named.wrapTooltip((bVal + range[0]) + "% - " + (bVal + range[1]) + "%");
			return _tooltip.id == 10 && _tooltip.icon == "ui/icons/hitchance.png";
		}
	},

	StaminaModifier = {
		Icon = "ui/icons/fatigue_named.png",
		Text = ""

		function isRightTooltip(_tooltip, _properties, _isShield = false) {
            local range = _isShield = false ? ::Legends.Weapons.Named.randomizeRanges.StaminaModifierShield : ::Legends.Weapons.Named.randomizeRanges.StaminaModifier;
			local bVal = _properties.StaminaModifier;
			this.Text = ::Legends.Weapons.Named.wrapTooltip(::Math.round(bVal * range[0] * 0.01) + " to " + ::Math.round(bVal * range[1] * 0.01));
			return _tooltip.icon == "ui/icons/fatigue.png";
		}
	},

	FatigueOnSkillUse = {
		Icon = "ui/icons/fatigue_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
            local range = ::Legends.Weapons.Named.randomizeRanges.FatigueOnSkillUse;
			local bVal = _properties.FatigueOnSkillUse;
			this.Text = ::Legends.Weapons.Named.wrapTooltip((bVal - range[0]) + " to " + (bVal - range[1]));
			return _tooltip.id == 8	&& _tooltip.icon == "ui/icons/fatigue.png" && _tooltip.text.find("skills build up") != null;
		}
	},

	AmmoMax = {
		Icon = "ui/icons/ammo_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
            local range = ::Legends.Weapons.Named.randomizeRanges.AmmoMax;
			local bVal = _properties.AmmoMax;
			this.Text = ::Legends.Weapons.Named.wrapTooltip((bVal + range[0]) + " - " + (bVal + range[1]));
			return _tooltip.id == 10 && _tooltip.icon == "ui/icons/ammo.png";
		}
	},

	MeleeDefense = {
		Icon = "ui/icons/melee_defense_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
            local range = ::Legends.Weapons.Named.randomizeRanges.MeleeDefense;
            local bVal = _properties.MeleeDefense;
            this.Text = ::Legends.Weapons.Named.wrapTooltip(::Math.round(bVal * range[0] * 0.01) + " to " + ::Math.round(bVal * range[1] * 0.01));
			return _tooltip.id == 5 && _tooltip.icon == "ui/icons/melee_defense.png";
		}
	},

	RangedDefense = {
		Icon = "ui/icons/ranged_defense_named.png",
		Text = ""
		function isRightTooltip(_tooltip, _properties, _isShield = false) {
            local range = ::Legends.Weapons.Named.randomizeRanges.RangedDefense;
            local bVal = _properties.RangedDefense;
            this.Text = ::Legends.Weapons.Named.wrapTooltip(::Math.round(bVal * range[0] * 0.01) + " to " + ::Math.round(bVal * range[1] * 0.01));
			return _tooltip.id == 6 && _tooltip.icon == "ui/icons/ranged_defense.png";
		}
	},
};


::Legends.Weapons.Named.wrapTooltip <- function (_tooltip) {
	return "\n[color=%positive%][" + _tooltip + "][/color]";
}

::Legends.Weapons.Named.getRangeOfSpecialEffect <- function (_item, _includePercent = true){
    return ::Legends.Mod.ModSettings.getSetting("ShowPotentialOnItems").getValue() ? ::Legends.Weapons.Named.wrapTooltip(_item.m.EffectBounds[_item.m.PossibleEffectIdx][0] + (_includePercent ? "%" : "") + " to " + _item.m.EffectBounds[_item.m.PossibleEffectIdx][1]) : (_includePercent ? "%" : "");
}