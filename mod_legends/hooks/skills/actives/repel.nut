::mods_hookExactClass("skills/actives/repel", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.HitChanceBonus = 10;
	}

	o.getTooltip = function () {
		local tooltip = this.getDefaultUtilityTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]100%[/color] chance to Stagger on a hit"
		});
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=%positive%]+" + this.getHitChanceModifier() + "%[/color] chance to hit"
		});
		if (!::Legends.Weapons.isCharacterWeaponSpecialized(this.getContainer().getActor().getCurrentProperties(), this.getItem())) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		return tooltip;
	}

	local onVerifyTarget = o.onVerifyTarget;
	o.onVerifyTarget = function (_originTile, _targetTile) {
		this.m.IsAttack = false; // work around to allow targeting on allies
		local result = onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;
		return result;
	}

	local onUse = o.onUse;
	o.onUse = function (_user, _targetTile) {
		local target = _targetTile.getEntity();

		if ((::Legends.Traits.has(this, ::Legends.Trait.Teamplayer) || ::Legends.Perks.has(this, ::Legends.Perk.Taunt)) && target.isAlliedWith(_user)) {
			target.getFlags().set("CanNotBeStaggered", true);
		}

		local ret = onUse(_user, _targetTile);

		if (!ret) {
			target.getFlags().remove("CanNotBeStaggered");
		}

		return ret;
	}

	o.onAfterUpdate = function (_properties) {
		if (::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCostMult = ::Const.Combat.WeaponSpecFatigueMult;
		}
	}

	o.onTargetSelected <- function (_targetTile) {
		local knockToTile = this.findTileToKnockBackTo(this.getContainer().getActor().getTile(), _targetTile);

		if (knockToTile == null) {
			return;
		}
		// to show where the target may be knocked back
		::Tactical.getHighlighter().addOverlayIcon("mortar_target_02", knockToTile, knockToTile.Pos.X, knockToTile.Pos.Y);
	}

	o.getHitchance <- function (_targetEntity) {
		if ((::Legends.Traits.has(this, ::Legends.Trait.Teamplayer) || ::Legends.Perks.has(this, ::Legends.Perk.Taunt)) && _targetEntity.isAlliedWith(this.getContainer().getActor())) {
			return 100;
		}

		return this.skill.getHitchance(_targetEntity);
	}

	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		if (_skill == this) {
			_properties.MeleeSkill += 10;

			if (_targetEntity != null && !::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) {
				_properties.MeleeSkill -= 15;
				this.m.HitChanceBonus -= 5;
			}
		}
	}
});
