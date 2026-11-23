::mods_hookExactClass("skills/actives/knock_back", function(o)
{
	local create = o.create;
	o.create = function() {
		create();
		this.m.Name = "Shield Bash";
		this.m.Description = "Use the shield to bash the target and deal damage. Targets hit on your own turn will be knocked back by one tile and may take damage if they are pushed down several levels of height. Shieldwall, Spearwall and Riposte will be canceled for a target that is successfully knocked back.";
		this.m.HitChanceBonus = 10;
		this.m.FatigueCost = 15;
		this.m.DirectDamageMult = 0.2;
	}

	o.getTooltip = function () {
		local tooltip = this.getDefaultTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]100%[/color] to knock a target away by one tile if you attack on your turn"
		});
		tooltip.push({
			id = 8,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "Inflicts [color=%positive%]50%[/color] more Damage against enemies that are [color=%status%]Netted[/color], [color=%status%]Rooted[/color] or [color=%status%]Webbed[/color]"
		});
		if (::Legends.Perks.has(this, ::Legends.Perk.ShieldBash)) {
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to apply [color=%status%]Knocked Over[/color] on a hit against enemies that are [color=%status%]Netted[/color], [color=%status%]Rooted[/color] or [color=%status%]Webbed[/color]"
			});
		}

		if (this.getContainer().hasTrait(::Legends.Trait.OathOfFortification)) {
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to Stagger on a hit"
			});
		}
		return tooltip;
	}

	o.onVerifyTarget = function( _originTile, _targetTile ) {
		this.m.IsAttack = false;
		local result = this.skill.onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;
		if (!::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor())) {
			return result;
		}

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
			local currentEntity = ::Tactical.TurnSequenceBar.getActiveEntity();
			if (success && !::Legends.S.isEntityNullOrDead(target) && !::Legends.S.isEntityNullOrDead(_user) && currentEntity != null && currentEntity.getID() == _user.getID()) {
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

	o.onAfterUpdate <- function ( _properties ) {
		this.m.FatigueCostMult = _properties.IsSpecializedInShields ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill != this) {
			return;
		}

		local bonus = _properties.IsSpecializedInShields ? 15 : 0;
		_properties.MeleeSkill += this.addHitChanceBonus(bonus);

		_properties.DamageRegularMin = this.getItem().m.RegularDamage;
		_properties.DamageRegularMax = this.getItem().m.RegularDamageMax;
		_properties.DamageArmorMult = 0.5;
		_properties.FatigueDealtPerHitMult += 1.0;
		if (::Legends.Perks.has(this, ::Legends.Perk.ShieldBash)) {
			_properties.DamageArmorMult = 1.0;
			_properties.DamageDirectAdd += 0.1;
			_properties.DamageTotalMult += 1.25;
		}
		if (!::Legends.S.isEntityNullOrDead(_targetEntity) && _targetEntity.getCurrentProperties().IsRooted) {
			_properties.DamageTotalMult *= 1.5;
		}
	}

	o.onTargetHit <- function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill != this)
			return;

		if (::Legends.S.isEntityNullOrDead(_targetEntity))
			return;

		local actor = this.getContainer().getActor();

		if (::Legends.Perks.has(this, ::Legends.Perk.ShieldBash) && _targetEntity.getCurrentProperties().IsRooted) {
			local effect = ::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendKnockedOver);
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
				::Tactical.EventLog.log(effect.getLogEntryOnAdded(::Const.UI.getColorizedEntityName(actor), ::Const.UI.getColorizedEntityName(_targetEntity)));
			}
		}

		if (actor.isAlliedWith(_targetEntity))
			return false;

		local skill = ::Legends.Actives.get(actor, ::Legends.Active.Taunt);
		if (skill != null && ::Legends.Perks.has(actor, ::Legends.Perk.Taunt)) {
			skill.onUse(actor, _targetEntity.getTile());
		}
	}

	o.findTileToKnockBackTo = function( _userTile, _targetTile ) {
		return this.skill.getForcedMovementDestinationTile(_userTile, _targetTile);
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

	o.getHitchance <- function ( _targetEntity ) {
		if ((::Legends.Traits.has(this, ::Legends.Trait.Teamplayer) || ::Legends.Perks.has(this, ::Legends.Perk.Taunt)) && _targetEntity.isAlliedWith(this.getContainer().getActor()))
			return 100;

		if (!this.isUsingHitchance())
			return 100;

		return this.skill.getHitchance(_targetEntity);
	}

});
