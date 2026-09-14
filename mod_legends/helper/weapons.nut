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
