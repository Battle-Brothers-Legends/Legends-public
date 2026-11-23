::mods_hookExactClass("skills/actives/repel", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.HitChanceBonus = 10;
		this.m.DirectDamageMult = 0.3;
		this.m.Description = "Poke and shove at a target in order to force it away from the user by one tile. Targets hit will be staggered and lose initiative, and may take damage if they are pushed down several levels of height. Shieldwall, Spearwall and Riposte will be canceled for a target that is successfully repelled.";
	}

	o.getTooltip = function () {
		local tooltip = this.getDefaultTooltip();
		local actor = this.getContainer().getActor();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]100%[/color] chance to apply [color=%status%]Staggered[/color] on a hit"
		});

		if (::Legends.Perks.has(this, ::Legends.Perk.ShieldBash)) {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to apply [color=%status%]Knocked Over[/color] on a hit against enemies that are [color=%status%]Netted[/color], [color=%status%]Rooted[/color] or [color=%status%]Webbed[/color]"
			});
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Inflicts [color=%positive%]50%[/color] more Damage against enemies that are [color=%status%]Netted[/color], [color=%status%]Rooted[/color] or [color=%status%]Webbed[/color]"
			});
		}
		if (!::Legends.Weapons.isCharacterWeaponSpecialized(actor.getCurrentProperties(), this.getItem())) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		return tooltip;
	}

	o.findTileToKnockBackTo = function( _userTile, _targetTile ) {
		return this.skill.getForcedMovementDestinationTile(_userTile, _targetTile);
	}

	o.onVerifyTarget = function( _originTile, _targetTile ) {
		this.m.IsAttack = false;
		local result = this.skill.onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;
		local pulledTo = this.skill.getForcedMovementDestinationTile(_originTile, _targetTile);
		local target = _targetTile.getEntity();
		if (result && pulledTo == null && (target != null && (!target.getCurrentProperties().IsRooted || target.isAlliedWith(this.getContainer().getActor()))))
			result = false;
		return result;
	}

	o.onUse = function( _user, _targetTile ) {
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSplitShield);
		local success = false;
		if (!target.isAlliedWith(_user)) {
			success = this.attackEntity(_user, _targetTile.getEntity());
			if (success && !::Legends.S.isEntityNullOrDead(target) && !::Legends.S.isEntityNullOrDead(_user)) {
				local knockToTile = this.skill.getForcedMovementDestinationTile(_user.getTile(), _targetTile);
				if (knockToTile != null && !target.getCurrentProperties().IsImmuneToKnockBackAndGrab && !target.getCurrentProperties().IsRooted) {
					::Tactical.State.handleInvoluntaryMovement(target, _user, _targetTile, knockToTile, this, null, null);
				}
			}
		}
		else {
			success = true;
			local knockToTile = this.skill.getForcedMovementDestinationTile(_user.getTile(), _targetTile);
			if (knockToTile != null && !target.getCurrentProperties().IsImmuneToKnockBackAndGrab && !target.getCurrentProperties().IsRooted) {
				::Tactical.State.handleInvoluntaryMovement(target, _user, _targetTile, knockToTile, this, null, null);
			}
		}
		return success;
	}

	o.onTargetHit <- function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill != this)
			return;

		if (::Legends.S.isEntityNullOrDead(_targetEntity))
			return;

		local actor = this.getContainer().getActor();
		if (actor.isAlliedWith(_targetEntity) && !::Legends.Traits.has(this, ::Legends.Trait.Teamplayer) && !::Legends.Perks.has(this, ::Legends.Perk.Taunt)) {
			return false;
		}
		local effect = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Staggered);
		if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
			::Tactical.EventLog.log(effect.getLogEntryOnAdded(::Const.UI.getColorizedEntityName(actor), ::Const.UI.getColorizedEntityName(_targetEntity)));
		}

		if (::Legends.Perks.has(this, ::Legends.Perk.ShieldBash) && _targetEntity.getCurrentProperties().IsRooted) {
			local effect = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendKnockedOver);
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
				::Tactical.EventLog.log(effect.getLogEntryOnAdded(::Const.UI.getColorizedEntityName(actor), ::Const.UI.getColorizedEntityName(_targetEntity)));
			}
		}
	}

	o.onAfterUpdate = function (_properties) {
		if (::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem())) {
			this.m.ActionPointCost -= 1;
			this.m.FatigueCostMult = ::Const.Combat.WeaponSpecFatigueMult;
		}
	}

	o.onTargetSelected <- function ( _targetTile ) {
		local knockToTile = this.findTileToKnockBackTo(this.getContainer().getActor().getTile(), _targetTile);

		if (knockToTile == null) {
			return;
		}

		local target = _targetTile.getEntity();
		if (target == null) {
			return;
		}

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab || target.getCurrentProperties().IsRooted) {
			return;
		}

		if (!_targetTile.IsEmpty) {
			return
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
			_properties.DamageTotalMult *= 0.6;
			if (!::Legends.S.isEntityNullOrDead(_targetEntity) && _targetEntity.getCurrentProperties().IsRooted) {
				_properties.DamageTotalMult *= 1.5;
			}
			local bonus = 0;
			if (_targetEntity != null && !::Legends.Weapons.isCharacterWeaponSpecialized(_properties, this.getItem()) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) {
				bonus -= 15;
			}
			_properties.MeleeSkill += this.addHitChanceBonus(bonus);
		}
	}
});
