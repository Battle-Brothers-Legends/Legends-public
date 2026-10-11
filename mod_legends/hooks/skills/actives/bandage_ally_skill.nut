::mods_hookExactClass("skills/actives/bandage_ally_skill", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.IsStacking = false;
		this.m.Description = "Save yourself or another character from bleeding to death by applying pressure and provisional bandaging to any such wound. Heals up to 10 hitpoints damage received during this combat. Neither the character using this skill nor the patient may be engaged in melee.";
	}

	o.getTooltip = function () {
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Heals up to 10 hitpoints received during this combat"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Removes the Bleeding and Grazed status effect"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Removes fresh Cut Artery, Cut Neck Vein and Grazed Neck injuries"
			}
		];

		if (::Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) {
			tooltip.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}

	o.isHidden <- function () {
		return this.getCurrentItem().m.Ammo <= 0;
	}

	o.getCurrentItem <- function () {
		// search for more bandages if the one under this.m.Item is empty
		if (this.m.Item.m.Ammo <= 0) {
			local self = this;
			local filledBandages = this.getContainer().getActor().getItems().getAllItems().filter(@(_, _item)(_item.getID() == self.m.Item.getID() && _item.m.Ammo > 0));
			foreach (item in filledBandages) {
				this.setItem(item);
				return item;
			}
		}

		return this.m.Item;
	}

	o.isUsable = function () {
		if (!::Tactical.isActive()) {
			return false;
		}

		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor) && ::Legends.Backgrounds.has(actor, ::Legends.Background.LegendDonkey)) {
			return false;
		}

		local tile = actor.getTile();
		return this.skill.isUsable() && !tile.hasZoneOfControlOtherThan(actor.getAlliedFactions()) && this.getCurrentItem().m.Ammo > 0;
	}

	o.onVerifyTarget = function (_originTile, _targetTile) {
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) {
			return false;
		}

		local actor = this.getContainer().getActor();
		local target = _targetTile.getEntity();

		if (!actor.isAlliedWith(target) || _targetTile.hasZoneOfControlOtherThan(actor.getAlliedFactions())) {
			return false;
		}

		if (target.getSkills().hasEffect(::Legends.Effect.Bleeding) || target.getSkills().hasEffect(::Legends.Effect.LegendGrazed)) {
			return true;
		}

		local skill = target.getSkills().getSkillByID("injury.cut_artery");

		if (skill != null && skill.isFresh()) {
			return true;
		}

		skill = target.getSkills().getSkillByID("injury.cut_throat");

		if (skill != null && skill.isFresh()) {
			return true;
		}

		skill = target.getSkills().getSkillByID("injury.grazed_neck");

		if (skill != null && skill.isFresh()) {
			return true;
		}

		if (::isKindOf(target, "player") && target.getHitpoints() < target.getCombatStartHP()) {
			return true;
		}

		return false;
	}

	o.onUse = function (_user, _targetTile) {
		local target = _targetTile.getEntity();
		this.spawnIcon("perk_55", _targetTile);

		while (target.getSkills().hasEffect(::Legends.Effect.Bleeding)) {
			::Legends.Effects.remove(target, ::Legends.Effect.Bleeding);
		}

		while (target.getSkills().hasEffect(::Legends.Effect.LegendGrazed)) {
			::Legends.Effects.remove(target, ::Legends.Effect.LegendGrazed);
		}

		local skill = target.getSkills().getSkillByID("injury.cut_artery");

		if (skill != null && skill.isFresh()) {
			target.getSkills().remove(skill);
		}

		skill = target.getSkills().getSkillByID("injury.cut_throat");

		if (skill != null && skill.isFresh()) {
			target.getSkills().remove(skill);
		}

		skill = target.getSkills().getSkillByID("injury.grazed_neck");

		if (skill != null && skill.isFresh()) {
			target.getSkills().remove(skill);
		}

		if (::isKindOf(target, "player") && target.getHitpoints() < target.getCombatStartHP()) {
			target.setHitpoints(::Math.min(target.getCombatStartHP(), target.getHitpoints() + 10));
		}

		this.getCurrentItem().consumeAmmo();

		this.updateAchievement("FirstAid", 1, 1);
		return true;
	}
});
